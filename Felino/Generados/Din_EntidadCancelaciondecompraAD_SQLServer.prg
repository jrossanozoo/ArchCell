
define class Din_EntidadCANCELACIONDECOMPRAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CANCELACIONDECOMPRA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0)]
	cTagClaveCandidata = '_CACCC'
	cTagClavePk = '_CACPK'
	cTablaPrincipal = 'CANCOMPRA'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
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
			local  lxCancompraFecexpo, lxCancompraFaltafw, lxCancompraFmodifw, lxCancompraFecimpo, lxCancompraFd2, lxCancompraFectrans, lxCancompraFcuit, lxCancompraIdcaja, lxCancompraFpodes1, lxCancompraFpodes2, lxCancompraFpodes, lxCancompraFturno, lxCancompraTimestamp, lxCancompraDesmntosi1, lxCancompraDesmntosi, lxCancompraDesmntosi2, lxCancompraTotalcant, lxCancompraRecmntosi2, lxCancompraSignomov, lxCancompraFacttipo, lxCancompraRecmntosi1, lxCancompraFsubton, lxCancompraSitfiscpro, lxCancompraCondivalp, lxCancompraFsubtot, lxCancompraRecmntosi, lxCancompraSubtotsisi, lxCancompraSubtotcisi, lxCancompraRecmnto2, lxCancompraRecmnto1, lxCancompraDesauto, lxCancompraFcompfis, lxCancompraAnulado, lxCancompraHoraexpo, lxCancompraFhora, lxCancompraHaltafw, lxCancompraHmodifw, lxCancompraHoraimpo, lxCancompraSmodifw, lxCancompraZadsfw, lxCancompraDescfw, lxCancompraVmodifw, lxCancompraValtafw, lxCancompraUaltafw, lxCancompraUmodifw, lxCancompraSaltafw, lxCancompraBdaltafw, lxCancompraSimbmon, lxCancompraBdmodifw, lxCancompraEsttrans, lxCancompraTcrg1361, lxCancompraIdvuelto, lxCancompraCodigo, lxCancompraMoneda, lxCancompraMonsis, lxCancompraFmtdes1, lxCancompraFdescu, lxCancompraFmtdes2, lxCancompraFletra, lxCancompraFimpuesto, lxCancompraFobs, lxCancompraFfchfac, lxCancompraFptoven, lxCancompraDesmntosi3, lxCancompraFmtdes3, lxCancompraRecpor, lxCancompraFnumcomp, lxCancompraTotdescsi, lxCancompraFfch, lxCancompraMr, lxCancompraNcai, lxCancompraRecmnto, lxCancompraFperson, lxCancompraFvtocai, lxCancompraFvuelto, lxCancompraCodlista, lxCancompraFtotal, lxCancompraRecmonto1, lxCancompraRecmonto2, lxCancompraMotivo, lxCancompraNroremito, lxCancompraCotiz, lxCancompraTotimpue, lxCancompraTotrecar, lxCancompraTotrecarsi, lxCancompraTotdesc
				lxCancompraFecexpo =  .Fechaexpo			lxCancompraFaltafw =  .Fechaaltafw			lxCancompraFmodifw =  .Fechamodificacionfw			lxCancompraFecimpo =  .Fechaimpo			lxCancompraFd2 =  .Fechamodificacion			lxCancompraFectrans =  .Fechatransferencia			lxCancompraFcuit =  .Cuit			lxCancompraIdcaja =  .Caja_PK 			lxCancompraFpodes1 =  .Porcentajedescuento1			lxCancompraFpodes2 =  .Porcentajedescuento2			lxCancompraFpodes =  .Porcentajedescuento			lxCancompraFturno =  .Turno			lxCancompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCancompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxCancompraDesmntosi =  .Montodescuentosinimpuestos			lxCancompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxCancompraTotalcant =  .Totalcantidad			lxCancompraRecmntosi2 =  .Recargomontosinimpuestos2			lxCancompraSignomov =  .Signodemovimiento			lxCancompraFacttipo =  .Tipocomprobante			lxCancompraRecmntosi1 =  .Recargomontosinimpuestos1			lxCancompraFsubton =  .Subtotalneto			lxCancompraSitfiscpro =  .Situacionfiscal_PK 			lxCancompraCondivalp =  .Condicioniva			lxCancompraFsubtot =  .Subtotalbruto			lxCancompraRecmntosi =  .Recargomontosinimpuestos			lxCancompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxCancompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxCancompraRecmnto2 =  .Recargomontoconimpuestos2			lxCancompraRecmnto1 =  .Recargomontoconimpuestos1			lxCancompraDesauto =  .Descuentoautomatico			lxCancompraFcompfis =  .Comprobantefiscal			lxCancompraAnulado =  .Anulado			lxCancompraHoraexpo =  .Horaexpo			lxCancompraFhora =  .Hora			lxCancompraHaltafw =  .Horaaltafw			lxCancompraHmodifw =  .Horamodificacionfw			lxCancompraHoraimpo =  .Horaimpo			lxCancompraSmodifw =  .Seriemodificacionfw			lxCancompraZadsfw =  .Zadsfw			lxCancompraDescfw =  .Descripcionfw			lxCancompraVmodifw =  .Versionmodificacionfw			lxCancompraValtafw =  .Versionaltafw			lxCancompraUaltafw =  .Usuarioaltafw			lxCancompraUmodifw =  .Usuariomodificacionfw			lxCancompraSaltafw =  .Seriealtafw			lxCancompraBdaltafw =  .Basededatosaltafw			lxCancompraSimbmon =  .Simbolomonetariocomprobante			lxCancompraBdmodifw =  .Basededatosmodificacionfw			lxCancompraEsttrans =  .Estadotransferencia			lxCancompraTcrg1361 =  .Tipocomprobanterg1361			lxCancompraIdvuelto =  upper( .IdVuelto_PK ) 			lxCancompraCodigo =  .Codigo			lxCancompraMoneda =  upper( .MonedaComprobante_PK ) 			lxCancompraMonsis =  upper( .MonedaSistema_PK ) 			lxCancompraFmtdes1 =  .Montodescuentoconimpuestos1			lxCancompraFdescu =  .Descuento			lxCancompraFmtdes2 =  .Montodescuentoconimpuestos2			lxCancompraFletra =  .Letra			lxCancompraFimpuesto =  .Impuestos			lxCancompraFobs =  .Obs			lxCancompraFfchfac =  .Fechafactura			lxCancompraFptoven =  .Puntodeventa			lxCancompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxCancompraFmtdes3 =  .Montodescuentoconimpuestos3			lxCancompraRecpor =  .Recargoporcentaje			lxCancompraFnumcomp =  .Numero			lxCancompraTotdescsi =  .Totaldescuentossinimpuestos			lxCancompraFfch =  .Fecha			lxCancompraMr =  .Recargomonto			lxCancompraNcai =  .Cai			lxCancompraRecmnto =  .Recargomontoconimpuestos			lxCancompraFperson =  upper( .Proveedor_PK ) 			lxCancompraFvtocai =  .Fechavtocai			lxCancompraFvuelto =  .Vuelto			lxCancompraCodlista =  upper( .ListaDePrecios_PK ) 			lxCancompraFtotal =  .Total			lxCancompraRecmonto1 =  .Recargomonto1			lxCancompraRecmonto2 =  .Recargomonto2			lxCancompraMotivo =  upper( .Motivo_PK ) 			lxCancompraNroremito =  .Remito			lxCancompraCotiz =  .Cotizacion			lxCancompraTotimpue =  .Totalimpuestos			lxCancompraTotrecar =  .Totalrecargos			lxCancompraTotrecarsi =  .Totalrecargossinimpuestos			lxCancompraTotdesc =  .Totaldescuentos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCancompraCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CANCOMPRA ( "Fecexpo","Faltafw","Fmodifw","Fecimpo","Fd2","Fectrans","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fturno","Timestamp","Desmntosi1","Desmntosi","Desmntosi2","Totalcant","Recmntosi2","Signomov","Facttipo","Recmntosi1","Fsubton","Sitfiscpro","Condivalp","Fsubtot","Recmntosi","Subtotsisi","Subtotcisi","Recmnto2","Recmnto1","Desauto","Fcompfis","Anulado","Horaexpo","Fhora","Haltafw","Hmodifw","Horaimpo","Smodifw","Zadsfw","Descfw","Vmodifw","Valtafw","Ualtafw","Umodifw","Saltafw","Bdaltafw","Simbmon","Bdmodifw","Esttrans","Tcrg1361","Idvuelto","Codigo","Moneda","Monsis","Fmtdes1","Fdescu","Fmtdes2","Fletra","Fimpuesto","Fobs","Ffchfac","Fptoven","Desmntosi3","Fmtdes3","Recpor","Fnumcomp","Totdescsi","Ffch","Mr","Ncai","Recmnto","Fperson","Fvtocai","Fvuelto","Codlista","Ftotal","Recmonto1","Recmonto2","Motivo","Nroremito","Cotiz","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxCancompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraFcuit ) + "'" >>, <<lxCancompraIdcaja >>, <<lxCancompraFpodes1 >>, <<lxCancompraFpodes2 >>, <<lxCancompraFpodes >>, <<lxCancompraFturno >>, <<lxCancompraTimestamp >>, <<lxCancompraDesmntosi1 >>, <<lxCancompraDesmntosi >>, <<lxCancompraDesmntosi2 >>, <<lxCancompraTotalcant >>, <<lxCancompraRecmntosi2 >>, <<lxCancompraSignomov >>, <<lxCancompraFacttipo >>, <<lxCancompraRecmntosi1 >>, <<lxCancompraFsubton >>, <<lxCancompraSitfiscpro >>, <<lxCancompraCondivalp >>, <<lxCancompraFsubtot >>, <<lxCancompraRecmntosi >>, <<lxCancompraSubtotsisi >>, <<lxCancompraSubtotcisi >>, <<lxCancompraRecmnto2 >>, <<lxCancompraRecmnto1 >>, <<iif( lxCancompraDesauto, 1, 0 ) >>, <<iif( lxCancompraFcompfis, 1, 0 ) >>, <<iif( lxCancompraAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCancompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraEsttrans ) + "'" >>, <<lxCancompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxCancompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraMonsis ) + "'" >>, <<lxCancompraFmtdes1 >>, <<lxCancompraFdescu >>, <<lxCancompraFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxCancompraFletra ) + "'" >>, <<lxCancompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxCancompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFfchfac ) + "'" >>, <<lxCancompraFptoven >>, <<lxCancompraDesmntosi3 >>, <<lxCancompraFmtdes3 >>, <<lxCancompraRecpor >>, <<lxCancompraFnumcomp >>, <<lxCancompraTotdescsi >>, <<"'" + this.ConvertirDateSql( lxCancompraFfch ) + "'" >>, <<lxCancompraMr >>, <<lxCancompraNcai >>, <<lxCancompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxCancompraFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFvtocai ) + "'" >>, <<lxCancompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxCancompraCodlista ) + "'" >>, <<lxCancompraFtotal >>, <<lxCancompraRecmonto1 >>, <<lxCancompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxCancompraMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraNroremito ) + "'" >>, <<lxCancompraCotiz >>, <<lxCancompraTotimpue >>, <<lxCancompraTotrecar >>, <<lxCancompraTotrecarsi >>, <<lxCancompraTotdesc >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_saldo = loItem.Afe_saldo
					lxAfe_timestamp = loItem.Afe_timestamp
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_numint = loItem.Afe_numint
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNroitem = lnContadorNroItem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxIditem = loItem.Iditem
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CANCOMPRADET("AfeLETRA","AfeNUMCOM","AfePTOVEN","MNTPRECCI","AfeSaldo","AfeTS","AfeCANT","ACondIvaC","MNTPTOT","APorcIvaC","MNTPDESSI","MNTPPER","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","NumInt","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","FNETO","FporCFI","FX2","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","NroItem","fporIva","prunconimp","AfeNroItem","iditemOrig","FN11","ciditem","FPRUN","Prunsinimp","ProcStock","UsarPLista","IdItem","afe_Cod","FAMate","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_saldo>>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxArticulo_condicionivacompras>>, <<lxMontoprorrateototal>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_numint>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxPrecioconimpuestos>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxIditem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpCanComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
						Insert into ZooLogic.ImpCanC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxCancompraTimestamp
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
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxCancompraFecexpo, lxCancompraFaltafw, lxCancompraFmodifw, lxCancompraFecimpo, lxCancompraFd2, lxCancompraFectrans, lxCancompraFcuit, lxCancompraIdcaja, lxCancompraFpodes1, lxCancompraFpodes2, lxCancompraFpodes, lxCancompraFturno, lxCancompraTimestamp, lxCancompraDesmntosi1, lxCancompraDesmntosi, lxCancompraDesmntosi2, lxCancompraTotalcant, lxCancompraRecmntosi2, lxCancompraSignomov, lxCancompraFacttipo, lxCancompraRecmntosi1, lxCancompraFsubton, lxCancompraSitfiscpro, lxCancompraCondivalp, lxCancompraFsubtot, lxCancompraRecmntosi, lxCancompraSubtotsisi, lxCancompraSubtotcisi, lxCancompraRecmnto2, lxCancompraRecmnto1, lxCancompraDesauto, lxCancompraFcompfis, lxCancompraAnulado, lxCancompraHoraexpo, lxCancompraFhora, lxCancompraHaltafw, lxCancompraHmodifw, lxCancompraHoraimpo, lxCancompraSmodifw, lxCancompraZadsfw, lxCancompraDescfw, lxCancompraVmodifw, lxCancompraValtafw, lxCancompraUaltafw, lxCancompraUmodifw, lxCancompraSaltafw, lxCancompraBdaltafw, lxCancompraSimbmon, lxCancompraBdmodifw, lxCancompraEsttrans, lxCancompraTcrg1361, lxCancompraIdvuelto, lxCancompraCodigo, lxCancompraMoneda, lxCancompraMonsis, lxCancompraFmtdes1, lxCancompraFdescu, lxCancompraFmtdes2, lxCancompraFletra, lxCancompraFimpuesto, lxCancompraFobs, lxCancompraFfchfac, lxCancompraFptoven, lxCancompraDesmntosi3, lxCancompraFmtdes3, lxCancompraRecpor, lxCancompraFnumcomp, lxCancompraTotdescsi, lxCancompraFfch, lxCancompraMr, lxCancompraNcai, lxCancompraRecmnto, lxCancompraFperson, lxCancompraFvtocai, lxCancompraFvuelto, lxCancompraCodlista, lxCancompraFtotal, lxCancompraRecmonto1, lxCancompraRecmonto2, lxCancompraMotivo, lxCancompraNroremito, lxCancompraCotiz, lxCancompraTotimpue, lxCancompraTotrecar, lxCancompraTotrecarsi, lxCancompraTotdesc
				lxCancompraFecexpo =  .Fechaexpo			lxCancompraFaltafw =  .Fechaaltafw			lxCancompraFmodifw =  .Fechamodificacionfw			lxCancompraFecimpo =  .Fechaimpo			lxCancompraFd2 =  .Fechamodificacion			lxCancompraFectrans =  .Fechatransferencia			lxCancompraFcuit =  .Cuit			lxCancompraIdcaja =  .Caja_PK 			lxCancompraFpodes1 =  .Porcentajedescuento1			lxCancompraFpodes2 =  .Porcentajedescuento2			lxCancompraFpodes =  .Porcentajedescuento			lxCancompraFturno =  .Turno			lxCancompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCancompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxCancompraDesmntosi =  .Montodescuentosinimpuestos			lxCancompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxCancompraTotalcant =  .Totalcantidad			lxCancompraRecmntosi2 =  .Recargomontosinimpuestos2			lxCancompraSignomov =  .Signodemovimiento			lxCancompraFacttipo =  .Tipocomprobante			lxCancompraRecmntosi1 =  .Recargomontosinimpuestos1			lxCancompraFsubton =  .Subtotalneto			lxCancompraSitfiscpro =  .Situacionfiscal_PK 			lxCancompraCondivalp =  .Condicioniva			lxCancompraFsubtot =  .Subtotalbruto			lxCancompraRecmntosi =  .Recargomontosinimpuestos			lxCancompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxCancompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxCancompraRecmnto2 =  .Recargomontoconimpuestos2			lxCancompraRecmnto1 =  .Recargomontoconimpuestos1			lxCancompraDesauto =  .Descuentoautomatico			lxCancompraFcompfis =  .Comprobantefiscal			lxCancompraAnulado =  .Anulado			lxCancompraHoraexpo =  .Horaexpo			lxCancompraFhora =  .Hora			lxCancompraHaltafw =  .Horaaltafw			lxCancompraHmodifw =  .Horamodificacionfw			lxCancompraHoraimpo =  .Horaimpo			lxCancompraSmodifw =  .Seriemodificacionfw			lxCancompraZadsfw =  .Zadsfw			lxCancompraDescfw =  .Descripcionfw			lxCancompraVmodifw =  .Versionmodificacionfw			lxCancompraValtafw =  .Versionaltafw			lxCancompraUaltafw =  .Usuarioaltafw			lxCancompraUmodifw =  .Usuariomodificacionfw			lxCancompraSaltafw =  .Seriealtafw			lxCancompraBdaltafw =  .Basededatosaltafw			lxCancompraSimbmon =  .Simbolomonetariocomprobante			lxCancompraBdmodifw =  .Basededatosmodificacionfw			lxCancompraEsttrans =  .Estadotransferencia			lxCancompraTcrg1361 =  .Tipocomprobanterg1361			lxCancompraIdvuelto =  upper( .IdVuelto_PK ) 			lxCancompraCodigo =  .Codigo			lxCancompraMoneda =  upper( .MonedaComprobante_PK ) 			lxCancompraMonsis =  upper( .MonedaSistema_PK ) 			lxCancompraFmtdes1 =  .Montodescuentoconimpuestos1			lxCancompraFdescu =  .Descuento			lxCancompraFmtdes2 =  .Montodescuentoconimpuestos2			lxCancompraFletra =  .Letra			lxCancompraFimpuesto =  .Impuestos			lxCancompraFobs =  .Obs			lxCancompraFfchfac =  .Fechafactura			lxCancompraFptoven =  .Puntodeventa			lxCancompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxCancompraFmtdes3 =  .Montodescuentoconimpuestos3			lxCancompraRecpor =  .Recargoporcentaje			lxCancompraFnumcomp =  .Numero			lxCancompraTotdescsi =  .Totaldescuentossinimpuestos			lxCancompraFfch =  .Fecha			lxCancompraMr =  .Recargomonto			lxCancompraNcai =  .Cai			lxCancompraRecmnto =  .Recargomontoconimpuestos			lxCancompraFperson =  upper( .Proveedor_PK ) 			lxCancompraFvtocai =  .Fechavtocai			lxCancompraFvuelto =  .Vuelto			lxCancompraCodlista =  upper( .ListaDePrecios_PK ) 			lxCancompraFtotal =  .Total			lxCancompraRecmonto1 =  .Recargomonto1			lxCancompraRecmonto2 =  .Recargomonto2			lxCancompraMotivo =  upper( .Motivo_PK ) 			lxCancompraNroremito =  .Remito			lxCancompraCotiz =  .Cotizacion			lxCancompraTotimpue =  .Totalimpuestos			lxCancompraTotrecar =  .Totalrecargos			lxCancompraTotrecarsi =  .Totalrecargossinimpuestos			lxCancompraTotdesc =  .Totaldescuentos
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
				update ZooLogic.CANCOMPRA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCancompraFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCancompraFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCancompraFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCancompraFecimpo ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxCancompraFd2 ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCancompraFectrans ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxCancompraFcuit ) + "'">>,"Idcaja" = <<lxCancompraIdcaja>>,"Fpodes1" = <<lxCancompraFpodes1>>,"Fpodes2" = <<lxCancompraFpodes2>>,"Fpodes" = <<lxCancompraFpodes>>,"Fturno" = <<lxCancompraFturno>>,"Timestamp" = <<lxCancompraTimestamp>>,"Desmntosi1" = <<lxCancompraDesmntosi1>>,"Desmntosi" = <<lxCancompraDesmntosi>>,"Desmntosi2" = <<lxCancompraDesmntosi2>>,"Totalcant" = <<lxCancompraTotalcant>>,"Recmntosi2" = <<lxCancompraRecmntosi2>>,"Signomov" = <<lxCancompraSignomov>>,"Facttipo" = <<lxCancompraFacttipo>>,"Recmntosi1" = <<lxCancompraRecmntosi1>>,"Fsubton" = <<lxCancompraFsubton>>,"Sitfiscpro" = <<lxCancompraSitfiscpro>>,"Condivalp" = <<lxCancompraCondivalp>>,"Fsubtot" = <<lxCancompraFsubtot>>,"Recmntosi" = <<lxCancompraRecmntosi>>,"Subtotsisi" = <<lxCancompraSubtotsisi>>,"Subtotcisi" = <<lxCancompraSubtotcisi>>,"Recmnto2" = <<lxCancompraRecmnto2>>,"Recmnto1" = <<lxCancompraRecmnto1>>,"Desauto" = <<iif( lxCancompraDesauto, 1, 0 )>>,"Fcompfis" = <<iif( lxCancompraFcompfis, 1, 0 )>>,"Anulado" = <<iif( lxCancompraAnulado, 1, 0 )>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCancompraHoraexpo ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxCancompraFhora ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCancompraHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCancompraHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCancompraHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCancompraSmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCancompraZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCancompraDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCancompraVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCancompraValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCancompraUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCancompraUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCancompraSaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCancompraBdaltafw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxCancompraSimbmon ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCancompraBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCancompraEsttrans ) + "'">>,"Tcrg1361" = <<lxCancompraTcrg1361>>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxCancompraIdvuelto ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCancompraCodigo ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxCancompraMoneda ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxCancompraMonsis ) + "'">>,"Fmtdes1" = <<lxCancompraFmtdes1>>,"Fdescu" = <<lxCancompraFdescu>>,"Fmtdes2" = <<lxCancompraFmtdes2>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxCancompraFletra ) + "'">>,"Fimpuesto" = <<lxCancompraFimpuesto>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxCancompraFobs ) + "'">>,"Ffchfac" = <<"'" + this.ConvertirDateSql( lxCancompraFfchfac ) + "'">>,"Fptoven" = <<lxCancompraFptoven>>,"Desmntosi3" = <<lxCancompraDesmntosi3>>,"Fmtdes3" = <<lxCancompraFmtdes3>>,"Recpor" = <<lxCancompraRecpor>>,"Fnumcomp" = <<lxCancompraFnumcomp>>,"Totdescsi" = <<lxCancompraTotdescsi>>,"Ffch" = <<"'" + this.ConvertirDateSql( lxCancompraFfch ) + "'">>,"Mr" = <<lxCancompraMr>>,"Ncai" = <<lxCancompraNcai>>,"Recmnto" = <<lxCancompraRecmnto>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxCancompraFperson ) + "'">>,"Fvtocai" = <<"'" + this.ConvertirDateSql( lxCancompraFvtocai ) + "'">>,"Fvuelto" = <<lxCancompraFvuelto>>,"Codlista" = <<"'" + this.FormatearTextoSql( lxCancompraCodlista ) + "'">>,"Ftotal" = <<lxCancompraFtotal>>,"Recmonto1" = <<lxCancompraRecmonto1>>,"Recmonto2" = <<lxCancompraRecmonto2>>,"Motivo" = <<"'" + this.FormatearTextoSql( lxCancompraMotivo ) + "'">>,"Nroremito" = <<"'" + this.FormatearTextoSql( lxCancompraNroremito ) + "'">>,"Cotiz" = <<lxCancompraCotiz>>,"Totimpue" = <<lxCancompraTotimpue>>,"Totrecar" = <<lxCancompraTotrecar>>,"Totrecarsi" = <<lxCancompraTotrecarsi>>,"Totdesc" = <<lxCancompraTotdesc>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCancompraCodigo ) + "'">> and  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CANCOMPRADET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpCanComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpCanC where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_saldo = loItem.Afe_saldo
					lxAfe_timestamp = loItem.Afe_timestamp
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_numint = loItem.Afe_numint
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNroitem = lnContadorNroItem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxIditem = loItem.Iditem
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CANCOMPRADET("AfeLETRA","AfeNUMCOM","AfePTOVEN","MNTPRECCI","AfeSaldo","AfeTS","AfeCANT","ACondIvaC","MNTPTOT","APorcIvaC","MNTPDESSI","MNTPPER","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","NumInt","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","FNETO","FporCFI","FX2","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","NroItem","fporIva","prunconimp","AfeNroItem","iditemOrig","FN11","ciditem","FPRUN","Prunsinimp","ProcStock","UsarPLista","IdItem","afe_Cod","FAMate","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_saldo>>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxArticulo_condicionivacompras>>, <<lxMontoprorrateototal>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_numint>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxPrecioconimpuestos>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxIditem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpCanComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
						Insert into ZooLogic.ImpCanC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxCancompraTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.CANCOMPRA where " + this.ConvertirFuncionesSql( " CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44" ) )
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
			Local lxCancompraCodigo
			lxCancompraCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaexpo" as "Horaexpo", "Fhora" as "Hora", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Nroremito" as "Remito", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.CANCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCancompraCodigo ) + "'">> and  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44
			endtext
			use in select('c_CANCELACIONDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_CANCELACIONDECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afesaldo" as "Afe_saldo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Mntptot" as "Montoprorrateototal", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Prunconimp" as "Precioconimpuestos", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.CANCOMPRADET where CODIGO = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpCanComp where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpCanC where cCod = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			Local lxCANCOMPRAFACTTIPO As Variant, lxCanCompraFLETRA As Variant, lxCanCompraFPTOVEN As Variant, lxCanCompraFNUMCOMP As Variant
			lxCANCOMPRAFACTTIPO = .TipoComprobante
			lxCanCompraFLETRA = .Letra
			lxCanCompraFPTOVEN = .PuntoDeVenta
			lxCanCompraFNUMCOMP = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaexpo" as "Horaexpo", "Fhora" as "Hora", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Nroremito" as "Remito", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.CANCOMPRA where  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44 And FACTTIPO = <<lxCANCOMPRAFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxCanCompraFLETRA ) + "'">> and FPTOVEN = <<lxCanCompraFPTOVEN>> and FNUMCOMP = <<lxCanCompraFNUMCOMP>>
			endtext
			use in select('c_CANCELACIONDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDECOMPRA', set( 'Datasession' ) )
			if reccount( 'c_CANCELACIONDECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afesaldo" as "Afe_saldo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Mntptot" as "Montoprorrateototal", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Prunconimp" as "Precioconimpuestos", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.CANCOMPRADET where CODIGO = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpCanComp where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpCanC where cCod = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxCancompraCodigo as Variant
		llRetorno = .t.
		lxCancompraCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CANCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxCancompraCodigo ) + "'">> and  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaexpo" as "Horaexpo", "Fhora" as "Hora", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Nroremito" as "Remito", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.CANCOMPRA where  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP
			endtext
			use in select('c_CANCELACIONDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afesaldo" as "Afe_saldo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Mntptot" as "Montoprorrateototal", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Prunconimp" as "Precioconimpuestos", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.CANCOMPRADET where CODIGO = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpCanComp where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpCanC where cCod = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaexpo" as "Horaexpo", "Fhora" as "Hora", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Nroremito" as "Remito", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.CANCOMPRA where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP
			endtext
			use in select('c_CANCELACIONDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afesaldo" as "Afe_saldo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Mntptot" as "Montoprorrateototal", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Prunconimp" as "Precioconimpuestos", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.CANCOMPRADET where CODIGO = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpCanComp where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpCanC where cCod = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaexpo" as "Horaexpo", "Fhora" as "Hora", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Nroremito" as "Remito", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.CANCOMPRA where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc
			endtext
			use in select('c_CANCELACIONDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afesaldo" as "Afe_saldo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Mntptot" as "Montoprorrateototal", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Prunconimp" as "Precioconimpuestos", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.CANCOMPRADET where CODIGO = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpCanComp where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpCanC where cCod = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaexpo" as "Horaexpo", "Fhora" as "Hora", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Nroremito" as "Remito", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.CANCOMPRA where  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc
			endtext
			use in select('c_CANCELACIONDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANCELACIONDECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afesaldo" as "Afe_saldo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Mntptot" as "Montoprorrateototal", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Prunconimp" as "Precioconimpuestos", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.CANCOMPRADET where CODIGO = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpCanComp where Codigo = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpCanC where cCod = <<"'" + this.FormatearTextoSql( c_CANCELACIONDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fmodifw,Fecimpo,Fd2,Fectrans,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fturno,Time" + ;
"stamp,Desmntosi1,Desmntosi,Desmntosi2,Totalcant,Recmntosi2,Signomov,Facttipo,Recmntosi1,Fsubton,Sitf" + ;
"iscpro,Condivalp,Fsubtot,Recmntosi,Subtotsisi,Subtotcisi,Recmnto2,Recmnto1,Desauto,Fcompfis,Anulado," + ;
"Horaexpo,Fhora,Haltafw,Hmodifw,Horaimpo,Smodifw,Zadsfw,Descfw,Vmodifw,Valtafw,Ualtafw,Umodifw,Saltaf" + ;
"w,Bdaltafw,Simbmon,Bdmodifw,Esttrans,Tcrg1361,Idvuelto,Codigo,Moneda,Monsis,Fmtdes1,Fdescu,Fmtdes2,F" + ;
"letra,Fimpuesto,Fobs,Ffchfac,Fptoven,Desmntosi3,Fmtdes3,Recpor,Fnumcomp,Totdescsi,Ffch,Mr,Ncai,Recmn" + ;
"to,Fperson,Fvtocai,Fvuelto,Codlista,Ftotal,Recmonto1,Recmonto2,Motivo,Nroremito,Cotiz,Totimpue,Totre" + ;
"car,Totrecarsi,Totdesc" + ;
" from ZooLogic.CANCOMPRA where  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44 and " + lcFiltro )
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
			local  lxCancompraFecexpo, lxCancompraFaltafw, lxCancompraFmodifw, lxCancompraFecimpo, lxCancompraFd2, lxCancompraFectrans, lxCancompraFcuit, lxCancompraIdcaja, lxCancompraFpodes1, lxCancompraFpodes2, lxCancompraFpodes, lxCancompraFturno, lxCancompraTimestamp, lxCancompraDesmntosi1, lxCancompraDesmntosi, lxCancompraDesmntosi2, lxCancompraTotalcant, lxCancompraRecmntosi2, lxCancompraSignomov, lxCancompraFacttipo, lxCancompraRecmntosi1, lxCancompraFsubton, lxCancompraSitfiscpro, lxCancompraCondivalp, lxCancompraFsubtot, lxCancompraRecmntosi, lxCancompraSubtotsisi, lxCancompraSubtotcisi, lxCancompraRecmnto2, lxCancompraRecmnto1, lxCancompraDesauto, lxCancompraFcompfis, lxCancompraAnulado, lxCancompraHoraexpo, lxCancompraFhora, lxCancompraHaltafw, lxCancompraHmodifw, lxCancompraHoraimpo, lxCancompraSmodifw, lxCancompraZadsfw, lxCancompraDescfw, lxCancompraVmodifw, lxCancompraValtafw, lxCancompraUaltafw, lxCancompraUmodifw, lxCancompraSaltafw, lxCancompraBdaltafw, lxCancompraSimbmon, lxCancompraBdmodifw, lxCancompraEsttrans, lxCancompraTcrg1361, lxCancompraIdvuelto, lxCancompraCodigo, lxCancompraMoneda, lxCancompraMonsis, lxCancompraFmtdes1, lxCancompraFdescu, lxCancompraFmtdes2, lxCancompraFletra, lxCancompraFimpuesto, lxCancompraFobs, lxCancompraFfchfac, lxCancompraFptoven, lxCancompraDesmntosi3, lxCancompraFmtdes3, lxCancompraRecpor, lxCancompraFnumcomp, lxCancompraTotdescsi, lxCancompraFfch, lxCancompraMr, lxCancompraNcai, lxCancompraRecmnto, lxCancompraFperson, lxCancompraFvtocai, lxCancompraFvuelto, lxCancompraCodlista, lxCancompraFtotal, lxCancompraRecmonto1, lxCancompraRecmonto2, lxCancompraMotivo, lxCancompraNroremito, lxCancompraCotiz, lxCancompraTotimpue, lxCancompraTotrecar, lxCancompraTotrecarsi, lxCancompraTotdesc
				lxCancompraFecexpo = ctod( '  /  /    ' )			lxCancompraFaltafw = ctod( '  /  /    ' )			lxCancompraFmodifw = ctod( '  /  /    ' )			lxCancompraFecimpo = ctod( '  /  /    ' )			lxCancompraFd2 = ctod( '  /  /    ' )			lxCancompraFectrans = ctod( '  /  /    ' )			lxCancompraFcuit = []			lxCancompraIdcaja = 0			lxCancompraFpodes1 = 0			lxCancompraFpodes2 = 0			lxCancompraFpodes = 0			lxCancompraFturno = 0			lxCancompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCancompraDesmntosi1 = 0			lxCancompraDesmntosi = 0			lxCancompraDesmntosi2 = 0			lxCancompraTotalcant = 0			lxCancompraRecmntosi2 = 0			lxCancompraSignomov = 0			lxCancompraFacttipo = 0			lxCancompraRecmntosi1 = 0			lxCancompraFsubton = 0			lxCancompraSitfiscpro = 0			lxCancompraCondivalp = 0			lxCancompraFsubtot = 0			lxCancompraRecmntosi = 0			lxCancompraSubtotsisi = 0			lxCancompraSubtotcisi = 0			lxCancompraRecmnto2 = 0			lxCancompraRecmnto1 = 0			lxCancompraDesauto = .F.			lxCancompraFcompfis = .F.			lxCancompraAnulado = .F.			lxCancompraHoraexpo = []			lxCancompraFhora = []			lxCancompraHaltafw = []			lxCancompraHmodifw = []			lxCancompraHoraimpo = []			lxCancompraSmodifw = []			lxCancompraZadsfw = []			lxCancompraDescfw = []			lxCancompraVmodifw = []			lxCancompraValtafw = []			lxCancompraUaltafw = []			lxCancompraUmodifw = []			lxCancompraSaltafw = []			lxCancompraBdaltafw = []			lxCancompraSimbmon = []			lxCancompraBdmodifw = []			lxCancompraEsttrans = []			lxCancompraTcrg1361 = 0			lxCancompraIdvuelto = []			lxCancompraCodigo = []			lxCancompraMoneda = []			lxCancompraMonsis = []			lxCancompraFmtdes1 = 0			lxCancompraFdescu = 0			lxCancompraFmtdes2 = 0			lxCancompraFletra = []			lxCancompraFimpuesto = 0			lxCancompraFobs = []			lxCancompraFfchfac = ctod( '  /  /    ' )			lxCancompraFptoven = 0			lxCancompraDesmntosi3 = 0			lxCancompraFmtdes3 = 0			lxCancompraRecpor = 0			lxCancompraFnumcomp = 0			lxCancompraTotdescsi = 0			lxCancompraFfch = ctod( '  /  /    ' )			lxCancompraMr = 0			lxCancompraNcai = 0			lxCancompraRecmnto = 0			lxCancompraFperson = []			lxCancompraFvtocai = ctod( '  /  /    ' )			lxCancompraFvuelto = 0			lxCancompraCodlista = []			lxCancompraFtotal = 0			lxCancompraRecmonto1 = 0			lxCancompraRecmonto2 = 0			lxCancompraMotivo = []			lxCancompraNroremito = []			lxCancompraCotiz = 0			lxCancompraTotimpue = 0			lxCancompraTotrecar = 0			lxCancompraTotrecarsi = 0			lxCancompraTotdesc = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CANCOMPRADET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpCanComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpCanC where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CANCOMPRA where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CANCOMPRA' + '_' + tcCampo
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
		lcWhere = " Where  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaexpo" as "Horaexpo", "Fhora" as "Hora", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Nroremito" as "Remito", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CANCOMPRA', '', tnTope )
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
		lcWhere = " Where  CANCOMPRADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afesaldo" as "Afe_saldo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Mntptot" as "Montoprorrateototal", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Prunconimp" as "Precioconimpuestos", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleFacturaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CANCOMPRADET', 'FacturaDetalle', tnTope )
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
		lcWhere = " Where  IMPCANCOMP.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpCanComp', 'ImpuestosDetalle', tnTope )
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
		lcWhere = " Where  IMPCANC.CCOD != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpCanC', 'ImpuestosComprobante', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
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
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCPRO AS SITUACIONFISCAL'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUTO AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'TIPOCOMPROBANTERG1361'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCRG1361 AS TIPOCOMPROBANTERG1361'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
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
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR AS RECARGOMONTO'
				Case lcAtributo == 'CAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCAI AS CAI'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO AS RECARGOMONTOCONIMPUESTOS'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS PROVEEDOR'
				Case lcAtributo == 'FECHAVTOCAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVTOCAI AS FECHAVTOCAI'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO1 AS RECARGOMONTO1'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO2 AS RECARGOMONTO2'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREMITO AS REMITO'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
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
	Function ObtenerCamposSelectDetalleFacturaDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'AFE_LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS AFE_LETRA'
				Case lcAtributo == 'AFE_NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENUMCOM AS AFE_NUMERO'
				Case lcAtributo == 'AFE_PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS AFE_PUNTODEVENTA'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'ARTICULO_CONDICIONIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAC AS ARTICULO_CONDICIONIVACOMPRAS'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAC AS ARTICULO_PORCENTAJEIVACOMPRAS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
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
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'AFE_NUMINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINT AS AFE_NUMINT'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
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
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
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
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMATE AS MATERIAL'
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
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTALL AS TALLE'
				Case lcAtributo == 'MONTOPRORRATEOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPIVA AS MONTOPRORRATEOIVA'
				Case lcAtributo == 'IDSENIACANCELADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIACANCE AS IDSENIACANCELADA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCPRO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTERG1361'
				lcCampo = 'TCRG1361'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'MR'
			Case upper( alltrim( tcAtributo ) ) == 'CAI'
				lcCampo = 'NCAI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS'
				lcCampo = 'RECMNTO'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOCAI'
				lcCampo = 'FVTOCAI'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'RECMONTO1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'RECMONTO2'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'NROREMITO'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
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
	Function ObtenerCampoDetalleFacturaDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'AFE_LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NUMERO'
				lcCampo = 'AFENUMCOM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVACOMPRAS'
				lcCampo = 'ACONDIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVACOMPRAS'
				lcCampo = 'APORCIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
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
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NUMINT'
				lcCampo = 'NUMINT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
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
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
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
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'FAMATE'
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
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'FTALL'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIVA'
				lcCampo = 'MNTPIVA'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIACANCELADA'
				lcCampo = 'SENIACANCE'
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
			lcRetorno = 'CANCOMPRADET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPCANCOMP'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPCANC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCancompraFecexpo, lxCancompraFaltafw, lxCancompraFmodifw, lxCancompraFecimpo, lxCancompraFd2, lxCancompraFectrans, lxCancompraFcuit, lxCancompraIdcaja, lxCancompraFpodes1, lxCancompraFpodes2, lxCancompraFpodes, lxCancompraFturno, lxCancompraTimestamp, lxCancompraDesmntosi1, lxCancompraDesmntosi, lxCancompraDesmntosi2, lxCancompraTotalcant, lxCancompraRecmntosi2, lxCancompraSignomov, lxCancompraFacttipo, lxCancompraRecmntosi1, lxCancompraFsubton, lxCancompraSitfiscpro, lxCancompraCondivalp, lxCancompraFsubtot, lxCancompraRecmntosi, lxCancompraSubtotsisi, lxCancompraSubtotcisi, lxCancompraRecmnto2, lxCancompraRecmnto1, lxCancompraDesauto, lxCancompraFcompfis, lxCancompraAnulado, lxCancompraHoraexpo, lxCancompraFhora, lxCancompraHaltafw, lxCancompraHmodifw, lxCancompraHoraimpo, lxCancompraSmodifw, lxCancompraZadsfw, lxCancompraDescfw, lxCancompraVmodifw, lxCancompraValtafw, lxCancompraUaltafw, lxCancompraUmodifw, lxCancompraSaltafw, lxCancompraBdaltafw, lxCancompraSimbmon, lxCancompraBdmodifw, lxCancompraEsttrans, lxCancompraTcrg1361, lxCancompraIdvuelto, lxCancompraCodigo, lxCancompraMoneda, lxCancompraMonsis, lxCancompraFmtdes1, lxCancompraFdescu, lxCancompraFmtdes2, lxCancompraFletra, lxCancompraFimpuesto, lxCancompraFobs, lxCancompraFfchfac, lxCancompraFptoven, lxCancompraDesmntosi3, lxCancompraFmtdes3, lxCancompraRecpor, lxCancompraFnumcomp, lxCancompraTotdescsi, lxCancompraFfch, lxCancompraMr, lxCancompraNcai, lxCancompraRecmnto, lxCancompraFperson, lxCancompraFvtocai, lxCancompraFvuelto, lxCancompraCodlista, lxCancompraFtotal, lxCancompraRecmonto1, lxCancompraRecmonto2, lxCancompraMotivo, lxCancompraNroremito, lxCancompraCotiz, lxCancompraTotimpue, lxCancompraTotrecar, lxCancompraTotrecarsi, lxCancompraTotdesc
				lxCancompraFecexpo =  .Fechaexpo			lxCancompraFaltafw =  .Fechaaltafw			lxCancompraFmodifw =  .Fechamodificacionfw			lxCancompraFecimpo =  .Fechaimpo			lxCancompraFd2 =  .Fechamodificacion			lxCancompraFectrans =  .Fechatransferencia			lxCancompraFcuit =  .Cuit			lxCancompraIdcaja =  .Caja_PK 			lxCancompraFpodes1 =  .Porcentajedescuento1			lxCancompraFpodes2 =  .Porcentajedescuento2			lxCancompraFpodes =  .Porcentajedescuento			lxCancompraFturno =  .Turno			lxCancompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCancompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxCancompraDesmntosi =  .Montodescuentosinimpuestos			lxCancompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxCancompraTotalcant =  .Totalcantidad			lxCancompraRecmntosi2 =  .Recargomontosinimpuestos2			lxCancompraSignomov =  .Signodemovimiento			lxCancompraFacttipo =  .Tipocomprobante			lxCancompraRecmntosi1 =  .Recargomontosinimpuestos1			lxCancompraFsubton =  .Subtotalneto			lxCancompraSitfiscpro =  .Situacionfiscal_PK 			lxCancompraCondivalp =  .Condicioniva			lxCancompraFsubtot =  .Subtotalbruto			lxCancompraRecmntosi =  .Recargomontosinimpuestos			lxCancompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxCancompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxCancompraRecmnto2 =  .Recargomontoconimpuestos2			lxCancompraRecmnto1 =  .Recargomontoconimpuestos1			lxCancompraDesauto =  .Descuentoautomatico			lxCancompraFcompfis =  .Comprobantefiscal			lxCancompraAnulado =  .Anulado			lxCancompraHoraexpo =  .Horaexpo			lxCancompraFhora =  .Hora			lxCancompraHaltafw =  .Horaaltafw			lxCancompraHmodifw =  .Horamodificacionfw			lxCancompraHoraimpo =  .Horaimpo			lxCancompraSmodifw =  .Seriemodificacionfw			lxCancompraZadsfw =  .Zadsfw			lxCancompraDescfw =  .Descripcionfw			lxCancompraVmodifw =  .Versionmodificacionfw			lxCancompraValtafw =  .Versionaltafw			lxCancompraUaltafw =  .Usuarioaltafw			lxCancompraUmodifw =  .Usuariomodificacionfw			lxCancompraSaltafw =  .Seriealtafw			lxCancompraBdaltafw =  .Basededatosaltafw			lxCancompraSimbmon =  .Simbolomonetariocomprobante			lxCancompraBdmodifw =  .Basededatosmodificacionfw			lxCancompraEsttrans =  .Estadotransferencia			lxCancompraTcrg1361 =  .Tipocomprobanterg1361			lxCancompraIdvuelto =  upper( .IdVuelto_PK ) 			lxCancompraCodigo =  .Codigo			lxCancompraMoneda =  upper( .MonedaComprobante_PK ) 			lxCancompraMonsis =  upper( .MonedaSistema_PK ) 			lxCancompraFmtdes1 =  .Montodescuentoconimpuestos1			lxCancompraFdescu =  .Descuento			lxCancompraFmtdes2 =  .Montodescuentoconimpuestos2			lxCancompraFletra =  .Letra			lxCancompraFimpuesto =  .Impuestos			lxCancompraFobs =  .Obs			lxCancompraFfchfac =  .Fechafactura			lxCancompraFptoven =  .Puntodeventa			lxCancompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxCancompraFmtdes3 =  .Montodescuentoconimpuestos3			lxCancompraRecpor =  .Recargoporcentaje			lxCancompraFnumcomp =  .Numero			lxCancompraTotdescsi =  .Totaldescuentossinimpuestos			lxCancompraFfch =  .Fecha			lxCancompraMr =  .Recargomonto			lxCancompraNcai =  .Cai			lxCancompraRecmnto =  .Recargomontoconimpuestos			lxCancompraFperson =  upper( .Proveedor_PK ) 			lxCancompraFvtocai =  .Fechavtocai			lxCancompraFvuelto =  .Vuelto			lxCancompraCodlista =  upper( .ListaDePrecios_PK ) 			lxCancompraFtotal =  .Total			lxCancompraRecmonto1 =  .Recargomonto1			lxCancompraRecmonto2 =  .Recargomonto2			lxCancompraMotivo =  upper( .Motivo_PK ) 			lxCancompraNroremito =  .Remito			lxCancompraCotiz =  .Cotizacion			lxCancompraTotimpue =  .Totalimpuestos			lxCancompraTotrecar =  .Totalrecargos			lxCancompraTotrecarsi =  .Totalrecargossinimpuestos			lxCancompraTotdesc =  .Totaldescuentos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CANCOMPRA ( "Fecexpo","Faltafw","Fmodifw","Fecimpo","Fd2","Fectrans","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fturno","Timestamp","Desmntosi1","Desmntosi","Desmntosi2","Totalcant","Recmntosi2","Signomov","Facttipo","Recmntosi1","Fsubton","Sitfiscpro","Condivalp","Fsubtot","Recmntosi","Subtotsisi","Subtotcisi","Recmnto2","Recmnto1","Desauto","Fcompfis","Anulado","Horaexpo","Fhora","Haltafw","Hmodifw","Horaimpo","Smodifw","Zadsfw","Descfw","Vmodifw","Valtafw","Ualtafw","Umodifw","Saltafw","Bdaltafw","Simbmon","Bdmodifw","Esttrans","Tcrg1361","Idvuelto","Codigo","Moneda","Monsis","Fmtdes1","Fdescu","Fmtdes2","Fletra","Fimpuesto","Fobs","Ffchfac","Fptoven","Desmntosi3","Fmtdes3","Recpor","Fnumcomp","Totdescsi","Ffch","Mr","Ncai","Recmnto","Fperson","Fvtocai","Fvuelto","Codlista","Ftotal","Recmonto1","Recmonto2","Motivo","Nroremito","Cotiz","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxCancompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraFcuit ) + "'" >>, <<lxCancompraIdcaja >>, <<lxCancompraFpodes1 >>, <<lxCancompraFpodes2 >>, <<lxCancompraFpodes >>, <<lxCancompraFturno >>, <<lxCancompraTimestamp >>, <<lxCancompraDesmntosi1 >>, <<lxCancompraDesmntosi >>, <<lxCancompraDesmntosi2 >>, <<lxCancompraTotalcant >>, <<lxCancompraRecmntosi2 >>, <<lxCancompraSignomov >>, <<lxCancompraFacttipo >>, <<lxCancompraRecmntosi1 >>, <<lxCancompraFsubton >>, <<lxCancompraSitfiscpro >>, <<lxCancompraCondivalp >>, <<lxCancompraFsubtot >>, <<lxCancompraRecmntosi >>, <<lxCancompraSubtotsisi >>, <<lxCancompraSubtotcisi >>, <<lxCancompraRecmnto2 >>, <<lxCancompraRecmnto1 >>, <<iif( lxCancompraDesauto, 1, 0 ) >>, <<iif( lxCancompraFcompfis, 1, 0 ) >>, <<iif( lxCancompraAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCancompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraEsttrans ) + "'" >>, <<lxCancompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxCancompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraMonsis ) + "'" >>, <<lxCancompraFmtdes1 >>, <<lxCancompraFdescu >>, <<lxCancompraFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxCancompraFletra ) + "'" >>, <<lxCancompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxCancompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFfchfac ) + "'" >>, <<lxCancompraFptoven >>, <<lxCancompraDesmntosi3 >>, <<lxCancompraFmtdes3 >>, <<lxCancompraRecpor >>, <<lxCancompraFnumcomp >>, <<lxCancompraTotdescsi >>, <<"'" + this.ConvertirDateSql( lxCancompraFfch ) + "'" >>, <<lxCancompraMr >>, <<lxCancompraNcai >>, <<lxCancompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxCancompraFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCancompraFvtocai ) + "'" >>, <<lxCancompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxCancompraCodlista ) + "'" >>, <<lxCancompraFtotal >>, <<lxCancompraRecmonto1 >>, <<lxCancompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxCancompraMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCancompraNroremito ) + "'" >>, <<lxCancompraCotiz >>, <<lxCancompraTotimpue >>, <<lxCancompraTotrecar >>, <<lxCancompraTotrecarsi >>, <<lxCancompraTotdesc >> )
		endtext
		loColeccion.cTabla = 'CANCOMPRA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_saldo = loItem.Afe_saldo
					lxAfe_timestamp = loItem.Afe_timestamp
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_numint = loItem.Afe_numint
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNroitem = lnContadorNroItem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxIditem = loItem.Iditem
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CANCOMPRADET("AfeLETRA","AfeNUMCOM","AfePTOVEN","MNTPRECCI","AfeSaldo","AfeTS","AfeCANT","ACondIvaC","MNTPTOT","APorcIvaC","MNTPDESSI","MNTPPER","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","NumInt","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","FNETO","FporCFI","FX2","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","NroItem","fporIva","prunconimp","AfeNroItem","iditemOrig","FN11","ciditem","FPRUN","Prunsinimp","ProcStock","UsarPLista","IdItem","afe_Cod","FAMate","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_saldo>>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxArticulo_condicionivacompras>>, <<lxMontoprorrateototal>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_numint>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxPrecioconimpuestos>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxIditem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpCanComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
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
						Insert into ZooLogic.ImpCanC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxCancompraFecexpo, lxCancompraFaltafw, lxCancompraFmodifw, lxCancompraFecimpo, lxCancompraFd2, lxCancompraFectrans, lxCancompraFcuit, lxCancompraIdcaja, lxCancompraFpodes1, lxCancompraFpodes2, lxCancompraFpodes, lxCancompraFturno, lxCancompraTimestamp, lxCancompraDesmntosi1, lxCancompraDesmntosi, lxCancompraDesmntosi2, lxCancompraTotalcant, lxCancompraRecmntosi2, lxCancompraSignomov, lxCancompraFacttipo, lxCancompraRecmntosi1, lxCancompraFsubton, lxCancompraSitfiscpro, lxCancompraCondivalp, lxCancompraFsubtot, lxCancompraRecmntosi, lxCancompraSubtotsisi, lxCancompraSubtotcisi, lxCancompraRecmnto2, lxCancompraRecmnto1, lxCancompraDesauto, lxCancompraFcompfis, lxCancompraAnulado, lxCancompraHoraexpo, lxCancompraFhora, lxCancompraHaltafw, lxCancompraHmodifw, lxCancompraHoraimpo, lxCancompraSmodifw, lxCancompraZadsfw, lxCancompraDescfw, lxCancompraVmodifw, lxCancompraValtafw, lxCancompraUaltafw, lxCancompraUmodifw, lxCancompraSaltafw, lxCancompraBdaltafw, lxCancompraSimbmon, lxCancompraBdmodifw, lxCancompraEsttrans, lxCancompraTcrg1361, lxCancompraIdvuelto, lxCancompraCodigo, lxCancompraMoneda, lxCancompraMonsis, lxCancompraFmtdes1, lxCancompraFdescu, lxCancompraFmtdes2, lxCancompraFletra, lxCancompraFimpuesto, lxCancompraFobs, lxCancompraFfchfac, lxCancompraFptoven, lxCancompraDesmntosi3, lxCancompraFmtdes3, lxCancompraRecpor, lxCancompraFnumcomp, lxCancompraTotdescsi, lxCancompraFfch, lxCancompraMr, lxCancompraNcai, lxCancompraRecmnto, lxCancompraFperson, lxCancompraFvtocai, lxCancompraFvuelto, lxCancompraCodlista, lxCancompraFtotal, lxCancompraRecmonto1, lxCancompraRecmonto2, lxCancompraMotivo, lxCancompraNroremito, lxCancompraCotiz, lxCancompraTotimpue, lxCancompraTotrecar, lxCancompraTotrecarsi, lxCancompraTotdesc
				lxCancompraFecexpo =  .Fechaexpo			lxCancompraFaltafw =  .Fechaaltafw			lxCancompraFmodifw =  .Fechamodificacionfw			lxCancompraFecimpo =  .Fechaimpo			lxCancompraFd2 =  .Fechamodificacion			lxCancompraFectrans =  .Fechatransferencia			lxCancompraFcuit =  .Cuit			lxCancompraIdcaja =  .Caja_PK 			lxCancompraFpodes1 =  .Porcentajedescuento1			lxCancompraFpodes2 =  .Porcentajedescuento2			lxCancompraFpodes =  .Porcentajedescuento			lxCancompraFturno =  .Turno			lxCancompraTimestamp = goLibrerias.ObtenerTimestamp()			lxCancompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxCancompraDesmntosi =  .Montodescuentosinimpuestos			lxCancompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxCancompraTotalcant =  .Totalcantidad			lxCancompraRecmntosi2 =  .Recargomontosinimpuestos2			lxCancompraSignomov =  .Signodemovimiento			lxCancompraFacttipo =  .Tipocomprobante			lxCancompraRecmntosi1 =  .Recargomontosinimpuestos1			lxCancompraFsubton =  .Subtotalneto			lxCancompraSitfiscpro =  .Situacionfiscal_PK 			lxCancompraCondivalp =  .Condicioniva			lxCancompraFsubtot =  .Subtotalbruto			lxCancompraRecmntosi =  .Recargomontosinimpuestos			lxCancompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxCancompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxCancompraRecmnto2 =  .Recargomontoconimpuestos2			lxCancompraRecmnto1 =  .Recargomontoconimpuestos1			lxCancompraDesauto =  .Descuentoautomatico			lxCancompraFcompfis =  .Comprobantefiscal			lxCancompraAnulado =  .Anulado			lxCancompraHoraexpo =  .Horaexpo			lxCancompraFhora =  .Hora			lxCancompraHaltafw =  .Horaaltafw			lxCancompraHmodifw =  .Horamodificacionfw			lxCancompraHoraimpo =  .Horaimpo			lxCancompraSmodifw =  .Seriemodificacionfw			lxCancompraZadsfw =  .Zadsfw			lxCancompraDescfw =  .Descripcionfw			lxCancompraVmodifw =  .Versionmodificacionfw			lxCancompraValtafw =  .Versionaltafw			lxCancompraUaltafw =  .Usuarioaltafw			lxCancompraUmodifw =  .Usuariomodificacionfw			lxCancompraSaltafw =  .Seriealtafw			lxCancompraBdaltafw =  .Basededatosaltafw			lxCancompraSimbmon =  .Simbolomonetariocomprobante			lxCancompraBdmodifw =  .Basededatosmodificacionfw			lxCancompraEsttrans =  .Estadotransferencia			lxCancompraTcrg1361 =  .Tipocomprobanterg1361			lxCancompraIdvuelto =  upper( .IdVuelto_PK ) 			lxCancompraCodigo =  .Codigo			lxCancompraMoneda =  upper( .MonedaComprobante_PK ) 			lxCancompraMonsis =  upper( .MonedaSistema_PK ) 			lxCancompraFmtdes1 =  .Montodescuentoconimpuestos1			lxCancompraFdescu =  .Descuento			lxCancompraFmtdes2 =  .Montodescuentoconimpuestos2			lxCancompraFletra =  .Letra			lxCancompraFimpuesto =  .Impuestos			lxCancompraFobs =  .Obs			lxCancompraFfchfac =  .Fechafactura			lxCancompraFptoven =  .Puntodeventa			lxCancompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxCancompraFmtdes3 =  .Montodescuentoconimpuestos3			lxCancompraRecpor =  .Recargoporcentaje			lxCancompraFnumcomp =  .Numero			lxCancompraTotdescsi =  .Totaldescuentossinimpuestos			lxCancompraFfch =  .Fecha			lxCancompraMr =  .Recargomonto			lxCancompraNcai =  .Cai			lxCancompraRecmnto =  .Recargomontoconimpuestos			lxCancompraFperson =  upper( .Proveedor_PK ) 			lxCancompraFvtocai =  .Fechavtocai			lxCancompraFvuelto =  .Vuelto			lxCancompraCodlista =  upper( .ListaDePrecios_PK ) 			lxCancompraFtotal =  .Total			lxCancompraRecmonto1 =  .Recargomonto1			lxCancompraRecmonto2 =  .Recargomonto2			lxCancompraMotivo =  upper( .Motivo_PK ) 			lxCancompraNroremito =  .Remito			lxCancompraCotiz =  .Cotizacion			lxCancompraTotimpue =  .Totalimpuestos			lxCancompraTotrecar =  .Totalrecargos			lxCancompraTotrecarsi =  .Totalrecargossinimpuestos			lxCancompraTotdesc =  .Totaldescuentos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44]
			text to lcSentencia noshow textmerge
				update ZooLogic.CANCOMPRA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCancompraFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCancompraFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCancompraFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCancompraFecimpo ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxCancompraFd2 ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCancompraFectrans ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxCancompraFcuit ) + "'">>, "Idcaja" = <<lxCancompraIdcaja>>, "Fpodes1" = <<lxCancompraFpodes1>>, "Fpodes2" = <<lxCancompraFpodes2>>, "Fpodes" = <<lxCancompraFpodes>>, "Fturno" = <<lxCancompraFturno>>, "Timestamp" = <<lxCancompraTimestamp>>, "Desmntosi1" = <<lxCancompraDesmntosi1>>, "Desmntosi" = <<lxCancompraDesmntosi>>, "Desmntosi2" = <<lxCancompraDesmntosi2>>, "Totalcant" = <<lxCancompraTotalcant>>, "Recmntosi2" = <<lxCancompraRecmntosi2>>, "Signomov" = <<lxCancompraSignomov>>, "Facttipo" = <<lxCancompraFacttipo>>, "Recmntosi1" = <<lxCancompraRecmntosi1>>, "Fsubton" = <<lxCancompraFsubton>>, "Sitfiscpro" = <<lxCancompraSitfiscpro>>, "Condivalp" = <<lxCancompraCondivalp>>, "Fsubtot" = <<lxCancompraFsubtot>>, "Recmntosi" = <<lxCancompraRecmntosi>>, "Subtotsisi" = <<lxCancompraSubtotsisi>>, "Subtotcisi" = <<lxCancompraSubtotcisi>>, "Recmnto2" = <<lxCancompraRecmnto2>>, "Recmnto1" = <<lxCancompraRecmnto1>>, "Desauto" = <<iif( lxCancompraDesauto, 1, 0 )>>, "Fcompfis" = <<iif( lxCancompraFcompfis, 1, 0 )>>, "Anulado" = <<iif( lxCancompraAnulado, 1, 0 )>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCancompraHoraexpo ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxCancompraFhora ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCancompraHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCancompraHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCancompraHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCancompraSmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCancompraZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCancompraDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCancompraVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCancompraValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCancompraUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCancompraUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCancompraSaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCancompraBdaltafw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxCancompraSimbmon ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCancompraBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCancompraEsttrans ) + "'">>, "Tcrg1361" = <<lxCancompraTcrg1361>>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxCancompraIdvuelto ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCancompraCodigo ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxCancompraMoneda ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxCancompraMonsis ) + "'">>, "Fmtdes1" = <<lxCancompraFmtdes1>>, "Fdescu" = <<lxCancompraFdescu>>, "Fmtdes2" = <<lxCancompraFmtdes2>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxCancompraFletra ) + "'">>, "Fimpuesto" = <<lxCancompraFimpuesto>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxCancompraFobs ) + "'">>, "Ffchfac" = <<"'" + this.ConvertirDateSql( lxCancompraFfchfac ) + "'">>, "Fptoven" = <<lxCancompraFptoven>>, "Desmntosi3" = <<lxCancompraDesmntosi3>>, "Fmtdes3" = <<lxCancompraFmtdes3>>, "Recpor" = <<lxCancompraRecpor>>, "Fnumcomp" = <<lxCancompraFnumcomp>>, "Totdescsi" = <<lxCancompraTotdescsi>>, "Ffch" = <<"'" + this.ConvertirDateSql( lxCancompraFfch ) + "'">>, "Mr" = <<lxCancompraMr>>, "Ncai" = <<lxCancompraNcai>>, "Recmnto" = <<lxCancompraRecmnto>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxCancompraFperson ) + "'">>, "Fvtocai" = <<"'" + this.ConvertirDateSql( lxCancompraFvtocai ) + "'">>, "Fvuelto" = <<lxCancompraFvuelto>>, "Codlista" = <<"'" + this.FormatearTextoSql( lxCancompraCodlista ) + "'">>, "Ftotal" = <<lxCancompraFtotal>>, "Recmonto1" = <<lxCancompraRecmonto1>>, "Recmonto2" = <<lxCancompraRecmonto2>>, "Motivo" = <<"'" + this.FormatearTextoSql( lxCancompraMotivo ) + "'">>, "Nroremito" = <<"'" + this.FormatearTextoSql( lxCancompraNroremito ) + "'">>, "Cotiz" = <<lxCancompraCotiz>>, "Totimpue" = <<lxCancompraTotimpue>>, "Totrecar" = <<lxCancompraTotrecar>>, "Totrecarsi" = <<lxCancompraTotrecarsi>>, "Totdesc" = <<lxCancompraTotdesc>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CANCOMPRA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CANCOMPRADET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpCanComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpCanC where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_saldo = loItem.Afe_saldo
					lxAfe_timestamp = loItem.Afe_timestamp
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_numint = loItem.Afe_numint
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNroitem = lnContadorNroItem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxIditem = loItem.Iditem
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxIdseniacancelada = loItem.Idseniacancelada
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CANCOMPRADET("AfeLETRA","AfeNUMCOM","AfePTOVEN","MNTPRECCI","AfeSaldo","AfeTS","AfeCANT","ACondIvaC","MNTPTOT","APorcIvaC","MNTPDESSI","MNTPPER","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","NumInt","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","FNETO","FporCFI","FX2","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","NroItem","fporIva","prunconimp","AfeNroItem","iditemOrig","FN11","ciditem","FPRUN","Prunsinimp","ProcStock","UsarPLista","IdItem","afe_Cod","FAMate","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_saldo>>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxArticulo_condicionivacompras>>, <<lxMontoprorrateototal>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_numint>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxPrecioconimpuestos>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxIditem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpCanComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
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
						Insert into ZooLogic.ImpCanC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44]
		loColeccion.Agregar( 'delete from ZooLogic.CANCOMPRA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CANCOMPRADET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpCanComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpCanC where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CANCOMPRA' 
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
					"Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afesaldo" as "Afe_saldo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Mntptot" as "Montoprorrateototal", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Prunconimp" as "Precioconimpuestos", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
		return lcAtributos
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CANCOMPRA where  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CANCOMPRA where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCANCOMPRAFACTTIPO as variant, lxCanCompraFLETRA as variant, lxCanCompraFPTOVEN as variant, lxCanCompraFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDECOMPRA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CANCOMPRA Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.CANCOMPRA set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, SitFiscPro = ] + transform( &lcCursor..SitFiscPro )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, DesAuto = ] + Transform( iif( &lcCursor..DesAuto, 1, 0 ))+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, tcrg1361 = ] + transform( &lcCursor..tcrg1361 )+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FFCHFAC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, MR = ] + transform( &lcCursor..MR )+ [, NCAI = ] + transform( &lcCursor..NCAI )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FVTOCAI = ] + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'"+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, RecMonto1 = ] + transform( &lcCursor..RecMonto1 )+ [, RecMonto2 = ] + transform( &lcCursor..RecMonto2 )+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, NROREMITO = ] + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, totdesc = ] + transform( &lcCursor..totdesc ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CANCOMPRA Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FALTAFW, FMODIFW, FECIMPO, FD2, FECTRANS, fCuit, IdCaja, FPODES1, FPODES2, FPODES, FTurno, TIMESTAMP, DesMntoSI1, DesMntoSI, DesMntoSI2, TotalCant, RecMntoSI2, signomov, FACTTIPO, RecMntoSI1, fSubToN, SitFiscPro, CondivaLp, FSubTOT, RecMntoSI, SubTotSISI, SubTotCISI, RecMnto2, RecMnto1, DesAuto, FCOMPFIS, Anulado, HORAEXPO, FHORA, HALTAFW, HMODIFW, HORAIMPO, SMODIFW, ZADSFW, DescFW, VMODIFW, VALTAFW, UALTAFW, UMODIFW, SALTAFW, BDALTAFW, SimbMon, BDMODIFW, ESTTRANS, tcrg1361, idVuelto, CODIGO, Moneda, MonSis, FMTDES1, fDescu, FMTDES2, FLETRA, fImpuesto, FObs, FFCHFAC, FPTOVEN, DesMntoSI3, FMTDES3, RecPor, FNUMCOMP, totdescSI, FFCH, MR, NCAI, RecMnto, FPerson, FVTOCAI, FVuelto, CodLista, FTotal, RecMonto1, RecMonto2, MOTIVO, NROREMITO, Cotiz, totimpue, totrecar, totrecarSI, totdesc
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..FPODES1 ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..FTurno ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..DesMntoSI ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..TotalCant )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..SitFiscPro ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..RecMntoSI ) + ',' + transform( &lcCursor..SubTotSISI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + Transform( iif( &lcCursor..DesAuto, 1, 0 )) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..tcrg1361 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + transform( &lcCursor..FMTDES1 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..fDescu ) + ',' + transform( &lcCursor..FMTDES2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..fImpuesto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + transform( &lcCursor..FMTDES3 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..totdescSI ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..NCAI ) + ',' + transform( &lcCursor..RecMnto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FVuelto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + transform( &lcCursor..RecMonto1 ) + ',' + transform( &lcCursor..RecMonto2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..totimpue )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..totrecar ) + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..totdesc )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CANCOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDECOMPRA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CANCOMPRADET Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpCanComp Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpCanC Where cCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSCANCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeLETRA","AfeNUMCOM","AfePTOVEN","MNTPRECCI","AfeSaldo","AfeTS","AfeCANT","ACondIvaC","MNTPTOT","APorcIvaC","MNTPDESSI","MNTPPER","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","NumInt","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","FNETO","FporCFI","FX2","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","NroItem","fporIva","prunconimp","AfeNroItem","iditemOrig","FN11","ciditem","FPRUN","Prunsinimp","ProcStock","UsarPLista","IdItem","afe_Cod","FAMate","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CANCOMPRADET ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.ACondIvaC  ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.APorcIvaC  ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.NumInt     ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_Cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSCANC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpCanComp ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOCANCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpCanC ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.porcen     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'CANCELACIONDECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CANCELACIONDECOMPRA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CANCELACIONDECOMPRA_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSCANCOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSCANC'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOCANCOMPRA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CANCOMPRA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CANCELACIONDECOMPRA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CANCELACIONDECOMPRA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDECOMPRA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FFCHFAC   
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  FVTOCAI   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CANCOMPRA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CANCOMPRA
Create Table ZooLogic.TablaTrabajo_CANCOMPRA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fd2" datetime  null, 
"fectrans" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"fturno" numeric( 1, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"desmntosi1" numeric( 15, 2 )  null, 
"desmntosi" numeric( 15, 2 )  null, 
"desmntosi2" numeric( 15, 2 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"recmntosi2" numeric( 15, 2 )  null, 
"signomov" numeric( 2, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"recmntosi1" numeric( 15, 2 )  null, 
"fsubton" numeric( 15, 2 )  null, 
"sitfiscpro" numeric( 2, 0 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"fsubtot" numeric( 15, 2 )  null, 
"recmntosi" numeric( 15, 2 )  null, 
"subtotsisi" numeric( 15, 2 )  null, 
"subtotcisi" numeric( 15, 2 )  null, 
"recmnto2" numeric( 15, 2 )  null, 
"recmnto1" numeric( 15, 2 )  null, 
"desauto" bit  null, 
"fcompfis" bit  null, 
"anulado" bit  null, 
"horaexpo" char( 8 )  null, 
"fhora" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"bdaltafw" char( 8 )  null, 
"simbmon" char( 3 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"tcrg1361" numeric( 1, 0 )  null, 
"idvuelto" char( 5 )  null, 
"codigo" char( 38 )  null, 
"moneda" char( 10 )  null, 
"monsis" char( 10 )  null, 
"fmtdes1" numeric( 15, 2 )  null, 
"fdescu" numeric( 15, 2 )  null, 
"fmtdes2" numeric( 15, 2 )  null, 
"fletra" char( 1 )  null, 
"fimpuesto" numeric( 15, 2 )  null, 
"fobs" varchar(max)  null, 
"ffchfac" datetime  null, 
"fptoven" numeric( 4, 0 )  null, 
"desmntosi3" numeric( 15, 2 )  null, 
"fmtdes3" numeric( 6, 2 )  null, 
"recpor" numeric( 6, 2 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"totdescsi" numeric( 15, 2 )  null, 
"ffch" datetime  null, 
"mr" numeric( 15, 2 )  null, 
"ncai" numeric( 14, 0 )  null, 
"recmnto" numeric( 15, 2 )  null, 
"fperson" char( 5 )  null, 
"fvtocai" datetime  null, 
"fvuelto" numeric( 15, 2 )  null, 
"codlista" char( 6 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"recmonto1" numeric( 15, 2 )  null, 
"recmonto2" numeric( 15, 2 )  null, 
"motivo" char( 3 )  null, 
"nroremito" char( 16 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"totimpue" numeric( 15, 2 )  null, 
"totrecar" numeric( 15, 2 )  null, 
"totrecarsi" numeric( 15, 2 )  null, 
"totdesc" numeric( 15, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CANCOMPRA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CANCOMPRA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANCELACIONDECOMPRA'
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('sitfiscpro','sitfiscpro')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('desauto','desauto')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('tcrg1361','tcrg1361')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('monsis','monsis')
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
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('ncai','ncai')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fvtocai','fvtocai')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('recmonto1','recmonto1')
			.AgregarMapeo('recmonto2','recmonto2')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('nroremito','nroremito')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('totdesc','totdesc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CANCOMPRA'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.SITFISCPRO = isnull( d.SITFISCPRO, t.SITFISCPRO ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.DESAUTO = isnull( d.DESAUTO, t.DESAUTO ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.TCRG1361 = isnull( d.TCRG1361, t.TCRG1361 ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FFCHFAC = isnull( d.FFCHFAC, t.FFCHFAC ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.MR = isnull( d.MR, t.MR ),t.NCAI = isnull( d.NCAI, t.NCAI ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FVTOCAI = isnull( d.FVTOCAI, t.FVTOCAI ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.RECMONTO1 = isnull( d.RECMONTO1, t.RECMONTO1 ),t.RECMONTO2 = isnull( d.RECMONTO2, t.RECMONTO2 ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.NROREMITO = isnull( d.NROREMITO, t.NROREMITO ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC )
					from ZooLogic.CANCOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.CANCOMPRA(Fecexpo,Faltafw,Fmodifw,Fecimpo,Fd2,Fectrans,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fturno,Timestamp,Desmntosi1,Desmntosi,Desmntosi2,Totalcant,Recmntosi2,Signomov,Facttipo,Recmntosi1,Fsubton,Sitfiscpro,Condivalp,Fsubtot,Recmntosi,Subtotsisi,Subtotcisi,Recmnto2,Recmnto1,Desauto,Fcompfis,Anulado,Horaexpo,Fhora,Haltafw,Hmodifw,Horaimpo,Smodifw,Zadsfw,Descfw,Vmodifw,Valtafw,Ualtafw,Umodifw,Saltafw,Bdaltafw,Simbmon,Bdmodifw,Esttrans,Tcrg1361,Idvuelto,Codigo,Moneda,Monsis,Fmtdes1,Fdescu,Fmtdes2,Fletra,Fimpuesto,Fobs,Ffchfac,Fptoven,Desmntosi3,Fmtdes3,Recpor,Fnumcomp,Totdescsi,Ffch,Mr,Ncai,Recmnto,Fperson,Fvtocai,Fvuelto,Codlista,Ftotal,Recmonto1,Recmonto2,Motivo,Nroremito,Cotiz,Totimpue,Totrecar,Totrecarsi,Totdesc)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FD2,''),isnull( d.FECTRANS,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FPODES1,0),isnull( d.FPODES2,0),isnull( d.FPODES,0),isnull( d.FTURNO,0),isnull( d.TIMESTAMP,0),isnull( d.DESMNTOSI1,0),isnull( d.DESMNTOSI,0),isnull( d.DESMNTOSI2,0),isnull( d.TOTALCANT,0),isnull( d.RECMNTOSI2,0),isnull( d.SIGNOMOV,0),isnull( d.FACTTIPO,0),isnull( d.RECMNTOSI1,0),isnull( d.FSUBTON,0),isnull( d.SITFISCPRO,0),isnull( d.CONDIVALP,0),isnull( d.FSUBTOT,0),isnull( d.RECMNTOSI,0),isnull( d.SUBTOTSISI,0),isnull( d.SUBTOTCISI,0),isnull( d.RECMNTO2,0),isnull( d.RECMNTO1,0),isnull( d.DESAUTO,0),isnull( d.FCOMPFIS,0),isnull( d.ANULADO,0),isnull( d.HORAEXPO,''),isnull( d.FHORA,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.BDALTAFW,''),isnull( d.SIMBMON,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.TCRG1361,0),isnull( d.IDVUELTO,''),isnull( d.CODIGO,''),isnull( d.MONEDA,''),isnull( d.MONSIS,''),isnull( d.FMTDES1,0),isnull( d.FDESCU,0),isnull( d.FMTDES2,0),isnull( d.FLETRA,''),isnull( d.FIMPUESTO,0),isnull( d.FOBS,''),isnull( d.FFCHFAC,''),isnull( d.FPTOVEN,0),isnull( d.DESMNTOSI3,0),isnull( d.FMTDES3,0),isnull( d.RECPOR,0),isnull( d.FNUMCOMP,0),isnull( d.TOTDESCSI,0),isnull( d.FFCH,''),isnull( d.MR,0),isnull( d.NCAI,0),isnull( d.RECMNTO,0),isnull( d.FPERSON,''),isnull( d.FVTOCAI,''),isnull( d.FVUELTO,0),isnull( d.CODLISTA,''),isnull( d.FTOTAL,0),isnull( d.RECMONTO1,0),isnull( d.RECMONTO2,0),isnull( d.MOTIVO,''),isnull( d.NROREMITO,''),isnull( d.COTIZ,0),isnull( d.TOTIMPUE,0),isnull( d.TOTRECAR,0),isnull( d.TOTRECARSI,0),isnull( d.TOTDESC,0)
						From deleted d left join ZooLogic.CANCOMPRA pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.CANCOMPRA cc 
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
					from ZooLogic.CANCOMPRA t inner join deleted d 
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
					from ZooLogic.CANCOMPRA t inner join deleted d 
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
	function ObtenerTriggerDeleteImportacion_CANCOMPRADET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CANCOMPRA_CANCOMPRADET
ON ZooLogic.TablaTrabajo_CANCOMPRA_CANCOMPRADET
AFTER DELETE
As
Begin
Update t Set 
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.ACONDIVAC = isnull( d.ACONDIVAC, t.ACONDIVAC ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.APORCIVAC = isnull( d.APORCIVAC, t.APORCIVAC ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.COMP = isnull( d.COMP, t.COMP ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.NUMINT = isnull( d.NUMINT, t.NUMINT ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.FAMATE = isnull( d.FAMATE, t.FAMATE ),
t.FART = isnull( d.FART, t.FART ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.FTXT = isnull( d.FTXT, t.FTXT ),
t.FCOLO = isnull( d.FCOLO, t.FCOLO ),
t.FCOTXT = isnull( d.FCOTXT, t.FCOTXT ),
t.FTALL = isnull( d.FTALL, t.FTALL ),
t.MNTPIVA = isnull( d.MNTPIVA, t.MNTPIVA ),
t.SENIACANCE = isnull( d.SENIACANCE, t.SENIACANCE ),
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.CANCOMPRADET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CANCOMPRADET
( 
"AFELETRA",
"AFENUMCOM",
"AFEPTOVEN",
"MNTPRECCI",
"AFESALDO",
"AFETS",
"AFECANT",
"ACONDIVAC",
"MNTPTOT",
"APORCIVAC",
"MNTPDESSI",
"MNTPPER",
"AJUSIMP",
"AJUCIMP",
"COMP",
"FBRUTO",
"ARTPERCEP",
"MNDESSI",
"NUMINT",
"MNTPRECSI",
"MNPDSI",
"MNTPDESCI",
"MNDESCI",
"AFETIPOCOM",
"FNETO",
"FPORCFI",
"FX2",
"FMTOIVA",
"FMTOCFI",
"FMTODTO1",
"FCFITOT",
"FKIT",
"FPORDTO1",
"NROITEM",
"FPORIVA",
"PRUNCONIMP",
"AFENROITEM",
"IDITEMORIG",
"FN11",
"CIDITEM",
"FPRUN",
"PRUNSINIMP",
"PROCSTOCK",
"USARPLISTA",
"IDITEM",
"AFE_COD",
"FAMATE",
"FART",
"CODIGO",
"FUNID",
"EQUIV",
"FTXT",
"FCOLO",
"FCOTXT",
"FTALL",
"MNTPIVA",
"SENIACANCE",
"FCANT",
"FPRECIO",
"FCFI",
"MNTDES",
"FMONTO"
 )
Select 
d.AFELETRA,
d.AFENUMCOM,
d.AFEPTOVEN,
d.MNTPRECCI,
d.AFESALDO,
d.AFETS,
d.AFECANT,
d.ACONDIVAC,
d.MNTPTOT,
d.APORCIVAC,
d.MNTPDESSI,
d.MNTPPER,
d.AJUSIMP,
d.AJUCIMP,
d.COMP,
d.FBRUTO,
d.ARTPERCEP,
d.MNDESSI,
d.NUMINT,
d.MNTPRECSI,
d.MNPDSI,
d.MNTPDESCI,
d.MNDESCI,
d.AFETIPOCOM,
d.FNETO,
d.FPORCFI,
d.FX2,
d.FMTOIVA,
d.FMTOCFI,
d.FMTODTO1,
d.FCFITOT,
d.FKIT,
d.FPORDTO1,
d.NROITEM,
d.FPORIVA,
d.PRUNCONIMP,
d.AFENROITEM,
d.IDITEMORIG,
d.FN11,
d.CIDITEM,
d.FPRUN,
d.PRUNSINIMP,
d.PROCSTOCK,
d.USARPLISTA,
d.IDITEM,
d.AFE_COD,
d.FAMATE,
d.FART,
d.CODIGO,
d.FUNID,
d.EQUIV,
d.FTXT,
d.FCOLO,
d.FCOTXT,
d.FTALL,
d.MNTPIVA,
d.SENIACANCE,
d.FCANT,
d.FPRECIO,
d.FCFI,
d.MNTDES,
d.FMONTO
From deleted d left join ZooLogic.CANCOMPRADET pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpCanComp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CANCOMPRA_ImpCanComp
ON ZooLogic.TablaTrabajo_CANCOMPRA_ImpCanComp
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
from ZooLogic.ImpCanComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpCanComp
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
From deleted d left join ZooLogic.ImpCanComp pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpCanC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CANCOMPRA_ImpCanC
ON ZooLogic.TablaTrabajo_CANCOMPRA_ImpCanC
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
from ZooLogic.ImpCanC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpCanC
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
From deleted d left join ZooLogic.ImpCanC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CANCOMPRA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CANCOMPRA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CANCELACIONDECOMPRA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDECOMPRA.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_CANCELACIONDECOMPRA.Cuit, [] )
					.Caja_PK =  nvl( c_CANCELACIONDECOMPRA.Caja, 0 )
					.Porcentajedescuento1 = nvl( c_CANCELACIONDECOMPRA.Porcentajedescuento1, 0 )
					.Porcentajedescuento2 = nvl( c_CANCELACIONDECOMPRA.Porcentajedescuento2, 0 )
					.Porcentajedescuento = nvl( c_CANCELACIONDECOMPRA.Porcentajedescuento, 0 )
					.Turno = nvl( c_CANCELACIONDECOMPRA.Turno, 0 )
					.Timestamp = nvl( c_CANCELACIONDECOMPRA.Timestamp, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_CANCELACIONDECOMPRA.Montodescuentosinimpuestos1, 0 )
					.Montodescuentosinimpuestos = nvl( c_CANCELACIONDECOMPRA.Montodescuentosinimpuestos, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_CANCELACIONDECOMPRA.Montodescuentosinimpuestos2, 0 )
					.Totalcantidad = nvl( c_CANCELACIONDECOMPRA.Totalcantidad, 0 )
					.Recargomontosinimpuestos2 = nvl( c_CANCELACIONDECOMPRA.Recargomontosinimpuestos2, 0 )
					.Signodemovimiento = nvl( c_CANCELACIONDECOMPRA.Signodemovimiento, 0 )
					.Tipocomprobante = nvl( c_CANCELACIONDECOMPRA.Tipocomprobante, 0 )
					.Recargomontosinimpuestos1 = nvl( c_CANCELACIONDECOMPRA.Recargomontosinimpuestos1, 0 )
					.Subtotalneto = nvl( c_CANCELACIONDECOMPRA.Subtotalneto, 0 )
					.Situacionfiscal_PK =  nvl( c_CANCELACIONDECOMPRA.Situacionfiscal, 0 )
					.Condicioniva = nvl( c_CANCELACIONDECOMPRA.Condicioniva, 0 )
					.Subtotalbruto = nvl( c_CANCELACIONDECOMPRA.Subtotalbruto, 0 )
					.Recargomontosinimpuestos = nvl( c_CANCELACIONDECOMPRA.Recargomontosinimpuestos, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_CANCELACIONDECOMPRA.Subtotalsinimpuestossobreitems, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_CANCELACIONDECOMPRA.Subtotalconimpuestossobreitems, 0 )
					.Recargomontoconimpuestos2 = nvl( c_CANCELACIONDECOMPRA.Recargomontoconimpuestos2, 0 )
					.Recargomontoconimpuestos1 = nvl( c_CANCELACIONDECOMPRA.Recargomontoconimpuestos1, 0 )
					.Descuentoautomatico = nvl( c_CANCELACIONDECOMPRA.Descuentoautomatico, .F. )
					.Comprobantefiscal = nvl( c_CANCELACIONDECOMPRA.Comprobantefiscal, .F. )
					.Anulado = nvl( c_CANCELACIONDECOMPRA.Anulado, .F. )
					.Horaexpo = nvl( c_CANCELACIONDECOMPRA.Horaexpo, [] )
					.Hora = nvl( c_CANCELACIONDECOMPRA.Hora, [] )
					.Horaaltafw = nvl( c_CANCELACIONDECOMPRA.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_CANCELACIONDECOMPRA.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_CANCELACIONDECOMPRA.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_CANCELACIONDECOMPRA.Seriemodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_CANCELACIONDECOMPRA.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_CANCELACIONDECOMPRA.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_CANCELACIONDECOMPRA.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_CANCELACIONDECOMPRA.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CANCELACIONDECOMPRA.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_CANCELACIONDECOMPRA.Seriealtafw, [] )
					.Basededatosaltafw = nvl( c_CANCELACIONDECOMPRA.Basededatosaltafw, [] )
					.Simbolomonetariocomprobante = nvl( c_CANCELACIONDECOMPRA.Simbolomonetariocomprobante, [] )
					.Basededatosmodificacionfw = nvl( c_CANCELACIONDECOMPRA.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_CANCELACIONDECOMPRA.Estadotransferencia, [] )
					.Tipocomprobanterg1361 = nvl( c_CANCELACIONDECOMPRA.Tipocomprobanterg1361, 0 )
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Idvuelto_PK =  nvl( c_CANCELACIONDECOMPRA.Idvuelto, [] )
					.Codigo = nvl( c_CANCELACIONDECOMPRA.Codigo, [] )
					.Monedacomprobante_PK =  nvl( c_CANCELACIONDECOMPRA.Monedacomprobante, [] )
					.Monedasistema_PK =  nvl( c_CANCELACIONDECOMPRA.Monedasistema, [] )
					.Montodescuentoconimpuestos1 = nvl( c_CANCELACIONDECOMPRA.Montodescuentoconimpuestos1, 0 )
					.Descuento = nvl( c_CANCELACIONDECOMPRA.Descuento, 0 )
					.Montodescuentoconimpuestos2 = nvl( c_CANCELACIONDECOMPRA.Montodescuentoconimpuestos2, 0 )
					.Letra = nvl( c_CANCELACIONDECOMPRA.Letra, [] )
					.Impuestos = nvl( c_CANCELACIONDECOMPRA.Impuestos, 0 )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fechafactura = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDECOMPRA.Fechafactura, ctod( '  /  /    ' ) ) )
					.Puntodeventa = nvl( c_CANCELACIONDECOMPRA.Puntodeventa, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_CANCELACIONDECOMPRA.Montodescuentosinimpuestos3, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_CANCELACIONDECOMPRA.Montodescuentoconimpuestos3, 0 )
					.Recargoporcentaje = nvl( c_CANCELACIONDECOMPRA.Recargoporcentaje, 0 )
					.Numero = nvl( c_CANCELACIONDECOMPRA.Numero, 0 )
					.Totaldescuentossinimpuestos = nvl( c_CANCELACIONDECOMPRA.Totaldescuentossinimpuestos, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDECOMPRA.Fecha, ctod( '  /  /    ' ) ) )
					.Recargomonto = nvl( c_CANCELACIONDECOMPRA.Recargomonto, 0 )
					.Cai = nvl( c_CANCELACIONDECOMPRA.Cai, 0 )
					.Recargomontoconimpuestos = nvl( c_CANCELACIONDECOMPRA.Recargomontoconimpuestos, 0 )
					.Proveedor_PK =  nvl( c_CANCELACIONDECOMPRA.Proveedor, [] )
					.Fechavtocai = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANCELACIONDECOMPRA.Fechavtocai, ctod( '  /  /    ' ) ) )
					.Vuelto = nvl( c_CANCELACIONDECOMPRA.Vuelto, 0 )
					.Listadeprecios_PK =  nvl( c_CANCELACIONDECOMPRA.Listadeprecios, [] )
					.Total = nvl( c_CANCELACIONDECOMPRA.Total, 0 )
					.Recargomonto1 = nvl( c_CANCELACIONDECOMPRA.Recargomonto1, 0 )
					.Recargomonto2 = nvl( c_CANCELACIONDECOMPRA.Recargomonto2, 0 )
					.Motivo_PK =  nvl( c_CANCELACIONDECOMPRA.Motivo, [] )
					.Remito = nvl( c_CANCELACIONDECOMPRA.Remito, [] )
					.Cotizacion = nvl( c_CANCELACIONDECOMPRA.Cotizacion, 0 )
					.Totalimpuestos = nvl( c_CANCELACIONDECOMPRA.Totalimpuestos, 0 )
					.Totalrecargos = nvl( c_CANCELACIONDECOMPRA.Totalrecargos, 0 )
					.Totalrecargossinimpuestos = nvl( c_CANCELACIONDECOMPRA.Totalrecargossinimpuestos, 0 )
					.Totaldescuentos = nvl( c_CANCELACIONDECOMPRA.Totaldescuentos, 0 )
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
			lxRetorno = c_CANCELACIONDECOMPRA.CODIGO
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
		return c_CANCELACIONDECOMPRA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CANCOMPRA' )
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
								from ZooLogic.CANCOMPRA 
								Where   CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CANCOMPRA", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaexpo" as "Horaexpo", "Fhora" as "Hora", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fptoven" as "Puntodeventa", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Nroremito" as "Remito", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CANCOMPRA 
								Where   CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44
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
	Tabla = 'CANCOMPRA'
	Filtro = " CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CANCOMPRA.CODIGO != '' AND CANCOMPRA.FACTTIPO = 44"
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
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FECHAEXPO                               " tabla="CANCOMPRA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FECHAALTAFW                             " tabla="CANCOMPRA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FECHAMODIFICACIONFW                     " tabla="CANCOMPRA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FECHAIMPO                               " tabla="CANCOMPRA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FECHAMODIFICACION                       " tabla="CANCOMPRA      " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FECHATRANSFERENCIA                      " tabla="CANCOMPRA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="CUIT                                    " tabla="CANCOMPRA      " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="proveedor.cuit                                                                                                                                                                                                                                                " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="CAJA                                    " tabla="CANCOMPRA      " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="PORCENTAJEDESCUENTO1                    " tabla="CANCOMPRA      " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="PORCENTAJEDESCUENTO2                    " tabla="CANCOMPRA      " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="PORCENTAJEDESCUENTO                     " tabla="CANCOMPRA      " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="% Descuento                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TURNO                                   " tabla="CANCOMPRA      " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TIMESTAMP                               " tabla="CANCOMPRA      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="CANCOMPRA      " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="CANCOMPRA      " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="CANCOMPRA      " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TOTALCANTIDAD                           " tabla="CANCOMPRA      " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total Cantidad                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="CANCOMPRA      " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="SIGNODEMOVIMIENTO                       " tabla="CANCOMPRA      " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TIPOCOMPROBANTE                         " tabla="CANCOMPRA      " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=44                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="CANCOMPRA      " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="SUBTOTALNETO                            " tabla="CANCOMPRA      " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="SITUACIONFISCAL                         " tabla="CANCOMPRA      " campo="SITFISCPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sit. Fis.                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="proveedor.SituacionFiscal                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="CONDICIONIVA                            " tabla="CANCOMPRA      " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="SUBTOTALBRUTO                           " tabla="CANCOMPRA      " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="CANCOMPRA      " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="CANCOMPRA      " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="CANCOMPRA      " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="CANCOMPRA      " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="CANCOMPRA      " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="DESCUENTOAUTOMATICO                     " tabla="CANCOMPRA      " campo="DESAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="COMPROBANTEFISCAL                       " tabla="CANCOMPRA      " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="ANULADO                                 " tabla="CANCOMPRA      " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Está anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="HORAEXPO                                " tabla="CANCOMPRA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="HORA                                    " tabla="CANCOMPRA      " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="HORAALTAFW                              " tabla="CANCOMPRA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="HORAMODIFICACIONFW                      " tabla="CANCOMPRA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="HORAIMPO                                " tabla="CANCOMPRA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="SERIEMODIFICACIONFW                     " tabla="CANCOMPRA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="ZADSFW                                  " tabla="CANCOMPRA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="DESCRIPCIONFW                           " tabla="CANCOMPRA      " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="VERSIONMODIFICACIONFW                   " tabla="CANCOMPRA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="VERSIONALTAFW                           " tabla="CANCOMPRA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="USUARIOALTAFW                           " tabla="CANCOMPRA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="USUARIOMODIFICACIONFW                   " tabla="CANCOMPRA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="SERIEALTAFW                             " tabla="CANCOMPRA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="BASEDEDATOSALTAFW                       " tabla="CANCOMPRA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="CANCOMPRA      " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CANCOMPRA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="ESTADOTRANSFERENCIA                     " tabla="CANCOMPRA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TIPOCOMPROBANTERG1361                   " tabla="CANCOMPRA      " campo="TCRG1361  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo factura                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FACTURADETALLE                          " tabla="CANCOMPRADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMARTICULOSCANCOMPRA " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="IMPUESTOSDETALLE                        " tabla="IMPCANCOMP     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOSCANC      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="IDVUELTO                                " tabla="CANCOMPRA      " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="CODIGO                                  " tabla="CANCOMPRA      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Nro Interno                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MONEDACOMPROBANTE                       " tabla="CANCOMPRA      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Moneda comprobante                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MONEDASISTEMA                           " tabla="CANCOMPRA      " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="CANCOMPRA      " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="DESCUENTO                               " tabla="CANCOMPRA      " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="% Descuento                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="CANCOMPRA      " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="LETRA                                   " tabla="CANCOMPRA      " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="IMPUESTOS                               " tabla="CANCOMPRA      " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="I.V.A.                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPCANC        " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOCANCOMPRA  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="OBS                                     " tabla="CANCOMPRA      " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FECHAFACTURA                            " tabla="CANCOMPRA      " campo="FFCHFAC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Emisión                                                                                                                                                         " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="PUNTODEVENTA                            " tabla="CANCOMPRA      " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="8" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="CANCOMPRA      " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="CANCOMPRA      " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOPORCENTAJE                       " tabla="CANCOMPRA      " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="% Recargo                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="NUMERO                                  " tabla="CANCOMPRA      " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="CANCOMPRA      " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="14" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FECHA                                   " tabla="CANCOMPRA      " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="418" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOMONTO                            " tabla="CANCOMPRA      " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="% Recargo                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="CAI                                     " tabla="CANCOMPRA      " campo="NCAI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="C.A.I./C.A.E.                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="CANCOMPRA      " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="PROVEEDOR                               " tabla="CANCOMPRA      " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="FECHAVTOCAI                             " tabla="CANCOMPRA      " campo="FVTOCAI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento C.A.I./C.A.E.                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="VUELTO                                  " tabla="CANCOMPRA      " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="LISTADEPRECIOS                          " tabla="CANCOMPRA      " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferenteCompras                                                                                                                                                                                  " obligatorio="true" admitebusqueda="424" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TOTAL                                   " tabla="CANCOMPRA      " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOMONTO1                           " tabla="CANCOMPRA      " campo="RECMONTO1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="RECARGOMONTO2                           " tabla="CANCOMPRA      " campo="RECMONTO2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="MOTIVO                                  " tabla="CANCOMPRA      " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="REMITO                                  " tabla="CANCOMPRA      " campo="NROREMITO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="16" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Remito                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="A 99999-99999999         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="COTIZACION                              " tabla="CANCOMPRA      " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="432" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TOTALIMPUESTOS                          " tabla="CANCOMPRA      " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TOTALRECARGOS                           " tabla="CANCOMPRA      " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="CANCOMPRA      " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANCELACIONDECOMPRA                     " atributo="TOTALDESCUENTOS                         " tabla="CANCOMPRA      " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On CANCOMPRA.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On CANCOMPRA.FPERSON = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On CANCOMPRA.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On CANCOMPRA.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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