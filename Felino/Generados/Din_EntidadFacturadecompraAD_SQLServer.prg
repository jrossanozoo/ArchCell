
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
			local  lxFaccompraFecimpo, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFmodifw, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraTimestamp, lxFaccompraDesmntosi1, lxFaccompraRecmntosi2, lxFaccompraDesmntosi, lxFaccompraTotalcant, lxFaccompraRecmntosi1, lxFaccompraDesmntosi2, lxFaccompraFptoven, lxFaccompraSignomov, lxFaccompraRecmntosi, lxFaccompraFsubton, lxFaccompraFacttipo, lxFaccompraSitfiscpro, lxFaccompraFsubtot, lxFaccompraCondivalp, lxFaccompraSubtotsisi, lxFaccompraSubtotcisi, lxFaccompraRecmnto2, lxFaccompraRecmnto1, lxFaccompraFcompfis, lxFaccompraAnulado, lxFaccompraDesauto, lxFaccompraFhora, lxFaccompraHoraexpo, lxFaccompraHoraimpo, lxFaccompraHaltafw, lxFaccompraUmodifw, lxFaccompraZadsfw, lxFaccompraDescfw, lxFaccompraVmodifw, lxFaccompraUaltafw, lxFaccompraValtafw, lxFaccompraSaltafw, lxFaccompraSmodifw, lxFaccompraHmodifw, lxFaccompraSimbmon, lxFaccompraEsttrans, lxFaccompraBdaltafw, lxFaccompraBdmodifw, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraMoneda, lxFaccompraFobs, lxFaccompraFfch, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFmtdes2, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfchfac, lxFaccompraFletra, lxFaccompraDesmntosi3, lxFaccompraFmtdes3, lxFaccompraImpman, lxFaccompraFfchvenc, lxFaccompraRecpor, lxFaccompraFptovenext, lxFaccompraTotdescsi, lxFaccompraCondpago, lxFaccompraMr, lxFaccompraFnumcomp, lxFaccompraNcai, lxFaccompraRecmnto, lxFaccompraNroremito, lxFaccompraFvtocai, lxFaccompraFvuelto, lxFaccompraFperson, lxFaccompraCodlista, lxFaccompraCotiz, lxFaccompraCcosto, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraTotimpue, lxFaccompraTotrecarsi, lxFaccompraTotrecar, lxFaccompraTotdesc
				lxFaccompraFecimpo =  .Fechaimpo			lxFaccompraFaltafw =  .Fechaaltafw			lxFaccompraFecexpo =  .Fechaexpo			lxFaccompraFectrans =  .Fechatransferencia			lxFaccompraFmodifw =  .Fechamodificacionfw			lxFaccompraFd2 =  .Fechamodificacion			lxFaccompraFcuit =  .Cuit			lxFaccompraIdcaja =  .Caja_PK 			lxFaccompraFpodes1 =  .Porcentajedescuento1			lxFaccompraFpodes2 =  .Porcentajedescuento2			lxFaccompraFpodes =  .Porcentajedescuento			lxFaccompraFturno =  .Turno			lxFaccompraNumint =  .Numint			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxFaccompraRecmntosi2 =  .Recargomontosinimpuestos2			lxFaccompraDesmntosi =  .Montodescuentosinimpuestos			lxFaccompraTotalcant =  .Totalcantidad			lxFaccompraRecmntosi1 =  .Recargomontosinimpuestos1			lxFaccompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxFaccompraFptoven =  .Puntodeventa			lxFaccompraSignomov =  .Signodemovimiento			lxFaccompraRecmntosi =  .Recargomontosinimpuestos			lxFaccompraFsubton =  .Subtotalneto			lxFaccompraFacttipo =  .Tipocomprobante			lxFaccompraSitfiscpro =  .Situacionfiscal_PK 			lxFaccompraFsubtot =  .Subtotalbruto			lxFaccompraCondivalp =  .Condicioniva			lxFaccompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxFaccompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxFaccompraRecmnto2 =  .Recargomontoconimpuestos2			lxFaccompraRecmnto1 =  .Recargomontoconimpuestos1			lxFaccompraFcompfis =  .Comprobantefiscal			lxFaccompraAnulado =  .Anulado			lxFaccompraDesauto =  .Descuentoautomatico			lxFaccompraFhora =  .Hora			lxFaccompraHoraexpo =  .Horaexpo			lxFaccompraHoraimpo =  .Horaimpo			lxFaccompraHaltafw =  .Horaaltafw			lxFaccompraUmodifw =  .Usuariomodificacionfw			lxFaccompraZadsfw =  .Zadsfw			lxFaccompraDescfw =  .Descripcionfw			lxFaccompraVmodifw =  .Versionmodificacionfw			lxFaccompraUaltafw =  .Usuarioaltafw			lxFaccompraValtafw =  .Versionaltafw			lxFaccompraSaltafw =  .Seriealtafw			lxFaccompraSmodifw =  .Seriemodificacionfw			lxFaccompraHmodifw =  .Horamodificacionfw			lxFaccompraSimbmon =  .Simbolomonetariocomprobante			lxFaccompraEsttrans =  .Estadotransferencia			lxFaccompraBdaltafw =  .Basededatosaltafw			lxFaccompraBdmodifw =  .Basededatosmodificacionfw			lxFaccompraIdvuelto =  upper( .IdVuelto_PK ) 			lxFaccompraMonsis =  upper( .MonedaSistema_PK ) 			lxFaccompraMoneda =  upper( .MonedaComprobante_PK ) 			lxFaccompraFobs =  .Obs			lxFaccompraFfch =  .Fecha			lxFaccompraFmtdes1 =  .Montodescuentoconimpuestos1			lxFaccompraFdescu =  .Descuento			lxFaccompraFmtdes2 =  .Montodescuentoconimpuestos2			lxFaccompraFimpuesto =  .Impuestos			lxFaccompraTcrg1361 =  .Tipocomprobanterg1361			lxFaccompraCodigo =  .Codigo			lxFaccompraFfchfac =  .Fechafactura			lxFaccompraFletra =  .Letra			lxFaccompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxFaccompraFmtdes3 =  .Montodescuentoconimpuestos3			lxFaccompraImpman =  .Impuestosmanuales			lxFaccompraFfchvenc =  .Fechavencimiento			lxFaccompraRecpor =  .Recargoporcentaje			lxFaccompraFptovenext =  .Puntodeventaextendido			lxFaccompraTotdescsi =  .Totaldescuentossinimpuestos			lxFaccompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxFaccompraMr =  .Recargomonto			lxFaccompraFnumcomp =  .Numero			lxFaccompraNcai =  .Cai			lxFaccompraRecmnto =  .Recargomontoconimpuestos			lxFaccompraNroremito =  .Remito			lxFaccompraFvtocai =  .Fechavtocai			lxFaccompraFvuelto =  .Vuelto			lxFaccompraFperson =  upper( .Proveedor_PK ) 			lxFaccompraCodlista =  upper( .ListaDePrecios_PK ) 			lxFaccompraCotiz =  .Cotizacion			lxFaccompraCcosto =  upper( .CentroDeCosto_PK ) 			lxFaccompraFtotal =  .Total			lxFaccompraRecmonto1 =  .Recargomonto1			lxFaccompraRecmonto2 =  .Recargomonto2			lxFaccompraDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxFaccompraTotimpue =  .Totalimpuestos			lxFaccompraTotrecarsi =  .Totalrecargossinimpuestos			lxFaccompraTotrecar =  .Totalrecargos			lxFaccompraTotdesc =  .Totaldescuentos
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
				insert into ZooLogic.FACCOMPRA ( "Fecimpo","Faltafw","Fecexpo","Fectrans","Fmodifw","Fd2","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fturno","Numint","Timestamp","Desmntosi1","Recmntosi2","Desmntosi","Totalcant","Recmntosi1","Desmntosi2","Fptoven","Signomov","Recmntosi","Fsubton","Facttipo","Sitfiscpro","Fsubtot","Condivalp","Subtotsisi","Subtotcisi","Recmnto2","Recmnto1","Fcompfis","Anulado","Desauto","Fhora","Horaexpo","Horaimpo","Haltafw","Umodifw","Zadsfw","Descfw","Vmodifw","Ualtafw","Valtafw","Saltafw","Smodifw","Hmodifw","Simbmon","Esttrans","Bdaltafw","Bdmodifw","Idvuelto","Monsis","Moneda","Fobs","Ffch","Fmtdes1","Fdescu","Fmtdes2","Fimpuesto","Tcrg1361","Codigo","Ffchfac","Fletra","Desmntosi3","Fmtdes3","Impman","Ffchvenc","Recpor","Fptovenext","Totdescsi","Condpago","Mr","Fnumcomp","Ncai","Recmnto","Nroremito","Fvtocai","Fvuelto","Fperson","Codlista","Cotiz","Ccosto","Ftotal","Recmonto1","Recmonto2","Disccos","Totimpue","Totrecarsi","Totrecar","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxFaccompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFd2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFcuit ) + "'" >>, <<lxFaccompraIdcaja >>, <<lxFaccompraFpodes1 >>, <<lxFaccompraFpodes2 >>, <<lxFaccompraFpodes >>, <<lxFaccompraFturno >>, <<lxFaccompraNumint >>, <<lxFaccompraTimestamp >>, <<lxFaccompraDesmntosi1 >>, <<lxFaccompraRecmntosi2 >>, <<lxFaccompraDesmntosi >>, <<lxFaccompraTotalcant >>, <<lxFaccompraRecmntosi1 >>, <<lxFaccompraDesmntosi2 >>, <<lxFaccompraFptoven >>, <<lxFaccompraSignomov >>, <<lxFaccompraRecmntosi >>, <<lxFaccompraFsubton >>, <<lxFaccompraFacttipo >>, <<lxFaccompraSitfiscpro >>, <<lxFaccompraFsubtot >>, <<lxFaccompraCondivalp >>, <<lxFaccompraSubtotsisi >>, <<lxFaccompraSubtotcisi >>, <<lxFaccompraRecmnto2 >>, <<lxFaccompraRecmnto1 >>, <<iif( lxFaccompraFcompfis, 1, 0 ) >>, <<iif( lxFaccompraAnulado, 1, 0 ) >>, <<iif( lxFaccompraDesauto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFaccompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfch ) + "'" >>, <<lxFaccompraFmtdes1 >>, <<lxFaccompraFdescu >>, <<lxFaccompraFmtdes2 >>, <<lxFaccompraFimpuesto >>, <<lxFaccompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfchfac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFletra ) + "'" >>, <<lxFaccompraDesmntosi3 >>, <<lxFaccompraFmtdes3 >>, <<iif( lxFaccompraImpman, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfchvenc ) + "'" >>, <<lxFaccompraRecpor >>, <<lxFaccompraFptovenext >>, <<lxFaccompraTotdescsi >>, <<"'" + this.FormatearTextoSql( lxFaccompraCondpago ) + "'" >>, <<lxFaccompraMr >>, <<lxFaccompraFnumcomp >>, <<lxFaccompraNcai >>, <<lxFaccompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxFaccompraNroremito ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFvtocai ) + "'" >>, <<lxFaccompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxFaccompraFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraCodlista ) + "'" >>, <<lxFaccompraCotiz >>, <<"'" + this.FormatearTextoSql( lxFaccompraCcosto ) + "'" >>, <<lxFaccompraFtotal >>, <<lxFaccompraRecmonto1 >>, <<lxFaccompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxFaccompraDisccos ) + "'" >>, <<lxFaccompraTotimpue >>, <<lxFaccompraTotrecarsi >>, <<lxFaccompraTotrecar >>, <<lxFaccompraTotdesc >> )
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
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_numero = loItem.Afe_numero
					lxAfe_letra = loItem.Afe_letra
					lxArticulo_PK = loItem.Articulo_PK
					lxAfe_timestamp = loItem.Afe_timestamp
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAfe_saldo = loItem.Afe_saldo
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxBruto = loItem.Bruto
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAfe_nroitem = loItem.Afe_nroitem
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxMontocfi = loItem.Montocfi
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxComportamiento = loItem.Comportamiento
					lxKit = loItem.Kit
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPorcentajeiva = loItem.Porcentajeiva
					lxIdorigen = loItem.Idorigen
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
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
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDistribucioncentrodecosto_PK = loItem.Distribucioncentrodecosto_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FacCompraDet("AfePTOVEN","AfeNUMCOM","AfeLETRA","FART","AfeTS","APorcIvaC","AfeCANT","ACondIvaC","ArtPercep","AfeSaldo","MNTPPER","MNTPRECCI","MNDESSI","MNDESCI","FBruto","MNPDSI","AjuCImp","MNTPDESCI","AfeTipoCom","MNTPRECSI","MNTPTOT","MNTPDESSI","AfeNroItem","FNETO","FmtoIVA","NroItem","FmtoDTO1","AjuSImp","FmtoCFI","FCFITot","COMP","FKIT","FporCFI","FX2","FporDTO1","FN11","FPRUN","prunconimp","Prunsinimp","fporIva","iditemOrig","ProcStock","UsarPLista","afe_Cod","FAMate","IdItem","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO","CCOSTO","DCCOSTO" ) values ( <<lxAfe_puntodeventa>>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_cantidad>>, <<lxArticulo_condicionivacompras>>, <<lxPercepcionivarg5329>>, <<lxAfe_saldo>>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxBruto>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAjusteporredondeoconimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAfe_nroitem>>, <<lxNeto>>, <<lxMontoiva>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxAjusteporredondeosinimpuestos>>, <<lxMontocfi>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxComportamiento>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxPorcentajeiva>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDistribucioncentrodecosto_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.FacCompraDet" )
this.xmlacursor( lcXml, 'c_FacCompraDetciditem' )
loItem.idItem = c_FacCompraDetciditem.ciditem
use in select( 'c_FacCompraDetciditem' )
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
					lxTipo = loItem.Tipo
					lxTurno = loItem.Turno
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxSigno = loItem.Signo
					lxPuntodeventa = loItem.Puntodeventa
					lxPesosalcambio = loItem.Pesosalcambio
					lxCotiza = loItem.Cotiza
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxLetra = loItem.Letra
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodocumento = loItem.Tipodocumento
					lxVendedor = loItem.Vendedor
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
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
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJT","JJTurno","Cotiza","Signo","PtoVenta","Pesos","JJCotiz","NroCupon","NroItem","NumCompr","VisualCaja","PersComp","CElectro","Letra","NroTarjeta","TipoDoc","JJVen","NroDoc","TIPCOMP","JJCO","NroChProp","JJNUM","NroCheque","CondPago","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxTurno>>, <<lxUltimacotizacion>>, <<lxSigno>>, <<lxPuntodeventa>>, <<lxPesosalcambio>>, <<lxCotiza>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxNumerodecomprobante>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
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
					
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacc("minoimp","NroItem","porcen","codint","TipoI","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
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
			local  lxFaccompraFecimpo, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFmodifw, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraTimestamp, lxFaccompraDesmntosi1, lxFaccompraRecmntosi2, lxFaccompraDesmntosi, lxFaccompraTotalcant, lxFaccompraRecmntosi1, lxFaccompraDesmntosi2, lxFaccompraFptoven, lxFaccompraSignomov, lxFaccompraRecmntosi, lxFaccompraFsubton, lxFaccompraFacttipo, lxFaccompraSitfiscpro, lxFaccompraFsubtot, lxFaccompraCondivalp, lxFaccompraSubtotsisi, lxFaccompraSubtotcisi, lxFaccompraRecmnto2, lxFaccompraRecmnto1, lxFaccompraFcompfis, lxFaccompraAnulado, lxFaccompraDesauto, lxFaccompraFhora, lxFaccompraHoraexpo, lxFaccompraHoraimpo, lxFaccompraHaltafw, lxFaccompraUmodifw, lxFaccompraZadsfw, lxFaccompraDescfw, lxFaccompraVmodifw, lxFaccompraUaltafw, lxFaccompraValtafw, lxFaccompraSaltafw, lxFaccompraSmodifw, lxFaccompraHmodifw, lxFaccompraSimbmon, lxFaccompraEsttrans, lxFaccompraBdaltafw, lxFaccompraBdmodifw, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraMoneda, lxFaccompraFobs, lxFaccompraFfch, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFmtdes2, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfchfac, lxFaccompraFletra, lxFaccompraDesmntosi3, lxFaccompraFmtdes3, lxFaccompraImpman, lxFaccompraFfchvenc, lxFaccompraRecpor, lxFaccompraFptovenext, lxFaccompraTotdescsi, lxFaccompraCondpago, lxFaccompraMr, lxFaccompraFnumcomp, lxFaccompraNcai, lxFaccompraRecmnto, lxFaccompraNroremito, lxFaccompraFvtocai, lxFaccompraFvuelto, lxFaccompraFperson, lxFaccompraCodlista, lxFaccompraCotiz, lxFaccompraCcosto, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraTotimpue, lxFaccompraTotrecarsi, lxFaccompraTotrecar, lxFaccompraTotdesc
				lxFaccompraFecimpo =  .Fechaimpo			lxFaccompraFaltafw =  .Fechaaltafw			lxFaccompraFecexpo =  .Fechaexpo			lxFaccompraFectrans =  .Fechatransferencia			lxFaccompraFmodifw =  .Fechamodificacionfw			lxFaccompraFd2 =  .Fechamodificacion			lxFaccompraFcuit =  .Cuit			lxFaccompraIdcaja =  .Caja_PK 			lxFaccompraFpodes1 =  .Porcentajedescuento1			lxFaccompraFpodes2 =  .Porcentajedescuento2			lxFaccompraFpodes =  .Porcentajedescuento			lxFaccompraFturno =  .Turno			lxFaccompraNumint =  .Numint			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxFaccompraRecmntosi2 =  .Recargomontosinimpuestos2			lxFaccompraDesmntosi =  .Montodescuentosinimpuestos			lxFaccompraTotalcant =  .Totalcantidad			lxFaccompraRecmntosi1 =  .Recargomontosinimpuestos1			lxFaccompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxFaccompraFptoven =  .Puntodeventa			lxFaccompraSignomov =  .Signodemovimiento			lxFaccompraRecmntosi =  .Recargomontosinimpuestos			lxFaccompraFsubton =  .Subtotalneto			lxFaccompraFacttipo =  .Tipocomprobante			lxFaccompraSitfiscpro =  .Situacionfiscal_PK 			lxFaccompraFsubtot =  .Subtotalbruto			lxFaccompraCondivalp =  .Condicioniva			lxFaccompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxFaccompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxFaccompraRecmnto2 =  .Recargomontoconimpuestos2			lxFaccompraRecmnto1 =  .Recargomontoconimpuestos1			lxFaccompraFcompfis =  .Comprobantefiscal			lxFaccompraAnulado =  .Anulado			lxFaccompraDesauto =  .Descuentoautomatico			lxFaccompraFhora =  .Hora			lxFaccompraHoraexpo =  .Horaexpo			lxFaccompraHoraimpo =  .Horaimpo			lxFaccompraHaltafw =  .Horaaltafw			lxFaccompraUmodifw =  .Usuariomodificacionfw			lxFaccompraZadsfw =  .Zadsfw			lxFaccompraDescfw =  .Descripcionfw			lxFaccompraVmodifw =  .Versionmodificacionfw			lxFaccompraUaltafw =  .Usuarioaltafw			lxFaccompraValtafw =  .Versionaltafw			lxFaccompraSaltafw =  .Seriealtafw			lxFaccompraSmodifw =  .Seriemodificacionfw			lxFaccompraHmodifw =  .Horamodificacionfw			lxFaccompraSimbmon =  .Simbolomonetariocomprobante			lxFaccompraEsttrans =  .Estadotransferencia			lxFaccompraBdaltafw =  .Basededatosaltafw			lxFaccompraBdmodifw =  .Basededatosmodificacionfw			lxFaccompraIdvuelto =  upper( .IdVuelto_PK ) 			lxFaccompraMonsis =  upper( .MonedaSistema_PK ) 			lxFaccompraMoneda =  upper( .MonedaComprobante_PK ) 			lxFaccompraFobs =  .Obs			lxFaccompraFfch =  .Fecha			lxFaccompraFmtdes1 =  .Montodescuentoconimpuestos1			lxFaccompraFdescu =  .Descuento			lxFaccompraFmtdes2 =  .Montodescuentoconimpuestos2			lxFaccompraFimpuesto =  .Impuestos			lxFaccompraTcrg1361 =  .Tipocomprobanterg1361			lxFaccompraCodigo =  .Codigo			lxFaccompraFfchfac =  .Fechafactura			lxFaccompraFletra =  .Letra			lxFaccompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxFaccompraFmtdes3 =  .Montodescuentoconimpuestos3			lxFaccompraImpman =  .Impuestosmanuales			lxFaccompraFfchvenc =  .Fechavencimiento			lxFaccompraRecpor =  .Recargoporcentaje			lxFaccompraFptovenext =  .Puntodeventaextendido			lxFaccompraTotdescsi =  .Totaldescuentossinimpuestos			lxFaccompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxFaccompraMr =  .Recargomonto			lxFaccompraFnumcomp =  .Numero			lxFaccompraNcai =  .Cai			lxFaccompraRecmnto =  .Recargomontoconimpuestos			lxFaccompraNroremito =  .Remito			lxFaccompraFvtocai =  .Fechavtocai			lxFaccompraFvuelto =  .Vuelto			lxFaccompraFperson =  upper( .Proveedor_PK ) 			lxFaccompraCodlista =  upper( .ListaDePrecios_PK ) 			lxFaccompraCotiz =  .Cotizacion			lxFaccompraCcosto =  upper( .CentroDeCosto_PK ) 			lxFaccompraFtotal =  .Total			lxFaccompraRecmonto1 =  .Recargomonto1			lxFaccompraRecmonto2 =  .Recargomonto2			lxFaccompraDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxFaccompraTotimpue =  .Totalimpuestos			lxFaccompraTotrecarsi =  .Totalrecargossinimpuestos			lxFaccompraTotrecar =  .Totalrecargos			lxFaccompraTotdesc =  .Totaldescuentos
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
				update ZooLogic.FACCOMPRA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxFaccompraFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxFaccompraFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxFaccompraFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxFaccompraFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxFaccompraFmodifw ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxFaccompraFd2 ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxFaccompraFcuit ) + "'">>,"Idcaja" = <<lxFaccompraIdcaja>>,"Fpodes1" = <<lxFaccompraFpodes1>>,"Fpodes2" = <<lxFaccompraFpodes2>>,"Fpodes" = <<lxFaccompraFpodes>>,"Fturno" = <<lxFaccompraFturno>>,"Numint" = <<lxFaccompraNumint>>,"Timestamp" = <<lxFaccompraTimestamp>>,"Desmntosi1" = <<lxFaccompraDesmntosi1>>,"Recmntosi2" = <<lxFaccompraRecmntosi2>>,"Desmntosi" = <<lxFaccompraDesmntosi>>,"Totalcant" = <<lxFaccompraTotalcant>>,"Recmntosi1" = <<lxFaccompraRecmntosi1>>,"Desmntosi2" = <<lxFaccompraDesmntosi2>>,"Fptoven" = <<lxFaccompraFptoven>>,"Signomov" = <<lxFaccompraSignomov>>,"Recmntosi" = <<lxFaccompraRecmntosi>>,"Fsubton" = <<lxFaccompraFsubton>>,"Facttipo" = <<lxFaccompraFacttipo>>,"Sitfiscpro" = <<lxFaccompraSitfiscpro>>,"Fsubtot" = <<lxFaccompraFsubtot>>,"Condivalp" = <<lxFaccompraCondivalp>>,"Subtotsisi" = <<lxFaccompraSubtotsisi>>,"Subtotcisi" = <<lxFaccompraSubtotcisi>>,"Recmnto2" = <<lxFaccompraRecmnto2>>,"Recmnto1" = <<lxFaccompraRecmnto1>>,"Fcompfis" = <<iif( lxFaccompraFcompfis, 1, 0 )>>,"Anulado" = <<iif( lxFaccompraAnulado, 1, 0 )>>,"Desauto" = <<iif( lxFaccompraDesauto, 1, 0 )>>,"Fhora" = <<"'" + this.FormatearTextoSql( lxFaccompraFhora ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxFaccompraHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxFaccompraHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraHaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxFaccompraZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxFaccompraDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxFaccompraUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxFaccompraValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraHmodifw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxFaccompraSimbmon ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxFaccompraEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraBdmodifw ) + "'">>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxFaccompraIdvuelto ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxFaccompraMonsis ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxFaccompraMoneda ) + "'">>,"Fobs" = <<"'" + this.FormatearTextoSql( lxFaccompraFobs ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxFaccompraFfch ) + "'">>,"Fmtdes1" = <<lxFaccompraFmtdes1>>,"Fdescu" = <<lxFaccompraFdescu>>,"Fmtdes2" = <<lxFaccompraFmtdes2>>,"Fimpuesto" = <<lxFaccompraFimpuesto>>,"Tcrg1361" = <<lxFaccompraTcrg1361>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'">>,"Ffchfac" = <<"'" + this.ConvertirDateSql( lxFaccompraFfchfac ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxFaccompraFletra ) + "'">>,"Desmntosi3" = <<lxFaccompraDesmntosi3>>,"Fmtdes3" = <<lxFaccompraFmtdes3>>,"Impman" = <<iif( lxFaccompraImpman, 1, 0 )>>,"Ffchvenc" = <<"'" + this.ConvertirDateSql( lxFaccompraFfchvenc ) + "'">>,"Recpor" = <<lxFaccompraRecpor>>,"Fptovenext" = <<lxFaccompraFptovenext>>,"Totdescsi" = <<lxFaccompraTotdescsi>>,"Condpago" = <<"'" + this.FormatearTextoSql( lxFaccompraCondpago ) + "'">>,"Mr" = <<lxFaccompraMr>>,"Fnumcomp" = <<lxFaccompraFnumcomp>>,"Ncai" = <<lxFaccompraNcai>>,"Recmnto" = <<lxFaccompraRecmnto>>,"Nroremito" = <<"'" + this.FormatearTextoSql( lxFaccompraNroremito ) + "'">>,"Fvtocai" = <<"'" + this.ConvertirDateSql( lxFaccompraFvtocai ) + "'">>,"Fvuelto" = <<lxFaccompraFvuelto>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxFaccompraFperson ) + "'">>,"Codlista" = <<"'" + this.FormatearTextoSql( lxFaccompraCodlista ) + "'">>,"Cotiz" = <<lxFaccompraCotiz>>,"Ccosto" = <<"'" + this.FormatearTextoSql( lxFaccompraCcosto ) + "'">>,"Ftotal" = <<lxFaccompraFtotal>>,"Recmonto1" = <<lxFaccompraRecmonto1>>,"Recmonto2" = <<lxFaccompraRecmonto2>>,"Disccos" = <<"'" + this.FormatearTextoSql( lxFaccompraDisccos ) + "'">>,"Totimpue" = <<lxFaccompraTotimpue>>,"Totrecarsi" = <<lxFaccompraTotrecarsi>>,"Totrecar" = <<lxFaccompraTotrecar>>,"Totdesc" = <<lxFaccompraTotdesc>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'">> and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_numero = loItem.Afe_numero
					lxAfe_letra = loItem.Afe_letra
					lxArticulo_PK = loItem.Articulo_PK
					lxAfe_timestamp = loItem.Afe_timestamp
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAfe_saldo = loItem.Afe_saldo
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxBruto = loItem.Bruto
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAfe_nroitem = loItem.Afe_nroitem
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxMontocfi = loItem.Montocfi
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxComportamiento = loItem.Comportamiento
					lxKit = loItem.Kit
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPorcentajeiva = loItem.Porcentajeiva
					lxIdorigen = loItem.Idorigen
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
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
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDistribucioncentrodecosto_PK = loItem.Distribucioncentrodecosto_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FacCompraDet("AfePTOVEN","AfeNUMCOM","AfeLETRA","FART","AfeTS","APorcIvaC","AfeCANT","ACondIvaC","ArtPercep","AfeSaldo","MNTPPER","MNTPRECCI","MNDESSI","MNDESCI","FBruto","MNPDSI","AjuCImp","MNTPDESCI","AfeTipoCom","MNTPRECSI","MNTPTOT","MNTPDESSI","AfeNroItem","FNETO","FmtoIVA","NroItem","FmtoDTO1","AjuSImp","FmtoCFI","FCFITot","COMP","FKIT","FporCFI","FX2","FporDTO1","FN11","FPRUN","prunconimp","Prunsinimp","fporIva","iditemOrig","ProcStock","UsarPLista","afe_Cod","FAMate","IdItem","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO","CCOSTO","DCCOSTO" ) values ( <<lxAfe_puntodeventa>>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_cantidad>>, <<lxArticulo_condicionivacompras>>, <<lxPercepcionivarg5329>>, <<lxAfe_saldo>>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxBruto>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAjusteporredondeoconimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAfe_nroitem>>, <<lxNeto>>, <<lxMontoiva>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxAjusteporredondeosinimpuestos>>, <<lxMontocfi>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxComportamiento>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxPorcentajeiva>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDistribucioncentrodecosto_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.FacCompraDet" )
this.xmlacursor( lcXml, 'c_FacCompraDetciditem' )
loItem.idItem = c_FacCompraDetciditem.ciditem
use in select( 'c_FacCompraDetciditem' )
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
					lxTipo = loItem.Tipo
					lxTurno = loItem.Turno
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxSigno = loItem.Signo
					lxPuntodeventa = loItem.Puntodeventa
					lxPesosalcambio = loItem.Pesosalcambio
					lxCotiza = loItem.Cotiza
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxLetra = loItem.Letra
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodocumento = loItem.Tipodocumento
					lxVendedor = loItem.Vendedor
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
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
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJT","JJTurno","Cotiza","Signo","PtoVenta","Pesos","JJCotiz","NroCupon","NroItem","NumCompr","VisualCaja","PersComp","CElectro","Letra","NroTarjeta","TipoDoc","JJVen","NroDoc","TIPCOMP","JJCO","NroChProp","JJNUM","NroCheque","CondPago","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxTurno>>, <<lxUltimacotizacion>>, <<lxSigno>>, <<lxPuntodeventa>>, <<lxPesosalcambio>>, <<lxCotiza>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxNumerodecomprobante>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
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
					
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacc("minoimp","NroItem","porcen","codint","TipoI","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
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
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fptoven" as "Puntodeventa", "Signomov" as "Signodemovimiento", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Sitfiscpro" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Desauto" as "Descuentoautomatico", "Fhora" as "Hora", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fobs" as "Obs", "Ffch" as "Fecha", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffchfac" as "Fechafactura", "Fletra" as "Letra", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Ffchvenc" as "Fechavencimiento", "Recpor" as "Recargoporcentaje", "Fptovenext" as "Puntodeventaextendido", "Totdescsi" as "Totaldescuentossinimpuestos", "Condpago" as "Condicionpagopreferente", "Mr" as "Recargomonto", "Fnumcomp" as "Numero", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Codlista" as "Listadeprecios", "Cotiz" as "Cotizacion", "Ccosto" as "Centrodecosto", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'">> and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_FACTURADECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Artpercep" as "Percepcionivarg5329", "Afesaldo" as "Afe_saldo", "Mntpper" as "Montoprorrateopercepciones", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Fbruto" as "Bruto", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afenroitem" as "Afe_nroitem", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Fmtocfi" as "Montocfi", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fporiva" as "Porcentajeiva", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fptoven" as "Puntodeventa", "Signomov" as "Signodemovimiento", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Sitfiscpro" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Desauto" as "Descuentoautomatico", "Fhora" as "Hora", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fobs" as "Obs", "Ffch" as "Fecha", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffchfac" as "Fechafactura", "Fletra" as "Letra", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Ffchvenc" as "Fechavencimiento", "Recpor" as "Recargoporcentaje", "Fptovenext" as "Puntodeventaextendido", "Totdescsi" as "Totaldescuentossinimpuestos", "Condpago" as "Condicionpagopreferente", "Mr" as "Recargomonto", "Fnumcomp" as "Numero", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Codlista" as "Listadeprecios", "Cotiz" as "Cotizacion", "Ccosto" as "Centrodecosto", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 And NumInt = <<lxFacCompraNumInt>> and FACTTIPO = <<lxFacCompraFACTTIPO>>
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			if reccount( 'c_FACTURADECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Artpercep" as "Percepcionivarg5329", "Afesaldo" as "Afe_saldo", "Mntpper" as "Montoprorrateopercepciones", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Fbruto" as "Bruto", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afenroitem" as "Afe_nroitem", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Fmtocfi" as "Montocfi", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fporiva" as "Porcentajeiva", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fptoven" as "Puntodeventa", "Signomov" as "Signodemovimiento", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Sitfiscpro" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Desauto" as "Descuentoautomatico", "Fhora" as "Hora", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fobs" as "Obs", "Ffch" as "Fecha", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffchfac" as "Fechafactura", "Fletra" as "Letra", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Ffchvenc" as "Fechavencimiento", "Recpor" as "Recargoporcentaje", "Fptovenext" as "Puntodeventaextendido", "Totdescsi" as "Totaldescuentossinimpuestos", "Condpago" as "Condicionpagopreferente", "Mr" as "Recargomonto", "Fnumcomp" as "Numero", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Codlista" as "Listadeprecios", "Cotiz" as "Cotizacion", "Ccosto" as "Centrodecosto", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 order by NumInt,FACTTIPO
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Artpercep" as "Percepcionivarg5329", "Afesaldo" as "Afe_saldo", "Mntpper" as "Montoprorrateopercepciones", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Fbruto" as "Bruto", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afenroitem" as "Afe_nroitem", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Fmtocfi" as "Montocfi", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fporiva" as "Porcentajeiva", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fptoven" as "Puntodeventa", "Signomov" as "Signodemovimiento", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Sitfiscpro" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Desauto" as "Descuentoautomatico", "Fhora" as "Hora", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fobs" as "Obs", "Ffch" as "Fecha", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffchfac" as "Fechafactura", "Fletra" as "Letra", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Ffchvenc" as "Fechavencimiento", "Recpor" as "Recargoporcentaje", "Fptovenext" as "Puntodeventaextendido", "Totdescsi" as "Totaldescuentossinimpuestos", "Condpago" as "Condicionpagopreferente", "Mr" as "Recargomonto", "Fnumcomp" as "Numero", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Codlista" as "Listadeprecios", "Cotiz" as "Cotizacion", "Ccosto" as "Centrodecosto", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  str( NumInt, 10, 0) + str( FACTTIPO, 2, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 order by NumInt,FACTTIPO
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Artpercep" as "Percepcionivarg5329", "Afesaldo" as "Afe_saldo", "Mntpper" as "Montoprorrateopercepciones", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Fbruto" as "Bruto", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afenroitem" as "Afe_nroitem", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Fmtocfi" as "Montocfi", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fporiva" as "Porcentajeiva", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fptoven" as "Puntodeventa", "Signomov" as "Signodemovimiento", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Sitfiscpro" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Desauto" as "Descuentoautomatico", "Fhora" as "Hora", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fobs" as "Obs", "Ffch" as "Fecha", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffchfac" as "Fechafactura", "Fletra" as "Letra", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Ffchvenc" as "Fechavencimiento", "Recpor" as "Recargoporcentaje", "Fptovenext" as "Puntodeventaextendido", "Totdescsi" as "Totaldescuentossinimpuestos", "Condpago" as "Condicionpagopreferente", "Mr" as "Recargomonto", "Fnumcomp" as "Numero", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Codlista" as "Listadeprecios", "Cotiz" as "Cotizacion", "Ccosto" as "Centrodecosto", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  str( NumInt, 10, 0) + str( FACTTIPO, 2, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 order by NumInt desc,FACTTIPO desc
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Artpercep" as "Percepcionivarg5329", "Afesaldo" as "Afe_saldo", "Mntpper" as "Montoprorrateopercepciones", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Fbruto" as "Bruto", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afenroitem" as "Afe_nroitem", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Fmtocfi" as "Montocfi", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fporiva" as "Porcentajeiva", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fptoven" as "Puntodeventa", "Signomov" as "Signodemovimiento", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Sitfiscpro" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Desauto" as "Descuentoautomatico", "Fhora" as "Hora", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fobs" as "Obs", "Ffch" as "Fecha", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffchfac" as "Fechafactura", "Fletra" as "Letra", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Ffchvenc" as "Fechavencimiento", "Recpor" as "Recargoporcentaje", "Fptovenext" as "Puntodeventaextendido", "Totdescsi" as "Totaldescuentossinimpuestos", "Condpago" as "Condicionpagopreferente", "Mr" as "Recargomonto", "Fnumcomp" as "Numero", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Codlista" as "Listadeprecios", "Cotiz" as "Cotizacion", "Ccosto" as "Centrodecosto", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 order by NumInt desc,FACTTIPO desc
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Artpercep" as "Percepcionivarg5329", "Afesaldo" as "Afe_saldo", "Mntpper" as "Montoprorrateopercepciones", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Fbruto" as "Bruto", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afenroitem" as "Afe_nroitem", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Fmtocfi" as "Montocfi", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fporiva" as "Porcentajeiva", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Faltafw,Fecexpo,Fectrans,Fmodifw,Fd2,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fturno,Numi" + ;
"nt,Timestamp,Desmntosi1,Recmntosi2,Desmntosi,Totalcant,Recmntosi1,Desmntosi2,Fptoven,Signomov,Recmnt" + ;
"osi,Fsubton,Facttipo,Sitfiscpro,Fsubtot,Condivalp,Subtotsisi,Subtotcisi,Recmnto2,Recmnto1,Fcompfis,A" + ;
"nulado,Desauto,Fhora,Horaexpo,Horaimpo,Haltafw,Umodifw,Zadsfw,Descfw,Vmodifw,Ualtafw,Valtafw,Saltafw" + ;
",Smodifw,Hmodifw,Simbmon,Esttrans,Bdaltafw,Bdmodifw,Idvuelto,Monsis,Moneda,Fobs,Ffch,Fmtdes1,Fdescu," + ;
"Fmtdes2,Fimpuesto,Tcrg1361,Codigo,Ffchfac,Fletra,Desmntosi3,Fmtdes3,Impman,Ffchvenc,Recpor,Fptovenex" + ;
"t,Totdescsi,Condpago,Mr,Fnumcomp,Ncai,Recmnto,Nroremito,Fvtocai,Fvuelto,Fperson,Codlista,Cotiz,Ccost" + ;
"o,Ftotal,Recmonto1,Recmonto2,Disccos,Totimpue,Totrecarsi,Totrecar,Totdesc" + ;
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
			local  lxFaccompraFecimpo, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFmodifw, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraTimestamp, lxFaccompraDesmntosi1, lxFaccompraRecmntosi2, lxFaccompraDesmntosi, lxFaccompraTotalcant, lxFaccompraRecmntosi1, lxFaccompraDesmntosi2, lxFaccompraFptoven, lxFaccompraSignomov, lxFaccompraRecmntosi, lxFaccompraFsubton, lxFaccompraFacttipo, lxFaccompraSitfiscpro, lxFaccompraFsubtot, lxFaccompraCondivalp, lxFaccompraSubtotsisi, lxFaccompraSubtotcisi, lxFaccompraRecmnto2, lxFaccompraRecmnto1, lxFaccompraFcompfis, lxFaccompraAnulado, lxFaccompraDesauto, lxFaccompraFhora, lxFaccompraHoraexpo, lxFaccompraHoraimpo, lxFaccompraHaltafw, lxFaccompraUmodifw, lxFaccompraZadsfw, lxFaccompraDescfw, lxFaccompraVmodifw, lxFaccompraUaltafw, lxFaccompraValtafw, lxFaccompraSaltafw, lxFaccompraSmodifw, lxFaccompraHmodifw, lxFaccompraSimbmon, lxFaccompraEsttrans, lxFaccompraBdaltafw, lxFaccompraBdmodifw, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraMoneda, lxFaccompraFobs, lxFaccompraFfch, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFmtdes2, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfchfac, lxFaccompraFletra, lxFaccompraDesmntosi3, lxFaccompraFmtdes3, lxFaccompraImpman, lxFaccompraFfchvenc, lxFaccompraRecpor, lxFaccompraFptovenext, lxFaccompraTotdescsi, lxFaccompraCondpago, lxFaccompraMr, lxFaccompraFnumcomp, lxFaccompraNcai, lxFaccompraRecmnto, lxFaccompraNroremito, lxFaccompraFvtocai, lxFaccompraFvuelto, lxFaccompraFperson, lxFaccompraCodlista, lxFaccompraCotiz, lxFaccompraCcosto, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraTotimpue, lxFaccompraTotrecarsi, lxFaccompraTotrecar, lxFaccompraTotdesc
				lxFaccompraFecimpo = ctod( '  /  /    ' )			lxFaccompraFaltafw = ctod( '  /  /    ' )			lxFaccompraFecexpo = ctod( '  /  /    ' )			lxFaccompraFectrans = ctod( '  /  /    ' )			lxFaccompraFmodifw = ctod( '  /  /    ' )			lxFaccompraFd2 = ctod( '  /  /    ' )			lxFaccompraFcuit = []			lxFaccompraIdcaja = 0			lxFaccompraFpodes1 = 0			lxFaccompraFpodes2 = 0			lxFaccompraFpodes = 0			lxFaccompraFturno = 0			lxFaccompraNumint = 0			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi1 = 0			lxFaccompraRecmntosi2 = 0			lxFaccompraDesmntosi = 0			lxFaccompraTotalcant = 0			lxFaccompraRecmntosi1 = 0			lxFaccompraDesmntosi2 = 0			lxFaccompraFptoven = 0			lxFaccompraSignomov = 0			lxFaccompraRecmntosi = 0			lxFaccompraFsubton = 0			lxFaccompraFacttipo = 0			lxFaccompraSitfiscpro = 0			lxFaccompraFsubtot = 0			lxFaccompraCondivalp = 0			lxFaccompraSubtotsisi = 0			lxFaccompraSubtotcisi = 0			lxFaccompraRecmnto2 = 0			lxFaccompraRecmnto1 = 0			lxFaccompraFcompfis = .F.			lxFaccompraAnulado = .F.			lxFaccompraDesauto = .F.			lxFaccompraFhora = []			lxFaccompraHoraexpo = []			lxFaccompraHoraimpo = []			lxFaccompraHaltafw = []			lxFaccompraUmodifw = []			lxFaccompraZadsfw = []			lxFaccompraDescfw = []			lxFaccompraVmodifw = []			lxFaccompraUaltafw = []			lxFaccompraValtafw = []			lxFaccompraSaltafw = []			lxFaccompraSmodifw = []			lxFaccompraHmodifw = []			lxFaccompraSimbmon = []			lxFaccompraEsttrans = []			lxFaccompraBdaltafw = []			lxFaccompraBdmodifw = []			lxFaccompraIdvuelto = []			lxFaccompraMonsis = []			lxFaccompraMoneda = []			lxFaccompraFobs = []			lxFaccompraFfch = ctod( '  /  /    ' )			lxFaccompraFmtdes1 = 0			lxFaccompraFdescu = 0			lxFaccompraFmtdes2 = 0			lxFaccompraFimpuesto = 0			lxFaccompraTcrg1361 = 0			lxFaccompraCodigo = []			lxFaccompraFfchfac = ctod( '  /  /    ' )			lxFaccompraFletra = []			lxFaccompraDesmntosi3 = 0			lxFaccompraFmtdes3 = 0			lxFaccompraImpman = .F.			lxFaccompraFfchvenc = ctod( '  /  /    ' )			lxFaccompraRecpor = 0			lxFaccompraFptovenext = 0			lxFaccompraTotdescsi = 0			lxFaccompraCondpago = []			lxFaccompraMr = 0			lxFaccompraFnumcomp = 0			lxFaccompraNcai = 0			lxFaccompraRecmnto = 0			lxFaccompraNroremito = []			lxFaccompraFvtocai = ctod( '  /  /    ' )			lxFaccompraFvuelto = 0			lxFaccompraFperson = []			lxFaccompraCodlista = []			lxFaccompraCotiz = 0			lxFaccompraCcosto = []			lxFaccompraFtotal = 0			lxFaccompraRecmonto1 = 0			lxFaccompraRecmonto2 = 0			lxFaccompraDisccos = []			lxFaccompraTotimpue = 0			lxFaccompraTotrecarsi = 0			lxFaccompraTotrecar = 0			lxFaccompraTotdesc = 0
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
					"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fptoven" as "Puntodeventa", "Signomov" as "Signodemovimiento", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Sitfiscpro" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Desauto" as "Descuentoautomatico", "Fhora" as "Hora", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fobs" as "Obs", "Ffch" as "Fecha", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffchfac" as "Fechafactura", "Fletra" as "Letra", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Ffchvenc" as "Fechavencimiento", "Recpor" as "Recargoporcentaje", "Fptovenext" as "Puntodeventaextendido", "Totdescsi" as "Totaldescuentossinimpuestos", "Condpago" as "Condicionpagopreferente", "Mr" as "Recargomonto", "Fnumcomp" as "Numero", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Codlista" as "Listadeprecios", "Cotiz" as "Cotizacion", "Ccosto" as "Centrodecosto", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos"
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
	Function ObtenerDatosDetalleFacturaDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  FACCOMPRADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Artpercep" as "Percepcionivarg5329", "Afesaldo" as "Afe_saldo", "Mntpper" as "Montoprorrateopercepciones", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Fbruto" as "Bruto", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afenroitem" as "Afe_nroitem", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Fmtocfi" as "Montocfi", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fporiva" as "Porcentajeiva", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto"
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
					"Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio"
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
					"Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo"
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
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
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCPRO AS SITUACIONFISCAL'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUTO AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES1 AS MONTODESCUENTOCONIMPUESTOS1'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'IMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FIMPUESTO AS IMPUESTOS'
				Case lcAtributo == 'TIPOCOMPROBANTERG1361'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCRG1361 AS TIPOCOMPROBANTERG1361'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHAFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHFAC AS FECHAFACTURA'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'IMPUESTOSMANUALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPMAN AS IMPUESTOSMANUALES'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHVENC AS FECHAVENCIMIENTO'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPOR AS RECARGOPORCENTAJE'
				Case lcAtributo == 'PUNTODEVENTAEXTENDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVENEXT AS PUNTODEVENTAEXTENDIDO'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'CONDICIONPAGOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONPAGOPREFERENTE'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR AS RECARGOMONTO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'CAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCAI AS CAI'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO AS RECARGOMONTOCONIMPUESTOS'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREMITO AS REMITO'
				Case lcAtributo == 'FECHAVTOCAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVTOCAI AS FECHAVTOCAI'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS PROVEEDOR'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'CENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOSTO AS CENTRODECOSTO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO1 AS RECARGOMONTO1'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO2 AS RECARGOMONTO2'
				Case lcAtributo == 'DISTRIBUCIONPORCENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISCCOS AS DISTRIBUCIONPORCENTRODECOSTO'
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
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FART AS ARTICULO'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAC AS ARTICULO_PORCENTAJEIVACOMPRAS'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'ARTICULO_CONDICIONIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAC AS ARTICULO_CONDICIONIVACOMPRAS'
				Case lcAtributo == 'PERCEPCIONIVARG5329'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS PERCEPCIONIVARG5329'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOIVA AS MONTOIVA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFITOT AS MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'KIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FKIT AS KIT'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMATE AS MATERIAL'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
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
				Case lcAtributo == 'CENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOSTO AS CENTRODECOSTO'
				Case lcAtributo == 'DISTRIBUCIONCENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DCCOSTO AS DISTRIBUCIONCENTRODECOSTO'
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
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTURNO AS TURNO'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'SIGNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJVEN AS VENDEDOR'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCO AS VALOR'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJNUM AS CODIGO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONDEPAGO'
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
				Case lcAtributo == 'PERMITEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERMVUELTO AS PERMITEVUELTO'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
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
				Case lcAtributo == 'MINIMONOIMPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINOIMP AS MINIMONOIMPONIBLE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'CODIGOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODIGOINTERNO'
				Case lcAtributo == 'TIPOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOI AS TIPOIMPUESTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCPRO'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS1'
				lcCampo = 'FMTDES1'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOS'
				lcCampo = 'FIMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTERG1361'
				lcCampo = 'TCRG1361'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAFACTURA'
				lcCampo = 'FFCHFAC'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOSMANUALES'
				lcCampo = 'IMPMAN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FFCHVENC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPOR'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAEXTENDIDO'
				lcCampo = 'FPTOVENEXT'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONPAGOPREFERENTE'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'MR'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CAI'
				lcCampo = 'NCAI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS'
				lcCampo = 'RECMNTO'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'NROREMITO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOCAI'
				lcCampo = 'FVTOCAI'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'CENTRODECOSTO'
				lcCampo = 'CCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'RECMONTO1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'RECMONTO2'
			Case upper( alltrim( tcAtributo ) ) == 'DISTRIBUCIONPORCENTRODECOSTO'
				lcCampo = 'DISCCOS'
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
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FART'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVACOMPRAS'
				lcCampo = 'APORCIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVACOMPRAS'
				lcCampo = 'ACONDIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVARG5329'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'FMTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				lcCampo = 'FCFITOT'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'KIT'
				lcCampo = 'FKIT'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'FAMATE'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
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
			Case upper( alltrim( tcAtributo ) ) == 'CENTRODECOSTO'
				lcCampo = 'CCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'DISTRIBUCIONCENTRODECOSTO'
				lcCampo = 'DCCOSTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'JJTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'TIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'JJVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'NRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'JJCO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'JJNUM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CONDPAGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEVUELTO'
				lcCampo = 'PERMVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
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
			Case upper( alltrim( tcAtributo ) ) == 'MINIMONOIMPONIBLE'
				lcCampo = 'MINOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOINTERNO'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTO'
				lcCampo = 'TIPOI'
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
			local  lxFaccompraFecimpo, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFmodifw, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraTimestamp, lxFaccompraDesmntosi1, lxFaccompraRecmntosi2, lxFaccompraDesmntosi, lxFaccompraTotalcant, lxFaccompraRecmntosi1, lxFaccompraDesmntosi2, lxFaccompraFptoven, lxFaccompraSignomov, lxFaccompraRecmntosi, lxFaccompraFsubton, lxFaccompraFacttipo, lxFaccompraSitfiscpro, lxFaccompraFsubtot, lxFaccompraCondivalp, lxFaccompraSubtotsisi, lxFaccompraSubtotcisi, lxFaccompraRecmnto2, lxFaccompraRecmnto1, lxFaccompraFcompfis, lxFaccompraAnulado, lxFaccompraDesauto, lxFaccompraFhora, lxFaccompraHoraexpo, lxFaccompraHoraimpo, lxFaccompraHaltafw, lxFaccompraUmodifw, lxFaccompraZadsfw, lxFaccompraDescfw, lxFaccompraVmodifw, lxFaccompraUaltafw, lxFaccompraValtafw, lxFaccompraSaltafw, lxFaccompraSmodifw, lxFaccompraHmodifw, lxFaccompraSimbmon, lxFaccompraEsttrans, lxFaccompraBdaltafw, lxFaccompraBdmodifw, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraMoneda, lxFaccompraFobs, lxFaccompraFfch, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFmtdes2, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfchfac, lxFaccompraFletra, lxFaccompraDesmntosi3, lxFaccompraFmtdes3, lxFaccompraImpman, lxFaccompraFfchvenc, lxFaccompraRecpor, lxFaccompraFptovenext, lxFaccompraTotdescsi, lxFaccompraCondpago, lxFaccompraMr, lxFaccompraFnumcomp, lxFaccompraNcai, lxFaccompraRecmnto, lxFaccompraNroremito, lxFaccompraFvtocai, lxFaccompraFvuelto, lxFaccompraFperson, lxFaccompraCodlista, lxFaccompraCotiz, lxFaccompraCcosto, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraTotimpue, lxFaccompraTotrecarsi, lxFaccompraTotrecar, lxFaccompraTotdesc
				lxFaccompraFecimpo =  .Fechaimpo			lxFaccompraFaltafw =  .Fechaaltafw			lxFaccompraFecexpo =  .Fechaexpo			lxFaccompraFectrans =  .Fechatransferencia			lxFaccompraFmodifw =  .Fechamodificacionfw			lxFaccompraFd2 =  .Fechamodificacion			lxFaccompraFcuit =  .Cuit			lxFaccompraIdcaja =  .Caja_PK 			lxFaccompraFpodes1 =  .Porcentajedescuento1			lxFaccompraFpodes2 =  .Porcentajedescuento2			lxFaccompraFpodes =  .Porcentajedescuento			lxFaccompraFturno =  .Turno			lxFaccompraNumint =  .Numint			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxFaccompraRecmntosi2 =  .Recargomontosinimpuestos2			lxFaccompraDesmntosi =  .Montodescuentosinimpuestos			lxFaccompraTotalcant =  .Totalcantidad			lxFaccompraRecmntosi1 =  .Recargomontosinimpuestos1			lxFaccompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxFaccompraFptoven =  .Puntodeventa			lxFaccompraSignomov =  .Signodemovimiento			lxFaccompraRecmntosi =  .Recargomontosinimpuestos			lxFaccompraFsubton =  .Subtotalneto			lxFaccompraFacttipo =  .Tipocomprobante			lxFaccompraSitfiscpro =  .Situacionfiscal_PK 			lxFaccompraFsubtot =  .Subtotalbruto			lxFaccompraCondivalp =  .Condicioniva			lxFaccompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxFaccompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxFaccompraRecmnto2 =  .Recargomontoconimpuestos2			lxFaccompraRecmnto1 =  .Recargomontoconimpuestos1			lxFaccompraFcompfis =  .Comprobantefiscal			lxFaccompraAnulado =  .Anulado			lxFaccompraDesauto =  .Descuentoautomatico			lxFaccompraFhora =  .Hora			lxFaccompraHoraexpo =  .Horaexpo			lxFaccompraHoraimpo =  .Horaimpo			lxFaccompraHaltafw =  .Horaaltafw			lxFaccompraUmodifw =  .Usuariomodificacionfw			lxFaccompraZadsfw =  .Zadsfw			lxFaccompraDescfw =  .Descripcionfw			lxFaccompraVmodifw =  .Versionmodificacionfw			lxFaccompraUaltafw =  .Usuarioaltafw			lxFaccompraValtafw =  .Versionaltafw			lxFaccompraSaltafw =  .Seriealtafw			lxFaccompraSmodifw =  .Seriemodificacionfw			lxFaccompraHmodifw =  .Horamodificacionfw			lxFaccompraSimbmon =  .Simbolomonetariocomprobante			lxFaccompraEsttrans =  .Estadotransferencia			lxFaccompraBdaltafw =  .Basededatosaltafw			lxFaccompraBdmodifw =  .Basededatosmodificacionfw			lxFaccompraIdvuelto =  upper( .IdVuelto_PK ) 			lxFaccompraMonsis =  upper( .MonedaSistema_PK ) 			lxFaccompraMoneda =  upper( .MonedaComprobante_PK ) 			lxFaccompraFobs =  .Obs			lxFaccompraFfch =  .Fecha			lxFaccompraFmtdes1 =  .Montodescuentoconimpuestos1			lxFaccompraFdescu =  .Descuento			lxFaccompraFmtdes2 =  .Montodescuentoconimpuestos2			lxFaccompraFimpuesto =  .Impuestos			lxFaccompraTcrg1361 =  .Tipocomprobanterg1361			lxFaccompraCodigo =  .Codigo			lxFaccompraFfchfac =  .Fechafactura			lxFaccompraFletra =  .Letra			lxFaccompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxFaccompraFmtdes3 =  .Montodescuentoconimpuestos3			lxFaccompraImpman =  .Impuestosmanuales			lxFaccompraFfchvenc =  .Fechavencimiento			lxFaccompraRecpor =  .Recargoporcentaje			lxFaccompraFptovenext =  .Puntodeventaextendido			lxFaccompraTotdescsi =  .Totaldescuentossinimpuestos			lxFaccompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxFaccompraMr =  .Recargomonto			lxFaccompraFnumcomp =  .Numero			lxFaccompraNcai =  .Cai			lxFaccompraRecmnto =  .Recargomontoconimpuestos			lxFaccompraNroremito =  .Remito			lxFaccompraFvtocai =  .Fechavtocai			lxFaccompraFvuelto =  .Vuelto			lxFaccompraFperson =  upper( .Proveedor_PK ) 			lxFaccompraCodlista =  upper( .ListaDePrecios_PK ) 			lxFaccompraCotiz =  .Cotizacion			lxFaccompraCcosto =  upper( .CentroDeCosto_PK ) 			lxFaccompraFtotal =  .Total			lxFaccompraRecmonto1 =  .Recargomonto1			lxFaccompraRecmonto2 =  .Recargomonto2			lxFaccompraDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxFaccompraTotimpue =  .Totalimpuestos			lxFaccompraTotrecarsi =  .Totalrecargossinimpuestos			lxFaccompraTotrecar =  .Totalrecargos			lxFaccompraTotdesc =  .Totaldescuentos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.FACCOMPRA ( "Fecimpo","Faltafw","Fecexpo","Fectrans","Fmodifw","Fd2","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fturno","Numint","Timestamp","Desmntosi1","Recmntosi2","Desmntosi","Totalcant","Recmntosi1","Desmntosi2","Fptoven","Signomov","Recmntosi","Fsubton","Facttipo","Sitfiscpro","Fsubtot","Condivalp","Subtotsisi","Subtotcisi","Recmnto2","Recmnto1","Fcompfis","Anulado","Desauto","Fhora","Horaexpo","Horaimpo","Haltafw","Umodifw","Zadsfw","Descfw","Vmodifw","Ualtafw","Valtafw","Saltafw","Smodifw","Hmodifw","Simbmon","Esttrans","Bdaltafw","Bdmodifw","Idvuelto","Monsis","Moneda","Fobs","Ffch","Fmtdes1","Fdescu","Fmtdes2","Fimpuesto","Tcrg1361","Codigo","Ffchfac","Fletra","Desmntosi3","Fmtdes3","Impman","Ffchvenc","Recpor","Fptovenext","Totdescsi","Condpago","Mr","Fnumcomp","Ncai","Recmnto","Nroremito","Fvtocai","Fvuelto","Fperson","Codlista","Cotiz","Ccosto","Ftotal","Recmonto1","Recmonto2","Disccos","Totimpue","Totrecarsi","Totrecar","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxFaccompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFd2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFcuit ) + "'" >>, <<lxFaccompraIdcaja >>, <<lxFaccompraFpodes1 >>, <<lxFaccompraFpodes2 >>, <<lxFaccompraFpodes >>, <<lxFaccompraFturno >>, <<lxFaccompraNumint >>, <<lxFaccompraTimestamp >>, <<lxFaccompraDesmntosi1 >>, <<lxFaccompraRecmntosi2 >>, <<lxFaccompraDesmntosi >>, <<lxFaccompraTotalcant >>, <<lxFaccompraRecmntosi1 >>, <<lxFaccompraDesmntosi2 >>, <<lxFaccompraFptoven >>, <<lxFaccompraSignomov >>, <<lxFaccompraRecmntosi >>, <<lxFaccompraFsubton >>, <<lxFaccompraFacttipo >>, <<lxFaccompraSitfiscpro >>, <<lxFaccompraFsubtot >>, <<lxFaccompraCondivalp >>, <<lxFaccompraSubtotsisi >>, <<lxFaccompraSubtotcisi >>, <<lxFaccompraRecmnto2 >>, <<lxFaccompraRecmnto1 >>, <<iif( lxFaccompraFcompfis, 1, 0 ) >>, <<iif( lxFaccompraAnulado, 1, 0 ) >>, <<iif( lxFaccompraDesauto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFaccompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfch ) + "'" >>, <<lxFaccompraFmtdes1 >>, <<lxFaccompraFdescu >>, <<lxFaccompraFmtdes2 >>, <<lxFaccompraFimpuesto >>, <<lxFaccompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfchfac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFletra ) + "'" >>, <<lxFaccompraDesmntosi3 >>, <<lxFaccompraFmtdes3 >>, <<iif( lxFaccompraImpman, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfchvenc ) + "'" >>, <<lxFaccompraRecpor >>, <<lxFaccompraFptovenext >>, <<lxFaccompraTotdescsi >>, <<"'" + this.FormatearTextoSql( lxFaccompraCondpago ) + "'" >>, <<lxFaccompraMr >>, <<lxFaccompraFnumcomp >>, <<lxFaccompraNcai >>, <<lxFaccompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxFaccompraNroremito ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFvtocai ) + "'" >>, <<lxFaccompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxFaccompraFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraCodlista ) + "'" >>, <<lxFaccompraCotiz >>, <<"'" + this.FormatearTextoSql( lxFaccompraCcosto ) + "'" >>, <<lxFaccompraFtotal >>, <<lxFaccompraRecmonto1 >>, <<lxFaccompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxFaccompraDisccos ) + "'" >>, <<lxFaccompraTotimpue >>, <<lxFaccompraTotrecarsi >>, <<lxFaccompraTotrecar >>, <<lxFaccompraTotdesc >> )
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
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_numero = loItem.Afe_numero
					lxAfe_letra = loItem.Afe_letra
					lxArticulo_PK = loItem.Articulo_PK
					lxAfe_timestamp = loItem.Afe_timestamp
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAfe_saldo = loItem.Afe_saldo
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxBruto = loItem.Bruto
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAfe_nroitem = loItem.Afe_nroitem
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxMontocfi = loItem.Montocfi
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxComportamiento = loItem.Comportamiento
					lxKit = loItem.Kit
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPorcentajeiva = loItem.Porcentajeiva
					lxIdorigen = loItem.Idorigen
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
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
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDistribucioncentrodecosto_PK = loItem.Distribucioncentrodecosto_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FacCompraDet("AfePTOVEN","AfeNUMCOM","AfeLETRA","FART","AfeTS","APorcIvaC","AfeCANT","ACondIvaC","ArtPercep","AfeSaldo","MNTPPER","MNTPRECCI","MNDESSI","MNDESCI","FBruto","MNPDSI","AjuCImp","MNTPDESCI","AfeTipoCom","MNTPRECSI","MNTPTOT","MNTPDESSI","AfeNroItem","FNETO","FmtoIVA","NroItem","FmtoDTO1","AjuSImp","FmtoCFI","FCFITot","COMP","FKIT","FporCFI","FX2","FporDTO1","FN11","FPRUN","prunconimp","Prunsinimp","fporIva","iditemOrig","ProcStock","UsarPLista","afe_Cod","FAMate","IdItem","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO","CCOSTO","DCCOSTO" ) values ( <<lxAfe_puntodeventa>>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_cantidad>>, <<lxArticulo_condicionivacompras>>, <<lxPercepcionivarg5329>>, <<lxAfe_saldo>>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxBruto>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAjusteporredondeoconimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAfe_nroitem>>, <<lxNeto>>, <<lxMontoiva>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxAjusteporredondeosinimpuestos>>, <<lxMontocfi>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxComportamiento>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxPorcentajeiva>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDistribucioncentrodecosto_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.FacCompraDet" )
this.xmlacursor( lcXml, 'c_FacCompraDetciditem' )
loItem.idItem = c_FacCompraDetciditem.ciditem
use in select( 'c_FacCompraDetciditem' )
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
					lxTipo = loItem.Tipo
					lxTurno = loItem.Turno
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxSigno = loItem.Signo
					lxPuntodeventa = loItem.Puntodeventa
					lxPesosalcambio = loItem.Pesosalcambio
					lxCotiza = loItem.Cotiza
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxLetra = loItem.Letra
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodocumento = loItem.Tipodocumento
					lxVendedor = loItem.Vendedor
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
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
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJT","JJTurno","Cotiza","Signo","PtoVenta","Pesos","JJCotiz","NroCupon","NroItem","NumCompr","VisualCaja","PersComp","CElectro","Letra","NroTarjeta","TipoDoc","JJVen","NroDoc","TIPCOMP","JJCO","NroChProp","JJNUM","NroCheque","CondPago","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxTurno>>, <<lxUltimacotizacion>>, <<lxSigno>>, <<lxPuntodeventa>>, <<lxPesosalcambio>>, <<lxCotiza>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxNumerodecomprobante>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
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
					
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacc("minoimp","NroItem","porcen","codint","TipoI","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
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
			local  lxFaccompraFecimpo, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFmodifw, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraTimestamp, lxFaccompraDesmntosi1, lxFaccompraRecmntosi2, lxFaccompraDesmntosi, lxFaccompraTotalcant, lxFaccompraRecmntosi1, lxFaccompraDesmntosi2, lxFaccompraFptoven, lxFaccompraSignomov, lxFaccompraRecmntosi, lxFaccompraFsubton, lxFaccompraFacttipo, lxFaccompraSitfiscpro, lxFaccompraFsubtot, lxFaccompraCondivalp, lxFaccompraSubtotsisi, lxFaccompraSubtotcisi, lxFaccompraRecmnto2, lxFaccompraRecmnto1, lxFaccompraFcompfis, lxFaccompraAnulado, lxFaccompraDesauto, lxFaccompraFhora, lxFaccompraHoraexpo, lxFaccompraHoraimpo, lxFaccompraHaltafw, lxFaccompraUmodifw, lxFaccompraZadsfw, lxFaccompraDescfw, lxFaccompraVmodifw, lxFaccompraUaltafw, lxFaccompraValtafw, lxFaccompraSaltafw, lxFaccompraSmodifw, lxFaccompraHmodifw, lxFaccompraSimbmon, lxFaccompraEsttrans, lxFaccompraBdaltafw, lxFaccompraBdmodifw, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraMoneda, lxFaccompraFobs, lxFaccompraFfch, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFmtdes2, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfchfac, lxFaccompraFletra, lxFaccompraDesmntosi3, lxFaccompraFmtdes3, lxFaccompraImpman, lxFaccompraFfchvenc, lxFaccompraRecpor, lxFaccompraFptovenext, lxFaccompraTotdescsi, lxFaccompraCondpago, lxFaccompraMr, lxFaccompraFnumcomp, lxFaccompraNcai, lxFaccompraRecmnto, lxFaccompraNroremito, lxFaccompraFvtocai, lxFaccompraFvuelto, lxFaccompraFperson, lxFaccompraCodlista, lxFaccompraCotiz, lxFaccompraCcosto, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraTotimpue, lxFaccompraTotrecarsi, lxFaccompraTotrecar, lxFaccompraTotdesc
				lxFaccompraFecimpo =  .Fechaimpo			lxFaccompraFaltafw =  .Fechaaltafw			lxFaccompraFecexpo =  .Fechaexpo			lxFaccompraFectrans =  .Fechatransferencia			lxFaccompraFmodifw =  .Fechamodificacionfw			lxFaccompraFd2 =  .Fechamodificacion			lxFaccompraFcuit =  .Cuit			lxFaccompraIdcaja =  .Caja_PK 			lxFaccompraFpodes1 =  .Porcentajedescuento1			lxFaccompraFpodes2 =  .Porcentajedescuento2			lxFaccompraFpodes =  .Porcentajedescuento			lxFaccompraFturno =  .Turno			lxFaccompraNumint =  .Numint			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxFaccompraRecmntosi2 =  .Recargomontosinimpuestos2			lxFaccompraDesmntosi =  .Montodescuentosinimpuestos			lxFaccompraTotalcant =  .Totalcantidad			lxFaccompraRecmntosi1 =  .Recargomontosinimpuestos1			lxFaccompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxFaccompraFptoven =  .Puntodeventa			lxFaccompraSignomov =  .Signodemovimiento			lxFaccompraRecmntosi =  .Recargomontosinimpuestos			lxFaccompraFsubton =  .Subtotalneto			lxFaccompraFacttipo =  .Tipocomprobante			lxFaccompraSitfiscpro =  .Situacionfiscal_PK 			lxFaccompraFsubtot =  .Subtotalbruto			lxFaccompraCondivalp =  .Condicioniva			lxFaccompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxFaccompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxFaccompraRecmnto2 =  .Recargomontoconimpuestos2			lxFaccompraRecmnto1 =  .Recargomontoconimpuestos1			lxFaccompraFcompfis =  .Comprobantefiscal			lxFaccompraAnulado =  .Anulado			lxFaccompraDesauto =  .Descuentoautomatico			lxFaccompraFhora =  .Hora			lxFaccompraHoraexpo =  .Horaexpo			lxFaccompraHoraimpo =  .Horaimpo			lxFaccompraHaltafw =  .Horaaltafw			lxFaccompraUmodifw =  .Usuariomodificacionfw			lxFaccompraZadsfw =  .Zadsfw			lxFaccompraDescfw =  .Descripcionfw			lxFaccompraVmodifw =  .Versionmodificacionfw			lxFaccompraUaltafw =  .Usuarioaltafw			lxFaccompraValtafw =  .Versionaltafw			lxFaccompraSaltafw =  .Seriealtafw			lxFaccompraSmodifw =  .Seriemodificacionfw			lxFaccompraHmodifw =  .Horamodificacionfw			lxFaccompraSimbmon =  .Simbolomonetariocomprobante			lxFaccompraEsttrans =  .Estadotransferencia			lxFaccompraBdaltafw =  .Basededatosaltafw			lxFaccompraBdmodifw =  .Basededatosmodificacionfw			lxFaccompraIdvuelto =  upper( .IdVuelto_PK ) 			lxFaccompraMonsis =  upper( .MonedaSistema_PK ) 			lxFaccompraMoneda =  upper( .MonedaComprobante_PK ) 			lxFaccompraFobs =  .Obs			lxFaccompraFfch =  .Fecha			lxFaccompraFmtdes1 =  .Montodescuentoconimpuestos1			lxFaccompraFdescu =  .Descuento			lxFaccompraFmtdes2 =  .Montodescuentoconimpuestos2			lxFaccompraFimpuesto =  .Impuestos			lxFaccompraTcrg1361 =  .Tipocomprobanterg1361			lxFaccompraCodigo =  .Codigo			lxFaccompraFfchfac =  .Fechafactura			lxFaccompraFletra =  .Letra			lxFaccompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxFaccompraFmtdes3 =  .Montodescuentoconimpuestos3			lxFaccompraImpman =  .Impuestosmanuales			lxFaccompraFfchvenc =  .Fechavencimiento			lxFaccompraRecpor =  .Recargoporcentaje			lxFaccompraFptovenext =  .Puntodeventaextendido			lxFaccompraTotdescsi =  .Totaldescuentossinimpuestos			lxFaccompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxFaccompraMr =  .Recargomonto			lxFaccompraFnumcomp =  .Numero			lxFaccompraNcai =  .Cai			lxFaccompraRecmnto =  .Recargomontoconimpuestos			lxFaccompraNroremito =  .Remito			lxFaccompraFvtocai =  .Fechavtocai			lxFaccompraFvuelto =  .Vuelto			lxFaccompraFperson =  upper( .Proveedor_PK ) 			lxFaccompraCodlista =  upper( .ListaDePrecios_PK ) 			lxFaccompraCotiz =  .Cotizacion			lxFaccompraCcosto =  upper( .CentroDeCosto_PK ) 			lxFaccompraFtotal =  .Total			lxFaccompraRecmonto1 =  .Recargomonto1			lxFaccompraRecmonto2 =  .Recargomonto2			lxFaccompraDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxFaccompraTotimpue =  .Totalimpuestos			lxFaccompraTotrecarsi =  .Totalrecargossinimpuestos			lxFaccompraTotrecar =  .Totalrecargos			lxFaccompraTotdesc =  .Totaldescuentos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8]
			text to lcSentencia noshow textmerge
				update ZooLogic.FACCOMPRA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxFaccompraFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxFaccompraFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxFaccompraFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxFaccompraFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxFaccompraFmodifw ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxFaccompraFd2 ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxFaccompraFcuit ) + "'">>, "Idcaja" = <<lxFaccompraIdcaja>>, "Fpodes1" = <<lxFaccompraFpodes1>>, "Fpodes2" = <<lxFaccompraFpodes2>>, "Fpodes" = <<lxFaccompraFpodes>>, "Fturno" = <<lxFaccompraFturno>>, "Numint" = <<lxFaccompraNumint>>, "Timestamp" = <<lxFaccompraTimestamp>>, "Desmntosi1" = <<lxFaccompraDesmntosi1>>, "Recmntosi2" = <<lxFaccompraRecmntosi2>>, "Desmntosi" = <<lxFaccompraDesmntosi>>, "Totalcant" = <<lxFaccompraTotalcant>>, "Recmntosi1" = <<lxFaccompraRecmntosi1>>, "Desmntosi2" = <<lxFaccompraDesmntosi2>>, "Fptoven" = <<lxFaccompraFptoven>>, "Signomov" = <<lxFaccompraSignomov>>, "Recmntosi" = <<lxFaccompraRecmntosi>>, "Fsubton" = <<lxFaccompraFsubton>>, "Facttipo" = <<lxFaccompraFacttipo>>, "Sitfiscpro" = <<lxFaccompraSitfiscpro>>, "Fsubtot" = <<lxFaccompraFsubtot>>, "Condivalp" = <<lxFaccompraCondivalp>>, "Subtotsisi" = <<lxFaccompraSubtotsisi>>, "Subtotcisi" = <<lxFaccompraSubtotcisi>>, "Recmnto2" = <<lxFaccompraRecmnto2>>, "Recmnto1" = <<lxFaccompraRecmnto1>>, "Fcompfis" = <<iif( lxFaccompraFcompfis, 1, 0 )>>, "Anulado" = <<iif( lxFaccompraAnulado, 1, 0 )>>, "Desauto" = <<iif( lxFaccompraDesauto, 1, 0 )>>, "Fhora" = <<"'" + this.FormatearTextoSql( lxFaccompraFhora ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxFaccompraHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxFaccompraHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraHaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxFaccompraZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxFaccompraDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxFaccompraUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxFaccompraValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraHmodifw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxFaccompraSimbmon ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxFaccompraEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraBdmodifw ) + "'">>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxFaccompraIdvuelto ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxFaccompraMonsis ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxFaccompraMoneda ) + "'">>, "Fobs" = <<"'" + this.FormatearTextoSql( lxFaccompraFobs ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxFaccompraFfch ) + "'">>, "Fmtdes1" = <<lxFaccompraFmtdes1>>, "Fdescu" = <<lxFaccompraFdescu>>, "Fmtdes2" = <<lxFaccompraFmtdes2>>, "Fimpuesto" = <<lxFaccompraFimpuesto>>, "Tcrg1361" = <<lxFaccompraTcrg1361>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'">>, "Ffchfac" = <<"'" + this.ConvertirDateSql( lxFaccompraFfchfac ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxFaccompraFletra ) + "'">>, "Desmntosi3" = <<lxFaccompraDesmntosi3>>, "Fmtdes3" = <<lxFaccompraFmtdes3>>, "Impman" = <<iif( lxFaccompraImpman, 1, 0 )>>, "Ffchvenc" = <<"'" + this.ConvertirDateSql( lxFaccompraFfchvenc ) + "'">>, "Recpor" = <<lxFaccompraRecpor>>, "Fptovenext" = <<lxFaccompraFptovenext>>, "Totdescsi" = <<lxFaccompraTotdescsi>>, "Condpago" = <<"'" + this.FormatearTextoSql( lxFaccompraCondpago ) + "'">>, "Mr" = <<lxFaccompraMr>>, "Fnumcomp" = <<lxFaccompraFnumcomp>>, "Ncai" = <<lxFaccompraNcai>>, "Recmnto" = <<lxFaccompraRecmnto>>, "Nroremito" = <<"'" + this.FormatearTextoSql( lxFaccompraNroremito ) + "'">>, "Fvtocai" = <<"'" + this.ConvertirDateSql( lxFaccompraFvtocai ) + "'">>, "Fvuelto" = <<lxFaccompraFvuelto>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxFaccompraFperson ) + "'">>, "Codlista" = <<"'" + this.FormatearTextoSql( lxFaccompraCodlista ) + "'">>, "Cotiz" = <<lxFaccompraCotiz>>, "Ccosto" = <<"'" + this.FormatearTextoSql( lxFaccompraCcosto ) + "'">>, "Ftotal" = <<lxFaccompraFtotal>>, "Recmonto1" = <<lxFaccompraRecmonto1>>, "Recmonto2" = <<lxFaccompraRecmonto2>>, "Disccos" = <<"'" + this.FormatearTextoSql( lxFaccompraDisccos ) + "'">>, "Totimpue" = <<lxFaccompraTotimpue>>, "Totrecarsi" = <<lxFaccompraTotrecarsi>>, "Totrecar" = <<lxFaccompraTotrecar>>, "Totdesc" = <<lxFaccompraTotdesc>> where << lcFiltro >>
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
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_numero = loItem.Afe_numero
					lxAfe_letra = loItem.Afe_letra
					lxArticulo_PK = loItem.Articulo_PK
					lxAfe_timestamp = loItem.Afe_timestamp
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAfe_saldo = loItem.Afe_saldo
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxBruto = loItem.Bruto
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAfe_nroitem = loItem.Afe_nroitem
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxMontocfi = loItem.Montocfi
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxComportamiento = loItem.Comportamiento
					lxKit = loItem.Kit
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPorcentajeiva = loItem.Porcentajeiva
					lxIdorigen = loItem.Idorigen
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
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
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDistribucioncentrodecosto_PK = loItem.Distribucioncentrodecosto_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FacCompraDet("AfePTOVEN","AfeNUMCOM","AfeLETRA","FART","AfeTS","APorcIvaC","AfeCANT","ACondIvaC","ArtPercep","AfeSaldo","MNTPPER","MNTPRECCI","MNDESSI","MNDESCI","FBruto","MNPDSI","AjuCImp","MNTPDESCI","AfeTipoCom","MNTPRECSI","MNTPTOT","MNTPDESSI","AfeNroItem","FNETO","FmtoIVA","NroItem","FmtoDTO1","AjuSImp","FmtoCFI","FCFITot","COMP","FKIT","FporCFI","FX2","FporDTO1","FN11","FPRUN","prunconimp","Prunsinimp","fporIva","iditemOrig","ProcStock","UsarPLista","afe_Cod","FAMate","IdItem","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO","CCOSTO","DCCOSTO" ) values ( <<lxAfe_puntodeventa>>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_cantidad>>, <<lxArticulo_condicionivacompras>>, <<lxPercepcionivarg5329>>, <<lxAfe_saldo>>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxBruto>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAjusteporredondeoconimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAfe_nroitem>>, <<lxNeto>>, <<lxMontoiva>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxAjusteporredondeosinimpuestos>>, <<lxMontocfi>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxComportamiento>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxPorcentajeiva>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDistribucioncentrodecosto_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.FacCompraDet" )
this.xmlacursor( lcXml, 'c_FacCompraDetciditem' )
loItem.idItem = c_FacCompraDetciditem.ciditem
use in select( 'c_FacCompraDetciditem' )
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
					lxTipo = loItem.Tipo
					lxTurno = loItem.Turno
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxSigno = loItem.Signo
					lxPuntodeventa = loItem.Puntodeventa
					lxPesosalcambio = loItem.Pesosalcambio
					lxCotiza = loItem.Cotiza
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxLetra = loItem.Letra
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodocumento = loItem.Tipodocumento
					lxVendedor = loItem.Vendedor
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
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
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJT","JJTurno","Cotiza","Signo","PtoVenta","Pesos","JJCotiz","NroCupon","NroItem","NumCompr","VisualCaja","PersComp","CElectro","Letra","NroTarjeta","TipoDoc","JJVen","NroDoc","TIPCOMP","JJCO","NroChProp","JJNUM","NroCheque","CondPago","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxTurno>>, <<lxUltimacotizacion>>, <<lxSigno>>, <<lxPuntodeventa>>, <<lxPesosalcambio>>, <<lxCotiza>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxNumerodecomprobante>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
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
					
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacc("minoimp","NroItem","porcen","codint","TipoI","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
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
					"Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Afecant" as "Afe_cantidad", "Acondivac" as "Articulo_condicionivacompras", "Artpercep" as "Percepcionivarg5329", "Afesaldo" as "Afe_saldo", "Mntpper" as "Montoprorrateopercepciones", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Fbruto" as "Bruto", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afenroitem" as "Afe_nroitem", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Fmtocfi" as "Montocfi", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Fporiva" as "Porcentajeiva", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto"
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.FACCOMPRA set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, NumInt = ] + transform( &lcCursor..NumInt )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, SitFiscPro = ] + transform( &lcCursor..SitFiscPro )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, DesAuto = ] + Transform( iif( &lcCursor..DesAuto, 1, 0 ))+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, tcrg1361 = ] + transform( &lcCursor..tcrg1361 )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, FFCHFAC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, ImpMan = ] + Transform( iif( &lcCursor..ImpMan, 1, 0 ))+ [, FFCHVENC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'"+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, FPTOVENEXT = ] + transform( &lcCursor..FPTOVENEXT )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, CONDPAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"+ [, MR = ] + transform( &lcCursor..MR )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, NCAI = ] + transform( &lcCursor..NCAI )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, NROREMITO = ] + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"+ [, FVTOCAI = ] + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'"+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, CCosto = ] + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, RecMonto1 = ] + transform( &lcCursor..RecMonto1 )+ [, RecMonto2 = ] + transform( &lcCursor..RecMonto2 )+ [, DisCCos = ] + "'" + this.FormatearTextoSql( &lcCursor..DisCCos ) + "'"+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totdesc = ] + transform( &lcCursor..totdesc ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
						 FECIMPO, FALTAFW, FECEXPO, FECTRANS, FMODIFW, FD2, fCuit, IdCaja, FPODES1, FPODES2, FPODES, FTurno, NumInt, TIMESTAMP, DesMntoSI1, RecMntoSI2, DesMntoSI, TotalCant, RecMntoSI1, DesMntoSI2, FPTOVEN, signomov, RecMntoSI, fSubToN, FACTTIPO, SitFiscPro, FSubTOT, CondivaLp, SubTotSISI, SubTotCISI, RecMnto2, RecMnto1, FCOMPFIS, Anulado, DesAuto, FHORA, HORAEXPO, HORAIMPO, HALTAFW, UMODIFW, ZADSFW, DescFW, VMODIFW, UALTAFW, VALTAFW, SALTAFW, SMODIFW, HMODIFW, SimbMon, ESTTRANS, BDALTAFW, BDMODIFW, idVuelto, MonSis, Moneda, FObs, FFCH, FMTDES1, fDescu, FMTDES2, fImpuesto, tcrg1361, CODIGO, FFCHFAC, FLETRA, DesMntoSI3, FMTDES3, ImpMan, FFCHVENC, RecPor, FPTOVENEXT, totdescSI, CONDPAGO, MR, FNUMCOMP, NCAI, RecMnto, NROREMITO, FVTOCAI, FVuelto, FPerson, CodLista, Cotiz, CCosto, FTotal, RecMonto1, RecMonto2, DisCCos, totimpue, totrecarSI, totrecar, totdesc
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..FPODES1 ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..FTurno ) + ',' + transform( &lcCursor..NumInt ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + transform( &lcCursor..DesMntoSI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..RecMntoSI ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..SitFiscPro ) + ',' + transform( &lcCursor..FSubTOT )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..DesAuto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FMTDES1 ) + ',' + transform( &lcCursor..fDescu ) + ',' + transform( &lcCursor..FMTDES2 ) + ',' + transform( &lcCursor..fImpuesto ) + ',' + transform( &lcCursor..tcrg1361 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..DesMntoSI3 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FMTDES3 ) + ',' + Transform( iif( &lcCursor..ImpMan, 1, 0 )) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'" + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..FPTOVENEXT ) + ',' + transform( &lcCursor..totdescSI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'" + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..FNUMCOMP )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NCAI ) + ',' + transform( &lcCursor..RecMnto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'" + ',' + transform( &lcCursor..FVuelto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + transform( &lcCursor..Cotiz )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + transform( &lcCursor..RecMonto1 ) + ',' + transform( &lcCursor..RecMonto2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DisCCos ) + "'" + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..totrecar ) + ',' + transform( &lcCursor..totdesc )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.FACCOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
			"NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfePTOVEN","AfeNUMCOM","AfeLETRA","FART","AfeTS","APorcIvaC","AfeCANT","ACondIvaC","ArtPercep","AfeSaldo","MNTPPER","MNTPRECCI","MNDESSI","MNDESCI","FBruto","MNPDSI","AjuCImp","MNTPDESCI","AfeTipoCom","MNTPRECSI","MNTPTOT","MNTPDESSI","AfeNroItem","FNETO","FmtoIVA","NroItem","FmtoDTO1","AjuSImp","FmtoCFI","FCFITot","COMP","FKIT","FporCFI","FX2","FporDTO1","FN11","FPRUN","prunconimp","Prunsinimp","fporIva","iditemOrig","ProcStock","UsarPLista","afe_Cod","FAMate","IdItem","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO","CCOSTO","DCCOSTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.FacCompraDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.APorcIvaC  ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.ACondIvaC  ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_Cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CCOSTO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DCCOSTO    ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALORESCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where JJNUM in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"FechCoti","JJfecha","IdCaja","JJT","JJTurno","Cotiza","Signo","PtoVenta","Pesos","JJCotiz","NroCupon","NroItem","NumCompr","VisualCaja","PersComp","CElectro","Letra","NroTarjeta","TipoDoc","JJVen","NroDoc","TIPCOMP","JJCO","NroChProp","JJNUM","NroCheque","CondPago","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","permvuelto","guidComp","ValeCambio"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ValFacComp ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.JJTurno    ) + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + transform( cDetallesExistentes.PtoVenta   ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.PersComp  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoDoc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJVen      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroDoc     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TIPCOMP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJNUM      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CondPago   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.jrecporc   ) + ',' + transform( cDetallesExistentes.jrecmnt    ) + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + transform( cDetallesExistentes.jrecmntsi  ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + transform( cDetallesExistentes.jrrecsperc ) + ',' + Transform( iif( cDetallesExistentes.permvuelto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValeCambio ) + "'" + ' )'  )
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
			"minoimp","NroItem","porcen","codint","TipoI","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpFacc ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.porcen     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + Transform( iif( cDetallesExistentes.ArtPerce  , 1, 0 )) + ' )'  )
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
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
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
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fd2" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"fturno" numeric( 1, 0 )  null, 
"numint" numeric( 10, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"desmntosi1" numeric( 8, 2 )  null, 
"recmntosi2" numeric( 8, 2 )  null, 
"desmntosi" numeric( 8, 2 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"recmntosi1" numeric( 8, 2 )  null, 
"desmntosi2" numeric( 8, 2 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"signomov" numeric( 2, 0 )  null, 
"recmntosi" numeric( 8, 2 )  null, 
"fsubton" numeric( 8, 2 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"sitfiscpro" numeric( 2, 0 )  null, 
"fsubtot" numeric( 8, 2 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"subtotsisi" numeric( 10, 2 )  null, 
"subtotcisi" numeric( 10, 2 )  null, 
"recmnto2" numeric( 8, 2 )  null, 
"recmnto1" numeric( 8, 2 )  null, 
"fcompfis" bit  null, 
"anulado" bit  null, 
"desauto" bit  null, 
"fhora" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"simbmon" char( 3 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"idvuelto" char( 5 )  null, 
"monsis" char( 10 )  null, 
"moneda" char( 10 )  null, 
"fobs" varchar(max)  null, 
"ffch" datetime  null, 
"fmtdes1" numeric( 8, 2 )  null, 
"fdescu" numeric( 8, 2 )  null, 
"fmtdes2" numeric( 8, 2 )  null, 
"fimpuesto" numeric( 8, 2 )  null, 
"tcrg1361" numeric( 1, 0 )  null, 
"codigo" char( 38 )  null, 
"ffchfac" datetime  null, 
"fletra" char( 2 )  null, 
"desmntosi3" numeric( 8, 2 )  null, 
"fmtdes3" numeric( 6, 2 )  null, 
"impman" bit  null, 
"ffchvenc" datetime  null, 
"recpor" numeric( 6, 2 )  null, 
"fptovenext" numeric( 5, 0 )  null, 
"totdescsi" numeric( 8, 2 )  null, 
"condpago" char( 5 )  null, 
"mr" numeric( 15, 2 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"ncai" numeric( 14, 0 )  null, 
"recmnto" numeric( 8, 2 )  null, 
"nroremito" char( 16 )  null, 
"fvtocai" datetime  null, 
"fvuelto" numeric( 8, 2 )  null, 
"fperson" char( 5 )  null, 
"codlista" char( 6 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"ccosto" char( 20 )  null, 
"ftotal" numeric( 16, 2 )  null, 
"recmonto1" numeric( 15, 2 )  null, 
"recmonto2" numeric( 15, 2 )  null, 
"disccos" char( 20 )  null, 
"totimpue" numeric( 8, 2 )  null, 
"totrecarsi" numeric( 8, 2 )  null, 
"totrecar" numeric( 8, 2 )  null, 
"totdesc" numeric( 8, 2 )  null )
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('numint','numint')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('sitfiscpro','sitfiscpro')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('desauto','desauto')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('tcrg1361','tcrg1361')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('ffchfac','ffchfac')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('impman','impman')
			.AgregarMapeo('ffchvenc','ffchvenc')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('fptovenext','fptovenext')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('condpago','condpago')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('ncai','ncai')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('nroremito','nroremito')
			.AgregarMapeo('fvtocai','fvtocai')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('ccosto','ccosto')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('recmonto1','recmonto1')
			.AgregarMapeo('recmonto2','recmonto2')
			.AgregarMapeo('disccos','disccos')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('totrecar','totrecar')
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.NUMINT = isnull( d.NUMINT, t.NUMINT ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.SITFISCPRO = isnull( d.SITFISCPRO, t.SITFISCPRO ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.DESAUTO = isnull( d.DESAUTO, t.DESAUTO ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.TCRG1361 = isnull( d.TCRG1361, t.TCRG1361 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FFCHFAC = isnull( d.FFCHFAC, t.FFCHFAC ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.IMPMAN = isnull( d.IMPMAN, t.IMPMAN ),t.FFCHVENC = isnull( d.FFCHVENC, t.FFCHVENC ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.FPTOVENEXT = isnull( d.FPTOVENEXT, t.FPTOVENEXT ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),t.MR = isnull( d.MR, t.MR ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.NCAI = isnull( d.NCAI, t.NCAI ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.NROREMITO = isnull( d.NROREMITO, t.NROREMITO ),t.FVTOCAI = isnull( d.FVTOCAI, t.FVTOCAI ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.CCOSTO = isnull( d.CCOSTO, t.CCOSTO ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.RECMONTO1 = isnull( d.RECMONTO1, t.RECMONTO1 ),t.RECMONTO2 = isnull( d.RECMONTO2, t.RECMONTO2 ),t.DISCCOS = isnull( d.DISCCOS, t.DISCCOS ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC )
					from ZooLogic.FACCOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.NumInt = d.NumInt
							 and  t.FACTTIPO = d.FACTTIPO
				-- Fin Updates
				insert into ZooLogic.FACCOMPRA(Fecimpo,Faltafw,Fecexpo,Fectrans,Fmodifw,Fd2,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fturno,Numint,Timestamp,Desmntosi1,Recmntosi2,Desmntosi,Totalcant,Recmntosi1,Desmntosi2,Fptoven,Signomov,Recmntosi,Fsubton,Facttipo,Sitfiscpro,Fsubtot,Condivalp,Subtotsisi,Subtotcisi,Recmnto2,Recmnto1,Fcompfis,Anulado,Desauto,Fhora,Horaexpo,Horaimpo,Haltafw,Umodifw,Zadsfw,Descfw,Vmodifw,Ualtafw,Valtafw,Saltafw,Smodifw,Hmodifw,Simbmon,Esttrans,Bdaltafw,Bdmodifw,Idvuelto,Monsis,Moneda,Fobs,Ffch,Fmtdes1,Fdescu,Fmtdes2,Fimpuesto,Tcrg1361,Codigo,Ffchfac,Fletra,Desmntosi3,Fmtdes3,Impman,Ffchvenc,Recpor,Fptovenext,Totdescsi,Condpago,Mr,Fnumcomp,Ncai,Recmnto,Nroremito,Fvtocai,Fvuelto,Fperson,Codlista,Cotiz,Ccosto,Ftotal,Recmonto1,Recmonto2,Disccos,Totimpue,Totrecarsi,Totrecar,Totdesc)
					Select isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FD2,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FPODES1,0),isnull( d.FPODES2,0),isnull( d.FPODES,0),isnull( d.FTURNO,0),isnull( d.NUMINT,0),isnull( d.TIMESTAMP,0),isnull( d.DESMNTOSI1,0),isnull( d.RECMNTOSI2,0),isnull( d.DESMNTOSI,0),isnull( d.TOTALCANT,0),isnull( d.RECMNTOSI1,0),isnull( d.DESMNTOSI2,0),isnull( d.FPTOVEN,0),isnull( d.SIGNOMOV,0),isnull( d.RECMNTOSI,0),isnull( d.FSUBTON,0),isnull( d.FACTTIPO,0),isnull( d.SITFISCPRO,0),isnull( d.FSUBTOT,0),isnull( d.CONDIVALP,0),isnull( d.SUBTOTSISI,0),isnull( d.SUBTOTCISI,0),isnull( d.RECMNTO2,0),isnull( d.RECMNTO1,0),isnull( d.FCOMPFIS,0),isnull( d.ANULADO,0),isnull( d.DESAUTO,0),isnull( d.FHORA,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SIMBMON,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.IDVUELTO,''),isnull( d.MONSIS,''),isnull( d.MONEDA,''),isnull( d.FOBS,''),isnull( d.FFCH,''),isnull( d.FMTDES1,0),isnull( d.FDESCU,0),isnull( d.FMTDES2,0),isnull( d.FIMPUESTO,0),isnull( d.TCRG1361,0),isnull( d.CODIGO,''),isnull( d.FFCHFAC,''),isnull( d.FLETRA,''),isnull( d.DESMNTOSI3,0),isnull( d.FMTDES3,0),isnull( d.IMPMAN,0),isnull( d.FFCHVENC,''),isnull( d.RECPOR,0),isnull( d.FPTOVENEXT,0),isnull( d.TOTDESCSI,0),isnull( d.CONDPAGO,''),isnull( d.MR,0),isnull( d.FNUMCOMP,0),isnull( d.NCAI,0),isnull( d.RECMNTO,0),isnull( d.NROREMITO,''),isnull( d.FVTOCAI,''),isnull( d.FVUELTO,0),isnull( d.FPERSON,''),isnull( d.CODLISTA,''),isnull( d.COTIZ,0),isnull( d.CCOSTO,''),isnull( d.FTOTAL,0),isnull( d.RECMONTO1,0),isnull( d.RECMONTO2,0),isnull( d.DISCCOS,''),isnull( d.TOTIMPUE,0),isnull( d.TOTRECARSI,0),isnull( d.TOTRECAR,0),isnull( d.TOTDESC,0)
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
t.FART = isnull( d.FART, t.FART ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.APORCIVAC = isnull( d.APORCIVAC, t.APORCIVAC ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.ACONDIVAC = isnull( d.ACONDIVAC, t.ACONDIVAC ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.COMP = isnull( d.COMP, t.COMP ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.FAMATE = isnull( d.FAMATE, t.FAMATE ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
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
t.FMONTO = isnull( d.FMONTO, t.FMONTO ),
t.CCOSTO = isnull( d.CCOSTO, t.CCOSTO ),
t.DCCOSTO = isnull( d.DCCOSTO, t.DCCOSTO )
from ZooLogic.FacCompraDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.FacCompraDet
( 
"AFEPTOVEN",
"AFENUMCOM",
"AFELETRA",
"FART",
"AFETS",
"APORCIVAC",
"AFECANT",
"ACONDIVAC",
"ARTPERCEP",
"AFESALDO",
"MNTPPER",
"MNTPRECCI",
"MNDESSI",
"MNDESCI",
"FBRUTO",
"MNPDSI",
"AJUCIMP",
"MNTPDESCI",
"AFETIPOCOM",
"MNTPRECSI",
"MNTPTOT",
"MNTPDESSI",
"AFENROITEM",
"FNETO",
"FMTOIVA",
"NROITEM",
"FMTODTO1",
"AJUSIMP",
"FMTOCFI",
"FCFITOT",
"COMP",
"FKIT",
"FPORCFI",
"FX2",
"FPORDTO1",
"CIDITEM",
"FN11",
"FPRUN",
"PRUNCONIMP",
"PRUNSINIMP",
"FPORIVA",
"IDITEMORIG",
"PROCSTOCK",
"USARPLISTA",
"AFE_COD",
"FAMATE",
"IDITEM",
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
"FMONTO",
"CCOSTO",
"DCCOSTO"
 )
Select 
d.AFEPTOVEN,
d.AFENUMCOM,
d.AFELETRA,
d.FART,
d.AFETS,
d.APORCIVAC,
d.AFECANT,
d.ACONDIVAC,
d.ARTPERCEP,
d.AFESALDO,
d.MNTPPER,
d.MNTPRECCI,
d.MNDESSI,
d.MNDESCI,
d.FBRUTO,
d.MNPDSI,
d.AJUCIMP,
d.MNTPDESCI,
d.AFETIPOCOM,
d.MNTPRECSI,
d.MNTPTOT,
d.MNTPDESSI,
d.AFENROITEM,
d.FNETO,
d.FMTOIVA,
d.NROITEM,
d.FMTODTO1,
d.AJUSIMP,
d.FMTOCFI,
d.FCFITOT,
d.COMP,
d.FKIT,
d.FPORCFI,
d.FX2,
d.FPORDTO1,
d.CIDITEM,
d.FN11,
d.FPRUN,
d.PRUNCONIMP,
d.PRUNSINIMP,
d.FPORIVA,
d.IDITEMORIG,
d.PROCSTOCK,
d.USARPLISTA,
d.AFE_COD,
d.FAMATE,
d.IDITEM,
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
d.FMONTO,
d.CCOSTO,
d.DCCOSTO
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
t.JJT = isnull( d.JJT, t.JJT ),
t.JJTURNO = isnull( d.JJTURNO, t.JJTURNO ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.PERSCOMP = isnull( d.PERSCOMP, t.PERSCOMP ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.TIPODOC = isnull( d.TIPODOC, t.TIPODOC ),
t.JJVEN = isnull( d.JJVEN, t.JJVEN ),
t.NRODOC = isnull( d.NRODOC, t.NRODOC ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.JJNUM = isnull( d.JJNUM, t.JJNUM ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),
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
t.PERMVUELTO = isnull( d.PERMVUELTO, t.PERMVUELTO ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.VALECAMBIO = isnull( d.VALECAMBIO, t.VALECAMBIO )
from ZooLogic.ValFacComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ValFacComp
( 
"FECHCOTI",
"JJFECHA",
"IDCAJA",
"JJT",
"JJTURNO",
"COTIZA",
"SIGNO",
"PTOVENTA",
"PESOS",
"JJCOTIZ",
"NROCUPON",
"NROITEM",
"NUMCOMPR",
"VISUALCAJA",
"PERSCOMP",
"CELECTRO",
"LETRA",
"NROTARJETA",
"TIPODOC",
"JJVEN",
"NRODOC",
"TIPCOMP",
"JJCO",
"NROCHPROP",
"JJNUM",
"NROCHEQUE",
"CONDPAGO",
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
"PERMVUELTO",
"GUIDCOMP",
"VALECAMBIO"
 )
Select 
d.FECHCOTI,
d.JJFECHA,
d.IDCAJA,
d.JJT,
d.JJTURNO,
d.COTIZA,
d.SIGNO,
d.PTOVENTA,
d.PESOS,
d.JJCOTIZ,
d.NROCUPON,
d.NROITEM,
d.NUMCOMPR,
d.VISUALCAJA,
d.PERSCOMP,
d.CELECTRO,
d.LETRA,
d.NROTARJETA,
d.TIPODOC,
d.JJVEN,
d.NRODOC,
d.TIPCOMP,
d.JJCO,
d.NROCHPROP,
d.JJNUM,
d.NROCHEQUE,
d.CONDPAGO,
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
d.PERMVUELTO,
d.GUIDCOMP,
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
t.MINOIMP = isnull( d.MINOIMP, t.MINOIMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PORCEN = isnull( d.PORCEN, t.PORCEN ),
t.CODINT = isnull( d.CODINT, t.CODINT ),
t.TIPOI = isnull( d.TIPOI, t.TIPOI ),
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
"MINOIMP",
"NROITEM",
"PORCEN",
"CODINT",
"TIPOI",
"CCOD",
"CODIMP",
"DESCRI",
"MONTO",
"ARTPERCEP",
"ARTPERCE"
 )
Select 
d.MINOIMP,
d.NROITEM,
d.PORCEN,
d.CODINT,
d.TIPOI,
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
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
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
					.Timestamp = nvl( c_FACTURADECOMPRA.Timestamp, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_FACTURADECOMPRA.Montodescuentosinimpuestos1, 0 )
					.Recargomontosinimpuestos2 = nvl( c_FACTURADECOMPRA.Recargomontosinimpuestos2, 0 )
					.Montodescuentosinimpuestos = nvl( c_FACTURADECOMPRA.Montodescuentosinimpuestos, 0 )
					.Totalcantidad = nvl( c_FACTURADECOMPRA.Totalcantidad, 0 )
					.Recargomontosinimpuestos1 = nvl( c_FACTURADECOMPRA.Recargomontosinimpuestos1, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_FACTURADECOMPRA.Montodescuentosinimpuestos2, 0 )
					.Puntodeventa = nvl( c_FACTURADECOMPRA.Puntodeventa, 0 )
					.Signodemovimiento = nvl( c_FACTURADECOMPRA.Signodemovimiento, 0 )
					.Recargomontosinimpuestos = nvl( c_FACTURADECOMPRA.Recargomontosinimpuestos, 0 )
					.Subtotalneto = nvl( c_FACTURADECOMPRA.Subtotalneto, 0 )
					.Tipocomprobante = nvl( c_FACTURADECOMPRA.Tipocomprobante, 0 )
					.Situacionfiscal_PK =  nvl( c_FACTURADECOMPRA.Situacionfiscal, 0 )
					.Subtotalbruto = nvl( c_FACTURADECOMPRA.Subtotalbruto, 0 )
					.Condicioniva = nvl( c_FACTURADECOMPRA.Condicioniva, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_FACTURADECOMPRA.Subtotalsinimpuestossobreitems, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_FACTURADECOMPRA.Subtotalconimpuestossobreitems, 0 )
					.Recargomontoconimpuestos2 = nvl( c_FACTURADECOMPRA.Recargomontoconimpuestos2, 0 )
					.Recargomontoconimpuestos1 = nvl( c_FACTURADECOMPRA.Recargomontoconimpuestos1, 0 )
					.Comprobantefiscal = nvl( c_FACTURADECOMPRA.Comprobantefiscal, .F. )
					.Anulado = nvl( c_FACTURADECOMPRA.Anulado, .F. )
					.Descuentoautomatico = nvl( c_FACTURADECOMPRA.Descuentoautomatico, .F. )
					.Hora = nvl( c_FACTURADECOMPRA.Hora, [] )
					.Horaexpo = nvl( c_FACTURADECOMPRA.Horaexpo, [] )
					.Horaimpo = nvl( c_FACTURADECOMPRA.Horaimpo, [] )
					.Horaaltafw = nvl( c_FACTURADECOMPRA.Horaaltafw, [] )
					.Usuariomodificacionfw = nvl( c_FACTURADECOMPRA.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_FACTURADECOMPRA.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_FACTURADECOMPRA.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_FACTURADECOMPRA.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_FACTURADECOMPRA.Versionaltafw, [] )
					.Seriealtafw = nvl( c_FACTURADECOMPRA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_FACTURADECOMPRA.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_FACTURADECOMPRA.Horamodificacionfw, [] )
					.Simbolomonetariocomprobante = nvl( c_FACTURADECOMPRA.Simbolomonetariocomprobante, [] )
					.Estadotransferencia = nvl( c_FACTURADECOMPRA.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_FACTURADECOMPRA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_FACTURADECOMPRA.Basededatosmodificacionfw, [] )
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
					.Monedacomprobante_PK =  nvl( c_FACTURADECOMPRA.Monedacomprobante, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fecha, ctod( '  /  /    ' ) ) )
					.Montodescuentoconimpuestos1 = nvl( c_FACTURADECOMPRA.Montodescuentoconimpuestos1, 0 )
					.Descuento = nvl( c_FACTURADECOMPRA.Descuento, 0 )
					.Montodescuentoconimpuestos2 = nvl( c_FACTURADECOMPRA.Montodescuentoconimpuestos2, 0 )
					.Impuestos = nvl( c_FACTURADECOMPRA.Impuestos, 0 )
					.Tipocomprobanterg1361 = nvl( c_FACTURADECOMPRA.Tipocomprobanterg1361, 0 )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					.Codigo = nvl( c_FACTURADECOMPRA.Codigo, [] )
					.Fechafactura = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechafactura, ctod( '  /  /    ' ) ) )
					.Letra = nvl( c_FACTURADECOMPRA.Letra, [] )
					.Montodescuentosinimpuestos3 = nvl( c_FACTURADECOMPRA.Montodescuentosinimpuestos3, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_FACTURADECOMPRA.Montodescuentoconimpuestos3, 0 )
					.Impuestosmanuales = nvl( c_FACTURADECOMPRA.Impuestosmanuales, .F. )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Recargoporcentaje = nvl( c_FACTURADECOMPRA.Recargoporcentaje, 0 )
					.Puntodeventaextendido = nvl( c_FACTURADECOMPRA.Puntodeventaextendido, 0 )
					.Totaldescuentossinimpuestos = nvl( c_FACTURADECOMPRA.Totaldescuentossinimpuestos, 0 )
					.Condicionpagopreferente_PK =  nvl( c_FACTURADECOMPRA.Condicionpagopreferente, [] )
					.Recargomonto = nvl( c_FACTURADECOMPRA.Recargomonto, 0 )
					.Numero = nvl( c_FACTURADECOMPRA.Numero, 0 )
					.Cai = nvl( c_FACTURADECOMPRA.Cai, 0 )
					.Recargomontoconimpuestos = nvl( c_FACTURADECOMPRA.Recargomontoconimpuestos, 0 )
					.Remito = nvl( c_FACTURADECOMPRA.Remito, [] )
					.Fechavtocai = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechavtocai, ctod( '  /  /    ' ) ) )
					.Vuelto = nvl( c_FACTURADECOMPRA.Vuelto, 0 )
					.Proveedor_PK =  nvl( c_FACTURADECOMPRA.Proveedor, [] )
					.Listadeprecios_PK =  nvl( c_FACTURADECOMPRA.Listadeprecios, [] )
					.Cotizacion = nvl( c_FACTURADECOMPRA.Cotizacion, 0 )
					.Centrodecosto_PK =  nvl( c_FACTURADECOMPRA.Centrodecosto, [] )
					.Total = nvl( c_FACTURADECOMPRA.Total, 0 )
					.Recargomonto1 = nvl( c_FACTURADECOMPRA.Recargomonto1, 0 )
					.Recargomonto2 = nvl( c_FACTURADECOMPRA.Recargomonto2, 0 )
					.Distribucionporcentrodecosto_PK =  nvl( c_FACTURADECOMPRA.Distribucionporcentrodecosto, [] )
					.Totalimpuestos = nvl( c_FACTURADECOMPRA.Totalimpuestos, 0 )
					.Totalrecargossinimpuestos = nvl( c_FACTURADECOMPRA.Totalrecargossinimpuestos, 0 )
					.Totalrecargos = nvl( c_FACTURADECOMPRA.Totalrecargos, 0 )
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
			"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fptoven" as "Puntodeventa", "Signomov" as "Signodemovimiento", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Sitfiscpro" as "Situacionfiscal", "Fsubtot" as "Subtotalbruto", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Desauto" as "Descuentoautomatico", "Fhora" as "Hora", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Moneda" as "Monedacomprobante", "Fobs" as "Obs", "Ffch" as "Fecha", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffchfac" as "Fechafactura", "Fletra" as "Letra", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Ffchvenc" as "Fechavencimiento", "Recpor" as "Recargoporcentaje", "Fptovenext" as "Puntodeventaextendido", "Totdescsi" as "Totaldescuentossinimpuestos", "Condpago" as "Condicionpagopreferente", "Mr" as "Recargomonto", "Fnumcomp" as "Numero", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Nroremito" as "Remito", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Codlista" as "Listadeprecios", "Cotiz" as "Cotizacion", "Ccosto" as "Centrodecosto", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos"
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
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAIMPO                               " tabla="FACCOMPRA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAALTAFW                             " tabla="FACCOMPRA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAEXPO                               " tabla="FACCOMPRA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHATRANSFERENCIA                      " tabla="FACCOMPRA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAMODIFICACIONFW                     " tabla="FACCOMPRA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAMODIFICACION                       " tabla="FACCOMPRA      " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CUIT                                    " tabla="FACCOMPRA      " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="proveedor.cuit                                                                                                                                                                                                                                                " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CAJA                                    " tabla="FACCOMPRA      " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PORCENTAJEDESCUENTO1                    " tabla="FACCOMPRA      " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PORCENTAJEDESCUENTO2                    " tabla="FACCOMPRA      " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PORCENTAJEDESCUENTO                     " tabla="FACCOMPRA      " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Des%                                                                                                                                                            " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TURNO                                   " tabla="FACCOMPRA      " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="NUMINT                                  " tabla="FACCOMPRA      " campo="NUMINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número interno                                                                                                                                                  " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TIMESTAMP                               " tabla="FACCOMPRA      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="FACCOMPRA      " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="FACCOMPRA      " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="FACCOMPRA      " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALCANTIDAD                           " tabla="FACCOMPRA      " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total Cantidad                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="FACCOMPRA      " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="FACCOMPRA      " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PUNTODEVENTA                            " tabla="FACCOMPRA      " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Nro. factura                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SIGNODEMOVIMIENTO                       " tabla="FACCOMPRA      " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="FACCOMPRA      " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SUBTOTALNETO                            " tabla="FACCOMPRA      " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TIPOCOMPROBANTE                         " tabla="FACCOMPRA      " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=8                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SITUACIONFISCAL                         " tabla="FACCOMPRA      " campo="SITFISCPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sit.Fis                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="proveedor.SituacionFiscal                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SUBTOTALBRUTO                           " tabla="FACCOMPRA      " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CONDICIONIVA                            " tabla="FACCOMPRA      " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condicion de iva                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="FACCOMPRA      " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="FACCOMPRA      " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="FACCOMPRA      " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="FACCOMPRA      " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="COMPROBANTEFISCAL                       " tabla="FACCOMPRA      " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="ANULADO                                 " tabla="FACCOMPRA      " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="DESCUENTOAUTOMATICO                     " tabla="FACCOMPRA      " campo="DESAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORA                                    " tabla="FACCOMPRA      " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORAEXPO                                " tabla="FACCOMPRA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORAIMPO                                " tabla="FACCOMPRA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORAALTAFW                              " tabla="FACCOMPRA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="USUARIOMODIFICACIONFW                   " tabla="FACCOMPRA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="ZADSFW                                  " tabla="FACCOMPRA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="DESCRIPCIONFW                           " tabla="FACCOMPRA      " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="VERSIONMODIFICACIONFW                   " tabla="FACCOMPRA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="USUARIOALTAFW                           " tabla="FACCOMPRA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="VERSIONALTAFW                           " tabla="FACCOMPRA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SERIEALTAFW                             " tabla="FACCOMPRA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SERIEMODIFICACIONFW                     " tabla="FACCOMPRA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORAMODIFICACIONFW                      " tabla="FACCOMPRA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="FACCOMPRA      " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="ESTADOTRANSFERENCIA                     " tabla="FACCOMPRA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="BASEDEDATOSALTAFW                       " tabla="FACCOMPRA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="FACCOMPRA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FACTURADETALLE                          " tabla="FACCOMPRADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMARTICULOSCOMPRA    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="VALORESDETALLE                          " tabla="VALFACCOMP     " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMVALORESCOMPRA      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="9" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IMPUESTOSDETALLE                        " tabla="IMPFACCOMP     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOSC         " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IDVUELTO                                " tabla="FACCOMPRA      " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONEDASISTEMA                           " tabla="FACCOMPRA      " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONEDACOMPROBANTE                       " tabla="FACCOMPRA      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Moneda comprobante                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="OBS                                     " tabla="FACCOMPRA      " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="                                                                                                                                                                " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHA                                   " tabla="FACCOMPRA      " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="410" etiqueta="Ingreso                                                                                                                                                         " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="FACCOMPRA      " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="DESCUENTO                               " tabla="FACCOMPRA      " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Des%                                                                                                                                                            " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="FACCOMPRA      " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IMPUESTOS                               " tabla="FACCOMPRA      " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="I.V.A.                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TIPOCOMPROBANTERG1361                   " tabla="FACCOMPRA      " campo="TCRG1361  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="416" etiqueta="Tipo factura                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPFACC        " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOCOMPRA     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CODIGO                                  " tabla="FACCOMPRA      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="14" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAFACTURA                            " tabla="FACCOMPRA      " campo="FFCHFAC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="420" etiqueta="Emisión                                                                                                                                                         " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="LETRA                                   " tabla="FACCOMPRA      " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número factura                                                                                                                                                  " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="FACCOMPRA      " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="FACCOMPRA      " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Monto de descuento.                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IMPUESTOSMANUALES                       " tabla="FACCOMPRA      " campo="IMPMAN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAVENCIMIENTO                        " tabla="FACCOMPRA      " campo="FFCHVENC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="424" etiqueta="Vencimiento                                                                                                                                                     " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOPORCENTAJE                       " tabla="FACCOMPRA      " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Recargo %                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PUNTODEVENTAEXTENDIDO                   " tabla="FACCOMPRA      " campo="FPTOVENEXT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="FACCOMPRA      " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="14" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CONDICIONPAGOPREFERENTE                 " tabla="FACCOMPRA      " campo="CONDPAGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTO                            " tabla="FACCOMPRA      " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="% Recargo                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="NUMERO                                  " tabla="FACCOMPRA      " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Número factura                                                                                                                                                  " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CAI                                     " tabla="FACCOMPRA      " campo="NCAI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="C.A.I./C.A.E.                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="FACCOMPRA      " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="REMITO                                  " tabla="FACCOMPRA      " campo="NROREMITO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="16" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Remito                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="A 99999-99999999         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAVTOCAI                             " tabla="FACCOMPRA      " campo="FVTOCAI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="438" etiqueta="Vencimiento C.A.I./C.A.E.                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="VUELTO                                  " tabla="FACCOMPRA      " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PROVEEDOR                               " tabla="FACCOMPRA      " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="LISTADEPRECIOS                          " tabla="FACCOMPRA      " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferenteCompras                                                                                                                                                                                  " obligatorio="true" admitebusqueda="440" etiqueta="Lista de Precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="COTIZACION                              " tabla="FACCOMPRA      " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="442" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CENTRODECOSTO                           " tabla="FACCOMPRA      " campo="CCOSTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CENTRODECOSTO                           " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Centro de costos                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTAL                                   " tabla="FACCOMPRA      " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTO1                           " tabla="FACCOMPRA      " campo="RECMONTO1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTO2                           " tabla="FACCOMPRA      " campo="RECMONTO2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="DISTRIBUCIONPORCENTRODECOSTO            " tabla="FACCOMPRA      " campo="DISCCOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DISTRIBUCIONCENTRODECOSTO               " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Distribución por centro de costos                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALIMPUESTOS                          " tabla="FACCOMPRA      " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="FACCOMPRA      " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALRECARGOS                           " tabla="FACCOMPRA      " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALDESCUENTOS                         " tabla="FACCOMPRA      " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On FACCOMPRA.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="429" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On FACCOMPRA.CONDPAGO = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On FACCOMPRA.FPERSON = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="441" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On FACCOMPRA.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CENTRODECOSTO                           " atributo="DESCRIPCION                             " tabla="CCOSTO         " campo="COSDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Cen.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CCOSTO On FACCOMPRA.CCOSTO = CCOSTO.COSCOD And  CCOSTO.COSCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISTRIBUCIONCENTRODECOSTO               " atributo="DESCRIPCION                             " tabla="DCCOSTO        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="449" etiqueta="Detalle Dis.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DCCOSTO On FACCOMPRA.DISCCOS = DCCOSTO.Codigo And  DCCOSTO.CODIGO != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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