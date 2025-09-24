
define class Din_EntidadREQUERIMIENTODECOMPRAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REQUERIMIENTODECOMPRA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0)]
	cTagClaveCandidata = '_RDCCC'
	cTagClavePk = '_RDCPK'
	cTablaPrincipal = 'REQCOMPRA'
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
			local  lxReqcompraFecexpo, lxReqcompraFaltafw, lxReqcompraFd2, lxReqcompraFecimpo, lxReqcompraFectrans, lxReqcompraFmodifw, lxReqcompraFcuit, lxReqcompraIdcaja, lxReqcompraFpodes2, lxReqcompraFpodes1, lxReqcompraFpodes, lxReqcompraFturno, lxReqcompraRecmntosi2, lxReqcompraTimestamp, lxReqcompraDesmntosi1, lxReqcompraDesmntosi2, lxReqcompraDesmntosi, lxReqcompraTotalcant, lxReqcompraSignomov, lxReqcompraFsubton, lxReqcompraRecmntosi1, lxReqcompraFsubtot, lxReqcompraSitfiscpro, lxReqcompraCondivalp, lxReqcompraFacttipo, lxReqcompraSubtotsisi, lxReqcompraRecmnto1, lxReqcompraSubtotcisi, lxReqcompraRecmntosi, lxReqcompraRecmnto2, lxReqcompraAnulado, lxReqcompraFcompfis, lxReqcompraDesauto, lxReqcompraUaltafw, lxReqcompraFhora, lxReqcompraEsttrans, lxReqcompraHaltafw, lxReqcompraHmodifw, lxReqcompraSaltafw, lxReqcompraHoraimpo, lxReqcompraBdmodifw, lxReqcompraHoraexpo, lxReqcompraUmodifw, lxReqcompraBdaltafw, lxReqcompraZadsfw, lxReqcompraVmodifw, lxReqcompraDescfw, lxReqcompraValtafw, lxReqcompraSimbmon, lxReqcompraSmodifw, lxReqcompraTcrg1361, lxReqcompraCodigo, lxReqcompraIdvuelto, lxReqcompraMonsis, lxReqcompraMoneda, lxReqcompraFmtdes1, lxReqcompraFdescu, lxReqcompraFmtdes2, lxReqcompraFletra, lxReqcompraFimpuesto, lxReqcompraFobs, lxReqcompraFfchfac, lxReqcompraFptoven, lxReqcompraDesmntosi3, lxReqcompraFmtdes3, lxReqcompraRecpor, lxReqcompraFnumcomp, lxReqcompraTotdescsi, lxReqcompraMr, lxReqcompraNcai, lxReqcompraFperson, lxReqcompraFvtocai, lxReqcompraFfch, lxReqcompraFvuelto, lxReqcompraRecmnto, lxReqcompraNroremito, lxReqcompraCodlista, lxReqcompraFfchvenc, lxReqcompraMotivo, lxReqcompraCondpago, lxReqcompraFtotal, lxReqcompraCotiz, lxReqcompraRecmonto2, lxReqcompraRecmonto1, lxReqcompraTotimpue, lxReqcompraTotrecarsi, lxReqcompraTotrecar, lxReqcompraTotdesc
				lxReqcompraFecexpo =  .Fechaexpo			lxReqcompraFaltafw =  .Fechaaltafw			lxReqcompraFd2 =  .Fechamodificacion			lxReqcompraFecimpo =  .Fechaimpo			lxReqcompraFectrans =  .Fechatransferencia			lxReqcompraFmodifw =  .Fechamodificacionfw			lxReqcompraFcuit =  .Cuit			lxReqcompraIdcaja =  .Caja_PK 			lxReqcompraFpodes2 =  .Porcentajedescuento2			lxReqcompraFpodes1 =  .Porcentajedescuento1			lxReqcompraFpodes =  .Porcentajedescuento			lxReqcompraFturno =  .Turno			lxReqcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxReqcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxReqcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxReqcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxReqcompraDesmntosi =  .Montodescuentosinimpuestos			lxReqcompraTotalcant =  .Totalcantidad			lxReqcompraSignomov =  .Signodemovimiento			lxReqcompraFsubton =  .Subtotalneto			lxReqcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxReqcompraFsubtot =  .Subtotalbruto			lxReqcompraSitfiscpro =  .Situacionfiscal_PK 			lxReqcompraCondivalp =  .Condicioniva			lxReqcompraFacttipo =  .Tipocomprobante			lxReqcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxReqcompraRecmnto1 =  .Recargomontoconimpuestos1			lxReqcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxReqcompraRecmntosi =  .Recargomontosinimpuestos			lxReqcompraRecmnto2 =  .Recargomontoconimpuestos2			lxReqcompraAnulado =  .Anulado			lxReqcompraFcompfis =  .Comprobantefiscal			lxReqcompraDesauto =  .Descuentoautomatico			lxReqcompraUaltafw =  .Usuarioaltafw			lxReqcompraFhora =  .Hora			lxReqcompraEsttrans =  .Estadotransferencia			lxReqcompraHaltafw =  .Horaaltafw			lxReqcompraHmodifw =  .Horamodificacionfw			lxReqcompraSaltafw =  .Seriealtafw			lxReqcompraHoraimpo =  .Horaimpo			lxReqcompraBdmodifw =  .Basededatosmodificacionfw			lxReqcompraHoraexpo =  .Horaexpo			lxReqcompraUmodifw =  .Usuariomodificacionfw			lxReqcompraBdaltafw =  .Basededatosaltafw			lxReqcompraZadsfw =  .Zadsfw			lxReqcompraVmodifw =  .Versionmodificacionfw			lxReqcompraDescfw =  .Descripcionfw			lxReqcompraValtafw =  .Versionaltafw			lxReqcompraSimbmon =  .Simbolomonetariocomprobante			lxReqcompraSmodifw =  .Seriemodificacionfw			lxReqcompraTcrg1361 =  .Tipocomprobanterg1361			lxReqcompraCodigo =  .Codigo			lxReqcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxReqcompraMonsis =  upper( .MonedaSistema_PK ) 			lxReqcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxReqcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxReqcompraFdescu =  .Descuento			lxReqcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxReqcompraFletra =  .Letra			lxReqcompraFimpuesto =  .Impuestos			lxReqcompraFobs =  .Obs			lxReqcompraFfchfac =  .Fechafactura			lxReqcompraFptoven =  .Puntodeventa			lxReqcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxReqcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxReqcompraRecpor =  .Recargoporcentaje			lxReqcompraFnumcomp =  .Numero			lxReqcompraTotdescsi =  .Totaldescuentossinimpuestos			lxReqcompraMr =  .Recargomonto			lxReqcompraNcai =  .Cai			lxReqcompraFperson =  upper( .Proveedor_PK ) 			lxReqcompraFvtocai =  .Fechavtocai			lxReqcompraFfch =  .Fecha			lxReqcompraFvuelto =  .Vuelto			lxReqcompraRecmnto =  .Recargomontoconimpuestos			lxReqcompraNroremito =  .Remito			lxReqcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxReqcompraFfchvenc =  .Fechavencimiento			lxReqcompraMotivo =  upper( .Motivo_PK ) 			lxReqcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxReqcompraFtotal =  .Total			lxReqcompraCotiz =  .Cotizacion			lxReqcompraRecmonto2 =  .Recargomonto2			lxReqcompraRecmonto1 =  .Recargomonto1			lxReqcompraTotimpue =  .Totalimpuestos			lxReqcompraTotrecarsi =  .Totalrecargossinimpuestos			lxReqcompraTotrecar =  .Totalrecargos			lxReqcompraTotdesc =  .Totaldescuentos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxReqcompraCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.REQCOMPRA ( "Fecexpo","Faltafw","Fd2","Fecimpo","Fectrans","Fmodifw","Fcuit","Idcaja","Fpodes2","Fpodes1","Fpodes","Fturno","Recmntosi2","Timestamp","Desmntosi1","Desmntosi2","Desmntosi","Totalcant","Signomov","Fsubton","Recmntosi1","Fsubtot","Sitfiscpro","Condivalp","Facttipo","Subtotsisi","Recmnto1","Subtotcisi","Recmntosi","Recmnto2","Anulado","Fcompfis","Desauto","Ualtafw","Fhora","Esttrans","Haltafw","Hmodifw","Saltafw","Horaimpo","Bdmodifw","Horaexpo","Umodifw","Bdaltafw","Zadsfw","Vmodifw","Descfw","Valtafw","Simbmon","Smodifw","Tcrg1361","Codigo","Idvuelto","Monsis","Moneda","Fmtdes1","Fdescu","Fmtdes2","Fletra","Fimpuesto","Fobs","Ffchfac","Fptoven","Desmntosi3","Fmtdes3","Recpor","Fnumcomp","Totdescsi","Mr","Ncai","Fperson","Fvtocai","Ffch","Fvuelto","Recmnto","Nroremito","Codlista","Ffchvenc","Motivo","Condpago","Ftotal","Cotiz","Recmonto2","Recmonto1","Totimpue","Totrecarsi","Totrecar","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxReqcompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraFcuit ) + "'" >>, <<lxReqcompraIdcaja >>, <<lxReqcompraFpodes2 >>, <<lxReqcompraFpodes1 >>, <<lxReqcompraFpodes >>, <<lxReqcompraFturno >>, <<lxReqcompraRecmntosi2 >>, <<lxReqcompraTimestamp >>, <<lxReqcompraDesmntosi1 >>, <<lxReqcompraDesmntosi2 >>, <<lxReqcompraDesmntosi >>, <<lxReqcompraTotalcant >>, <<lxReqcompraSignomov >>, <<lxReqcompraFsubton >>, <<lxReqcompraRecmntosi1 >>, <<lxReqcompraFsubtot >>, <<lxReqcompraSitfiscpro >>, <<lxReqcompraCondivalp >>, <<lxReqcompraFacttipo >>, <<lxReqcompraSubtotsisi >>, <<lxReqcompraRecmnto1 >>, <<lxReqcompraSubtotcisi >>, <<lxReqcompraRecmntosi >>, <<lxReqcompraRecmnto2 >>, <<iif( lxReqcompraAnulado, 1, 0 ) >>, <<iif( lxReqcompraFcompfis, 1, 0 ) >>, <<iif( lxReqcompraDesauto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxReqcompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraSmodifw ) + "'" >>, <<lxReqcompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxReqcompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraMoneda ) + "'" >>, <<lxReqcompraFmtdes1 >>, <<lxReqcompraFdescu >>, <<lxReqcompraFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxReqcompraFletra ) + "'" >>, <<lxReqcompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxReqcompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFfchfac ) + "'" >>, <<lxReqcompraFptoven >>, <<lxReqcompraDesmntosi3 >>, <<lxReqcompraFmtdes3 >>, <<lxReqcompraRecpor >>, <<lxReqcompraFnumcomp >>, <<lxReqcompraTotdescsi >>, <<lxReqcompraMr >>, <<lxReqcompraNcai >>, <<"'" + this.FormatearTextoSql( lxReqcompraFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFvtocai ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFfch ) + "'" >>, <<lxReqcompraFvuelto >>, <<lxReqcompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxReqcompraNroremito ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraCodlista ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFfchvenc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraCondpago ) + "'" >>, <<lxReqcompraFtotal >>, <<lxReqcompraCotiz >>, <<lxReqcompraRecmonto2 >>, <<lxReqcompraRecmonto1 >>, <<lxReqcompraTotimpue >>, <<lxReqcompraTotrecarsi >>, <<lxReqcompraTotrecar >>, <<lxReqcompraTotdesc >> )
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
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxArticulo_PK = loItem.Articulo_PK
					lxAfe_timestamp = loItem.Afe_timestamp
					lxAfe_cantidad = loItem.Afe_cantidad
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxAfe_nroitem = loItem.Afe_nroitem
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNroitem = lnContadorNroItem
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxIditem = loItem.Iditem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxIdorigen = loItem.Idorigen
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxAfe_codigo = loItem.Afe_codigo
					lxIditemarticulos = loItem.Iditemarticulos
					lxMaterial_PK = loItem.Material_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReqCompraDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxOferta>>, <<lxAfe_nroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxIditem>>, <<lxPorcentajeiva>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpReqComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
					
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpReqc("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxReqcompraTimestamp
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
			local  lxReqcompraFecexpo, lxReqcompraFaltafw, lxReqcompraFd2, lxReqcompraFecimpo, lxReqcompraFectrans, lxReqcompraFmodifw, lxReqcompraFcuit, lxReqcompraIdcaja, lxReqcompraFpodes2, lxReqcompraFpodes1, lxReqcompraFpodes, lxReqcompraFturno, lxReqcompraRecmntosi2, lxReqcompraTimestamp, lxReqcompraDesmntosi1, lxReqcompraDesmntosi2, lxReqcompraDesmntosi, lxReqcompraTotalcant, lxReqcompraSignomov, lxReqcompraFsubton, lxReqcompraRecmntosi1, lxReqcompraFsubtot, lxReqcompraSitfiscpro, lxReqcompraCondivalp, lxReqcompraFacttipo, lxReqcompraSubtotsisi, lxReqcompraRecmnto1, lxReqcompraSubtotcisi, lxReqcompraRecmntosi, lxReqcompraRecmnto2, lxReqcompraAnulado, lxReqcompraFcompfis, lxReqcompraDesauto, lxReqcompraUaltafw, lxReqcompraFhora, lxReqcompraEsttrans, lxReqcompraHaltafw, lxReqcompraHmodifw, lxReqcompraSaltafw, lxReqcompraHoraimpo, lxReqcompraBdmodifw, lxReqcompraHoraexpo, lxReqcompraUmodifw, lxReqcompraBdaltafw, lxReqcompraZadsfw, lxReqcompraVmodifw, lxReqcompraDescfw, lxReqcompraValtafw, lxReqcompraSimbmon, lxReqcompraSmodifw, lxReqcompraTcrg1361, lxReqcompraCodigo, lxReqcompraIdvuelto, lxReqcompraMonsis, lxReqcompraMoneda, lxReqcompraFmtdes1, lxReqcompraFdescu, lxReqcompraFmtdes2, lxReqcompraFletra, lxReqcompraFimpuesto, lxReqcompraFobs, lxReqcompraFfchfac, lxReqcompraFptoven, lxReqcompraDesmntosi3, lxReqcompraFmtdes3, lxReqcompraRecpor, lxReqcompraFnumcomp, lxReqcompraTotdescsi, lxReqcompraMr, lxReqcompraNcai, lxReqcompraFperson, lxReqcompraFvtocai, lxReqcompraFfch, lxReqcompraFvuelto, lxReqcompraRecmnto, lxReqcompraNroremito, lxReqcompraCodlista, lxReqcompraFfchvenc, lxReqcompraMotivo, lxReqcompraCondpago, lxReqcompraFtotal, lxReqcompraCotiz, lxReqcompraRecmonto2, lxReqcompraRecmonto1, lxReqcompraTotimpue, lxReqcompraTotrecarsi, lxReqcompraTotrecar, lxReqcompraTotdesc
				lxReqcompraFecexpo =  .Fechaexpo			lxReqcompraFaltafw =  .Fechaaltafw			lxReqcompraFd2 =  .Fechamodificacion			lxReqcompraFecimpo =  .Fechaimpo			lxReqcompraFectrans =  .Fechatransferencia			lxReqcompraFmodifw =  .Fechamodificacionfw			lxReqcompraFcuit =  .Cuit			lxReqcompraIdcaja =  .Caja_PK 			lxReqcompraFpodes2 =  .Porcentajedescuento2			lxReqcompraFpodes1 =  .Porcentajedescuento1			lxReqcompraFpodes =  .Porcentajedescuento			lxReqcompraFturno =  .Turno			lxReqcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxReqcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxReqcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxReqcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxReqcompraDesmntosi =  .Montodescuentosinimpuestos			lxReqcompraTotalcant =  .Totalcantidad			lxReqcompraSignomov =  .Signodemovimiento			lxReqcompraFsubton =  .Subtotalneto			lxReqcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxReqcompraFsubtot =  .Subtotalbruto			lxReqcompraSitfiscpro =  .Situacionfiscal_PK 			lxReqcompraCondivalp =  .Condicioniva			lxReqcompraFacttipo =  .Tipocomprobante			lxReqcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxReqcompraRecmnto1 =  .Recargomontoconimpuestos1			lxReqcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxReqcompraRecmntosi =  .Recargomontosinimpuestos			lxReqcompraRecmnto2 =  .Recargomontoconimpuestos2			lxReqcompraAnulado =  .Anulado			lxReqcompraFcompfis =  .Comprobantefiscal			lxReqcompraDesauto =  .Descuentoautomatico			lxReqcompraUaltafw =  .Usuarioaltafw			lxReqcompraFhora =  .Hora			lxReqcompraEsttrans =  .Estadotransferencia			lxReqcompraHaltafw =  .Horaaltafw			lxReqcompraHmodifw =  .Horamodificacionfw			lxReqcompraSaltafw =  .Seriealtafw			lxReqcompraHoraimpo =  .Horaimpo			lxReqcompraBdmodifw =  .Basededatosmodificacionfw			lxReqcompraHoraexpo =  .Horaexpo			lxReqcompraUmodifw =  .Usuariomodificacionfw			lxReqcompraBdaltafw =  .Basededatosaltafw			lxReqcompraZadsfw =  .Zadsfw			lxReqcompraVmodifw =  .Versionmodificacionfw			lxReqcompraDescfw =  .Descripcionfw			lxReqcompraValtafw =  .Versionaltafw			lxReqcompraSimbmon =  .Simbolomonetariocomprobante			lxReqcompraSmodifw =  .Seriemodificacionfw			lxReqcompraTcrg1361 =  .Tipocomprobanterg1361			lxReqcompraCodigo =  .Codigo			lxReqcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxReqcompraMonsis =  upper( .MonedaSistema_PK ) 			lxReqcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxReqcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxReqcompraFdescu =  .Descuento			lxReqcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxReqcompraFletra =  .Letra			lxReqcompraFimpuesto =  .Impuestos			lxReqcompraFobs =  .Obs			lxReqcompraFfchfac =  .Fechafactura			lxReqcompraFptoven =  .Puntodeventa			lxReqcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxReqcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxReqcompraRecpor =  .Recargoporcentaje			lxReqcompraFnumcomp =  .Numero			lxReqcompraTotdescsi =  .Totaldescuentossinimpuestos			lxReqcompraMr =  .Recargomonto			lxReqcompraNcai =  .Cai			lxReqcompraFperson =  upper( .Proveedor_PK ) 			lxReqcompraFvtocai =  .Fechavtocai			lxReqcompraFfch =  .Fecha			lxReqcompraFvuelto =  .Vuelto			lxReqcompraRecmnto =  .Recargomontoconimpuestos			lxReqcompraNroremito =  .Remito			lxReqcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxReqcompraFfchvenc =  .Fechavencimiento			lxReqcompraMotivo =  upper( .Motivo_PK ) 			lxReqcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxReqcompraFtotal =  .Total			lxReqcompraCotiz =  .Cotizacion			lxReqcompraRecmonto2 =  .Recargomonto2			lxReqcompraRecmonto1 =  .Recargomonto1			lxReqcompraTotimpue =  .Totalimpuestos			lxReqcompraTotrecarsi =  .Totalrecargossinimpuestos			lxReqcompraTotrecar =  .Totalrecargos			lxReqcompraTotdesc =  .Totaldescuentos
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
				update ZooLogic.REQCOMPRA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxReqcompraFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxReqcompraFaltafw ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxReqcompraFd2 ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxReqcompraFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxReqcompraFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxReqcompraFmodifw ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxReqcompraFcuit ) + "'">>,"Idcaja" = <<lxReqcompraIdcaja>>,"Fpodes2" = <<lxReqcompraFpodes2>>,"Fpodes1" = <<lxReqcompraFpodes1>>,"Fpodes" = <<lxReqcompraFpodes>>,"Fturno" = <<lxReqcompraFturno>>,"Recmntosi2" = <<lxReqcompraRecmntosi2>>,"Timestamp" = <<lxReqcompraTimestamp>>,"Desmntosi1" = <<lxReqcompraDesmntosi1>>,"Desmntosi2" = <<lxReqcompraDesmntosi2>>,"Desmntosi" = <<lxReqcompraDesmntosi>>,"Totalcant" = <<lxReqcompraTotalcant>>,"Signomov" = <<lxReqcompraSignomov>>,"Fsubton" = <<lxReqcompraFsubton>>,"Recmntosi1" = <<lxReqcompraRecmntosi1>>,"Fsubtot" = <<lxReqcompraFsubtot>>,"Sitfiscpro" = <<lxReqcompraSitfiscpro>>,"Condivalp" = <<lxReqcompraCondivalp>>,"Facttipo" = <<lxReqcompraFacttipo>>,"Subtotsisi" = <<lxReqcompraSubtotsisi>>,"Recmnto1" = <<lxReqcompraRecmnto1>>,"Subtotcisi" = <<lxReqcompraSubtotcisi>>,"Recmntosi" = <<lxReqcompraRecmntosi>>,"Recmnto2" = <<lxReqcompraRecmnto2>>,"Anulado" = <<iif( lxReqcompraAnulado, 1, 0 )>>,"Fcompfis" = <<iif( lxReqcompraFcompfis, 1, 0 )>>,"Desauto" = <<iif( lxReqcompraDesauto, 1, 0 )>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxReqcompraUaltafw ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxReqcompraFhora ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxReqcompraEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxReqcompraHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxReqcompraSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxReqcompraHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxReqcompraHoraexpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraUmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxReqcompraBdaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxReqcompraZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraVmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxReqcompraDescfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxReqcompraValtafw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxReqcompraSimbmon ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraSmodifw ) + "'">>,"Tcrg1361" = <<lxReqcompraTcrg1361>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxReqcompraCodigo ) + "'">>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxReqcompraIdvuelto ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxReqcompraMonsis ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxReqcompraMoneda ) + "'">>,"Fmtdes1" = <<lxReqcompraFmtdes1>>,"Fdescu" = <<lxReqcompraFdescu>>,"Fmtdes2" = <<lxReqcompraFmtdes2>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxReqcompraFletra ) + "'">>,"Fimpuesto" = <<lxReqcompraFimpuesto>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxReqcompraFobs ) + "'">>,"Ffchfac" = <<"'" + this.ConvertirDateSql( lxReqcompraFfchfac ) + "'">>,"Fptoven" = <<lxReqcompraFptoven>>,"Desmntosi3" = <<lxReqcompraDesmntosi3>>,"Fmtdes3" = <<lxReqcompraFmtdes3>>,"Recpor" = <<lxReqcompraRecpor>>,"Fnumcomp" = <<lxReqcompraFnumcomp>>,"Totdescsi" = <<lxReqcompraTotdescsi>>,"Mr" = <<lxReqcompraMr>>,"Ncai" = <<lxReqcompraNcai>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxReqcompraFperson ) + "'">>,"Fvtocai" = <<"'" + this.ConvertirDateSql( lxReqcompraFvtocai ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxReqcompraFfch ) + "'">>,"Fvuelto" = <<lxReqcompraFvuelto>>,"Recmnto" = <<lxReqcompraRecmnto>>,"Nroremito" = <<"'" + this.FormatearTextoSql( lxReqcompraNroremito ) + "'">>,"Codlista" = <<"'" + this.FormatearTextoSql( lxReqcompraCodlista ) + "'">>,"Ffchvenc" = <<"'" + this.ConvertirDateSql( lxReqcompraFfchvenc ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxReqcompraMotivo ) + "'">>,"Condpago" = <<"'" + this.FormatearTextoSql( lxReqcompraCondpago ) + "'">>,"Ftotal" = <<lxReqcompraFtotal>>,"Cotiz" = <<lxReqcompraCotiz>>,"Recmonto2" = <<lxReqcompraRecmonto2>>,"Recmonto1" = <<lxReqcompraRecmonto1>>,"Totimpue" = <<lxReqcompraTotimpue>>,"Totrecarsi" = <<lxReqcompraTotrecarsi>>,"Totrecar" = <<lxReqcompraTotrecar>>,"Totdesc" = <<lxReqcompraTotdesc>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxReqcompraCodigo ) + "'">> and  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ReqCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpReqComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpReqc where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxArticulo_PK = loItem.Articulo_PK
					lxAfe_timestamp = loItem.Afe_timestamp
					lxAfe_cantidad = loItem.Afe_cantidad
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxAfe_nroitem = loItem.Afe_nroitem
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNroitem = lnContadorNroItem
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxIditem = loItem.Iditem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxIdorigen = loItem.Idorigen
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxAfe_codigo = loItem.Afe_codigo
					lxIditemarticulos = loItem.Iditemarticulos
					lxMaterial_PK = loItem.Material_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReqCompraDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxOferta>>, <<lxAfe_nroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxIditem>>, <<lxPorcentajeiva>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpReqComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
					
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpReqc("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxReqcompraTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.REQCOMPRA where " + this.ConvertirFuncionesSql( " REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40" ) )
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
			Local lxReqcompraCodigo
			lxReqcompraCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fd2" as "Fechamodificacion", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Recmntosi2" as "Recargomontosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Facttipo" as "Tipocomprobante", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Ualtafw" as "Usuarioaltafw", "Fhora" as "Hora", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Smodifw" as "Seriemodificacionfw", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Ffch" as "Fecha", "Fvuelto" as "Vuelto", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Ffchvenc" as "Fechavencimiento", "Motivo" as "Motivo", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.REQCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxReqcompraCodigo ) + "'">> and  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40
			endtext
			use in select('c_REQUERIMIENTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REQUERIMIENTODECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_REQUERIMIENTODECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ReqCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpReqComp where Codigo = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpReqc where cCod = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			Local lxReqCompraFACTTIPO As Variant, lxReqCompraFLETRA As Variant, lxReqCompraFPTOVEN As Variant, lxReqCompraFNUMCOMP As Variant
			lxReqCompraFACTTIPO = .TipoComprobante
			lxReqCompraFLETRA = .Letra
			lxReqCompraFPTOVEN = .PuntoDeVenta
			lxReqCompraFNUMCOMP = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fd2" as "Fechamodificacion", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Recmntosi2" as "Recargomontosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Facttipo" as "Tipocomprobante", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Ualtafw" as "Usuarioaltafw", "Fhora" as "Hora", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Smodifw" as "Seriemodificacionfw", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Ffch" as "Fecha", "Fvuelto" as "Vuelto", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Ffchvenc" as "Fechavencimiento", "Motivo" as "Motivo", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.REQCOMPRA where  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40 And FACTTIPO = <<lxReqCompraFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxReqCompraFLETRA ) + "'">> and FPTOVEN = <<lxReqCompraFPTOVEN>> and FNUMCOMP = <<lxReqCompraFNUMCOMP>>
			endtext
			use in select('c_REQUERIMIENTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REQUERIMIENTODECOMPRA', set( 'Datasession' ) )
			if reccount( 'c_REQUERIMIENTODECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ReqCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpReqComp where Codigo = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpReqc where cCod = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxReqcompraCodigo as Variant
		llRetorno = .t.
		lxReqcompraCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.REQCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxReqcompraCodigo ) + "'">> and  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fd2" as "Fechamodificacion", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Recmntosi2" as "Recargomontosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Facttipo" as "Tipocomprobante", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Ualtafw" as "Usuarioaltafw", "Fhora" as "Hora", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Smodifw" as "Seriemodificacionfw", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Ffch" as "Fecha", "Fvuelto" as "Vuelto", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Ffchvenc" as "Fechavencimiento", "Motivo" as "Motivo", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.REQCOMPRA where  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP
			endtext
			use in select('c_REQUERIMIENTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REQUERIMIENTODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ReqCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpReqComp where Codigo = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpReqc where cCod = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fd2" as "Fechamodificacion", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Recmntosi2" as "Recargomontosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Facttipo" as "Tipocomprobante", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Ualtafw" as "Usuarioaltafw", "Fhora" as "Hora", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Smodifw" as "Seriemodificacionfw", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Ffch" as "Fecha", "Fvuelto" as "Vuelto", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Ffchvenc" as "Fechavencimiento", "Motivo" as "Motivo", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.REQCOMPRA where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP
			endtext
			use in select('c_REQUERIMIENTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REQUERIMIENTODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ReqCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpReqComp where Codigo = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpReqc where cCod = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fd2" as "Fechamodificacion", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Recmntosi2" as "Recargomontosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Facttipo" as "Tipocomprobante", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Ualtafw" as "Usuarioaltafw", "Fhora" as "Hora", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Smodifw" as "Seriemodificacionfw", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Ffch" as "Fecha", "Fvuelto" as "Vuelto", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Ffchvenc" as "Fechavencimiento", "Motivo" as "Motivo", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.REQCOMPRA where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc
			endtext
			use in select('c_REQUERIMIENTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REQUERIMIENTODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ReqCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpReqComp where Codigo = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpReqc where cCod = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fd2" as "Fechamodificacion", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Recmntosi2" as "Recargomontosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Facttipo" as "Tipocomprobante", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Ualtafw" as "Usuarioaltafw", "Fhora" as "Hora", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Smodifw" as "Seriemodificacionfw", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Ffch" as "Fecha", "Fvuelto" as "Vuelto", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Ffchvenc" as "Fechavencimiento", "Motivo" as "Motivo", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.REQCOMPRA where  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc
			endtext
			use in select('c_REQUERIMIENTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REQUERIMIENTODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ReqCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpReqComp where Codigo = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpReqc where cCod = <<"'" + this.FormatearTextoSql( c_REQUERIMIENTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fd2,Fecimpo,Fectrans,Fmodifw,Fcuit,Idcaja,Fpodes2,Fpodes1,Fpodes,Fturno,Recm" + ;
"ntosi2,Timestamp,Desmntosi1,Desmntosi2,Desmntosi,Totalcant,Signomov,Fsubton,Recmntosi1,Fsubtot,Sitfi" + ;
"scpro,Condivalp,Facttipo,Subtotsisi,Recmnto1,Subtotcisi,Recmntosi,Recmnto2,Anulado,Fcompfis,Desauto," + ;
"Ualtafw,Fhora,Esttrans,Haltafw,Hmodifw,Saltafw,Horaimpo,Bdmodifw,Horaexpo,Umodifw,Bdaltafw,Zadsfw,Vm" + ;
"odifw,Descfw,Valtafw,Simbmon,Smodifw,Tcrg1361,Codigo,Idvuelto,Monsis,Moneda,Fmtdes1,Fdescu,Fmtdes2,F" + ;
"letra,Fimpuesto,Fobs,Ffchfac,Fptoven,Desmntosi3,Fmtdes3,Recpor,Fnumcomp,Totdescsi,Mr,Ncai,Fperson,Fv" + ;
"tocai,Ffch,Fvuelto,Recmnto,Nroremito,Codlista,Ffchvenc,Motivo,Condpago,Ftotal,Cotiz,Recmonto2,Recmon" + ;
"to1,Totimpue,Totrecarsi,Totrecar,Totdesc" + ;
" from ZooLogic.REQCOMPRA where  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40 and " + lcFiltro )
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
			local  lxReqcompraFecexpo, lxReqcompraFaltafw, lxReqcompraFd2, lxReqcompraFecimpo, lxReqcompraFectrans, lxReqcompraFmodifw, lxReqcompraFcuit, lxReqcompraIdcaja, lxReqcompraFpodes2, lxReqcompraFpodes1, lxReqcompraFpodes, lxReqcompraFturno, lxReqcompraRecmntosi2, lxReqcompraTimestamp, lxReqcompraDesmntosi1, lxReqcompraDesmntosi2, lxReqcompraDesmntosi, lxReqcompraTotalcant, lxReqcompraSignomov, lxReqcompraFsubton, lxReqcompraRecmntosi1, lxReqcompraFsubtot, lxReqcompraSitfiscpro, lxReqcompraCondivalp, lxReqcompraFacttipo, lxReqcompraSubtotsisi, lxReqcompraRecmnto1, lxReqcompraSubtotcisi, lxReqcompraRecmntosi, lxReqcompraRecmnto2, lxReqcompraAnulado, lxReqcompraFcompfis, lxReqcompraDesauto, lxReqcompraUaltafw, lxReqcompraFhora, lxReqcompraEsttrans, lxReqcompraHaltafw, lxReqcompraHmodifw, lxReqcompraSaltafw, lxReqcompraHoraimpo, lxReqcompraBdmodifw, lxReqcompraHoraexpo, lxReqcompraUmodifw, lxReqcompraBdaltafw, lxReqcompraZadsfw, lxReqcompraVmodifw, lxReqcompraDescfw, lxReqcompraValtafw, lxReqcompraSimbmon, lxReqcompraSmodifw, lxReqcompraTcrg1361, lxReqcompraCodigo, lxReqcompraIdvuelto, lxReqcompraMonsis, lxReqcompraMoneda, lxReqcompraFmtdes1, lxReqcompraFdescu, lxReqcompraFmtdes2, lxReqcompraFletra, lxReqcompraFimpuesto, lxReqcompraFobs, lxReqcompraFfchfac, lxReqcompraFptoven, lxReqcompraDesmntosi3, lxReqcompraFmtdes3, lxReqcompraRecpor, lxReqcompraFnumcomp, lxReqcompraTotdescsi, lxReqcompraMr, lxReqcompraNcai, lxReqcompraFperson, lxReqcompraFvtocai, lxReqcompraFfch, lxReqcompraFvuelto, lxReqcompraRecmnto, lxReqcompraNroremito, lxReqcompraCodlista, lxReqcompraFfchvenc, lxReqcompraMotivo, lxReqcompraCondpago, lxReqcompraFtotal, lxReqcompraCotiz, lxReqcompraRecmonto2, lxReqcompraRecmonto1, lxReqcompraTotimpue, lxReqcompraTotrecarsi, lxReqcompraTotrecar, lxReqcompraTotdesc
				lxReqcompraFecexpo = ctod( '  /  /    ' )			lxReqcompraFaltafw = ctod( '  /  /    ' )			lxReqcompraFd2 = ctod( '  /  /    ' )			lxReqcompraFecimpo = ctod( '  /  /    ' )			lxReqcompraFectrans = ctod( '  /  /    ' )			lxReqcompraFmodifw = ctod( '  /  /    ' )			lxReqcompraFcuit = []			lxReqcompraIdcaja = 0			lxReqcompraFpodes2 = 0			lxReqcompraFpodes1 = 0			lxReqcompraFpodes = 0			lxReqcompraFturno = 0			lxReqcompraRecmntosi2 = 0			lxReqcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxReqcompraDesmntosi1 = 0			lxReqcompraDesmntosi2 = 0			lxReqcompraDesmntosi = 0			lxReqcompraTotalcant = 0			lxReqcompraSignomov = 0			lxReqcompraFsubton = 0			lxReqcompraRecmntosi1 = 0			lxReqcompraFsubtot = 0			lxReqcompraSitfiscpro = 0			lxReqcompraCondivalp = 0			lxReqcompraFacttipo = 0			lxReqcompraSubtotsisi = 0			lxReqcompraRecmnto1 = 0			lxReqcompraSubtotcisi = 0			lxReqcompraRecmntosi = 0			lxReqcompraRecmnto2 = 0			lxReqcompraAnulado = .F.			lxReqcompraFcompfis = .F.			lxReqcompraDesauto = .F.			lxReqcompraUaltafw = []			lxReqcompraFhora = []			lxReqcompraEsttrans = []			lxReqcompraHaltafw = []			lxReqcompraHmodifw = []			lxReqcompraSaltafw = []			lxReqcompraHoraimpo = []			lxReqcompraBdmodifw = []			lxReqcompraHoraexpo = []			lxReqcompraUmodifw = []			lxReqcompraBdaltafw = []			lxReqcompraZadsfw = []			lxReqcompraVmodifw = []			lxReqcompraDescfw = []			lxReqcompraValtafw = []			lxReqcompraSimbmon = []			lxReqcompraSmodifw = []			lxReqcompraTcrg1361 = 0			lxReqcompraCodigo = []			lxReqcompraIdvuelto = []			lxReqcompraMonsis = []			lxReqcompraMoneda = []			lxReqcompraFmtdes1 = 0			lxReqcompraFdescu = 0			lxReqcompraFmtdes2 = 0			lxReqcompraFletra = []			lxReqcompraFimpuesto = 0			lxReqcompraFobs = []			lxReqcompraFfchfac = ctod( '  /  /    ' )			lxReqcompraFptoven = 0			lxReqcompraDesmntosi3 = 0			lxReqcompraFmtdes3 = 0			lxReqcompraRecpor = 0			lxReqcompraFnumcomp = 0			lxReqcompraTotdescsi = 0			lxReqcompraMr = 0			lxReqcompraNcai = 0			lxReqcompraFperson = []			lxReqcompraFvtocai = ctod( '  /  /    ' )			lxReqcompraFfch = ctod( '  /  /    ' )			lxReqcompraFvuelto = 0			lxReqcompraRecmnto = 0			lxReqcompraNroremito = []			lxReqcompraCodlista = []			lxReqcompraFfchvenc = ctod( '  /  /    ' )			lxReqcompraMotivo = []			lxReqcompraCondpago = []			lxReqcompraFtotal = 0			lxReqcompraCotiz = 0			lxReqcompraRecmonto2 = 0			lxReqcompraRecmonto1 = 0			lxReqcompraTotimpue = 0			lxReqcompraTotrecarsi = 0			lxReqcompraTotrecar = 0			lxReqcompraTotdesc = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ReqCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpReqComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpReqc where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.REQCOMPRA where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REQCOMPRA' + '_' + tcCampo
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
		lcWhere = " Where  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fd2" as "Fechamodificacion", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Recmntosi2" as "Recargomontosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Facttipo" as "Tipocomprobante", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Ualtafw" as "Usuarioaltafw", "Fhora" as "Hora", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Smodifw" as "Seriemodificacionfw", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Ffch" as "Fecha", "Fvuelto" as "Vuelto", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Ffchvenc" as "Fechavencimiento", "Motivo" as "Motivo", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REQCOMPRA', '', tnTope )
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
		lcWhere = " Where  REQCOMPRADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleFacturaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ReqCompraDet', 'FacturaDetalle', tnTope )
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
		lcWhere = " Where  IMPREQCOMP.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpReqComp', 'ImpuestosDetalle', tnTope )
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
		lcWhere = " Where  IMPREQC.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosComprobante( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpReqc', 'ImpuestosComprobante', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCUIT AS CUIT'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'PORCENTAJEDESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES2 AS PORCENTAJEDESCUENTO2'
				Case lcAtributo == 'PORCENTAJEDESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES1 AS PORCENTAJEDESCUENTO1'
				Case lcAtributo == 'PORCENTAJEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES AS PORCENTAJEDESCUENTO'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTURNO AS TURNO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCPRO AS SITUACIONFISCAL'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUTO AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'TIPOCOMPROBANTERG1361'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCRG1361 AS TIPOCOMPROBANTERG1361'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES1 AS MONTODESCUENTOCONIMPUESTOS1'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'IMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FIMPUESTO AS IMPUESTOS'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'FECHAFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHFAC AS FECHAFACTURA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPOR AS RECARGOPORCENTAJE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR AS RECARGOMONTO'
				Case lcAtributo == 'CAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCAI AS CAI'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS PROVEEDOR'
				Case lcAtributo == 'FECHAVTOCAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVTOCAI AS FECHAVTOCAI'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO AS RECARGOMONTOCONIMPUESTOS'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREMITO AS REMITO'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHVENC AS FECHAVENCIMIENTO'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'CONDICIONPAGOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONPAGOPREFERENTE'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO2 AS RECARGOMONTO2'
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO1 AS RECARGOMONTO1'
				Case lcAtributo == 'TOTALIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTIMPUE AS TOTALIMPUESTOS'
				Case lcAtributo == 'TOTALRECARGOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECARSI AS TOTALRECARGOSSINIMPUESTOS'
				Case lcAtributo == 'TOTALRECARGOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECAR AS TOTALRECARGOS'
				Case lcAtributo == 'TOTALDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESC AS TOTALDESCUENTOS'
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
				Case lcAtributo == 'AFE_NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENUMCOM AS AFE_NUMERO'
				Case lcAtributo == 'AFE_PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS AFE_PUNTODEVENTA'
				Case lcAtributo == 'AFE_LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS AFE_LETRA'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FART AS ARTICULO'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'ARTICULO_CONDICIONIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAC AS ARTICULO_CONDICIONIVACOMPRAS'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAC AS ARTICULO_PORCENTAJEIVACOMPRAS'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'PERCEPCIONIVARG5329'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS PERCEPCIONIVARG5329'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOIVA AS MONTOIVA'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFITOT AS MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				Case lcAtributo == 'KIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FKIT AS KIT'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMATE AS MATERIAL'
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
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTALL AS TALLE'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFI AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTDES AS MONTODESCUENTO'
				Case lcAtributo == 'MONTOPRORRATEOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPIVA AS MONTOPRORRATEOIVA'
				Case lcAtributo == 'IDSENIACANCELADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIACANCE AS IDSENIACANCELADA'
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
				Case lcAtributo == 'MINIMONOIMPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINOIMP AS MINIMONOIMPONIBLE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'TIPOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOI AS TIPOIMPUESTO'
				Case lcAtributo == 'CODIGOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODIGOINTERNO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'CODIMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIMP AS CODIMP'
				Case lcAtributo == 'CODIMPDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS CODIMPDETALLE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'FCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO2'
				lcCampo = 'FPODES2'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO1'
				lcCampo = 'FPODES1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO'
				lcCampo = 'FPODES'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'FTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCPRO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTERG1361'
				lcCampo = 'TCRG1361'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS1'
				lcCampo = 'FMTDES1'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOS'
				lcCampo = 'FIMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAFACTURA'
				lcCampo = 'FFCHFAC'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPOR'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'MR'
			Case upper( alltrim( tcAtributo ) ) == 'CAI'
				lcCampo = 'NCAI'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOCAI'
				lcCampo = 'FVTOCAI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS'
				lcCampo = 'RECMNTO'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'NROREMITO'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FFCHVENC'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONPAGOPREFERENTE'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'RECMONTO2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'RECMONTO1'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALIMPUESTOS'
				lcCampo = 'TOTIMPUE'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSSINIMPUESTOS'
				lcCampo = 'TOTRECARSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOS'
				lcCampo = 'TOTRECAR'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOS'
				lcCampo = 'TOTDESC'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleFacturaDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NUMERO'
				lcCampo = 'AFENUMCOM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FART'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVACOMPRAS'
				lcCampo = 'ACONDIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVACOMPRAS'
				lcCampo = 'APORCIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVARG5329'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'FMTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				lcCampo = 'FCFITOT'
			Case upper( alltrim( tcAtributo ) ) == 'KIT'
				lcCampo = 'FKIT'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'FAMATE'
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
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'FTALL'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO'
				lcCampo = 'MNTDES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIVA'
				lcCampo = 'MNTPIVA'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIACANCELADA'
				lcCampo = 'SENIACANCE'
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
			Case upper( alltrim( tcAtributo ) ) == 'MINIMONOIMPONIBLE'
				lcCampo = 'MINOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTO'
				lcCampo = 'TIPOI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOINTERNO'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIMP'
				lcCampo = 'CODIMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIMPDETALLE'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'FACTURADETALLE'
			lcRetorno = 'REQCOMPRADET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPREQCOMP'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPREQC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxReqcompraFecexpo, lxReqcompraFaltafw, lxReqcompraFd2, lxReqcompraFecimpo, lxReqcompraFectrans, lxReqcompraFmodifw, lxReqcompraFcuit, lxReqcompraIdcaja, lxReqcompraFpodes2, lxReqcompraFpodes1, lxReqcompraFpodes, lxReqcompraFturno, lxReqcompraRecmntosi2, lxReqcompraTimestamp, lxReqcompraDesmntosi1, lxReqcompraDesmntosi2, lxReqcompraDesmntosi, lxReqcompraTotalcant, lxReqcompraSignomov, lxReqcompraFsubton, lxReqcompraRecmntosi1, lxReqcompraFsubtot, lxReqcompraSitfiscpro, lxReqcompraCondivalp, lxReqcompraFacttipo, lxReqcompraSubtotsisi, lxReqcompraRecmnto1, lxReqcompraSubtotcisi, lxReqcompraRecmntosi, lxReqcompraRecmnto2, lxReqcompraAnulado, lxReqcompraFcompfis, lxReqcompraDesauto, lxReqcompraUaltafw, lxReqcompraFhora, lxReqcompraEsttrans, lxReqcompraHaltafw, lxReqcompraHmodifw, lxReqcompraSaltafw, lxReqcompraHoraimpo, lxReqcompraBdmodifw, lxReqcompraHoraexpo, lxReqcompraUmodifw, lxReqcompraBdaltafw, lxReqcompraZadsfw, lxReqcompraVmodifw, lxReqcompraDescfw, lxReqcompraValtafw, lxReqcompraSimbmon, lxReqcompraSmodifw, lxReqcompraTcrg1361, lxReqcompraCodigo, lxReqcompraIdvuelto, lxReqcompraMonsis, lxReqcompraMoneda, lxReqcompraFmtdes1, lxReqcompraFdescu, lxReqcompraFmtdes2, lxReqcompraFletra, lxReqcompraFimpuesto, lxReqcompraFobs, lxReqcompraFfchfac, lxReqcompraFptoven, lxReqcompraDesmntosi3, lxReqcompraFmtdes3, lxReqcompraRecpor, lxReqcompraFnumcomp, lxReqcompraTotdescsi, lxReqcompraMr, lxReqcompraNcai, lxReqcompraFperson, lxReqcompraFvtocai, lxReqcompraFfch, lxReqcompraFvuelto, lxReqcompraRecmnto, lxReqcompraNroremito, lxReqcompraCodlista, lxReqcompraFfchvenc, lxReqcompraMotivo, lxReqcompraCondpago, lxReqcompraFtotal, lxReqcompraCotiz, lxReqcompraRecmonto2, lxReqcompraRecmonto1, lxReqcompraTotimpue, lxReqcompraTotrecarsi, lxReqcompraTotrecar, lxReqcompraTotdesc
				lxReqcompraFecexpo =  .Fechaexpo			lxReqcompraFaltafw =  .Fechaaltafw			lxReqcompraFd2 =  .Fechamodificacion			lxReqcompraFecimpo =  .Fechaimpo			lxReqcompraFectrans =  .Fechatransferencia			lxReqcompraFmodifw =  .Fechamodificacionfw			lxReqcompraFcuit =  .Cuit			lxReqcompraIdcaja =  .Caja_PK 			lxReqcompraFpodes2 =  .Porcentajedescuento2			lxReqcompraFpodes1 =  .Porcentajedescuento1			lxReqcompraFpodes =  .Porcentajedescuento			lxReqcompraFturno =  .Turno			lxReqcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxReqcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxReqcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxReqcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxReqcompraDesmntosi =  .Montodescuentosinimpuestos			lxReqcompraTotalcant =  .Totalcantidad			lxReqcompraSignomov =  .Signodemovimiento			lxReqcompraFsubton =  .Subtotalneto			lxReqcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxReqcompraFsubtot =  .Subtotalbruto			lxReqcompraSitfiscpro =  .Situacionfiscal_PK 			lxReqcompraCondivalp =  .Condicioniva			lxReqcompraFacttipo =  .Tipocomprobante			lxReqcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxReqcompraRecmnto1 =  .Recargomontoconimpuestos1			lxReqcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxReqcompraRecmntosi =  .Recargomontosinimpuestos			lxReqcompraRecmnto2 =  .Recargomontoconimpuestos2			lxReqcompraAnulado =  .Anulado			lxReqcompraFcompfis =  .Comprobantefiscal			lxReqcompraDesauto =  .Descuentoautomatico			lxReqcompraUaltafw =  .Usuarioaltafw			lxReqcompraFhora =  .Hora			lxReqcompraEsttrans =  .Estadotransferencia			lxReqcompraHaltafw =  .Horaaltafw			lxReqcompraHmodifw =  .Horamodificacionfw			lxReqcompraSaltafw =  .Seriealtafw			lxReqcompraHoraimpo =  .Horaimpo			lxReqcompraBdmodifw =  .Basededatosmodificacionfw			lxReqcompraHoraexpo =  .Horaexpo			lxReqcompraUmodifw =  .Usuariomodificacionfw			lxReqcompraBdaltafw =  .Basededatosaltafw			lxReqcompraZadsfw =  .Zadsfw			lxReqcompraVmodifw =  .Versionmodificacionfw			lxReqcompraDescfw =  .Descripcionfw			lxReqcompraValtafw =  .Versionaltafw			lxReqcompraSimbmon =  .Simbolomonetariocomprobante			lxReqcompraSmodifw =  .Seriemodificacionfw			lxReqcompraTcrg1361 =  .Tipocomprobanterg1361			lxReqcompraCodigo =  .Codigo			lxReqcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxReqcompraMonsis =  upper( .MonedaSistema_PK ) 			lxReqcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxReqcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxReqcompraFdescu =  .Descuento			lxReqcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxReqcompraFletra =  .Letra			lxReqcompraFimpuesto =  .Impuestos			lxReqcompraFobs =  .Obs			lxReqcompraFfchfac =  .Fechafactura			lxReqcompraFptoven =  .Puntodeventa			lxReqcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxReqcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxReqcompraRecpor =  .Recargoporcentaje			lxReqcompraFnumcomp =  .Numero			lxReqcompraTotdescsi =  .Totaldescuentossinimpuestos			lxReqcompraMr =  .Recargomonto			lxReqcompraNcai =  .Cai			lxReqcompraFperson =  upper( .Proveedor_PK ) 			lxReqcompraFvtocai =  .Fechavtocai			lxReqcompraFfch =  .Fecha			lxReqcompraFvuelto =  .Vuelto			lxReqcompraRecmnto =  .Recargomontoconimpuestos			lxReqcompraNroremito =  .Remito			lxReqcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxReqcompraFfchvenc =  .Fechavencimiento			lxReqcompraMotivo =  upper( .Motivo_PK ) 			lxReqcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxReqcompraFtotal =  .Total			lxReqcompraCotiz =  .Cotizacion			lxReqcompraRecmonto2 =  .Recargomonto2			lxReqcompraRecmonto1 =  .Recargomonto1			lxReqcompraTotimpue =  .Totalimpuestos			lxReqcompraTotrecarsi =  .Totalrecargossinimpuestos			lxReqcompraTotrecar =  .Totalrecargos			lxReqcompraTotdesc =  .Totaldescuentos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.REQCOMPRA ( "Fecexpo","Faltafw","Fd2","Fecimpo","Fectrans","Fmodifw","Fcuit","Idcaja","Fpodes2","Fpodes1","Fpodes","Fturno","Recmntosi2","Timestamp","Desmntosi1","Desmntosi2","Desmntosi","Totalcant","Signomov","Fsubton","Recmntosi1","Fsubtot","Sitfiscpro","Condivalp","Facttipo","Subtotsisi","Recmnto1","Subtotcisi","Recmntosi","Recmnto2","Anulado","Fcompfis","Desauto","Ualtafw","Fhora","Esttrans","Haltafw","Hmodifw","Saltafw","Horaimpo","Bdmodifw","Horaexpo","Umodifw","Bdaltafw","Zadsfw","Vmodifw","Descfw","Valtafw","Simbmon","Smodifw","Tcrg1361","Codigo","Idvuelto","Monsis","Moneda","Fmtdes1","Fdescu","Fmtdes2","Fletra","Fimpuesto","Fobs","Ffchfac","Fptoven","Desmntosi3","Fmtdes3","Recpor","Fnumcomp","Totdescsi","Mr","Ncai","Fperson","Fvtocai","Ffch","Fvuelto","Recmnto","Nroremito","Codlista","Ffchvenc","Motivo","Condpago","Ftotal","Cotiz","Recmonto2","Recmonto1","Totimpue","Totrecarsi","Totrecar","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxReqcompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraFcuit ) + "'" >>, <<lxReqcompraIdcaja >>, <<lxReqcompraFpodes2 >>, <<lxReqcompraFpodes1 >>, <<lxReqcompraFpodes >>, <<lxReqcompraFturno >>, <<lxReqcompraRecmntosi2 >>, <<lxReqcompraTimestamp >>, <<lxReqcompraDesmntosi1 >>, <<lxReqcompraDesmntosi2 >>, <<lxReqcompraDesmntosi >>, <<lxReqcompraTotalcant >>, <<lxReqcompraSignomov >>, <<lxReqcompraFsubton >>, <<lxReqcompraRecmntosi1 >>, <<lxReqcompraFsubtot >>, <<lxReqcompraSitfiscpro >>, <<lxReqcompraCondivalp >>, <<lxReqcompraFacttipo >>, <<lxReqcompraSubtotsisi >>, <<lxReqcompraRecmnto1 >>, <<lxReqcompraSubtotcisi >>, <<lxReqcompraRecmntosi >>, <<lxReqcompraRecmnto2 >>, <<iif( lxReqcompraAnulado, 1, 0 ) >>, <<iif( lxReqcompraFcompfis, 1, 0 ) >>, <<iif( lxReqcompraDesauto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxReqcompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraSmodifw ) + "'" >>, <<lxReqcompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxReqcompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraMoneda ) + "'" >>, <<lxReqcompraFmtdes1 >>, <<lxReqcompraFdescu >>, <<lxReqcompraFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxReqcompraFletra ) + "'" >>, <<lxReqcompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxReqcompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFfchfac ) + "'" >>, <<lxReqcompraFptoven >>, <<lxReqcompraDesmntosi3 >>, <<lxReqcompraFmtdes3 >>, <<lxReqcompraRecpor >>, <<lxReqcompraFnumcomp >>, <<lxReqcompraTotdescsi >>, <<lxReqcompraMr >>, <<lxReqcompraNcai >>, <<"'" + this.FormatearTextoSql( lxReqcompraFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFvtocai ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFfch ) + "'" >>, <<lxReqcompraFvuelto >>, <<lxReqcompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxReqcompraNroremito ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraCodlista ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReqcompraFfchvenc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReqcompraCondpago ) + "'" >>, <<lxReqcompraFtotal >>, <<lxReqcompraCotiz >>, <<lxReqcompraRecmonto2 >>, <<lxReqcompraRecmonto1 >>, <<lxReqcompraTotimpue >>, <<lxReqcompraTotrecarsi >>, <<lxReqcompraTotrecar >>, <<lxReqcompraTotdesc >> )
		endtext
		loColeccion.cTabla = 'REQCOMPRA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxArticulo_PK = loItem.Articulo_PK
					lxAfe_timestamp = loItem.Afe_timestamp
					lxAfe_cantidad = loItem.Afe_cantidad
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxAfe_nroitem = loItem.Afe_nroitem
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNroitem = lnContadorNroItem
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxIditem = loItem.Iditem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxIdorigen = loItem.Idorigen
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxAfe_codigo = loItem.Afe_codigo
					lxIditemarticulos = loItem.Iditemarticulos
					lxMaterial_PK = loItem.Material_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReqCompraDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxOferta>>, <<lxAfe_nroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxIditem>>, <<lxPorcentajeiva>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpReqComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpReqc("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxReqcompraFecexpo, lxReqcompraFaltafw, lxReqcompraFd2, lxReqcompraFecimpo, lxReqcompraFectrans, lxReqcompraFmodifw, lxReqcompraFcuit, lxReqcompraIdcaja, lxReqcompraFpodes2, lxReqcompraFpodes1, lxReqcompraFpodes, lxReqcompraFturno, lxReqcompraRecmntosi2, lxReqcompraTimestamp, lxReqcompraDesmntosi1, lxReqcompraDesmntosi2, lxReqcompraDesmntosi, lxReqcompraTotalcant, lxReqcompraSignomov, lxReqcompraFsubton, lxReqcompraRecmntosi1, lxReqcompraFsubtot, lxReqcompraSitfiscpro, lxReqcompraCondivalp, lxReqcompraFacttipo, lxReqcompraSubtotsisi, lxReqcompraRecmnto1, lxReqcompraSubtotcisi, lxReqcompraRecmntosi, lxReqcompraRecmnto2, lxReqcompraAnulado, lxReqcompraFcompfis, lxReqcompraDesauto, lxReqcompraUaltafw, lxReqcompraFhora, lxReqcompraEsttrans, lxReqcompraHaltafw, lxReqcompraHmodifw, lxReqcompraSaltafw, lxReqcompraHoraimpo, lxReqcompraBdmodifw, lxReqcompraHoraexpo, lxReqcompraUmodifw, lxReqcompraBdaltafw, lxReqcompraZadsfw, lxReqcompraVmodifw, lxReqcompraDescfw, lxReqcompraValtafw, lxReqcompraSimbmon, lxReqcompraSmodifw, lxReqcompraTcrg1361, lxReqcompraCodigo, lxReqcompraIdvuelto, lxReqcompraMonsis, lxReqcompraMoneda, lxReqcompraFmtdes1, lxReqcompraFdescu, lxReqcompraFmtdes2, lxReqcompraFletra, lxReqcompraFimpuesto, lxReqcompraFobs, lxReqcompraFfchfac, lxReqcompraFptoven, lxReqcompraDesmntosi3, lxReqcompraFmtdes3, lxReqcompraRecpor, lxReqcompraFnumcomp, lxReqcompraTotdescsi, lxReqcompraMr, lxReqcompraNcai, lxReqcompraFperson, lxReqcompraFvtocai, lxReqcompraFfch, lxReqcompraFvuelto, lxReqcompraRecmnto, lxReqcompraNroremito, lxReqcompraCodlista, lxReqcompraFfchvenc, lxReqcompraMotivo, lxReqcompraCondpago, lxReqcompraFtotal, lxReqcompraCotiz, lxReqcompraRecmonto2, lxReqcompraRecmonto1, lxReqcompraTotimpue, lxReqcompraTotrecarsi, lxReqcompraTotrecar, lxReqcompraTotdesc
				lxReqcompraFecexpo =  .Fechaexpo			lxReqcompraFaltafw =  .Fechaaltafw			lxReqcompraFd2 =  .Fechamodificacion			lxReqcompraFecimpo =  .Fechaimpo			lxReqcompraFectrans =  .Fechatransferencia			lxReqcompraFmodifw =  .Fechamodificacionfw			lxReqcompraFcuit =  .Cuit			lxReqcompraIdcaja =  .Caja_PK 			lxReqcompraFpodes2 =  .Porcentajedescuento2			lxReqcompraFpodes1 =  .Porcentajedescuento1			lxReqcompraFpodes =  .Porcentajedescuento			lxReqcompraFturno =  .Turno			lxReqcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxReqcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxReqcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxReqcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxReqcompraDesmntosi =  .Montodescuentosinimpuestos			lxReqcompraTotalcant =  .Totalcantidad			lxReqcompraSignomov =  .Signodemovimiento			lxReqcompraFsubton =  .Subtotalneto			lxReqcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxReqcompraFsubtot =  .Subtotalbruto			lxReqcompraSitfiscpro =  .Situacionfiscal_PK 			lxReqcompraCondivalp =  .Condicioniva			lxReqcompraFacttipo =  .Tipocomprobante			lxReqcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxReqcompraRecmnto1 =  .Recargomontoconimpuestos1			lxReqcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxReqcompraRecmntosi =  .Recargomontosinimpuestos			lxReqcompraRecmnto2 =  .Recargomontoconimpuestos2			lxReqcompraAnulado =  .Anulado			lxReqcompraFcompfis =  .Comprobantefiscal			lxReqcompraDesauto =  .Descuentoautomatico			lxReqcompraUaltafw =  .Usuarioaltafw			lxReqcompraFhora =  .Hora			lxReqcompraEsttrans =  .Estadotransferencia			lxReqcompraHaltafw =  .Horaaltafw			lxReqcompraHmodifw =  .Horamodificacionfw			lxReqcompraSaltafw =  .Seriealtafw			lxReqcompraHoraimpo =  .Horaimpo			lxReqcompraBdmodifw =  .Basededatosmodificacionfw			lxReqcompraHoraexpo =  .Horaexpo			lxReqcompraUmodifw =  .Usuariomodificacionfw			lxReqcompraBdaltafw =  .Basededatosaltafw			lxReqcompraZadsfw =  .Zadsfw			lxReqcompraVmodifw =  .Versionmodificacionfw			lxReqcompraDescfw =  .Descripcionfw			lxReqcompraValtafw =  .Versionaltafw			lxReqcompraSimbmon =  .Simbolomonetariocomprobante			lxReqcompraSmodifw =  .Seriemodificacionfw			lxReqcompraTcrg1361 =  .Tipocomprobanterg1361			lxReqcompraCodigo =  .Codigo			lxReqcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxReqcompraMonsis =  upper( .MonedaSistema_PK ) 			lxReqcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxReqcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxReqcompraFdescu =  .Descuento			lxReqcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxReqcompraFletra =  .Letra			lxReqcompraFimpuesto =  .Impuestos			lxReqcompraFobs =  .Obs			lxReqcompraFfchfac =  .Fechafactura			lxReqcompraFptoven =  .Puntodeventa			lxReqcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxReqcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxReqcompraRecpor =  .Recargoporcentaje			lxReqcompraFnumcomp =  .Numero			lxReqcompraTotdescsi =  .Totaldescuentossinimpuestos			lxReqcompraMr =  .Recargomonto			lxReqcompraNcai =  .Cai			lxReqcompraFperson =  upper( .Proveedor_PK ) 			lxReqcompraFvtocai =  .Fechavtocai			lxReqcompraFfch =  .Fecha			lxReqcompraFvuelto =  .Vuelto			lxReqcompraRecmnto =  .Recargomontoconimpuestos			lxReqcompraNroremito =  .Remito			lxReqcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxReqcompraFfchvenc =  .Fechavencimiento			lxReqcompraMotivo =  upper( .Motivo_PK ) 			lxReqcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxReqcompraFtotal =  .Total			lxReqcompraCotiz =  .Cotizacion			lxReqcompraRecmonto2 =  .Recargomonto2			lxReqcompraRecmonto1 =  .Recargomonto1			lxReqcompraTotimpue =  .Totalimpuestos			lxReqcompraTotrecarsi =  .Totalrecargossinimpuestos			lxReqcompraTotrecar =  .Totalrecargos			lxReqcompraTotdesc =  .Totaldescuentos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40]
			text to lcSentencia noshow textmerge
				update ZooLogic.REQCOMPRA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxReqcompraFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxReqcompraFaltafw ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxReqcompraFd2 ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxReqcompraFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxReqcompraFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxReqcompraFmodifw ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxReqcompraFcuit ) + "'">>, "Idcaja" = <<lxReqcompraIdcaja>>, "Fpodes2" = <<lxReqcompraFpodes2>>, "Fpodes1" = <<lxReqcompraFpodes1>>, "Fpodes" = <<lxReqcompraFpodes>>, "Fturno" = <<lxReqcompraFturno>>, "Recmntosi2" = <<lxReqcompraRecmntosi2>>, "Timestamp" = <<lxReqcompraTimestamp>>, "Desmntosi1" = <<lxReqcompraDesmntosi1>>, "Desmntosi2" = <<lxReqcompraDesmntosi2>>, "Desmntosi" = <<lxReqcompraDesmntosi>>, "Totalcant" = <<lxReqcompraTotalcant>>, "Signomov" = <<lxReqcompraSignomov>>, "Fsubton" = <<lxReqcompraFsubton>>, "Recmntosi1" = <<lxReqcompraRecmntosi1>>, "Fsubtot" = <<lxReqcompraFsubtot>>, "Sitfiscpro" = <<lxReqcompraSitfiscpro>>, "Condivalp" = <<lxReqcompraCondivalp>>, "Facttipo" = <<lxReqcompraFacttipo>>, "Subtotsisi" = <<lxReqcompraSubtotsisi>>, "Recmnto1" = <<lxReqcompraRecmnto1>>, "Subtotcisi" = <<lxReqcompraSubtotcisi>>, "Recmntosi" = <<lxReqcompraRecmntosi>>, "Recmnto2" = <<lxReqcompraRecmnto2>>, "Anulado" = <<iif( lxReqcompraAnulado, 1, 0 )>>, "Fcompfis" = <<iif( lxReqcompraFcompfis, 1, 0 )>>, "Desauto" = <<iif( lxReqcompraDesauto, 1, 0 )>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxReqcompraUaltafw ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxReqcompraFhora ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxReqcompraEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxReqcompraHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxReqcompraSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxReqcompraHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxReqcompraHoraexpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraUmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxReqcompraBdaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxReqcompraZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraVmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxReqcompraDescfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxReqcompraValtafw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxReqcompraSimbmon ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxReqcompraSmodifw ) + "'">>, "Tcrg1361" = <<lxReqcompraTcrg1361>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxReqcompraCodigo ) + "'">>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxReqcompraIdvuelto ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxReqcompraMonsis ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxReqcompraMoneda ) + "'">>, "Fmtdes1" = <<lxReqcompraFmtdes1>>, "Fdescu" = <<lxReqcompraFdescu>>, "Fmtdes2" = <<lxReqcompraFmtdes2>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxReqcompraFletra ) + "'">>, "Fimpuesto" = <<lxReqcompraFimpuesto>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxReqcompraFobs ) + "'">>, "Ffchfac" = <<"'" + this.ConvertirDateSql( lxReqcompraFfchfac ) + "'">>, "Fptoven" = <<lxReqcompraFptoven>>, "Desmntosi3" = <<lxReqcompraDesmntosi3>>, "Fmtdes3" = <<lxReqcompraFmtdes3>>, "Recpor" = <<lxReqcompraRecpor>>, "Fnumcomp" = <<lxReqcompraFnumcomp>>, "Totdescsi" = <<lxReqcompraTotdescsi>>, "Mr" = <<lxReqcompraMr>>, "Ncai" = <<lxReqcompraNcai>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxReqcompraFperson ) + "'">>, "Fvtocai" = <<"'" + this.ConvertirDateSql( lxReqcompraFvtocai ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxReqcompraFfch ) + "'">>, "Fvuelto" = <<lxReqcompraFvuelto>>, "Recmnto" = <<lxReqcompraRecmnto>>, "Nroremito" = <<"'" + this.FormatearTextoSql( lxReqcompraNroremito ) + "'">>, "Codlista" = <<"'" + this.FormatearTextoSql( lxReqcompraCodlista ) + "'">>, "Ffchvenc" = <<"'" + this.ConvertirDateSql( lxReqcompraFfchvenc ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxReqcompraMotivo ) + "'">>, "Condpago" = <<"'" + this.FormatearTextoSql( lxReqcompraCondpago ) + "'">>, "Ftotal" = <<lxReqcompraFtotal>>, "Cotiz" = <<lxReqcompraCotiz>>, "Recmonto2" = <<lxReqcompraRecmonto2>>, "Recmonto1" = <<lxReqcompraRecmonto1>>, "Totimpue" = <<lxReqcompraTotimpue>>, "Totrecarsi" = <<lxReqcompraTotrecarsi>>, "Totrecar" = <<lxReqcompraTotrecar>>, "Totdesc" = <<lxReqcompraTotdesc>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REQCOMPRA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ReqCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpReqComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpReqc where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxArticulo_PK = loItem.Articulo_PK
					lxAfe_timestamp = loItem.Afe_timestamp
					lxAfe_cantidad = loItem.Afe_cantidad
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxAfe_nroitem = loItem.Afe_nroitem
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNroitem = lnContadorNroItem
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxIditem = loItem.Iditem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxIdorigen = loItem.Idorigen
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxAfe_codigo = loItem.Afe_codigo
					lxIditemarticulos = loItem.Iditemarticulos
					lxMaterial_PK = loItem.Material_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReqCompraDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxOferta>>, <<lxAfe_nroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxIditem>>, <<lxPorcentajeiva>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpReqComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpReqc("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40]
		loColeccion.Agregar( 'delete from ZooLogic.REQCOMPRA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ReqCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpReqComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpReqc where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'REQCOMPRA' 
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
					"Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto"
				endtext
		return lcAtributos
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

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
			
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.REQCOMPRA set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.REQCOMPRA where  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.REQCOMPRA where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxReqCompraFACTTIPO as variant, lxReqCompraFLETRA as variant, lxReqCompraFPTOVEN as variant, lxReqCompraFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REQUERIMIENTODECOMPRA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.REQCOMPRA Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.REQCOMPRA set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, SitFiscPro = ] + transform( &lcCursor..SitFiscPro )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, DesAuto = ] + Transform( iif( &lcCursor..DesAuto, 1, 0 ))+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, tcrg1361 = ] + transform( &lcCursor..tcrg1361 )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FFCHFAC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, MR = ] + transform( &lcCursor..MR )+ [, NCAI = ] + transform( &lcCursor..NCAI )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FVTOCAI = ] + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, NROREMITO = ] + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, FFCHVENC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'"+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, CONDPAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, RecMonto2 = ] + transform( &lcCursor..RecMonto2 )+ [, RecMonto1 = ] + transform( &lcCursor..RecMonto1 )+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totdesc = ] + transform( &lcCursor..totdesc ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.REQCOMPRA Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FALTAFW, FD2, FECIMPO, FECTRANS, FMODIFW, fCuit, IdCaja, FPODES2, FPODES1, FPODES, FTurno, RecMntoSI2, TIMESTAMP, DesMntoSI1, DesMntoSI2, DesMntoSI, TotalCant, signomov, fSubToN, RecMntoSI1, FSubTOT, SitFiscPro, CondivaLp, FACTTIPO, SubTotSISI, RecMnto1, SubTotCISI, RecMntoSI, RecMnto2, Anulado, FCOMPFIS, DesAuto, UALTAFW, FHORA, ESTTRANS, HALTAFW, HMODIFW, SALTAFW, HORAIMPO, BDMODIFW, HORAEXPO, UMODIFW, BDALTAFW, ZADSFW, VMODIFW, DescFW, VALTAFW, SimbMon, SMODIFW, tcrg1361, CODIGO, idVuelto, MonSis, Moneda, FMTDES1, fDescu, FMTDES2, FLETRA, fImpuesto, FObs, FFCHFAC, FPTOVEN, DesMntoSI3, FMTDES3, RecPor, FNUMCOMP, totdescSI, MR, NCAI, FPerson, FVTOCAI, FFCH, FVuelto, RecMnto, NROREMITO, CodLista, FFCHVENC, MOTIVO, CONDPAGO, FTotal, Cotiz, RecMonto2, RecMonto1, totimpue, totrecarSI, totrecar, totdesc
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..FPODES1 ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..FTurno ) + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..DesMntoSI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..SitFiscPro ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..RecMnto1 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..RecMntoSI ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..DesAuto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + transform( &lcCursor..tcrg1361 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + transform( &lcCursor..FMTDES1 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..fDescu ) + ',' + transform( &lcCursor..FMTDES2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..fImpuesto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + transform( &lcCursor..FMTDES3 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..totdescSI ) + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..NCAI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + transform( &lcCursor..FVuelto )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecMnto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'" + ',' + transform( &lcCursor..FTotal )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..RecMonto2 ) + ',' + transform( &lcCursor..RecMonto1 ) + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..totrecar ) + ',' + transform( &lcCursor..totdesc )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.REQCOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REQUERIMIENTODECOMPRA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ReqCompraDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpReqComp Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpReqc Where cCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSREQCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ReqCompraDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.ACondIvaC  ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.APorcIvaC  ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_Cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSREQC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpReqComp ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOREQCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpReqc ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.porcen     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSREQCOMPRA',this.oEntidad.cPrefijoRecibir + 'REQUERIMIENTODECOMPRA')
		this.oEntidad.FacturaDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSREQCOMPRA',this.oEntidad.cPrefijoRecibir + 'REQUERIMIENTODECOMPRA')
		
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
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'REQUERIMIENTODECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REQUERIMIENTODECOMPRA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REQUERIMIENTODECOMPRA_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSREQCOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSREQC'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOREQCOMPRA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ReqCompra')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REQUERIMIENTODECOMPRA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REQUERIMIENTODECOMPRA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REQUERIMIENTODECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REQUERIMIENTODECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FFCHFAC   
		* Validar ANTERIORES A 1/1/1753  FVTOCAI   
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  FFCHVENC  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ReqCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ReqCompra
Create Table ZooLogic.TablaTrabajo_ReqCompra ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fd2" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"fturno" numeric( 1, 0 )  null, 
"recmntosi2" numeric( 8, 2 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"desmntosi1" numeric( 8, 2 )  null, 
"desmntosi2" numeric( 8, 2 )  null, 
"desmntosi" numeric( 8, 2 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"signomov" numeric( 2, 0 )  null, 
"fsubton" numeric( 8, 2 )  null, 
"recmntosi1" numeric( 8, 2 )  null, 
"fsubtot" numeric( 8, 2 )  null, 
"sitfiscpro" numeric( 2, 0 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"subtotsisi" numeric( 10, 2 )  null, 
"recmnto1" numeric( 8, 2 )  null, 
"subtotcisi" numeric( 10, 2 )  null, 
"recmntosi" numeric( 8, 2 )  null, 
"recmnto2" numeric( 8, 2 )  null, 
"anulado" bit  null, 
"fcompfis" bit  null, 
"desauto" bit  null, 
"ualtafw" char( 100 )  null, 
"fhora" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"bdaltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"valtafw" char( 13 )  null, 
"simbmon" char( 3 )  null, 
"smodifw" char( 7 )  null, 
"tcrg1361" numeric( 1, 0 )  null, 
"codigo" char( 38 )  null, 
"idvuelto" char( 5 )  null, 
"monsis" char( 10 )  null, 
"moneda" char( 10 )  null, 
"fmtdes1" numeric( 8, 2 )  null, 
"fdescu" numeric( 8, 2 )  null, 
"fmtdes2" numeric( 8, 2 )  null, 
"fletra" char( 1 )  null, 
"fimpuesto" numeric( 8, 2 )  null, 
"fobs" varchar(max)  null, 
"ffchfac" datetime  null, 
"fptoven" numeric( 4, 0 )  null, 
"desmntosi3" numeric( 8, 2 )  null, 
"fmtdes3" numeric( 6, 2 )  null, 
"recpor" numeric( 6, 2 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"totdescsi" numeric( 8, 2 )  null, 
"mr" numeric( 15, 2 )  null, 
"ncai" numeric( 14, 0 )  null, 
"fperson" char( 5 )  null, 
"fvtocai" datetime  null, 
"ffch" datetime  null, 
"fvuelto" numeric( 8, 2 )  null, 
"recmnto" numeric( 8, 2 )  null, 
"nroremito" char( 15 )  null, 
"codlista" char( 6 )  null, 
"ffchvenc" datetime  null, 
"motivo" char( 3 )  null, 
"condpago" char( 5 )  null, 
"ftotal" numeric( 16, 2 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"recmonto2" numeric( 15, 2 )  null, 
"recmonto1" numeric( 15, 2 )  null, 
"totimpue" numeric( 8, 2 )  null, 
"totrecarsi" numeric( 8, 2 )  null, 
"totrecar" numeric( 8, 2 )  null, 
"totdesc" numeric( 8, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ReqCompra' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ReqCompra' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REQUERIMIENTODECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('sitfiscpro','sitfiscpro')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('desauto','desauto')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('tcrg1361','tcrg1361')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('ffchfac','ffchfac')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('ncai','ncai')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fvtocai','fvtocai')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('nroremito','nroremito')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('ffchvenc','ffchvenc')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('condpago','condpago')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('recmonto2','recmonto2')
			.AgregarMapeo('recmonto1','recmonto1')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totdesc','totdesc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ReqCompra'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.SITFISCPRO = isnull( d.SITFISCPRO, t.SITFISCPRO ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.DESAUTO = isnull( d.DESAUTO, t.DESAUTO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.TCRG1361 = isnull( d.TCRG1361, t.TCRG1361 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FFCHFAC = isnull( d.FFCHFAC, t.FFCHFAC ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.MR = isnull( d.MR, t.MR ),t.NCAI = isnull( d.NCAI, t.NCAI ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FVTOCAI = isnull( d.FVTOCAI, t.FVTOCAI ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.NROREMITO = isnull( d.NROREMITO, t.NROREMITO ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.FFCHVENC = isnull( d.FFCHVENC, t.FFCHVENC ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.RECMONTO2 = isnull( d.RECMONTO2, t.RECMONTO2 ),t.RECMONTO1 = isnull( d.RECMONTO1, t.RECMONTO1 ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC )
					from ZooLogic.REQCOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.REQCOMPRA(Fecexpo,Faltafw,Fd2,Fecimpo,Fectrans,Fmodifw,Fcuit,Idcaja,Fpodes2,Fpodes1,Fpodes,Fturno,Recmntosi2,Timestamp,Desmntosi1,Desmntosi2,Desmntosi,Totalcant,Signomov,Fsubton,Recmntosi1,Fsubtot,Sitfiscpro,Condivalp,Facttipo,Subtotsisi,Recmnto1,Subtotcisi,Recmntosi,Recmnto2,Anulado,Fcompfis,Desauto,Ualtafw,Fhora,Esttrans,Haltafw,Hmodifw,Saltafw,Horaimpo,Bdmodifw,Horaexpo,Umodifw,Bdaltafw,Zadsfw,Vmodifw,Descfw,Valtafw,Simbmon,Smodifw,Tcrg1361,Codigo,Idvuelto,Monsis,Moneda,Fmtdes1,Fdescu,Fmtdes2,Fletra,Fimpuesto,Fobs,Ffchfac,Fptoven,Desmntosi3,Fmtdes3,Recpor,Fnumcomp,Totdescsi,Mr,Ncai,Fperson,Fvtocai,Ffch,Fvuelto,Recmnto,Nroremito,Codlista,Ffchvenc,Motivo,Condpago,Ftotal,Cotiz,Recmonto2,Recmonto1,Totimpue,Totrecarsi,Totrecar,Totdesc)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FD2,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FPODES2,0),isnull( d.FPODES1,0),isnull( d.FPODES,0),isnull( d.FTURNO,0),isnull( d.RECMNTOSI2,0),isnull( d.TIMESTAMP,0),isnull( d.DESMNTOSI1,0),isnull( d.DESMNTOSI2,0),isnull( d.DESMNTOSI,0),isnull( d.TOTALCANT,0),isnull( d.SIGNOMOV,0),isnull( d.FSUBTON,0),isnull( d.RECMNTOSI1,0),isnull( d.FSUBTOT,0),isnull( d.SITFISCPRO,0),isnull( d.CONDIVALP,0),isnull( d.FACTTIPO,0),isnull( d.SUBTOTSISI,0),isnull( d.RECMNTO1,0),isnull( d.SUBTOTCISI,0),isnull( d.RECMNTOSI,0),isnull( d.RECMNTO2,0),isnull( d.ANULADO,0),isnull( d.FCOMPFIS,0),isnull( d.DESAUTO,0),isnull( d.UALTAFW,''),isnull( d.FHORA,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.UMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.DESCFW,''),isnull( d.VALTAFW,''),isnull( d.SIMBMON,''),isnull( d.SMODIFW,''),isnull( d.TCRG1361,0),isnull( d.CODIGO,''),isnull( d.IDVUELTO,''),isnull( d.MONSIS,''),isnull( d.MONEDA,''),isnull( d.FMTDES1,0),isnull( d.FDESCU,0),isnull( d.FMTDES2,0),isnull( d.FLETRA,''),isnull( d.FIMPUESTO,0),isnull( d.FOBS,''),isnull( d.FFCHFAC,''),isnull( d.FPTOVEN,0),isnull( d.DESMNTOSI3,0),isnull( d.FMTDES3,0),isnull( d.RECPOR,0),isnull( d.FNUMCOMP,0),isnull( d.TOTDESCSI,0),isnull( d.MR,0),isnull( d.NCAI,0),isnull( d.FPERSON,''),isnull( d.FVTOCAI,''),isnull( d.FFCH,''),isnull( d.FVUELTO,0),isnull( d.RECMNTO,0),isnull( d.NROREMITO,''),isnull( d.CODLISTA,''),isnull( d.FFCHVENC,''),isnull( d.MOTIVO,''),isnull( d.CONDPAGO,''),isnull( d.FTOTAL,0),isnull( d.COTIZ,0),isnull( d.RECMONTO2,0),isnull( d.RECMONTO1,0),isnull( d.TOTIMPUE,0),isnull( d.TOTRECARSI,0),isnull( d.TOTRECAR,0),isnull( d.TOTDESC,0)
						From deleted d left join ZooLogic.REQCOMPRA pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.REQCOMPRA cc 
							 on  d.FACTTIPO = cc.FACTTIPO
							 and  d.FLETRA = cc.FLETRA
							 and  d.FPTOVEN = cc.FPTOVEN
							 and  d.FNUMCOMP = cc.FNUMCOMP
						Where pk.CODIGO Is Null 
							 and cc.FACTTIPO Is Null 
							 and cc.FLETRA Is Null 
							 and cc.FPTOVEN Is Null 
							 and cc.FNUMCOMP Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.REQCOMPRA t inner join deleted d 
							on   t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.REQCOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.FACTTIPO = h.FACTTIPO
							 and   t.FLETRA = h.FLETRA
							 and   t.FPTOVEN = h.FPTOVEN
							 and   t.FNUMCOMP = h.FNUMCOMP
							where   h.FACTTIPO is null 
							 and   h.FLETRA is null 
							 and   h.FPTOVEN is null 
							 and   h.FNUMCOMP is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ReqCompraDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REQCOMPRA_ReqCompraDet
ON ZooLogic.TablaTrabajo_REQCOMPRA_ReqCompraDet
AFTER DELETE
As
Begin
Update t Set 
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.FART = isnull( d.FART, t.FART ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.ACONDIVAC = isnull( d.ACONDIVAC, t.ACONDIVAC ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.APORCIVAC = isnull( d.APORCIVAC, t.APORCIVAC ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.COMP = isnull( d.COMP, t.COMP ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.FAMATE = isnull( d.FAMATE, t.FAMATE ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.FTXT = isnull( d.FTXT, t.FTXT ),
t.FCOLO = isnull( d.FCOLO, t.FCOLO ),
t.FCOTXT = isnull( d.FCOTXT, t.FCOTXT ),
t.FTALL = isnull( d.FTALL, t.FTALL ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.MNTPIVA = isnull( d.MNTPIVA, t.MNTPIVA ),
t.SENIACANCE = isnull( d.SENIACANCE, t.SENIACANCE ),
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.ReqCompraDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ReqCompraDet
( 
"AFENUMCOM",
"AFEPTOVEN",
"AFELETRA",
"FART",
"AFETS",
"AFECANT",
"MNTPRECCI",
"ACONDIVAC",
"AFESALDO",
"APORCIVAC",
"MNTPRECSI",
"MNTPTOT",
"AJUSIMP",
"AJUCIMP",
"COMP",
"FBRUTO",
"ARTPERCEP",
"MNDESCI",
"MNDESSI",
"MNTPDESSI",
"MNTPDESCI",
"MNTPPER",
"MNPDSI",
"AFETIPOCOM",
"FNETO",
"FX2",
"AFENROITEM",
"FMTOIVA",
"FMTOCFI",
"FMTODTO1",
"FCFITOT",
"FKIT",
"FPORCFI",
"NROITEM",
"FPORDTO1",
"CIDITEM",
"FPORIVA",
"FN11",
"FPRUN",
"PRUNSINIMP",
"PRUNCONIMP",
"IDITEMORIG",
"PROCSTOCK",
"USARPLISTA",
"AFE_COD",
"IDITEM",
"FAMATE",
"CODIGO",
"FUNID",
"EQUIV",
"FTXT",
"FCOLO",
"FCOTXT",
"FTALL",
"FCFI",
"MNTDES",
"MNTPIVA",
"SENIACANCE",
"FCANT",
"FPRECIO",
"FMONTO"
 )
Select 
d.AFENUMCOM,
d.AFEPTOVEN,
d.AFELETRA,
d.FART,
d.AFETS,
d.AFECANT,
d.MNTPRECCI,
d.ACONDIVAC,
d.AFESALDO,
d.APORCIVAC,
d.MNTPRECSI,
d.MNTPTOT,
d.AJUSIMP,
d.AJUCIMP,
d.COMP,
d.FBRUTO,
d.ARTPERCEP,
d.MNDESCI,
d.MNDESSI,
d.MNTPDESSI,
d.MNTPDESCI,
d.MNTPPER,
d.MNPDSI,
d.AFETIPOCOM,
d.FNETO,
d.FX2,
d.AFENROITEM,
d.FMTOIVA,
d.FMTOCFI,
d.FMTODTO1,
d.FCFITOT,
d.FKIT,
d.FPORCFI,
d.NROITEM,
d.FPORDTO1,
d.CIDITEM,
d.FPORIVA,
d.FN11,
d.FPRUN,
d.PRUNSINIMP,
d.PRUNCONIMP,
d.IDITEMORIG,
d.PROCSTOCK,
d.USARPLISTA,
d.AFE_COD,
d.IDITEM,
d.FAMATE,
d.CODIGO,
d.FUNID,
d.EQUIV,
d.FTXT,
d.FCOLO,
d.FCOTXT,
d.FTALL,
d.FCFI,
d.MNTDES,
d.MNTPIVA,
d.SENIACANCE,
d.FCANT,
d.FPRECIO,
d.FMONTO
From deleted d left join ZooLogic.ReqCompraDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpReqComp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REQCOMPRA_ImpReqComp
ON ZooLogic.TablaTrabajo_REQCOMPRA_ImpReqComp
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
from ZooLogic.ImpReqComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpReqComp
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
From deleted d left join ZooLogic.ImpReqComp pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpReqc( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REQCOMPRA_ImpReqc
ON ZooLogic.TablaTrabajo_REQCOMPRA_ImpReqc
AFTER DELETE
As
Begin
Update t Set 
t.MINOIMP = isnull( d.MINOIMP, t.MINOIMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PORCEN = isnull( d.PORCEN, t.PORCEN ),
t.TIPOI = isnull( d.TIPOI, t.TIPOI ),
t.CODINT = isnull( d.CODINT, t.CODINT ),
t.CCOD = isnull( d.CCOD, t.CCOD ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.ImpReqc t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpReqc
( 
"MINOIMP",
"NROITEM",
"PORCEN",
"TIPOI",
"CODINT",
"CCOD",
"CODIMP",
"DESCRI",
"MONTO"
 )
Select 
d.MINOIMP,
d.NROITEM,
d.PORCEN,
d.TIPOI,
d.CODINT,
d.CCOD,
d.CODIMP,
d.DESCRI,
d.MONTO
From deleted d left join ZooLogic.ImpReqc pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ReqCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ReqCompra
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REQUERIMIENTODECOMPRA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_REQUERIMIENTODECOMPRA.Cuit, [] )
					.Caja_PK =  nvl( c_REQUERIMIENTODECOMPRA.Caja, 0 )
					.Porcentajedescuento2 = nvl( c_REQUERIMIENTODECOMPRA.Porcentajedescuento2, 0 )
					.Porcentajedescuento1 = nvl( c_REQUERIMIENTODECOMPRA.Porcentajedescuento1, 0 )
					.Porcentajedescuento = nvl( c_REQUERIMIENTODECOMPRA.Porcentajedescuento, 0 )
					.Turno = nvl( c_REQUERIMIENTODECOMPRA.Turno, 0 )
					.Recargomontosinimpuestos2 = nvl( c_REQUERIMIENTODECOMPRA.Recargomontosinimpuestos2, 0 )
					.Timestamp = nvl( c_REQUERIMIENTODECOMPRA.Timestamp, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_REQUERIMIENTODECOMPRA.Montodescuentosinimpuestos1, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_REQUERIMIENTODECOMPRA.Montodescuentosinimpuestos2, 0 )
					.Montodescuentosinimpuestos = nvl( c_REQUERIMIENTODECOMPRA.Montodescuentosinimpuestos, 0 )
					.Totalcantidad = nvl( c_REQUERIMIENTODECOMPRA.Totalcantidad, 0 )
					.Signodemovimiento = nvl( c_REQUERIMIENTODECOMPRA.Signodemovimiento, 0 )
					.Subtotalneto = nvl( c_REQUERIMIENTODECOMPRA.Subtotalneto, 0 )
					.Recargomontosinimpuestos1 = nvl( c_REQUERIMIENTODECOMPRA.Recargomontosinimpuestos1, 0 )
					.Subtotalbruto = nvl( c_REQUERIMIENTODECOMPRA.Subtotalbruto, 0 )
					.Situacionfiscal_PK =  nvl( c_REQUERIMIENTODECOMPRA.Situacionfiscal, 0 )
					.Condicioniva = nvl( c_REQUERIMIENTODECOMPRA.Condicioniva, 0 )
					.Tipocomprobante = nvl( c_REQUERIMIENTODECOMPRA.Tipocomprobante, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_REQUERIMIENTODECOMPRA.Subtotalsinimpuestossobreitems, 0 )
					.Recargomontoconimpuestos1 = nvl( c_REQUERIMIENTODECOMPRA.Recargomontoconimpuestos1, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_REQUERIMIENTODECOMPRA.Subtotalconimpuestossobreitems, 0 )
					.Recargomontosinimpuestos = nvl( c_REQUERIMIENTODECOMPRA.Recargomontosinimpuestos, 0 )
					.Recargomontoconimpuestos2 = nvl( c_REQUERIMIENTODECOMPRA.Recargomontoconimpuestos2, 0 )
					.Anulado = nvl( c_REQUERIMIENTODECOMPRA.Anulado, .F. )
					.Comprobantefiscal = nvl( c_REQUERIMIENTODECOMPRA.Comprobantefiscal, .F. )
					.Descuentoautomatico = nvl( c_REQUERIMIENTODECOMPRA.Descuentoautomatico, .F. )
					.Usuarioaltafw = nvl( c_REQUERIMIENTODECOMPRA.Usuarioaltafw, [] )
					.Hora = nvl( c_REQUERIMIENTODECOMPRA.Hora, [] )
					.Estadotransferencia = nvl( c_REQUERIMIENTODECOMPRA.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_REQUERIMIENTODECOMPRA.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_REQUERIMIENTODECOMPRA.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_REQUERIMIENTODECOMPRA.Seriealtafw, [] )
					.Horaimpo = nvl( c_REQUERIMIENTODECOMPRA.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_REQUERIMIENTODECOMPRA.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_REQUERIMIENTODECOMPRA.Horaexpo, [] )
					.Usuariomodificacionfw = nvl( c_REQUERIMIENTODECOMPRA.Usuariomodificacionfw, [] )
					.Basededatosaltafw = nvl( c_REQUERIMIENTODECOMPRA.Basededatosaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_REQUERIMIENTODECOMPRA.Versionmodificacionfw, [] )
					.Descripcionfw = nvl( c_REQUERIMIENTODECOMPRA.Descripcionfw, [] )
					.Versionaltafw = nvl( c_REQUERIMIENTODECOMPRA.Versionaltafw, [] )
					.Simbolomonetariocomprobante = nvl( c_REQUERIMIENTODECOMPRA.Simbolomonetariocomprobante, [] )
					.Seriemodificacionfw = nvl( c_REQUERIMIENTODECOMPRA.Seriemodificacionfw, [] )
					.Tipocomprobanterg1361 = nvl( c_REQUERIMIENTODECOMPRA.Tipocomprobanterg1361, 0 )
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Codigo = nvl( c_REQUERIMIENTODECOMPRA.Codigo, [] )
					.Idvuelto_PK =  nvl( c_REQUERIMIENTODECOMPRA.Idvuelto, [] )
					.Monedasistema_PK =  nvl( c_REQUERIMIENTODECOMPRA.Monedasistema, [] )
					.Monedacomprobante_PK =  nvl( c_REQUERIMIENTODECOMPRA.Monedacomprobante, [] )
					.Montodescuentoconimpuestos1 = nvl( c_REQUERIMIENTODECOMPRA.Montodescuentoconimpuestos1, 0 )
					.Descuento = nvl( c_REQUERIMIENTODECOMPRA.Descuento, 0 )
					.Montodescuentoconimpuestos2 = nvl( c_REQUERIMIENTODECOMPRA.Montodescuentoconimpuestos2, 0 )
					.Letra = nvl( c_REQUERIMIENTODECOMPRA.Letra, [] )
					.Impuestos = nvl( c_REQUERIMIENTODECOMPRA.Impuestos, 0 )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fechafactura = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fechafactura, ctod( '  /  /    ' ) ) )
					.Puntodeventa = nvl( c_REQUERIMIENTODECOMPRA.Puntodeventa, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_REQUERIMIENTODECOMPRA.Montodescuentosinimpuestos3, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_REQUERIMIENTODECOMPRA.Montodescuentoconimpuestos3, 0 )
					.Recargoporcentaje = nvl( c_REQUERIMIENTODECOMPRA.Recargoporcentaje, 0 )
					.Numero = nvl( c_REQUERIMIENTODECOMPRA.Numero, 0 )
					.Totaldescuentossinimpuestos = nvl( c_REQUERIMIENTODECOMPRA.Totaldescuentossinimpuestos, 0 )
					.Recargomonto = nvl( c_REQUERIMIENTODECOMPRA.Recargomonto, 0 )
					.Cai = nvl( c_REQUERIMIENTODECOMPRA.Cai, 0 )
					.Proveedor_PK =  nvl( c_REQUERIMIENTODECOMPRA.Proveedor, [] )
					.Fechavtocai = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fechavtocai, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fecha, ctod( '  /  /    ' ) ) )
					.Vuelto = nvl( c_REQUERIMIENTODECOMPRA.Vuelto, 0 )
					.Recargomontoconimpuestos = nvl( c_REQUERIMIENTODECOMPRA.Recargomontoconimpuestos, 0 )
					.Remito = nvl( c_REQUERIMIENTODECOMPRA.Remito, [] )
					.Listadeprecios_PK =  nvl( c_REQUERIMIENTODECOMPRA.Listadeprecios, [] )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_REQUERIMIENTODECOMPRA.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Motivo_PK =  nvl( c_REQUERIMIENTODECOMPRA.Motivo, [] )
					.Condicionpagopreferente_PK =  nvl( c_REQUERIMIENTODECOMPRA.Condicionpagopreferente, [] )
					.Total = nvl( c_REQUERIMIENTODECOMPRA.Total, 0 )
					.Cotizacion = nvl( c_REQUERIMIENTODECOMPRA.Cotizacion, 0 )
					.Recargomonto2 = nvl( c_REQUERIMIENTODECOMPRA.Recargomonto2, 0 )
					.Recargomonto1 = nvl( c_REQUERIMIENTODECOMPRA.Recargomonto1, 0 )
					.Totalimpuestos = nvl( c_REQUERIMIENTODECOMPRA.Totalimpuestos, 0 )
					.Totalrecargossinimpuestos = nvl( c_REQUERIMIENTODECOMPRA.Totalrecargossinimpuestos, 0 )
					.Totalrecargos = nvl( c_REQUERIMIENTODECOMPRA.Totalrecargos, 0 )
					.Totaldescuentos = nvl( c_REQUERIMIENTODECOMPRA.Totaldescuentos, 0 )
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
			lxRetorno = c_REQUERIMIENTODECOMPRA.CODIGO
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
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_REQUERIMIENTODECOMPRA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.REQCOMPRA' )
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
								from ZooLogic.REQCOMPRA 
								Where   REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REQCOMPRA", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fd2" as "Fechamodificacion", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Recmntosi2" as "Recargomontosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Facttipo" as "Tipocomprobante", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Ualtafw" as "Usuarioaltafw", "Fhora" as "Hora", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Valtafw" as "Versionaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Smodifw" as "Seriemodificacionfw", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Ffch" as "Fecha", "Fvuelto" as "Vuelto", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Ffchvenc" as "Fechavencimiento", "Motivo" as "Motivo", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.REQCOMPRA 
								Where   REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40
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
	Tabla = 'REQCOMPRA'
	Filtro = " REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REQCOMPRA.CODIGO != '' AND REQCOMPRA.FACTTIPO = 40"
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
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHAEXPO                               " tabla="REQCOMPRA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHAALTAFW                             " tabla="REQCOMPRA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHAMODIFICACION                       " tabla="REQCOMPRA      " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHAIMPO                               " tabla="REQCOMPRA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHATRANSFERENCIA                      " tabla="REQCOMPRA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHAMODIFICACIONFW                     " tabla="REQCOMPRA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="CUIT                                    " tabla="REQCOMPRA      " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="proveedor.cuit                                                                                                                                                                                                                                                " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="CAJA                                    " tabla="REQCOMPRA      " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="PORCENTAJEDESCUENTO2                    " tabla="REQCOMPRA      " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="PORCENTAJEDESCUENTO1                    " tabla="REQCOMPRA      " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="PORCENTAJEDESCUENTO                     " tabla="REQCOMPRA      " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% Descuento                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TURNO                                   " tabla="REQCOMPRA      " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="REQCOMPRA      " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TIMESTAMP                               " tabla="REQCOMPRA      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="REQCOMPRA      " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="REQCOMPRA      " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="REQCOMPRA      " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TOTALCANTIDAD                           " tabla="REQCOMPRA      " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total Cantidad                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="SIGNODEMOVIMIENTO                       " tabla="REQCOMPRA      " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="SUBTOTALNETO                            " tabla="REQCOMPRA      " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="REQCOMPRA      " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="SUBTOTALBRUTO                           " tabla="REQCOMPRA      " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="SITUACIONFISCAL                         " tabla="REQCOMPRA      " campo="SITFISCPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sit. Fis.                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="proveedor.SituacionFiscal                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="CONDICIONIVA                            " tabla="REQCOMPRA      " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TIPOCOMPROBANTE                         " tabla="REQCOMPRA      " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=40                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="REQCOMPRA      " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="REQCOMPRA      " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="REQCOMPRA      " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="REQCOMPRA      " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="REQCOMPRA      " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="ANULADO                                 " tabla="REQCOMPRA      " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Está anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="COMPROBANTEFISCAL                       " tabla="REQCOMPRA      " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="DESCUENTOAUTOMATICO                     " tabla="REQCOMPRA      " campo="DESAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="USUARIOALTAFW                           " tabla="REQCOMPRA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="HORA                                    " tabla="REQCOMPRA      " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="ESTADOTRANSFERENCIA                     " tabla="REQCOMPRA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="HORAALTAFW                              " tabla="REQCOMPRA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="HORAMODIFICACIONFW                      " tabla="REQCOMPRA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="SERIEALTAFW                             " tabla="REQCOMPRA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="HORAIMPO                                " tabla="REQCOMPRA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REQCOMPRA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="HORAEXPO                                " tabla="REQCOMPRA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="USUARIOMODIFICACIONFW                   " tabla="REQCOMPRA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="BASEDEDATOSALTAFW                       " tabla="REQCOMPRA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="ZADSFW                                  " tabla="REQCOMPRA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="VERSIONMODIFICACIONFW                   " tabla="REQCOMPRA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="DESCRIPCIONFW                           " tabla="REQCOMPRA      " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="VERSIONALTAFW                           " tabla="REQCOMPRA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="REQCOMPRA      " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="SERIEMODIFICACIONFW                     " tabla="REQCOMPRA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TIPOCOMPROBANTERG1361                   " tabla="REQCOMPRA      " campo="TCRG1361  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo factura                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FACTURADETALLE                          " tabla="REQCOMPRADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMARTICULOSREQCOMPRA " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="IMPUESTOSDETALLE                        " tabla="IMPREQCOMP     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOSREQC      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="CODIGO                                  " tabla="REQCOMPRA      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Nro Interno                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="IDVUELTO                                " tabla="REQCOMPRA      " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MONEDASISTEMA                           " tabla="REQCOMPRA      " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MONEDACOMPROBANTE                       " tabla="REQCOMPRA      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Moneda comprobante                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="REQCOMPRA      " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="DESCUENTO                               " tabla="REQCOMPRA      " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% Descuento                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="REQCOMPRA      " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="LETRA                                   " tabla="REQCOMPRA      " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="IMPUESTOS                               " tabla="REQCOMPRA      " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="I.V.A.                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPREQC        " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOREQCOMPRA  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="OBS                                     " tabla="REQCOMPRA      " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHAFACTURA                            " tabla="REQCOMPRA      " campo="FFCHFAC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Emisión                                                                                                                                                         " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="PUNTODEVENTA                            " tabla="REQCOMPRA      " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                    " obligatorio="true" admitebusqueda="8" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="REQCOMPRA      " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="REQCOMPRA      " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOPORCENTAJE                       " tabla="REQCOMPRA      " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="% Recargo                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="NUMERO                                  " tabla="REQCOMPRA      " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="REQCOMPRA      " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="14" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOMONTO                            " tabla="REQCOMPRA      " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="% Recargo                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="CAI                                     " tabla="REQCOMPRA      " campo="NCAI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="C.A.I./C.A.E.                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="PROVEEDOR                               " tabla="REQCOMPRA      " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHAVTOCAI                             " tabla="REQCOMPRA      " campo="FVTOCAI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento C.A.I./C.A.E.                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHA                                   " tabla="REQCOMPRA      " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="414" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="VUELTO                                  " tabla="REQCOMPRA      " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="REQCOMPRA      " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="REMITO                                  " tabla="REQCOMPRA      " campo="NROREMITO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Remito                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="A 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="LISTADEPRECIOS                          " tabla="REQCOMPRA      " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferenteCompras                                                                                                                                                                                  " obligatorio="false" admitebusqueda="416" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="FECHAVENCIMIENTO                        " tabla="REQCOMPRA      " campo="FFCHVENC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="418" etiqueta="Fecha de vencimiento                                                                                                                                            " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="MOTIVO                                  " tabla="REQCOMPRA      " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="CONDICIONPAGOPREFERENTE                 " tabla="REQCOMPRA      " campo="CONDPAGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TOTAL                                   " tabla="REQCOMPRA      " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="COTIZACION                              " tabla="REQCOMPRA      " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="422" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOMONTO2                           " tabla="REQCOMPRA      " campo="RECMONTO2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="RECARGOMONTO1                           " tabla="REQCOMPRA      " campo="RECMONTO1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TOTALIMPUESTOS                          " tabla="REQCOMPRA      " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="REQCOMPRA      " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TOTALRECARGOS                           " tabla="REQCOMPRA      " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REQUERIMIENTODECOMPRA                   " atributo="TOTALDESCUENTOS                         " tabla="REQCOMPRA      " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On REQCOMPRA.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On REQCOMPRA.FPERSON = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On REQCOMPRA.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On REQCOMPRA.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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