
define class Din_EntidadPREPARACIONDEMERCADERIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PREPARACIONDEMERCADERIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + Secuencia]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0) + #tabla#.FACTSEC]
	cTagClaveCandidata = '_PRMCC'
	cTagClavePk = '_PRMPK'
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
			local  lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFectrans, lxComprobantevDatosecomm, lxComprobantevFpodes1, lxComprobantevFpodes2, lxComprobantevFletra, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevCotiz, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevTimestamp, lxComprobantevTotalcant, lxComprobantevFactsec, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevCondivalp, lxComprobantevSitfisccli, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevDesmntosi1, lxComprobantevFcompfis, lxComprobantevAnulado, lxComprobantevFhora, lxComprobantevValtafw, lxComprobantevFaltafw, lxComprobantevHoraexpo, lxComprobantevVmodifw, lxComprobantevHoraimpo, lxComprobantevSmodifw, lxComprobantevHmodifw, lxComprobantevSaltafw, lxComprobantevUaltafw, lxComprobantevBdmodifw, lxComprobantevHaltafw, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevZadsfw, lxComprobantevEsttrans, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevMonsis, lxComprobantevMoneda, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevMd2, lxComprobantevFptoven, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFobs, lxComprobantevFnumcomp, lxComprobantevFmtdes3, lxComprobantevFven, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevCodlista, lxComprobantevFpago, lxComprobantevFfch, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevMotivo, lxComprobantevFfchent, lxComprobantevFtransp, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevMerconsign, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr1, lxComprobantevMr2, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis
				lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevDatosecomm =  .Dataecom			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevFletra =  .Letra			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevCotiz =  .Cotizacion			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFactsec =  .Secuencia			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevAnulado =  .Anulado			lxComprobantevFhora =  .Hora			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFcuit =  .Cuit			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevFobs =  .Obs			lxComprobantevFnumcomp =  .Numero			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFpago =  upper( .ForPago_PK ) 			lxComprobantevFfch =  .Fecha			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevMotivo =  upper( .Motivo_PK ) 			lxComprobantevFfchent =  .Fechadeentrega			lxComprobantevFtransp =  upper( .Transportista_PK ) 			lxComprobantevFtotal =  .Total			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevIvasis =  .Ivadelsistema
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
				insert into ZooLogic.COMPROBANTEV ( "Fmodifw","Fecexpo","Fecimpo","Fd2","Fectrans","Datosecomm","Fpodes1","Fpodes2","Fletra","Fperson","Fturno","Cotiz","Mdcimpu","Fajxre","Timestamp","Totalcant","Factsec","Subtotsisi","Subtotcisi","Signomov","Condivalp","Sitfisccli","Fsubtot","Fsubton","Facttipo","Recmntosi2","Desmntosi2","Desmntosi3","Desmntosi","Recmntosi1","Recmntosi","Desmntosi1","Fcompfis","Anulado","Fhora","Valtafw","Faltafw","Horaexpo","Vmodifw","Horaimpo","Smodifw","Hmodifw","Saltafw","Ualtafw","Bdmodifw","Haltafw","Descfw","Simbmon","Zadsfw","Esttrans","Umodifw","Bdaltafw","Monsis","Moneda","Fcuit","Md1","Md2","Fptoven","Fcliente","Fmtdes1","Fmtdes2","Codigo","Fobs","Fnumcomp","Fmtdes3","Fven","Tdci","Totdescsi","Codlista","Fpago","Ffch","Totrecarsi","Trci","Motivo","Ffchent","Ftransp","Ftotal","Fpodes","Recmnto2","Merconsign","Fdescu","Md3","Percepcion","Recmnto","Recpor","Mr","Mr1","Mr2","Recmnto1","Gravamen","Fimpuesto","Totrecar","Totdesc","Totimpue","Ivasis" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDatosecomm ) + "'" >>, <<lxComprobantevFpodes1 >>, <<lxComprobantevFpodes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevFturno >>, <<lxComprobantevCotiz >>, <<lxComprobantevMdcimpu >>, <<lxComprobantevFajxre >>, <<lxComprobantevTimestamp >>, <<lxComprobantevTotalcant >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevSignomov >>, <<lxComprobantevCondivalp >>, <<lxComprobantevSitfisccli >>, <<lxComprobantevFsubtot >>, <<lxComprobantevFsubton >>, <<lxComprobantevFacttipo >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevDesmntosi2 >>, <<lxComprobantevDesmntosi3 >>, <<lxComprobantevDesmntosi >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmntosi >>, <<lxComprobantevDesmntosi1 >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevMd1 >>, <<lxComprobantevMd2 >>, <<lxComprobantevFptoven >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<lxComprobantevFmtdes1 >>, <<lxComprobantevFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<lxComprobantevFnumcomp >>, <<lxComprobantevFmtdes3 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<lxComprobantevTdci >>, <<lxComprobantevTotdescsi >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFpago ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevTrci >>, <<"'" + this.FormatearTextoSql( lxComprobantevMotivo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfchent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFtransp ) + "'" >>, <<lxComprobantevFtotal >>, <<lxComprobantevFpodes >>, <<lxComprobantevRecmnto2 >>, <<iif( lxComprobantevMerconsign, 1, 0 ) >>, <<lxComprobantevFdescu >>, <<lxComprobantevMd3 >>, <<lxComprobantevPercepcion >>, <<lxComprobantevRecmnto >>, <<lxComprobantevRecpor >>, <<lxComprobantevMr >>, <<lxComprobantevMr1 >>, <<lxComprobantevMr2 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecar >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<lxComprobantevIvasis >> )
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
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string, lcFiltroEspecifico as String

		lcFiltroEspecifico = this.ObtenerFiltroEspecifico()
		with this.oEntidad
			this.GenerarSentenciasComponentes()
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFectrans, lxComprobantevDatosecomm, lxComprobantevFpodes1, lxComprobantevFpodes2, lxComprobantevFletra, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevCotiz, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevTimestamp, lxComprobantevTotalcant, lxComprobantevFactsec, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevCondivalp, lxComprobantevSitfisccli, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevDesmntosi1, lxComprobantevFcompfis, lxComprobantevAnulado, lxComprobantevFhora, lxComprobantevValtafw, lxComprobantevFaltafw, lxComprobantevHoraexpo, lxComprobantevVmodifw, lxComprobantevHoraimpo, lxComprobantevSmodifw, lxComprobantevHmodifw, lxComprobantevSaltafw, lxComprobantevUaltafw, lxComprobantevBdmodifw, lxComprobantevHaltafw, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevZadsfw, lxComprobantevEsttrans, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevMonsis, lxComprobantevMoneda, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevMd2, lxComprobantevFptoven, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFobs, lxComprobantevFnumcomp, lxComprobantevFmtdes3, lxComprobantevFven, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevCodlista, lxComprobantevFpago, lxComprobantevFfch, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevMotivo, lxComprobantevFfchent, lxComprobantevFtransp, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevMerconsign, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr1, lxComprobantevMr2, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis
				lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevDatosecomm =  .Dataecom			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevFletra =  .Letra			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevCotiz =  .Cotizacion			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFactsec =  .Secuencia			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevAnulado =  .Anulado			lxComprobantevFhora =  .Hora			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFcuit =  .Cuit			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevFobs =  .Obs			lxComprobantevFnumcomp =  .Numero			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFpago =  upper( .ForPago_PK ) 			lxComprobantevFfch =  .Fecha			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevMotivo =  upper( .Motivo_PK ) 			lxComprobantevFfchent =  .Fechadeentrega			lxComprobantevFtransp =  upper( .Transportista_PK ) 			lxComprobantevFtotal =  .Total			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevIvasis =  .Ivadelsistema
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
				update ZooLogic.COMPROBANTEV set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>,"Datosecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevDatosecomm ) + "'">>,"Fpodes1" = <<lxComprobantevFpodes1>>,"Fpodes2" = <<lxComprobantevFpodes2>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>,"Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>,"Fturno" = <<lxComprobantevFturno>>,"Cotiz" = <<lxComprobantevCotiz>>,"Mdcimpu" = <<lxComprobantevMdcimpu>>,"Fajxre" = <<lxComprobantevFajxre>>,"Timestamp" = <<lxComprobantevTimestamp>>,"Totalcant" = <<lxComprobantevTotalcant>>,"Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>,"Subtotsisi" = <<lxComprobantevSubtotsisi>>,"Subtotcisi" = <<lxComprobantevSubtotcisi>>,"Signomov" = <<lxComprobantevSignomov>>,"Condivalp" = <<lxComprobantevCondivalp>>,"Sitfisccli" = <<lxComprobantevSitfisccli>>,"Fsubtot" = <<lxComprobantevFsubtot>>,"Fsubton" = <<lxComprobantevFsubton>>,"Facttipo" = <<lxComprobantevFacttipo>>,"Recmntosi2" = <<lxComprobantevRecmntosi2>>,"Desmntosi2" = <<lxComprobantevDesmntosi2>>,"Desmntosi3" = <<lxComprobantevDesmntosi3>>,"Desmntosi" = <<lxComprobantevDesmntosi>>,"Recmntosi1" = <<lxComprobantevRecmntosi1>>,"Recmntosi" = <<lxComprobantevRecmntosi>>,"Desmntosi1" = <<lxComprobantevDesmntosi1>>,"Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>,"Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>,"Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>,"Md1" = <<lxComprobantevMd1>>,"Md2" = <<lxComprobantevMd2>>,"Fptoven" = <<lxComprobantevFptoven>>,"Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>,"Fmtdes1" = <<lxComprobantevFmtdes1>>,"Fmtdes2" = <<lxComprobantevFmtdes2>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>,"Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>,"Fnumcomp" = <<lxComprobantevFnumcomp>>,"Fmtdes3" = <<lxComprobantevFmtdes3>>,"Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>,"Tdci" = <<lxComprobantevTdci>>,"Totdescsi" = <<lxComprobantevTotdescsi>>,"Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>,"Fpago" = <<"'" + this.FormatearTextoSql( lxComprobantevFpago ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>,"Totrecarsi" = <<lxComprobantevTotrecarsi>>,"Trci" = <<lxComprobantevTrci>>,"Motivo" = <<"'" + this.FormatearTextoSql( lxComprobantevMotivo ) + "'">>,"Ffchent" = <<"'" + this.ConvertirDateSql( lxComprobantevFfchent ) + "'">>,"Ftransp" = <<"'" + this.FormatearTextoSql( lxComprobantevFtransp ) + "'">>,"Ftotal" = <<lxComprobantevFtotal>>,"Fpodes" = <<lxComprobantevFpodes>>,"Recmnto2" = <<lxComprobantevRecmnto2>>,"Merconsign" = <<iif( lxComprobantevMerconsign, 1, 0 )>>,"Fdescu" = <<lxComprobantevFdescu>>,"Md3" = <<lxComprobantevMd3>>,"Percepcion" = <<lxComprobantevPercepcion>>,"Recmnto" = <<lxComprobantevRecmnto>>,"Recpor" = <<lxComprobantevRecpor>>,"Mr" = <<lxComprobantevMr>>,"Mr1" = <<lxComprobantevMr1>>,"Mr2" = <<lxComprobantevMr2>>,"Recmnto1" = <<lxComprobantevRecmnto1>>,"Gravamen" = <<lxComprobantevGravamen>>,"Fimpuesto" = <<lxComprobantevFimpuesto>>,"Totrecar" = <<lxComprobantevTotrecar>>,"Totdesc" = <<lxComprobantevTotdesc>>,"Totimpue" = <<lxComprobantevTotimpue>>,"Ivasis" = <<lxComprobantevIvasis>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57 <<lcFiltroEspecifico>>  << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ComprobanteVDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpuestosV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.impVentas where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.COMPROBANTEV where " + this.ConvertirFuncionesSql( " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57" ) )
			this.xmlacursor( lcXml, 'c_HayDatos' )
			llHayDatos = reccount( 'c_HayDatos' ) > 0 
			use in select('c_HayDatos')
		return llHayDatos
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClavePrimaria( tlLlenarAtributos as Boolean ) as Boolean
		local llRetorno as boolean, lcFiltroEspecifico as String
		llRetorno = .t.
		lcFiltroEspecifico = this.ObtenerFiltroEspecifico()
		with this.oEntidad
			Local lxComprobantevCodigo
			lxComprobantevCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Datosecomm" as "Dataecom", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fletra" as "Letra", "Fperson" as "Cliente", "Fturno" as "Turno", "Cotiz" as "Cotizacion", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Factsec" as "Secuencia", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Condivalp" as "Condicioniva", "Sitfisccli" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Fhora" as "Hora", "Valtafw" as "Versionaltafw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Md2" as "Montodescuento2", "Fptoven" as "Puntodeventa", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fobs" as "Obs", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fven" as "Vendedor", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Codlista" as "Listadeprecios", "Fpago" as "Forpago", "Ffch" as "Fecha", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Motivo" as "Motivo", "Ffchent" as "Fechadeentrega", "Ftransp" as "Transportista", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Merconsign" as "Mercaderiaconsignacion", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr1" as "Recargomonto1", "Mr2" as "Recargomonto2", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57 <<lcFiltroEspecifico>> 
			endtext
			use in select('c_PREPARACIONDEMERCADERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PREPARACIONDEMERCADERIA', set( 'Datasession' ) )

			if reccount( 'c_PREPARACIONDEMERCADERIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as Boolean, lcFiltroEspecifico as String
		llRetorno = .t.
		lcFiltroEspecifico = this.ObtenerFiltroEspecifico()
		with this.oEntidad
			Local lxComprobanteVFACTTIPO As Variant, lxComprobanteVFLETRA As Variant, lxComprobanteVFPTOVEN As Variant, lxComprobanteVFNUMCOMP As Variant, lxCOMPROBANTEVFACTSEC As Variant
			lxComprobanteVFACTTIPO = .TipoComprobante
			lxComprobanteVFLETRA = .Letra
			lxComprobanteVFPTOVEN = .PuntoDeVenta
			lxComprobanteVFNUMCOMP = .Numero
			lxCOMPROBANTEVFACTSEC = .Secuencia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Datosecomm" as "Dataecom", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fletra" as "Letra", "Fperson" as "Cliente", "Fturno" as "Turno", "Cotiz" as "Cotizacion", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Factsec" as "Secuencia", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Condivalp" as "Condicioniva", "Sitfisccli" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Fhora" as "Hora", "Valtafw" as "Versionaltafw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Md2" as "Montodescuento2", "Fptoven" as "Puntodeventa", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fobs" as "Obs", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fven" as "Vendedor", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Codlista" as "Listadeprecios", "Fpago" as "Forpago", "Ffch" as "Fecha", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Motivo" as "Motivo", "Ffchent" as "Fechadeentrega", "Ftransp" as "Transportista", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Merconsign" as "Mercaderiaconsignacion", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr1" as "Recargomonto1", "Mr2" as "Recargomonto2", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57 And FACTTIPO = <<lxComprobanteVFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxComprobanteVFLETRA ) + "'">> and FPTOVEN = <<lxComprobanteVFPTOVEN>> and FNUMCOMP = <<lxComprobanteVFNUMCOMP>> and FACTSEC = <<"'" + this.FormatearTextoSql( lxCOMPROBANTEVFACTSEC ) + "'">> <<lcFiltroEspecifico>>
			endtext
			use in select('c_PREPARACIONDEMERCADERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PREPARACIONDEMERCADERIA', set( 'Datasession' ) )
			if reccount( 'c_PREPARACIONDEMERCADERIA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxComprobantevCodigo as Variant, lcFiltroEspecifico as String
		llRetorno = .t.
		lcFiltroEspecifico = This.ObtenerFiltroEspecifico()
		lxComprobantevCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57 <<lcFiltroEspecifico>> 
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
		Local llRetorno As Boolean, loError as Exception, loEx as Exception, lcFiltroEspecifico as String
		llRetorno = .F.
		lcFiltroEspecifico = this.ObtenerFiltroEspecifico()
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Datosecomm" as "Dataecom", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fletra" as "Letra", "Fperson" as "Cliente", "Fturno" as "Turno", "Cotiz" as "Cotizacion", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Factsec" as "Secuencia", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Condivalp" as "Condicioniva", "Sitfisccli" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Fhora" as "Hora", "Valtafw" as "Versionaltafw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Md2" as "Montodescuento2", "Fptoven" as "Puntodeventa", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fobs" as "Obs", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fven" as "Vendedor", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Codlista" as "Listadeprecios", "Fpago" as "Forpago", "Ffch" as "Fecha", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Motivo" as "Motivo", "Ffchent" as "Fechadeentrega", "Ftransp" as "Transportista", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Merconsign" as "Mercaderiaconsignacion", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr1" as "Recargomonto1", "Mr2" as "Recargomonto2", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57 <<lcFiltroEspecifico>> order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_PREPARACIONDEMERCADERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PREPARACIONDEMERCADERIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
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
		Local llRetorno As Boolean, loError as Exception, loEx as Exception, lcFiltroEspecifico as String
		llRetorno = .F.
		lcFiltroEspecifico = this.ObtenerFiltroEspecifico()
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Datosecomm" as "Dataecom", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fletra" as "Letra", "Fperson" as "Cliente", "Fturno" as "Turno", "Cotiz" as "Cotizacion", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Factsec" as "Secuencia", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Condivalp" as "Condicioniva", "Sitfisccli" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Fhora" as "Hora", "Valtafw" as "Versionaltafw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Md2" as "Montodescuento2", "Fptoven" as "Puntodeventa", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fobs" as "Obs", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fven" as "Vendedor", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Codlista" as "Listadeprecios", "Fpago" as "Forpago", "Ffch" as "Fecha", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Motivo" as "Motivo", "Ffchent" as "Fechadeentrega", "Ftransp" as "Transportista", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Merconsign" as "Mercaderiaconsignacion", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr1" as "Recargomonto1", "Mr2" as "Recargomonto2", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57 <<lcFiltroEspecifico>> order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_PREPARACIONDEMERCADERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PREPARACIONDEMERCADERIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
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
		Local llRetorno As Boolean, loError as Exception, loEx as Exception, lcFiltroEspecifico as String
		llRetorno = .F.
		lcFiltroEspecifico = this.ObtenerFiltroEspecifico()
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Datosecomm" as "Dataecom", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fletra" as "Letra", "Fperson" as "Cliente", "Fturno" as "Turno", "Cotiz" as "Cotizacion", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Factsec" as "Secuencia", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Condivalp" as "Condicioniva", "Sitfisccli" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Fhora" as "Hora", "Valtafw" as "Versionaltafw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Md2" as "Montodescuento2", "Fptoven" as "Puntodeventa", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fobs" as "Obs", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fven" as "Vendedor", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Codlista" as "Listadeprecios", "Fpago" as "Forpago", "Ffch" as "Fecha", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Motivo" as "Motivo", "Ffchent" as "Fechadeentrega", "Ftransp" as "Transportista", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Merconsign" as "Mercaderiaconsignacion", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr1" as "Recargomonto1", "Mr2" as "Recargomonto2", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57 <<lcFiltroEspecifico>> order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_PREPARACIONDEMERCADERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PREPARACIONDEMERCADERIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
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
		Local llRetorno As Boolean, loError as Exception, loEx as Exception, lcFiltroEspecifico as String
		llRetorno = .F.
		lcFiltroEspecifico = this.ObtenerFiltroEspecifico()
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Datosecomm" as "Dataecom", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fletra" as "Letra", "Fperson" as "Cliente", "Fturno" as "Turno", "Cotiz" as "Cotizacion", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Factsec" as "Secuencia", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Condivalp" as "Condicioniva", "Sitfisccli" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Fhora" as "Hora", "Valtafw" as "Versionaltafw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Md2" as "Montodescuento2", "Fptoven" as "Puntodeventa", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fobs" as "Obs", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fven" as "Vendedor", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Codlista" as "Listadeprecios", "Fpago" as "Forpago", "Ffch" as "Fecha", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Motivo" as "Motivo", "Ffchent" as "Fechadeentrega", "Ftransp" as "Transportista", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Merconsign" as "Mercaderiaconsignacion", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr1" as "Recargomonto1", "Mr2" as "Recargomonto2", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57 <<lcFiltroEspecifico>> order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_PREPARACIONDEMERCADERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PREPARACIONDEMERCADERIA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_PREPARACIONDEMERCADERIA.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecexpo,Fecimpo,Fd2,Fectrans,Datosecomm,Fpodes1,Fpodes2,Fletra,Fperson,Fturno,Cotiz," + ;
"Mdcimpu,Fajxre,Timestamp,Totalcant,Factsec,Subtotsisi,Subtotcisi,Signomov,Condivalp,Sitfisccli,Fsubt" + ;
"ot,Fsubton,Facttipo,Recmntosi2,Desmntosi2,Desmntosi3,Desmntosi,Recmntosi1,Recmntosi,Desmntosi1,Fcomp" + ;
"fis,Anulado,Fhora,Valtafw,Faltafw,Horaexpo,Vmodifw,Horaimpo,Smodifw,Hmodifw,Saltafw,Ualtafw,Bdmodifw" + ;
",Haltafw,Descfw,Simbmon,Zadsfw,Esttrans,Umodifw,Bdaltafw,Monsis,Moneda,Fcuit,Md1,Md2,Fptoven,Fclient" + ;
"e,Fmtdes1,Fmtdes2,Codigo,Fobs,Fnumcomp,Fmtdes3,Fven,Tdci,Totdescsi,Codlista,Fpago,Ffch,Totrecarsi,Tr" + ;
"ci,Motivo,Ffchent,Ftransp,Ftotal,Fpodes,Recmnto2,Merconsign,Fdescu,Md3,Percepcion,Recmnto,Recpor,Mr," + ;
"Mr1,Mr2,Recmnto1,Gravamen,Fimpuesto,Totrecar,Totdesc,Totimpue,Ivasis" + ;
" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57 and " + lcFiltro )
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
			local  lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFectrans, lxComprobantevDatosecomm, lxComprobantevFpodes1, lxComprobantevFpodes2, lxComprobantevFletra, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevCotiz, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevTimestamp, lxComprobantevTotalcant, lxComprobantevFactsec, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevCondivalp, lxComprobantevSitfisccli, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevDesmntosi1, lxComprobantevFcompfis, lxComprobantevAnulado, lxComprobantevFhora, lxComprobantevValtafw, lxComprobantevFaltafw, lxComprobantevHoraexpo, lxComprobantevVmodifw, lxComprobantevHoraimpo, lxComprobantevSmodifw, lxComprobantevHmodifw, lxComprobantevSaltafw, lxComprobantevUaltafw, lxComprobantevBdmodifw, lxComprobantevHaltafw, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevZadsfw, lxComprobantevEsttrans, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevMonsis, lxComprobantevMoneda, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevMd2, lxComprobantevFptoven, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFobs, lxComprobantevFnumcomp, lxComprobantevFmtdes3, lxComprobantevFven, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevCodlista, lxComprobantevFpago, lxComprobantevFfch, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevMotivo, lxComprobantevFfchent, lxComprobantevFtransp, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevMerconsign, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr1, lxComprobantevMr2, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis
				lxComprobantevFmodifw = ctod( '  /  /    ' )			lxComprobantevFecexpo = ctod( '  /  /    ' )			lxComprobantevFecimpo = ctod( '  /  /    ' )			lxComprobantevFd2 = ctod( '  /  /    ' )			lxComprobantevFectrans = ctod( '  /  /    ' )			lxComprobantevDatosecomm = []			lxComprobantevFpodes1 = 0			lxComprobantevFpodes2 = 0			lxComprobantevFletra = []			lxComprobantevFperson = []			lxComprobantevFturno = 0			lxComprobantevCotiz = 0			lxComprobantevMdcimpu = 0			lxComprobantevFajxre = 0			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevTotalcant = 0			lxComprobantevFactsec = []			lxComprobantevSubtotsisi = 0			lxComprobantevSubtotcisi = 0			lxComprobantevSignomov = 0			lxComprobantevCondivalp = 0			lxComprobantevSitfisccli = 0			lxComprobantevFsubtot = 0			lxComprobantevFsubton = 0			lxComprobantevFacttipo = 0			lxComprobantevRecmntosi2 = 0			lxComprobantevDesmntosi2 = 0			lxComprobantevDesmntosi3 = 0			lxComprobantevDesmntosi = 0			lxComprobantevRecmntosi1 = 0			lxComprobantevRecmntosi = 0			lxComprobantevDesmntosi1 = 0			lxComprobantevFcompfis = .F.			lxComprobantevAnulado = .F.			lxComprobantevFhora = []			lxComprobantevValtafw = []			lxComprobantevFaltafw = ctod( '  /  /    ' )			lxComprobantevHoraexpo = []			lxComprobantevVmodifw = []			lxComprobantevHoraimpo = []			lxComprobantevSmodifw = []			lxComprobantevHmodifw = []			lxComprobantevSaltafw = []			lxComprobantevUaltafw = []			lxComprobantevBdmodifw = []			lxComprobantevHaltafw = []			lxComprobantevDescfw = []			lxComprobantevSimbmon = []			lxComprobantevZadsfw = []			lxComprobantevEsttrans = []			lxComprobantevUmodifw = []			lxComprobantevBdaltafw = []			lxComprobantevMonsis = []			lxComprobantevMoneda = []			lxComprobantevFcuit = []			lxComprobantevMd1 = 0			lxComprobantevMd2 = 0			lxComprobantevFptoven = 0			lxComprobantevFcliente = []			lxComprobantevFmtdes1 = 0			lxComprobantevFmtdes2 = 0			lxComprobantevCodigo = []			lxComprobantevFobs = []			lxComprobantevFnumcomp = 0			lxComprobantevFmtdes3 = 0			lxComprobantevFven = []			lxComprobantevTdci = 0			lxComprobantevTotdescsi = 0			lxComprobantevCodlista = []			lxComprobantevFpago = []			lxComprobantevFfch = ctod( '  /  /    ' )			lxComprobantevTotrecarsi = 0			lxComprobantevTrci = 0			lxComprobantevMotivo = []			lxComprobantevFfchent = ctod( '  /  /    ' )			lxComprobantevFtransp = []			lxComprobantevFtotal = 0			lxComprobantevFpodes = 0			lxComprobantevRecmnto2 = 0			lxComprobantevMerconsign = .F.			lxComprobantevFdescu = 0			lxComprobantevMd3 = 0			lxComprobantevPercepcion = 0			lxComprobantevRecmnto = 0			lxComprobantevRecpor = 0			lxComprobantevMr = 0			lxComprobantevMr1 = 0			lxComprobantevMr2 = 0			lxComprobantevRecmnto1 = 0			lxComprobantevGravamen = 0			lxComprobantevFimpuesto = 0			lxComprobantevTotrecar = 0			lxComprobantevTotdesc = 0			lxComprobantevTotimpue = 0			lxComprobantevIvasis = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ComprobanteVDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpuestosV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.impVentas where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
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
		lcWhere = " Where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57" + this.ObtenerFiltroEspecifico()
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Datosecomm" as "Dataecom", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fletra" as "Letra", "Fperson" as "Cliente", "Fturno" as "Turno", "Cotiz" as "Cotizacion", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Factsec" as "Secuencia", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Condivalp" as "Condicioniva", "Sitfisccli" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Fhora" as "Hora", "Valtafw" as "Versionaltafw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Md2" as "Montodescuento2", "Fptoven" as "Puntodeventa", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fobs" as "Obs", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fven" as "Vendedor", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Codlista" as "Listadeprecios", "Fpago" as "Forpago", "Ffch" as "Fecha", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Motivo" as "Motivo", "Ffchent" as "Fechadeentrega", "Ftransp" as "Transportista", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Merconsign" as "Mercaderiaconsignacion", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr1" as "Recargomonto1", "Mr2" as "Recargomonto2", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema"
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
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'DATAECOM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DATOSECOMM AS DATAECOM'
				Case lcAtributo == 'PORCENTAJEDESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES1 AS PORCENTAJEDESCUENTO1'
				Case lcAtributo == 'PORCENTAJEDESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES2 AS PORCENTAJEDESCUENTO2'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS CLIENTE'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTURNO AS TURNO'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MDCIMPU AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'AJUSTESPORREDONDEOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAJXRE AS AJUSTESPORREDONDEOS'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'SECUENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSEC AS SECUENCIA'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCCLI AS SITUACIONFISCAL'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCUIT AS CUIT'
				Case lcAtributo == 'MONTODESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD1 AS MONTODESCUENTO1'
				Case lcAtributo == 'MONTODESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD2 AS MONTODESCUENTO2'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCLIENTE AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES1 AS MONTODESCUENTOCONIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVEN AS VENDEDOR'
				Case lcAtributo == 'TOTALDESCUENTOSCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDCI AS TOTALDESCUENTOSCONIMPUESTOS'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'FORPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPAGO AS FORPAGO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'TOTALRECARGOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECARSI AS TOTALRECARGOSSINIMPUESTOS'
				Case lcAtributo == 'TOTALRECARGOSCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRCI AS TOTALRECARGOSCONIMPUESTOS'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'FECHADEENTREGA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHENT AS FECHADEENTREGA'
				Case lcAtributo == 'TRANSPORTISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTRANSP AS TRANSPORTISTA'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'PORCENTAJEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES AS PORCENTAJEDESCUENTO'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'MERCADERIACONSIGNACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MERCONSIGN AS MERCADERIACONSIGNACION'
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
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR1 AS RECARGOMONTO1'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR2 AS RECARGOMONTO2'
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
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'DATAECOM'
				lcCampo = 'DATOSECOMM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO1'
				lcCampo = 'FPODES1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO2'
				lcCampo = 'FPODES2'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'FTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MDCIMPU'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTESPORREDONDEOS'
				lcCampo = 'FAJXRE'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'SECUENCIA'
				lcCampo = 'FACTSEC'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCCLI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'FCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO1'
				lcCampo = 'MD1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO2'
				lcCampo = 'MD2'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'FCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS1'
				lcCampo = 'FMTDES1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'FVEN'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSCONIMPUESTOS'
				lcCampo = 'TDCI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'FORPAGO'
				lcCampo = 'FPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSSINIMPUESTOS'
				lcCampo = 'TOTRECARSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSCONIMPUESTOS'
				lcCampo = 'TRCI'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADEENTREGA'
				lcCampo = 'FFCHENT'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTA'
				lcCampo = 'FTRANSP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO'
				lcCampo = 'FPODES'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'MERCADERIACONSIGNACION'
				lcCampo = 'MERCONSIGN'
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
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'MR1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'MR2'
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
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'FACTURADETALLE'
			lcRetorno = 'COMPROBANTEVDET'
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
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFectrans, lxComprobantevDatosecomm, lxComprobantevFpodes1, lxComprobantevFpodes2, lxComprobantevFletra, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevCotiz, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevTimestamp, lxComprobantevTotalcant, lxComprobantevFactsec, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevCondivalp, lxComprobantevSitfisccli, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevDesmntosi1, lxComprobantevFcompfis, lxComprobantevAnulado, lxComprobantevFhora, lxComprobantevValtafw, lxComprobantevFaltafw, lxComprobantevHoraexpo, lxComprobantevVmodifw, lxComprobantevHoraimpo, lxComprobantevSmodifw, lxComprobantevHmodifw, lxComprobantevSaltafw, lxComprobantevUaltafw, lxComprobantevBdmodifw, lxComprobantevHaltafw, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevZadsfw, lxComprobantevEsttrans, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevMonsis, lxComprobantevMoneda, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevMd2, lxComprobantevFptoven, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFobs, lxComprobantevFnumcomp, lxComprobantevFmtdes3, lxComprobantevFven, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevCodlista, lxComprobantevFpago, lxComprobantevFfch, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevMotivo, lxComprobantevFfchent, lxComprobantevFtransp, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevMerconsign, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr1, lxComprobantevMr2, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis
				lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevDatosecomm =  .Dataecom			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevFletra =  .Letra			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevCotiz =  .Cotizacion			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFactsec =  .Secuencia			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevAnulado =  .Anulado			lxComprobantevFhora =  .Hora			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFcuit =  .Cuit			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevFobs =  .Obs			lxComprobantevFnumcomp =  .Numero			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFpago =  upper( .ForPago_PK ) 			lxComprobantevFfch =  .Fecha			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevMotivo =  upper( .Motivo_PK ) 			lxComprobantevFfchent =  .Fechadeentrega			lxComprobantevFtransp =  upper( .Transportista_PK ) 			lxComprobantevFtotal =  .Total			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevIvasis =  .Ivadelsistema
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPROBANTEV ( "Fmodifw","Fecexpo","Fecimpo","Fd2","Fectrans","Datosecomm","Fpodes1","Fpodes2","Fletra","Fperson","Fturno","Cotiz","Mdcimpu","Fajxre","Timestamp","Totalcant","Factsec","Subtotsisi","Subtotcisi","Signomov","Condivalp","Sitfisccli","Fsubtot","Fsubton","Facttipo","Recmntosi2","Desmntosi2","Desmntosi3","Desmntosi","Recmntosi1","Recmntosi","Desmntosi1","Fcompfis","Anulado","Fhora","Valtafw","Faltafw","Horaexpo","Vmodifw","Horaimpo","Smodifw","Hmodifw","Saltafw","Ualtafw","Bdmodifw","Haltafw","Descfw","Simbmon","Zadsfw","Esttrans","Umodifw","Bdaltafw","Monsis","Moneda","Fcuit","Md1","Md2","Fptoven","Fcliente","Fmtdes1","Fmtdes2","Codigo","Fobs","Fnumcomp","Fmtdes3","Fven","Tdci","Totdescsi","Codlista","Fpago","Ffch","Totrecarsi","Trci","Motivo","Ffchent","Ftransp","Ftotal","Fpodes","Recmnto2","Merconsign","Fdescu","Md3","Percepcion","Recmnto","Recpor","Mr","Mr1","Mr2","Recmnto1","Gravamen","Fimpuesto","Totrecar","Totdesc","Totimpue","Ivasis" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDatosecomm ) + "'" >>, <<lxComprobantevFpodes1 >>, <<lxComprobantevFpodes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevFturno >>, <<lxComprobantevCotiz >>, <<lxComprobantevMdcimpu >>, <<lxComprobantevFajxre >>, <<lxComprobantevTimestamp >>, <<lxComprobantevTotalcant >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevSignomov >>, <<lxComprobantevCondivalp >>, <<lxComprobantevSitfisccli >>, <<lxComprobantevFsubtot >>, <<lxComprobantevFsubton >>, <<lxComprobantevFacttipo >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevDesmntosi2 >>, <<lxComprobantevDesmntosi3 >>, <<lxComprobantevDesmntosi >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmntosi >>, <<lxComprobantevDesmntosi1 >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevMd1 >>, <<lxComprobantevMd2 >>, <<lxComprobantevFptoven >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<lxComprobantevFmtdes1 >>, <<lxComprobantevFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<lxComprobantevFnumcomp >>, <<lxComprobantevFmtdes3 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<lxComprobantevTdci >>, <<lxComprobantevTotdescsi >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFpago ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevTrci >>, <<"'" + this.FormatearTextoSql( lxComprobantevMotivo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfchent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFtransp ) + "'" >>, <<lxComprobantevFtotal >>, <<lxComprobantevFpodes >>, <<lxComprobantevRecmnto2 >>, <<iif( lxComprobantevMerconsign, 1, 0 ) >>, <<lxComprobantevFdescu >>, <<lxComprobantevMd3 >>, <<lxComprobantevPercepcion >>, <<lxComprobantevRecmnto >>, <<lxComprobantevRecpor >>, <<lxComprobantevMr >>, <<lxComprobantevMr1 >>, <<lxComprobantevMr2 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecar >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<lxComprobantevIvasis >> )
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
			local  lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFectrans, lxComprobantevDatosecomm, lxComprobantevFpodes1, lxComprobantevFpodes2, lxComprobantevFletra, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevCotiz, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevTimestamp, lxComprobantevTotalcant, lxComprobantevFactsec, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevCondivalp, lxComprobantevSitfisccli, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevDesmntosi1, lxComprobantevFcompfis, lxComprobantevAnulado, lxComprobantevFhora, lxComprobantevValtafw, lxComprobantevFaltafw, lxComprobantevHoraexpo, lxComprobantevVmodifw, lxComprobantevHoraimpo, lxComprobantevSmodifw, lxComprobantevHmodifw, lxComprobantevSaltafw, lxComprobantevUaltafw, lxComprobantevBdmodifw, lxComprobantevHaltafw, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevZadsfw, lxComprobantevEsttrans, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevMonsis, lxComprobantevMoneda, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevMd2, lxComprobantevFptoven, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFobs, lxComprobantevFnumcomp, lxComprobantevFmtdes3, lxComprobantevFven, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevCodlista, lxComprobantevFpago, lxComprobantevFfch, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevMotivo, lxComprobantevFfchent, lxComprobantevFtransp, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevMerconsign, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr1, lxComprobantevMr2, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis
				lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevDatosecomm =  .Dataecom			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevFletra =  .Letra			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevCotiz =  .Cotizacion			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFactsec =  .Secuencia			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevAnulado =  .Anulado			lxComprobantevFhora =  .Hora			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFcuit =  .Cuit			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevFobs =  .Obs			lxComprobantevFnumcomp =  .Numero			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFpago =  upper( .ForPago_PK ) 			lxComprobantevFfch =  .Fecha			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevMotivo =  upper( .Motivo_PK ) 			lxComprobantevFfchent =  .Fechadeentrega			lxComprobantevFtransp =  upper( .Transportista_PK ) 			lxComprobantevFtotal =  .Total			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevIvasis =  .Ivadelsistema
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57]
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPROBANTEV set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>, "Datosecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevDatosecomm ) + "'">>, "Fpodes1" = <<lxComprobantevFpodes1>>, "Fpodes2" = <<lxComprobantevFpodes2>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>, "Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>, "Fturno" = <<lxComprobantevFturno>>, "Cotiz" = <<lxComprobantevCotiz>>, "Mdcimpu" = <<lxComprobantevMdcimpu>>, "Fajxre" = <<lxComprobantevFajxre>>, "Timestamp" = <<lxComprobantevTimestamp>>, "Totalcant" = <<lxComprobantevTotalcant>>, "Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>, "Subtotsisi" = <<lxComprobantevSubtotsisi>>, "Subtotcisi" = <<lxComprobantevSubtotcisi>>, "Signomov" = <<lxComprobantevSignomov>>, "Condivalp" = <<lxComprobantevCondivalp>>, "Sitfisccli" = <<lxComprobantevSitfisccli>>, "Fsubtot" = <<lxComprobantevFsubtot>>, "Fsubton" = <<lxComprobantevFsubton>>, "Facttipo" = <<lxComprobantevFacttipo>>, "Recmntosi2" = <<lxComprobantevRecmntosi2>>, "Desmntosi2" = <<lxComprobantevDesmntosi2>>, "Desmntosi3" = <<lxComprobantevDesmntosi3>>, "Desmntosi" = <<lxComprobantevDesmntosi>>, "Recmntosi1" = <<lxComprobantevRecmntosi1>>, "Recmntosi" = <<lxComprobantevRecmntosi>>, "Desmntosi1" = <<lxComprobantevDesmntosi1>>, "Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>, "Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>, "Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>, "Md1" = <<lxComprobantevMd1>>, "Md2" = <<lxComprobantevMd2>>, "Fptoven" = <<lxComprobantevFptoven>>, "Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>, "Fmtdes1" = <<lxComprobantevFmtdes1>>, "Fmtdes2" = <<lxComprobantevFmtdes2>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>, "Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>, "Fnumcomp" = <<lxComprobantevFnumcomp>>, "Fmtdes3" = <<lxComprobantevFmtdes3>>, "Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>, "Tdci" = <<lxComprobantevTdci>>, "Totdescsi" = <<lxComprobantevTotdescsi>>, "Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>, "Fpago" = <<"'" + this.FormatearTextoSql( lxComprobantevFpago ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>, "Totrecarsi" = <<lxComprobantevTotrecarsi>>, "Trci" = <<lxComprobantevTrci>>, "Motivo" = <<"'" + this.FormatearTextoSql( lxComprobantevMotivo ) + "'">>, "Ffchent" = <<"'" + this.ConvertirDateSql( lxComprobantevFfchent ) + "'">>, "Ftransp" = <<"'" + this.FormatearTextoSql( lxComprobantevFtransp ) + "'">>, "Ftotal" = <<lxComprobantevFtotal>>, "Fpodes" = <<lxComprobantevFpodes>>, "Recmnto2" = <<lxComprobantevRecmnto2>>, "Merconsign" = <<iif( lxComprobantevMerconsign, 1, 0 )>>, "Fdescu" = <<lxComprobantevFdescu>>, "Md3" = <<lxComprobantevMd3>>, "Percepcion" = <<lxComprobantevPercepcion>>, "Recmnto" = <<lxComprobantevRecmnto>>, "Recpor" = <<lxComprobantevRecpor>>, "Mr" = <<lxComprobantevMr>>, "Mr1" = <<lxComprobantevMr1>>, "Mr2" = <<lxComprobantevMr2>>, "Recmnto1" = <<lxComprobantevRecmnto1>>, "Gravamen" = <<lxComprobantevGravamen>>, "Fimpuesto" = <<lxComprobantevFimpuesto>>, "Totrecar" = <<lxComprobantevTotrecar>>, "Totdesc" = <<lxComprobantevTotdesc>>, "Totimpue" = <<lxComprobantevTotimpue>>, "Ivasis" = <<lxComprobantevIvasis>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPROBANTEV' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ComprobanteVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpuestosV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57]
		loColeccion.Agregar( 'delete from ZooLogic.COMPROBANTEV where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ComprobanteVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpuestosV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
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
			lcRetorno = [update ZooLogic.COMPROBANTEV set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPROBANTEV where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxComprobanteVFLETRA as variant, lxCOMPROBANTEVFACTSEC as variant, lxComprobanteVFACTTIPO as variant, lxComprobanteVFPTOVEN as variant, lxComprobanteVFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PREPARACIONDEMERCADERIA'
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPROBANTEV set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, DatosEComm = ] + "'" + this.FormatearTextoSql( &lcCursor..DatosEComm ) + "'"+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, fTurno = ] + transform( &lcCursor..fTurno )+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, MDCIMPU = ] + transform( &lcCursor..MDCIMPU )+ [, FAjXRe = ] + transform( &lcCursor..FAjXRe )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, FACTSEC = ] + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'"+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, SitFiscCli = ] + transform( &lcCursor..SitFiscCli )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, MD1 = ] + transform( &lcCursor..MD1 )+ [, MD2 = ] + transform( &lcCursor..MD2 )+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, FCLIENTE = ] + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'"+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, FVEN = ] + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'"+ [, TDCI = ] + transform( &lcCursor..TDCI )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, FPago = ] + "'" + this.FormatearTextoSql( &lcCursor..FPago ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, TRCI = ] + transform( &lcCursor..TRCI )+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, FFCHENT = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHENT ) + "'"+ [, FTransp = ] + "'" + this.FormatearTextoSql( &lcCursor..FTransp ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, MerConsign = ] + Transform( iif( &lcCursor..MerConsign, 1, 0 ))+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, MD3 = ] + transform( &lcCursor..MD3 )+ [, percepcion = ] + transform( &lcCursor..percepcion )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, MR = ] + transform( &lcCursor..MR )+ [, MR1 = ] + transform( &lcCursor..MR1 )+ [, MR2 = ] + transform( &lcCursor..MR2 )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, gravamen = ] + transform( &lcCursor..gravamen )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totdesc = ] + transform( &lcCursor..totdesc )+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, IvaSis = ] + transform( &lcCursor..IvaSis ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
						 FMODIFW, FECEXPO, FECIMPO, FD2, FECTRANS, DatosEComm, FPODES1, FPODES2, FLETRA, FPerson, fTurno, Cotiz, MDCIMPU, FAjXRe, TIMESTAMP, TotalCant, FACTSEC, SubTotSISI, SubTotCISI, signomov, CondivaLp, SitFiscCli, FSubTOT, fSubToN, FACTTIPO, RecMntoSI2, DesMntoSI2, DesMntoSI3, DesMntoSI, RecMntoSI1, RecMntoSI, DesMntoSI1, FCOMPFIS, Anulado, FHORA, VALTAFW, FAltaFW, HORAEXPO, VMODIFW, HORAIMPO, SMODIFW, HMODIFW, SALTAFW, UALTAFW, BDMODIFW, HAltaFW, DescFW, SimbMon, ZADSFW, ESTTRANS, UMODIFW, BDALTAFW, MonSis, Moneda, fCuit, MD1, MD2, FPTOVEN, FCLIENTE, FMTDES1, FMTDES2, CODIGO, FObs, FNUMCOMP, FMTDES3, FVEN, TDCI, totdescSI, CodLista, FPago, FFCH, totrecarSI, TRCI, MOTIVO, FFCHENT, FTransp, FTotal, FPODES, RecMnto2, MerConsign, fDescu, MD3, percepcion, RecMnto, RecPor, MR, MR1, MR2, RecMnto1, gravamen, fImpuesto, totrecar, totdesc, totimpue, IvaSis
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DatosEComm ) + "'" + ',' + transform( &lcCursor..FPODES1 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FPODES2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + transform( &lcCursor..fTurno ) + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..MDCIMPU ) + ',' + transform( &lcCursor..FAjXRe ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..TotalCant )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'" + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..SitFiscCli ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..RecMntoSI2 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + transform( &lcCursor..DesMntoSI ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..RecMntoSI ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'" + ',' + transform( &lcCursor..MD1 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MD2 ) + ',' + transform( &lcCursor..FPTOVEN ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'" + ',' + transform( &lcCursor..FMTDES1 ) + ',' + transform( &lcCursor..FMTDES2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..FMTDES3 )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'" + ',' + transform( &lcCursor..TDCI ) + ',' + transform( &lcCursor..totdescSI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPago ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..TRCI )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHENT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FTransp ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + Transform( iif( &lcCursor..MerConsign, 1, 0 )) + ',' + transform( &lcCursor..fDescu )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MD3 ) + ',' + transform( &lcCursor..percepcion ) + ',' + transform( &lcCursor..RecMnto ) + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..MR1 ) + ',' + transform( &lcCursor..MR2 ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + transform( &lcCursor..gravamen ) + ',' + transform( &lcCursor..fImpuesto ) + ',' + transform( &lcCursor..totrecar )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..totdesc ) + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..IvaSis )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PREPARACIONDEMERCADERIA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpuestosV Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.impVentas Where cCod] + lcIn  )
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
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'PREPARACIONDEMERCADERIA')
		this.oEntidad.FacturaDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'PREPARACIONDEMERCADERIA')
		this.oEntidad.FacturaDetalle.oItem.oCompGiftcard.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'PREPARACIONDEMERCADERIA')
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS', this.oEntidad.cPrefijoRecibir + 'PREPARACIONDEMERCADERIA')
		
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
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'PREPARACIONDEMERCADERIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PREPARACIONDEMERCADERIA_DATOSECOMM'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PREPARACIONDEMERCADERIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PREPARACIONDEMERCADERIA_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSVENTAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOVENTAS'
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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PREPARACIONDEMERCADERIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP ) or isnull( &lcCursor..FACTSEC )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PREPARACIONDEMERCADERIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PREPARACIONDEMERCADERIA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PREPARACIONDEMERCADERIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  FFCHENT   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ComprobanteV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ComprobanteV
Create Table ZooLogic.TablaTrabajo_ComprobanteV ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fd2" datetime  null, 
"fectrans" datetime  null, 
"datosecomm" varchar(max)  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fletra" char( 1 )  null, 
"fperson" char( 5 )  null, 
"fturno" numeric( 1, 0 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"mdcimpu" numeric( 15, 4 )  null, 
"fajxre" numeric( 8, 2 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"factsec" char( 2 )  null, 
"subtotsisi" numeric( 10, 2 )  null, 
"subtotcisi" numeric( 10, 2 )  null, 
"signomov" numeric( 2, 0 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"sitfisccli" numeric( 2, 0 )  null, 
"fsubtot" numeric( 15, 4 )  null, 
"fsubton" numeric( 15, 4 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"recmntosi2" numeric( 15, 4 )  null, 
"desmntosi2" numeric( 15, 4 )  null, 
"desmntosi3" numeric( 15, 4 )  null, 
"desmntosi" numeric( 15, 4 )  null, 
"recmntosi1" numeric( 15, 4 )  null, 
"recmntosi" numeric( 15, 4 )  null, 
"desmntosi1" numeric( 15, 4 )  null, 
"fcompfis" bit  null, 
"anulado" bit  null, 
"fhora" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"faltafw" datetime  null, 
"horaexpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"descfw" char( 200 )  null, 
"simbmon" char( 3 )  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"umodifw" char( 100 )  null, 
"bdaltafw" char( 8 )  null, 
"monsis" char( 10 )  null, 
"moneda" char( 10 )  null, 
"fcuit" char( 15 )  null, 
"md1" numeric( 15, 2 )  null, 
"md2" numeric( 17, 4 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"fcliente" char( 30 )  null, 
"fmtdes1" numeric( 15, 4 )  null, 
"fmtdes2" numeric( 15, 4 )  null, 
"codigo" char( 38 )  null, 
"fobs" varchar(max)  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"fmtdes3" numeric( 15, 4 )  null, 
"fven" char( 5 )  null, 
"tdci" numeric( 15, 4 )  null, 
"totdescsi" numeric( 15, 4 )  null, 
"codlista" char( 6 )  null, 
"fpago" char( 5 )  null, 
"ffch" datetime  null, 
"totrecarsi" numeric( 15, 4 )  null, 
"trci" numeric( 15, 4 )  null, 
"motivo" char( 3 )  null, 
"ffchent" datetime  null, 
"ftransp" char( 6 )  null, 
"ftotal" numeric( 16, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"recmnto2" numeric( 15, 4 )  null, 
"merconsign" bit  null, 
"fdescu" numeric( 8, 2 )  null, 
"md3" numeric( 15, 2 )  null, 
"percepcion" numeric( 15, 2 )  null, 
"recmnto" numeric( 15, 4 )  null, 
"recpor" numeric( 6, 2 )  null, 
"mr" numeric( 15, 2 )  null, 
"mr1" numeric( 17, 4 )  null, 
"mr2" numeric( 15, 2 )  null, 
"recmnto1" numeric( 15, 4 )  null, 
"gravamen" numeric( 15, 2 )  null, 
"fimpuesto" numeric( 8, 2 )  null, 
"totrecar" numeric( 8, 2 )  null, 
"totdesc" numeric( 8, 2 )  null, 
"totimpue" numeric( 8, 2 )  null, 
"ivasis" numeric( 10, 2 )  null )
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PREPARACIONDEMERCADERIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('datosecomm','datosecomm')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('mdcimpu','mdcimpu')
			.AgregarMapeo('fajxre','fajxre')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('factsec','factsec')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('sitfisccli','sitfisccli')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('md1','md1')
			.AgregarMapeo('md2','md2')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('fcliente','fcliente')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('fven','fven')
			.AgregarMapeo('tdci','tdci')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('fpago','fpago')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('trci','trci')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('ffchent','ffchent')
			.AgregarMapeo('ftransp','ftransp')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('merconsign','merconsign')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('md3','md3')
			.AgregarMapeo('percepcion','percepcion')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('mr1','mr1')
			.AgregarMapeo('mr2','mr2')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('gravamen','gravamen')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totdesc','totdesc')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('ivasis','ivasis')
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.DATOSECOMM = isnull( d.DATOSECOMM, t.DATOSECOMM ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.MDCIMPU = isnull( d.MDCIMPU, t.MDCIMPU ),t.FAJXRE = isnull( d.FAJXRE, t.FAJXRE ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.FACTSEC = isnull( d.FACTSEC, t.FACTSEC ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.SITFISCCLI = isnull( d.SITFISCCLI, t.SITFISCCLI ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.MD1 = isnull( d.MD1, t.MD1 ),t.MD2 = isnull( d.MD2, t.MD2 ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.FCLIENTE = isnull( d.FCLIENTE, t.FCLIENTE ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.FVEN = isnull( d.FVEN, t.FVEN ),t.TDCI = isnull( d.TDCI, t.TDCI ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.FPAGO = isnull( d.FPAGO, t.FPAGO ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TRCI = isnull( d.TRCI, t.TRCI ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.FFCHENT = isnull( d.FFCHENT, t.FFCHENT ),t.FTRANSP = isnull( d.FTRANSP, t.FTRANSP ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.MERCONSIGN = isnull( d.MERCONSIGN, t.MERCONSIGN ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.MD3 = isnull( d.MD3, t.MD3 ),t.PERCEPCION = isnull( d.PERCEPCION, t.PERCEPCION ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.MR = isnull( d.MR, t.MR ),t.MR1 = isnull( d.MR1, t.MR1 ),t.MR2 = isnull( d.MR2, t.MR2 ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.GRAVAMEN = isnull( d.GRAVAMEN, t.GRAVAMEN ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.IVASIS = isnull( d.IVASIS, t.IVASIS )
					from ZooLogic.COMPROBANTEV t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
							 and  t.FACTSEC = d.FACTSEC
				-- Fin Updates
				insert into ZooLogic.COMPROBANTEV(Fmodifw,Fecexpo,Fecimpo,Fd2,Fectrans,Datosecomm,Fpodes1,Fpodes2,Fletra,Fperson,Fturno,Cotiz,Mdcimpu,Fajxre,Timestamp,Totalcant,Factsec,Subtotsisi,Subtotcisi,Signomov,Condivalp,Sitfisccli,Fsubtot,Fsubton,Facttipo,Recmntosi2,Desmntosi2,Desmntosi3,Desmntosi,Recmntosi1,Recmntosi,Desmntosi1,Fcompfis,Anulado,Fhora,Valtafw,Faltafw,Horaexpo,Vmodifw,Horaimpo,Smodifw,Hmodifw,Saltafw,Ualtafw,Bdmodifw,Haltafw,Descfw,Simbmon,Zadsfw,Esttrans,Umodifw,Bdaltafw,Monsis,Moneda,Fcuit,Md1,Md2,Fptoven,Fcliente,Fmtdes1,Fmtdes2,Codigo,Fobs,Fnumcomp,Fmtdes3,Fven,Tdci,Totdescsi,Codlista,Fpago,Ffch,Totrecarsi,Trci,Motivo,Ffchent,Ftransp,Ftotal,Fpodes,Recmnto2,Merconsign,Fdescu,Md3,Percepcion,Recmnto,Recpor,Mr,Mr1,Mr2,Recmnto1,Gravamen,Fimpuesto,Totrecar,Totdesc,Totimpue,Ivasis)
					Select isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FD2,''),isnull( d.FECTRANS,''),isnull( d.DATOSECOMM,''),isnull( d.FPODES1,0),isnull( d.FPODES2,0),isnull( d.FLETRA,''),isnull( d.FPERSON,''),isnull( d.FTURNO,0),isnull( d.COTIZ,0),isnull( d.MDCIMPU,0),isnull( d.FAJXRE,0),isnull( d.TIMESTAMP,0),isnull( d.TOTALCANT,0),isnull( d.FACTSEC,''),isnull( d.SUBTOTSISI,0),isnull( d.SUBTOTCISI,0),isnull( d.SIGNOMOV,0),isnull( d.CONDIVALP,0),isnull( d.SITFISCCLI,0),isnull( d.FSUBTOT,0),isnull( d.FSUBTON,0),isnull( d.FACTTIPO,0),isnull( d.RECMNTOSI2,0),isnull( d.DESMNTOSI2,0),isnull( d.DESMNTOSI3,0),isnull( d.DESMNTOSI,0),isnull( d.RECMNTOSI1,0),isnull( d.RECMNTOSI,0),isnull( d.DESMNTOSI1,0),isnull( d.FCOMPFIS,0),isnull( d.ANULADO,0),isnull( d.FHORA,''),isnull( d.VALTAFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.HORAEXPO,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.DESCFW,''),isnull( d.SIMBMON,''),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.UMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.MONSIS,''),isnull( d.MONEDA,''),isnull( d.FCUIT,''),isnull( d.MD1,0),isnull( d.MD2,0),isnull( d.FPTOVEN,0),isnull( d.FCLIENTE,''),isnull( d.FMTDES1,0),isnull( d.FMTDES2,0),isnull( d.CODIGO,''),isnull( d.FOBS,''),isnull( d.FNUMCOMP,0),isnull( d.FMTDES3,0),isnull( d.FVEN,''),isnull( d.TDCI,0),isnull( d.TOTDESCSI,0),isnull( d.CODLISTA,''),isnull( d.FPAGO,''),isnull( d.FFCH,''),isnull( d.TOTRECARSI,0),isnull( d.TRCI,0),isnull( d.MOTIVO,''),isnull( d.FFCHENT,''),isnull( d.FTRANSP,''),isnull( d.FTOTAL,0),isnull( d.FPODES,0),isnull( d.RECMNTO2,0),isnull( d.MERCONSIGN,0),isnull( d.FDESCU,0),isnull( d.MD3,0),isnull( d.PERCEPCION,0),isnull( d.RECMNTO,0),isnull( d.RECPOR,0),isnull( d.MR,0),isnull( d.MR1,0),isnull( d.MR2,0),isnull( d.RECMNTO1,0),isnull( d.GRAVAMEN,0),isnull( d.FIMPUESTO,0),isnull( d.TOTRECAR,0),isnull( d.TOTDESC,0),isnull( d.TOTIMPUE,0),isnull( d.IVASIS,0)
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
			if reccount( 'c_PREPARACIONDEMERCADERIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PREPARACIONDEMERCADERIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PREPARACIONDEMERCADERIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PREPARACIONDEMERCADERIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_PREPARACIONDEMERCADERIA.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PREPARACIONDEMERCADERIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					lcValor = This.ObtenerMemo( 'c_Dataecom')
					.Dataecom = lcValor 
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Porcentajedescuento1 = nvl( c_PREPARACIONDEMERCADERIA.Porcentajedescuento1, 0 )
					.Porcentajedescuento2 = nvl( c_PREPARACIONDEMERCADERIA.Porcentajedescuento2, 0 )
					.Letra = nvl( c_PREPARACIONDEMERCADERIA.Letra, [] )
					.Cliente_PK =  nvl( c_PREPARACIONDEMERCADERIA.Cliente, [] )
					.Turno = nvl( c_PREPARACIONDEMERCADERIA.Turno, 0 )
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Cotizacion = nvl( c_PREPARACIONDEMERCADERIA.Cotizacion, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Montodescuentoconimpuestos = nvl( c_PREPARACIONDEMERCADERIA.Montodescuentoconimpuestos, 0 )
					.Ajustesporredondeos = nvl( c_PREPARACIONDEMERCADERIA.Ajustesporredondeos, 0 )
					.Timestamp = nvl( c_PREPARACIONDEMERCADERIA.Timestamp, 0 )
					.Totalcantidad = nvl( c_PREPARACIONDEMERCADERIA.Totalcantidad, 0 )
					.Secuencia = nvl( c_PREPARACIONDEMERCADERIA.Secuencia, [] )
					.Subtotalsinimpuestossobreitems = nvl( c_PREPARACIONDEMERCADERIA.Subtotalsinimpuestossobreitems, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_PREPARACIONDEMERCADERIA.Subtotalconimpuestossobreitems, 0 )
					.Signodemovimiento = nvl( c_PREPARACIONDEMERCADERIA.Signodemovimiento, 0 )
					.Condicioniva = nvl( c_PREPARACIONDEMERCADERIA.Condicioniva, 0 )
					.Situacionfiscal_PK =  nvl( c_PREPARACIONDEMERCADERIA.Situacionfiscal, 0 )
					.Subtotalbruto = nvl( c_PREPARACIONDEMERCADERIA.Subtotalbruto, 0 )
					.Subtotalneto = nvl( c_PREPARACIONDEMERCADERIA.Subtotalneto, 0 )
					.Tipocomprobante = nvl( c_PREPARACIONDEMERCADERIA.Tipocomprobante, 0 )
					.Recargomontosinimpuestos2 = nvl( c_PREPARACIONDEMERCADERIA.Recargomontosinimpuestos2, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_PREPARACIONDEMERCADERIA.Montodescuentosinimpuestos2, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_PREPARACIONDEMERCADERIA.Montodescuentosinimpuestos3, 0 )
					.Montodescuentosinimpuestos = nvl( c_PREPARACIONDEMERCADERIA.Montodescuentosinimpuestos, 0 )
					.Recargomontosinimpuestos1 = nvl( c_PREPARACIONDEMERCADERIA.Recargomontosinimpuestos1, 0 )
					.Recargomontosinimpuestos = nvl( c_PREPARACIONDEMERCADERIA.Recargomontosinimpuestos, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_PREPARACIONDEMERCADERIA.Montodescuentosinimpuestos1, 0 )
					.Comprobantefiscal = nvl( c_PREPARACIONDEMERCADERIA.Comprobantefiscal, .F. )
					.Anulado = nvl( c_PREPARACIONDEMERCADERIA.Anulado, .F. )
					.Hora = nvl( c_PREPARACIONDEMERCADERIA.Hora, [] )
					.Versionaltafw = nvl( c_PREPARACIONDEMERCADERIA.Versionaltafw, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PREPARACIONDEMERCADERIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_PREPARACIONDEMERCADERIA.Horaexpo, [] )
					.Versionmodificacionfw = nvl( c_PREPARACIONDEMERCADERIA.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_PREPARACIONDEMERCADERIA.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_PREPARACIONDEMERCADERIA.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_PREPARACIONDEMERCADERIA.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_PREPARACIONDEMERCADERIA.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_PREPARACIONDEMERCADERIA.Usuarioaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_PREPARACIONDEMERCADERIA.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_PREPARACIONDEMERCADERIA.Horaaltafw, [] )
					.Descripcionfw = nvl( c_PREPARACIONDEMERCADERIA.Descripcionfw, [] )
					.Simbolomonetariocomprobante = nvl( c_PREPARACIONDEMERCADERIA.Simbolomonetariocomprobante, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_PREPARACIONDEMERCADERIA.Estadotransferencia, [] )
					.Usuariomodificacionfw = nvl( c_PREPARACIONDEMERCADERIA.Usuariomodificacionfw, [] )
					.Basededatosaltafw = nvl( c_PREPARACIONDEMERCADERIA.Basededatosaltafw, [] )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					.Monedasistema_PK =  nvl( c_PREPARACIONDEMERCADERIA.Monedasistema, [] )
					.Monedacomprobante_PK =  nvl( c_PREPARACIONDEMERCADERIA.Monedacomprobante, [] )
					.Cuit = nvl( c_PREPARACIONDEMERCADERIA.Cuit, [] )
					.Montodescuento1 = nvl( c_PREPARACIONDEMERCADERIA.Montodescuento1, 0 )
					.Montodescuento2 = nvl( c_PREPARACIONDEMERCADERIA.Montodescuento2, 0 )
					.Puntodeventa = nvl( c_PREPARACIONDEMERCADERIA.Puntodeventa, 0 )
					.Clientedescripcion = nvl( c_PREPARACIONDEMERCADERIA.Clientedescripcion, [] )
					.Montodescuentoconimpuestos1 = nvl( c_PREPARACIONDEMERCADERIA.Montodescuentoconimpuestos1, 0 )
					.Montodescuentoconimpuestos2 = nvl( c_PREPARACIONDEMERCADERIA.Montodescuentoconimpuestos2, 0 )
					.Codigo = nvl( c_PREPARACIONDEMERCADERIA.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Numero = nvl( c_PREPARACIONDEMERCADERIA.Numero, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_PREPARACIONDEMERCADERIA.Montodescuentoconimpuestos3, 0 )
					.Vendedor_PK =  nvl( c_PREPARACIONDEMERCADERIA.Vendedor, [] )
					.Totaldescuentosconimpuestos = nvl( c_PREPARACIONDEMERCADERIA.Totaldescuentosconimpuestos, 0 )
					.Totaldescuentossinimpuestos = nvl( c_PREPARACIONDEMERCADERIA.Totaldescuentossinimpuestos, 0 )
					.Listadeprecios_PK =  nvl( c_PREPARACIONDEMERCADERIA.Listadeprecios, [] )
					.Forpago_PK =  nvl( c_PREPARACIONDEMERCADERIA.Forpago, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_PREPARACIONDEMERCADERIA.Fecha, ctod( '  /  /    ' ) ) )
					.Totalrecargossinimpuestos = nvl( c_PREPARACIONDEMERCADERIA.Totalrecargossinimpuestos, 0 )
					.Totalrecargosconimpuestos = nvl( c_PREPARACIONDEMERCADERIA.Totalrecargosconimpuestos, 0 )
					.Motivo_PK =  nvl( c_PREPARACIONDEMERCADERIA.Motivo, [] )
					.Fechadeentrega = GoLibrerias.ObtenerFechaFormateada( nvl( c_PREPARACIONDEMERCADERIA.Fechadeentrega, ctod( '  /  /    ' ) ) )
					.Transportista_PK =  nvl( c_PREPARACIONDEMERCADERIA.Transportista, [] )
					.Total = nvl( c_PREPARACIONDEMERCADERIA.Total, 0 )
					.Porcentajedescuento = nvl( c_PREPARACIONDEMERCADERIA.Porcentajedescuento, 0 )
					.Recargomontoconimpuestos2 = nvl( c_PREPARACIONDEMERCADERIA.Recargomontoconimpuestos2, 0 )
					.Mercaderiaconsignacion = nvl( c_PREPARACIONDEMERCADERIA.Mercaderiaconsignacion, .F. )
					.Descuento = nvl( c_PREPARACIONDEMERCADERIA.Descuento, 0 )
					.Montodescuento3 = nvl( c_PREPARACIONDEMERCADERIA.Montodescuento3, 0 )
					.Percepciones = nvl( c_PREPARACIONDEMERCADERIA.Percepciones, 0 )
					.Recargomontoconimpuestos = nvl( c_PREPARACIONDEMERCADERIA.Recargomontoconimpuestos, 0 )
					.Recargoporcentaje = nvl( c_PREPARACIONDEMERCADERIA.Recargoporcentaje, 0 )
					.Recargomonto = nvl( c_PREPARACIONDEMERCADERIA.Recargomonto, 0 )
					.Recargomonto1 = nvl( c_PREPARACIONDEMERCADERIA.Recargomonto1, 0 )
					.Recargomonto2 = nvl( c_PREPARACIONDEMERCADERIA.Recargomonto2, 0 )
					.Recargomontoconimpuestos1 = nvl( c_PREPARACIONDEMERCADERIA.Recargomontoconimpuestos1, 0 )
					.Gravamenes = nvl( c_PREPARACIONDEMERCADERIA.Gravamenes, 0 )
					.Impuestos = nvl( c_PREPARACIONDEMERCADERIA.Impuestos, 0 )
					.Totalrecargos = nvl( c_PREPARACIONDEMERCADERIA.Totalrecargos, 0 )
					.Totaldescuentos = nvl( c_PREPARACIONDEMERCADERIA.Totaldescuentos, 0 )
					.Totalimpuestos = nvl( c_PREPARACIONDEMERCADERIA.Totalimpuestos, 0 )
					.Ivadelsistema = nvl( c_PREPARACIONDEMERCADERIA.Ivadelsistema, 0 )
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
			lxRetorno = c_PREPARACIONDEMERCADERIA.CODIGO
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
	function ObtenerFiltroEspecifico() as String
		local lcRetorno as String, lcTabla as String

		lcRetorno = ''
		lcTabla = 'COMPROBANTEV'

		if '<FILTROESPECIFICO>' $ this.oEntidad.ObtenerFuncionalidades()
			if goServicios.modulos.ExisteModulo( 'D' )
				if !goServicios.Modulos.ModuloHabilitado( 'D' )
					lcRetorno = ' And ' + lcTabla + '.PagaEnCaja = 1'
				endif
			endif
		endif

		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_PREPARACIONDEMERCADERIA.&lcAtributo
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
								Where   COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57
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
			"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Datosecomm" as "Dataecom", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fletra" as "Letra", "Fperson" as "Cliente", "Fturno" as "Turno", "Cotiz" as "Cotizacion", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Factsec" as "Secuencia", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Condivalp" as "Condicioniva", "Sitfisccli" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Fhora" as "Hora", "Valtafw" as "Versionaltafw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Md2" as "Montodescuento2", "Fptoven" as "Puntodeventa", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fobs" as "Obs", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fven" as "Vendedor", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Codlista" as "Listadeprecios", "Fpago" as "Forpago", "Ffch" as "Fecha", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Motivo" as "Motivo", "Ffchent" as "Fechadeentrega", "Ftransp" as "Transportista", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Merconsign" as "Mercaderiaconsignacion", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr1" as "Recargomonto1", "Mr2" as "Recargomonto2", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPROBANTEV 
								Where   COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57
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
	Filtro = " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57"
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
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FECHAMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FECHAEXPO                               " tabla="COMPROBANTEV   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FECHAIMPO                               " tabla="COMPROBANTEV   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FECHAMODIFICACION                       " tabla="COMPROBANTEV   " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FECHATRANSFERENCIA                      " tabla="COMPROBANTEV   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                                                                                                                       " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="DATAECOM                                " tabla="COMPROBANTEV   " campo="DATOSECOMM" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FACTURADETALLE                          " tabla="COMPROBANTEVDET" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Artículos del pedido                                                                                                                                                                                                                                      " dominio="DETALLEITEMARTICULOSVENTAS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="PORCENTAJEDESCUENTO1                    " tabla="COMPROBANTEV   " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje descuento 1                                                                                                                                                                                                                                    " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="PORCENTAJEDESCUENTO2                    " tabla="COMPROBANTEV   " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje descuento 2                                                                                                                                                                                                                                    " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="LETRA                                   " tabla="COMPROBANTEV   " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Letra de comprobante                                                                                                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="CLIENTE                                 " tabla="COMPROBANTEV   " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Cliente                                                                                                                                                                                                                                                   " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TURNO                                   " tabla="COMPROBANTEV   " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="@ObtenerTurno()                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="IMPUESTOSDETALLE                        " tabla="IMPUESTOSV     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos                                                                                                                                                                                                                                                 " dominio="DETALLEITEMIMPUESTOS          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="COTIZACION                              " tabla="COMPROBANTEV   " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTOCONIMPUESTOS              " tabla="COMPROBANTEV   " campo="MDCIMPU   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="AJUSTESPORREDONDEOS                     " tabla="COMPROBANTEV   " campo="FAJXRE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Ajustes por redondeo                                                                                                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TIMESTAMP                               " tabla="COMPROBANTEV   " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TOTALCANTIDAD                           " tabla="COMPROBANTEV   " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Total Cantidad                                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SECUENCIA                               " tabla="COMPROBANTEV   " campo="FACTSEC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Secuencia                                                                                                                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SIGNODEMOVIMIENTO                       " tabla="COMPROBANTEV   " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="CONDICIONIVA                            " tabla="COMPROBANTEV   " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SITUACIONFISCAL                         " tabla="COMPROBANTEV   " campo="SITFISCCLI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="=3                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="Situación fiscal                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SUBTOTALBRUTO                           " tabla="COMPROBANTEV   " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal bruto                                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SUBTOTALNETO                            " tabla="COMPROBANTEV   " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal neto                                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TIPOCOMPROBANTE                         " tabla="COMPROBANTEV   " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=57                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="18" etiqueta="Tipo de comprobante                                                                                                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="COMPROBANTEV   " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="COMPROBANTEV   " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="COMPROBANTEV   " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="COMPROBANTEV   " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="COMPROBANTEFISCAL                       " tabla="COMPROBANTEV   " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="ANULADO                                 " tabla="COMPROBANTEV   " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="HORA                                    " tabla="COMPROBANTEV   " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="VERSIONALTAFW                           " tabla="COMPROBANTEV   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FECHAALTAFW                             " tabla="COMPROBANTEV   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="20" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="HORAEXPO                                " tabla="COMPROBANTEV   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="HORAIMPO                                " tabla="COMPROBANTEV   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SERIEMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="HORAMODIFICACIONFW                      " tabla="COMPROBANTEV   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SERIEALTAFW                             " tabla="COMPROBANTEV   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="USUARIOALTAFW                           " tabla="COMPROBANTEV   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPROBANTEV   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="HORAALTAFW                              " tabla="COMPROBANTEV   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="22" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="DESCRIPCIONFW                           " tabla="COMPROBANTEV   " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="COMPROBANTEV   " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="ZADSFW                                  " tabla="COMPROBANTEV   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPROBANTEV   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="BASEDEDATOSALTAFW                       " tabla="COMPROBANTEV   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPVENTAS      " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos del comprobante                                                                                                                                                                                                                                 " dominio="DETALLEITEMIMPUESTOVENTAS     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONEDASISTEMA                           " tabla="COMPROBANTEV   " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Sistema                                                                                                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONEDACOMPROBANTE                       " tabla="COMPROBANTEV   " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Comprobante                                                                                                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="CUIT                                    " tabla="COMPROBANTEV   " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="CUIT                                                                                                                                                                                                                                                      " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="Cliente.cuit                                                                                                                                                                                                                                                  " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTO1                         " tabla="COMPROBANTEV   " campo="MD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento 1                                                                                                                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTO2                         " tabla="COMPROBANTEV   " campo="MD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento 2                                                                                                                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="PUNTODEVENTA                            " tabla="COMPROBANTEV   " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Pto. venta                                                                                                                                                                                                                                                " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="CLIENTEDESCRIPCION                      " tabla="COMPROBANTEV   " campo="FCLIENTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Cliente descripción                                                                                                                                                                                                                                       " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="COMPROBANTEV   " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto cescuento con impuestos 1                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="COMPROBANTEV   " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto cescuento con impuestos 2                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="CODIGO                                  " tabla="COMPROBANTEV   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="24" etiqueta="Código número                                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="OBS                                     " tabla="COMPROBANTEV   " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="NUMERO                                  " tabla="COMPROBANTEV   " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="COMPROBANTEV   " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 3                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="VENDEDOR                                " tabla="COMPROBANTEV   " campo="FVEN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Vendedor                                                                                                                                                                                                                                                  " dominio="CODIGOVENDEDOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TOTALDESCUENTOSCONIMPUESTOS             " tabla="COMPROBANTEV   " campo="TDCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos con impuestos                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="COMPROBANTEV   " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos sin impuestos                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="LISTADEPRECIOS                          " tabla="COMPROBANTEV   " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferente                                                                                                                                                                                         " obligatorio="true" admitebusqueda="410" etiqueta="Lista de precio                                                                                                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FORPAGO                                 " tabla="COMPROBANTEV   " campo="FPAGO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Condición de pago                                                                                                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FECHA                                   " tabla="COMPROBANTEV   " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                                                                                                                     " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="COMPROBANTEV   " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo sin impuestos                                                                                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TOTALRECARGOSCONIMPUESTOS               " tabla="COMPROBANTEV   " campo="TRCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo con impuestos                                                                                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MOTIVO                                  " tabla="COMPROBANTEV   " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Motivo                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="FECHADEENTREGA                          " tabla="COMPROBANTEV   " campo="FFCHENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="12" etiqueta="Fecha de entrega                                                                                                                                                                                                                                          " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TRANSPORTISTA                           " tabla="COMPROBANTEV   " campo="FTRANSP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Transportista                                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TOTAL                                   " tabla="COMPROBANTEV   " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Total                                                                                                                                                                                                                                                     " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="PORCENTAJEDESCUENTO                     " tabla="COMPROBANTEV   " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Porcentaje descuento                                                                                                                                                                                                                                      " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 2                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MERCADERIACONSIGNACION                  " tabla="COMPROBANTEV   " campo="MERCONSIGN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Mercadería en consignación                                                                                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="DESCUENTO                               " tabla="COMPROBANTEV   " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Monto % descuento                                                                                                                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="MONTODESCUENTO3                         " tabla="COMPROBANTEV   " campo="MD3       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Monto de descuento                                                                                                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="PERCEPCIONES                            " tabla="COMPROBANTEV   " campo="PERCEPCION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Percepciones                                                                                                                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos                                                                                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOPORCENTAJE                       " tabla="COMPROBANTEV   " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Recargo porcentaje                                                                                                                                                                                                                                        " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOMONTO                            " tabla="COMPROBANTEV   " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Recargo % monto                                                                                                                                                                                                                                           " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="42" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOMONTO1                           " tabla="COMPROBANTEV   " campo="MR1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto recargo valores                                                                                                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="44" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOMONTO2                           " tabla="COMPROBANTEV   " campo="MR2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Recargo monto                                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 1                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="GRAVAMENES                              " tabla="COMPROBANTEV   " campo="GRAVAMEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuesto Interno                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SUBTOTALSINIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal sin imp                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="IMPUESTOS                               " tabla="COMPROBANTEV   " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="I.V.A.                                                                                                                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="SUBTOTALCONIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal con imp                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TOTALRECARGOS                           " tabla="COMPROBANTEV   " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo                                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TOTALDESCUENTOS                         " tabla="COMPROBANTEV   " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="28" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="TOTALIMPUESTOS                          " tabla="COMPROBANTEV   " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Total impuestos                                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PREPARACIONDEMERCADERIA                 " atributo="IVADELSISTEMA                           " tabla="COMPROBANTEV   " campo="IVASIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="goparametros.felino.datoSIMPOSITIVOS.ivaINSCRIPTOS                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="81" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="9" etiqueta="Detalle Cli.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPROBANTEV.FPERSON = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Ven.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPROBANTEV.FVEN = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Lis.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On COMPROBANTEV.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="413" etiqueta="Detalle Con.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On COMPROBANTEV.FPAGO = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Mot.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On COMPROBANTEV.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="417" etiqueta="Detalle Tra.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On COMPROBANTEV.FTRANSP = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="ARTICULO                                " tabla="COMPROBANTEVDET" campo="FART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleArtículosDelPedido, Artículo                                                                                                                             " dominio="CLAVECONLECTURACB             " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="ARTICULODETALLE                         " tabla="COMPROBANTEVDET" campo="FTXT      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleArtículosDelPedido, Descripción                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="COLOR                                   " tabla="COMPROBANTEVDET" campo="FCOLO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleArtículosDelPedido, Color                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="COLORDETALLE                            " tabla="COMPROBANTEVDET" campo="FCOTXT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleArtículosDelPedido, Detalle                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="TALLE                                   " tabla="COMPROBANTEVDET" campo="FTALL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleArtículosDelPedido, Tal                                                                                                                                  " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="DESCUENTO                               " tabla="COMPROBANTEVDET" campo="FCFI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleArtículosDelPedido, Des%                                                                                                                                 " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="MONTODESCUENTO                          " tabla="COMPROBANTEVDET" campo="MNTDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleArtículosDelPedido, Monto Desc.                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="CANTIDAD                                " tabla="COMPROBANTEVDET" campo="FCANT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="this.CompletarCantidadSegunParametro()                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="208" etiqueta="DetalleArtículosDelPedido, Cant                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="PRECIO                                  " tabla="COMPROBANTEVDET" campo="FPRECIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleArtículosDelPedido, Precio                                                                                                                               " dominio="PRECIONONEGATIVOPARAMETROFOCO " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="MONTO                                   " tabla="COMPROBANTEVDET" campo="FMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleArtículosDelPedido, Monto                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 57                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext


			.listadecampos = .cEstructura
			.cEstructuraSinDetalle = .cEstructura
			.oEntidad = toEntidad
			.Indice = .Indice + this.ObtenerFiltroEspecifico()
			.Filtro = .Filtro + this.ObtenerFiltroEspecifico()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFiltroEspecifico() as String
		local lcRetorno as String, lcTabla as String

		lcRetorno = ''
		lcTabla = 'COMPROBANTEV'

		if '<FILTROESPECIFICO>' $ this.oEntidad.ObtenerFuncionalidades()
			if goServicios.modulos.ExisteModulo( 'D' )
				if !goServicios.Modulos.ModuloHabilitado( 'D' )
					lcRetorno = ' And ' + lcTabla + '.PagaEnCaja = 1'
				endif
			endif
		endif

		return lcRetorno
	endfunc
enddefine