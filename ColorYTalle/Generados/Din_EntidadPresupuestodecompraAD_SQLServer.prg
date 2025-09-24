
define class Din_EntidadPRESUPUESTODECOMPRAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PRESUPUESTODECOMPRA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + str( NumInt, 10, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + str( #tabla#.NumInt, 10, 0)]
	cTagClaveCandidata = '_PDCCC'
	cTagClavePk = '_PDCPK'
	cTablaPrincipal = 'PRECOMPRA'
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
			local  lxPrecompraFecimpo, lxPrecompraFmodifw, lxPrecompraFecexpo, lxPrecompraFd2, lxPrecompraFaltafw, lxPrecompraFectrans, lxPrecompraFcuit, lxPrecompraIdcaja, lxPrecompraFpodes2, lxPrecompraFpodes1, lxPrecompraFpodes, lxPrecompraFturno, lxPrecompraBdaltafw, lxPrecompraFhora, lxPrecompraZadsfw, lxPrecompraBdmodifw, lxPrecompraVmodifw, lxPrecompraValtafw, lxPrecompraSmodifw, lxPrecompraSaltafw, lxPrecompraUaltafw, lxPrecompraHmodifw, lxPrecompraSimbmon, lxPrecompraHoraimpo, lxPrecompraUmodifw, lxPrecompraDescfw, lxPrecompraHaltafw, lxPrecompraEsttrans, lxPrecompraHoraexpo, lxPrecompraTimestamp, lxPrecompraTotalcant, lxPrecompraRecmnto1, lxPrecompraRecmnto2, lxPrecompraRecmntosi1, lxPrecompraSubtotsisi, lxPrecompraCondivalp, lxPrecompraSubtotcisi, lxPrecompraFsubtot, lxPrecompraSitfiscpro, lxPrecompraFsubton, lxPrecompraFacttipo, lxPrecompraSignomov, lxPrecompraRecmntosi2, lxPrecompraRecmntosi, lxPrecompraDesmntosi, lxPrecompraDesmntosi2, lxPrecompraDesmntosi1, lxPrecompraDesauto, lxPrecompraAnulado, lxPrecompraFcompfis, lxPrecompraTcrg1361, lxPrecompraCodigo, lxPrecompraIdvuelto, lxPrecompraMonsis, lxPrecompraFmtdes1, lxPrecompraFdescu, lxPrecompraFmtdes2, lxPrecompraNumint, lxPrecompraFimpuesto, lxPrecompraFobs, lxPrecompraFletra, lxPrecompraFfch, lxPrecompraFfchfac, lxPrecompraFmtdes3, lxPrecompraDesmntosi3, lxPrecompraFptovenext, lxPrecompraRecpor, lxPrecompraCotiz, lxPrecompraTotdescsi, lxPrecompraFnumcomp, lxPrecompraFfchvenc, lxPrecompraMr, lxPrecompraNcai, lxPrecompraFptoven, lxPrecompraFvtocai, lxPrecompraNroremito, lxPrecompraRecmnto, lxPrecompraFvuelto, lxPrecompraFperson, lxPrecompraMoneda, lxPrecompraFtotal, lxPrecompraRecmonto1, lxPrecompraRecmonto2, lxPrecompraCodlista, lxPrecompraCondpago, lxPrecompraMotivo, lxPrecompraFtransp, lxPrecompraTotimpue, lxPrecompraTotrecar, lxPrecompraTotrecarsi, lxPrecompraTotdesc
				lxPrecompraFecimpo =  .Fechaimpo			lxPrecompraFmodifw =  .Fechamodificacionfw			lxPrecompraFecexpo =  .Fechaexpo			lxPrecompraFd2 =  .Fechamodificacion			lxPrecompraFaltafw =  .Fechaaltafw			lxPrecompraFectrans =  .Fechatransferencia			lxPrecompraFcuit =  .Cuit			lxPrecompraIdcaja =  .Caja_PK 			lxPrecompraFpodes2 =  .Porcentajedescuento2			lxPrecompraFpodes1 =  .Porcentajedescuento1			lxPrecompraFpodes =  .Porcentajedescuento			lxPrecompraFturno =  .Turno			lxPrecompraBdaltafw =  .Basededatosaltafw			lxPrecompraFhora =  .Hora			lxPrecompraZadsfw =  .Zadsfw			lxPrecompraBdmodifw =  .Basededatosmodificacionfw			lxPrecompraVmodifw =  .Versionmodificacionfw			lxPrecompraValtafw =  .Versionaltafw			lxPrecompraSmodifw =  .Seriemodificacionfw			lxPrecompraSaltafw =  .Seriealtafw			lxPrecompraUaltafw =  .Usuarioaltafw			lxPrecompraHmodifw =  .Horamodificacionfw			lxPrecompraSimbmon =  .Simbolomonetariocomprobante			lxPrecompraHoraimpo =  .Horaimpo			lxPrecompraUmodifw =  .Usuariomodificacionfw			lxPrecompraDescfw =  .Descripcionfw			lxPrecompraHaltafw =  .Horaaltafw			lxPrecompraEsttrans =  .Estadotransferencia			lxPrecompraHoraexpo =  .Horaexpo			lxPrecompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecompraTotalcant =  .Totalcantidad			lxPrecompraRecmnto1 =  .Recargomontoconimpuestos1			lxPrecompraRecmnto2 =  .Recargomontoconimpuestos2			lxPrecompraRecmntosi1 =  .Recargomontosinimpuestos1			lxPrecompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxPrecompraCondivalp =  .Condicioniva			lxPrecompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxPrecompraFsubtot =  .Subtotalbruto			lxPrecompraSitfiscpro =  .Situacionfiscal_PK 			lxPrecompraFsubton =  .Subtotalneto			lxPrecompraFacttipo =  .Tipocomprobante			lxPrecompraSignomov =  .Signodemovimiento			lxPrecompraRecmntosi2 =  .Recargomontosinimpuestos2			lxPrecompraRecmntosi =  .Recargomontosinimpuestos			lxPrecompraDesmntosi =  .Montodescuentosinimpuestos			lxPrecompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxPrecompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxPrecompraDesauto =  .Descuentoautomatico			lxPrecompraAnulado =  .Anulado			lxPrecompraFcompfis =  .Comprobantefiscal			lxPrecompraTcrg1361 =  .Tipocomprobanterg1361			lxPrecompraCodigo =  .Codigo			lxPrecompraIdvuelto =  upper( .IdVuelto_PK ) 			lxPrecompraMonsis =  upper( .MonedaSistema_PK ) 			lxPrecompraFmtdes1 =  .Montodescuentoconimpuestos1			lxPrecompraFdescu =  .Descuento			lxPrecompraFmtdes2 =  .Montodescuentoconimpuestos2			lxPrecompraNumint =  .Numint			lxPrecompraFimpuesto =  .Impuestos			lxPrecompraFobs =  .Obs			lxPrecompraFletra =  .Letra			lxPrecompraFfch =  .Fecha			lxPrecompraFfchfac =  .Fechafactura			lxPrecompraFmtdes3 =  .Montodescuentoconimpuestos3			lxPrecompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxPrecompraFptovenext =  .Puntodeventaextendido			lxPrecompraRecpor =  .Recargoporcentaje			lxPrecompraCotiz =  .Cotizacion			lxPrecompraTotdescsi =  .Totaldescuentossinimpuestos			lxPrecompraFnumcomp =  .Numero			lxPrecompraFfchvenc =  .Fechavencimiento			lxPrecompraMr =  .Recargomonto			lxPrecompraNcai =  .Cai			lxPrecompraFptoven =  .Puntodeventa			lxPrecompraFvtocai =  .Fechavtocai			lxPrecompraNroremito =  .Remito			lxPrecompraRecmnto =  .Recargomontoconimpuestos			lxPrecompraFvuelto =  .Vuelto			lxPrecompraFperson =  upper( .Proveedor_PK ) 			lxPrecompraMoneda =  upper( .MonedaComprobante_PK ) 			lxPrecompraFtotal =  .Total			lxPrecompraRecmonto1 =  .Recargomonto1			lxPrecompraRecmonto2 =  .Recargomonto2			lxPrecompraCodlista =  upper( .ListaDePrecios_PK ) 			lxPrecompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxPrecompraMotivo =  upper( .Motivo_PK ) 			lxPrecompraFtransp =  upper( .Transportista_PK ) 			lxPrecompraTotimpue =  .Totalimpuestos			lxPrecompraTotrecar =  .Totalrecargos			lxPrecompraTotrecarsi =  .Totalrecargossinimpuestos			lxPrecompraTotdesc =  .Totaldescuentos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxPrecompraCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PRECOMPRA ( "Fecimpo","Fmodifw","Fecexpo","Fd2","Faltafw","Fectrans","Fcuit","Idcaja","Fpodes2","Fpodes1","Fpodes","Fturno","Bdaltafw","Fhora","Zadsfw","Bdmodifw","Vmodifw","Valtafw","Smodifw","Saltafw","Ualtafw","Hmodifw","Simbmon","Horaimpo","Umodifw","Descfw","Haltafw","Esttrans","Horaexpo","Timestamp","Totalcant","Recmnto1","Recmnto2","Recmntosi1","Subtotsisi","Condivalp","Subtotcisi","Fsubtot","Sitfiscpro","Fsubton","Facttipo","Signomov","Recmntosi2","Recmntosi","Desmntosi","Desmntosi2","Desmntosi1","Desauto","Anulado","Fcompfis","Tcrg1361","Codigo","Idvuelto","Monsis","Fmtdes1","Fdescu","Fmtdes2","Numint","Fimpuesto","Fobs","Fletra","Ffch","Ffchfac","Fmtdes3","Desmntosi3","Fptovenext","Recpor","Cotiz","Totdescsi","Fnumcomp","Ffchvenc","Mr","Ncai","Fptoven","Fvtocai","Nroremito","Recmnto","Fvuelto","Fperson","Moneda","Ftotal","Recmonto1","Recmonto2","Codlista","Condpago","Motivo","Ftransp","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxPrecompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraFcuit ) + "'" >>, <<lxPrecompraIdcaja >>, <<lxPrecompraFpodes2 >>, <<lxPrecompraFpodes1 >>, <<lxPrecompraFpodes >>, <<lxPrecompraFturno >>, <<"'" + this.FormatearTextoSql( lxPrecompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraHoraexpo ) + "'" >>, <<lxPrecompraTimestamp >>, <<lxPrecompraTotalcant >>, <<lxPrecompraRecmnto1 >>, <<lxPrecompraRecmnto2 >>, <<lxPrecompraRecmntosi1 >>, <<lxPrecompraSubtotsisi >>, <<lxPrecompraCondivalp >>, <<lxPrecompraSubtotcisi >>, <<lxPrecompraFsubtot >>, <<lxPrecompraSitfiscpro >>, <<lxPrecompraFsubton >>, <<lxPrecompraFacttipo >>, <<lxPrecompraSignomov >>, <<lxPrecompraRecmntosi2 >>, <<lxPrecompraRecmntosi >>, <<lxPrecompraDesmntosi >>, <<lxPrecompraDesmntosi2 >>, <<lxPrecompraDesmntosi1 >>, <<iif( lxPrecompraDesauto, 1, 0 ) >>, <<iif( lxPrecompraAnulado, 1, 0 ) >>, <<iif( lxPrecompraFcompfis, 1, 0 ) >>, <<lxPrecompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxPrecompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraMonsis ) + "'" >>, <<lxPrecompraFmtdes1 >>, <<lxPrecompraFdescu >>, <<lxPrecompraFmtdes2 >>, <<lxPrecompraNumint >>, <<lxPrecompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxPrecompraFobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraFletra ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFfch ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFfchfac ) + "'" >>, <<lxPrecompraFmtdes3 >>, <<lxPrecompraDesmntosi3 >>, <<lxPrecompraFptovenext >>, <<lxPrecompraRecpor >>, <<lxPrecompraCotiz >>, <<lxPrecompraTotdescsi >>, <<lxPrecompraFnumcomp >>, <<"'" + this.ConvertirDateSql( lxPrecompraFfchvenc ) + "'" >>, <<lxPrecompraMr >>, <<lxPrecompraNcai >>, <<lxPrecompraFptoven >>, <<"'" + this.ConvertirDateSql( lxPrecompraFvtocai ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraNroremito ) + "'" >>, <<lxPrecompraRecmnto >>, <<lxPrecompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxPrecompraFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraMoneda ) + "'" >>, <<lxPrecompraFtotal >>, <<lxPrecompraRecmonto1 >>, <<lxPrecompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxPrecompraCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraCondpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraFtransp ) + "'" >>, <<lxPrecompraTotimpue >>, <<lxPrecompraTotrecar >>, <<lxPrecompraTotrecarsi >>, <<lxPrecompraTotdesc >> )
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
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpPreComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
					
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxIditemarticulos = loItem.Iditemarticulos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNroitem = lnContadorNroItem
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxMontodto1 = loItem.Montodto1
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajeiva = loItem.Porcentajeiva
					lxMontocfi = loItem.Montocfi
					lxPorcentajecfi = loItem.Porcentajecfi
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxIdorigen = loItem.Idorigen
					lxIditem = loItem.Iditem
					lxAfe_nroitem = loItem.Afe_nroitem
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
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
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PreCompraDet("AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_cantidad>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_condicionivacompras>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajedto1>>, <<lxMontodto1>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajeiva>>, <<lxMontocfi>>, <<lxPorcentajecfi>>, <<lxPrecioconimpuestos>>, <<lxTipolistadeprecio>>, <<lxIdorigen>>, <<lxIditem>>, <<lxAfe_nroitem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
					
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxPorcentaje = loItem.Porcentaje
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpPrec("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxPrecompraTimestamp
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
			local  lxPrecompraFecimpo, lxPrecompraFmodifw, lxPrecompraFecexpo, lxPrecompraFd2, lxPrecompraFaltafw, lxPrecompraFectrans, lxPrecompraFcuit, lxPrecompraIdcaja, lxPrecompraFpodes2, lxPrecompraFpodes1, lxPrecompraFpodes, lxPrecompraFturno, lxPrecompraBdaltafw, lxPrecompraFhora, lxPrecompraZadsfw, lxPrecompraBdmodifw, lxPrecompraVmodifw, lxPrecompraValtafw, lxPrecompraSmodifw, lxPrecompraSaltafw, lxPrecompraUaltafw, lxPrecompraHmodifw, lxPrecompraSimbmon, lxPrecompraHoraimpo, lxPrecompraUmodifw, lxPrecompraDescfw, lxPrecompraHaltafw, lxPrecompraEsttrans, lxPrecompraHoraexpo, lxPrecompraTimestamp, lxPrecompraTotalcant, lxPrecompraRecmnto1, lxPrecompraRecmnto2, lxPrecompraRecmntosi1, lxPrecompraSubtotsisi, lxPrecompraCondivalp, lxPrecompraSubtotcisi, lxPrecompraFsubtot, lxPrecompraSitfiscpro, lxPrecompraFsubton, lxPrecompraFacttipo, lxPrecompraSignomov, lxPrecompraRecmntosi2, lxPrecompraRecmntosi, lxPrecompraDesmntosi, lxPrecompraDesmntosi2, lxPrecompraDesmntosi1, lxPrecompraDesauto, lxPrecompraAnulado, lxPrecompraFcompfis, lxPrecompraTcrg1361, lxPrecompraCodigo, lxPrecompraIdvuelto, lxPrecompraMonsis, lxPrecompraFmtdes1, lxPrecompraFdescu, lxPrecompraFmtdes2, lxPrecompraNumint, lxPrecompraFimpuesto, lxPrecompraFobs, lxPrecompraFletra, lxPrecompraFfch, lxPrecompraFfchfac, lxPrecompraFmtdes3, lxPrecompraDesmntosi3, lxPrecompraFptovenext, lxPrecompraRecpor, lxPrecompraCotiz, lxPrecompraTotdescsi, lxPrecompraFnumcomp, lxPrecompraFfchvenc, lxPrecompraMr, lxPrecompraNcai, lxPrecompraFptoven, lxPrecompraFvtocai, lxPrecompraNroremito, lxPrecompraRecmnto, lxPrecompraFvuelto, lxPrecompraFperson, lxPrecompraMoneda, lxPrecompraFtotal, lxPrecompraRecmonto1, lxPrecompraRecmonto2, lxPrecompraCodlista, lxPrecompraCondpago, lxPrecompraMotivo, lxPrecompraFtransp, lxPrecompraTotimpue, lxPrecompraTotrecar, lxPrecompraTotrecarsi, lxPrecompraTotdesc
				lxPrecompraFecimpo =  .Fechaimpo			lxPrecompraFmodifw =  .Fechamodificacionfw			lxPrecompraFecexpo =  .Fechaexpo			lxPrecompraFd2 =  .Fechamodificacion			lxPrecompraFaltafw =  .Fechaaltafw			lxPrecompraFectrans =  .Fechatransferencia			lxPrecompraFcuit =  .Cuit			lxPrecompraIdcaja =  .Caja_PK 			lxPrecompraFpodes2 =  .Porcentajedescuento2			lxPrecompraFpodes1 =  .Porcentajedescuento1			lxPrecompraFpodes =  .Porcentajedescuento			lxPrecompraFturno =  .Turno			lxPrecompraBdaltafw =  .Basededatosaltafw			lxPrecompraFhora =  .Hora			lxPrecompraZadsfw =  .Zadsfw			lxPrecompraBdmodifw =  .Basededatosmodificacionfw			lxPrecompraVmodifw =  .Versionmodificacionfw			lxPrecompraValtafw =  .Versionaltafw			lxPrecompraSmodifw =  .Seriemodificacionfw			lxPrecompraSaltafw =  .Seriealtafw			lxPrecompraUaltafw =  .Usuarioaltafw			lxPrecompraHmodifw =  .Horamodificacionfw			lxPrecompraSimbmon =  .Simbolomonetariocomprobante			lxPrecompraHoraimpo =  .Horaimpo			lxPrecompraUmodifw =  .Usuariomodificacionfw			lxPrecompraDescfw =  .Descripcionfw			lxPrecompraHaltafw =  .Horaaltafw			lxPrecompraEsttrans =  .Estadotransferencia			lxPrecompraHoraexpo =  .Horaexpo			lxPrecompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecompraTotalcant =  .Totalcantidad			lxPrecompraRecmnto1 =  .Recargomontoconimpuestos1			lxPrecompraRecmnto2 =  .Recargomontoconimpuestos2			lxPrecompraRecmntosi1 =  .Recargomontosinimpuestos1			lxPrecompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxPrecompraCondivalp =  .Condicioniva			lxPrecompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxPrecompraFsubtot =  .Subtotalbruto			lxPrecompraSitfiscpro =  .Situacionfiscal_PK 			lxPrecompraFsubton =  .Subtotalneto			lxPrecompraFacttipo =  .Tipocomprobante			lxPrecompraSignomov =  .Signodemovimiento			lxPrecompraRecmntosi2 =  .Recargomontosinimpuestos2			lxPrecompraRecmntosi =  .Recargomontosinimpuestos			lxPrecompraDesmntosi =  .Montodescuentosinimpuestos			lxPrecompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxPrecompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxPrecompraDesauto =  .Descuentoautomatico			lxPrecompraAnulado =  .Anulado			lxPrecompraFcompfis =  .Comprobantefiscal			lxPrecompraTcrg1361 =  .Tipocomprobanterg1361			lxPrecompraCodigo =  .Codigo			lxPrecompraIdvuelto =  upper( .IdVuelto_PK ) 			lxPrecompraMonsis =  upper( .MonedaSistema_PK ) 			lxPrecompraFmtdes1 =  .Montodescuentoconimpuestos1			lxPrecompraFdescu =  .Descuento			lxPrecompraFmtdes2 =  .Montodescuentoconimpuestos2			lxPrecompraNumint =  .Numint			lxPrecompraFimpuesto =  .Impuestos			lxPrecompraFobs =  .Obs			lxPrecompraFletra =  .Letra			lxPrecompraFfch =  .Fecha			lxPrecompraFfchfac =  .Fechafactura			lxPrecompraFmtdes3 =  .Montodescuentoconimpuestos3			lxPrecompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxPrecompraFptovenext =  .Puntodeventaextendido			lxPrecompraRecpor =  .Recargoporcentaje			lxPrecompraCotiz =  .Cotizacion			lxPrecompraTotdescsi =  .Totaldescuentossinimpuestos			lxPrecompraFnumcomp =  .Numero			lxPrecompraFfchvenc =  .Fechavencimiento			lxPrecompraMr =  .Recargomonto			lxPrecompraNcai =  .Cai			lxPrecompraFptoven =  .Puntodeventa			lxPrecompraFvtocai =  .Fechavtocai			lxPrecompraNroremito =  .Remito			lxPrecompraRecmnto =  .Recargomontoconimpuestos			lxPrecompraFvuelto =  .Vuelto			lxPrecompraFperson =  upper( .Proveedor_PK ) 			lxPrecompraMoneda =  upper( .MonedaComprobante_PK ) 			lxPrecompraFtotal =  .Total			lxPrecompraRecmonto1 =  .Recargomonto1			lxPrecompraRecmonto2 =  .Recargomonto2			lxPrecompraCodlista =  upper( .ListaDePrecios_PK ) 			lxPrecompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxPrecompraMotivo =  upper( .Motivo_PK ) 			lxPrecompraFtransp =  upper( .Transportista_PK ) 			lxPrecompraTotimpue =  .Totalimpuestos			lxPrecompraTotrecar =  .Totalrecargos			lxPrecompraTotrecarsi =  .Totalrecargossinimpuestos			lxPrecompraTotdesc =  .Totaldescuentos
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
				update ZooLogic.PRECOMPRA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPrecompraFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxPrecompraFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxPrecompraFecexpo ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxPrecompraFd2 ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxPrecompraFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxPrecompraFectrans ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxPrecompraFcuit ) + "'">>,"Idcaja" = <<lxPrecompraIdcaja>>,"Fpodes2" = <<lxPrecompraFpodes2>>,"Fpodes1" = <<lxPrecompraFpodes1>>,"Fpodes" = <<lxPrecompraFpodes>>,"Fturno" = <<lxPrecompraFturno>>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPrecompraBdaltafw ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxPrecompraFhora ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxPrecompraZadsfw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraBdmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxPrecompraValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxPrecompraSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxPrecompraUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraHmodifw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxPrecompraSimbmon ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxPrecompraHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraUmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxPrecompraDescfw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxPrecompraHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxPrecompraEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxPrecompraHoraexpo ) + "'">>,"Timestamp" = <<lxPrecompraTimestamp>>,"Totalcant" = <<lxPrecompraTotalcant>>,"Recmnto1" = <<lxPrecompraRecmnto1>>,"Recmnto2" = <<lxPrecompraRecmnto2>>,"Recmntosi1" = <<lxPrecompraRecmntosi1>>,"Subtotsisi" = <<lxPrecompraSubtotsisi>>,"Condivalp" = <<lxPrecompraCondivalp>>,"Subtotcisi" = <<lxPrecompraSubtotcisi>>,"Fsubtot" = <<lxPrecompraFsubtot>>,"Sitfiscpro" = <<lxPrecompraSitfiscpro>>,"Fsubton" = <<lxPrecompraFsubton>>,"Facttipo" = <<lxPrecompraFacttipo>>,"Signomov" = <<lxPrecompraSignomov>>,"Recmntosi2" = <<lxPrecompraRecmntosi2>>,"Recmntosi" = <<lxPrecompraRecmntosi>>,"Desmntosi" = <<lxPrecompraDesmntosi>>,"Desmntosi2" = <<lxPrecompraDesmntosi2>>,"Desmntosi1" = <<lxPrecompraDesmntosi1>>,"Desauto" = <<iif( lxPrecompraDesauto, 1, 0 )>>,"Anulado" = <<iif( lxPrecompraAnulado, 1, 0 )>>,"Fcompfis" = <<iif( lxPrecompraFcompfis, 1, 0 )>>,"Tcrg1361" = <<lxPrecompraTcrg1361>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxPrecompraCodigo ) + "'">>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxPrecompraIdvuelto ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxPrecompraMonsis ) + "'">>,"Fmtdes1" = <<lxPrecompraFmtdes1>>,"Fdescu" = <<lxPrecompraFdescu>>,"Fmtdes2" = <<lxPrecompraFmtdes2>>,"Numint" = <<lxPrecompraNumint>>,"Fimpuesto" = <<lxPrecompraFimpuesto>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxPrecompraFobs ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxPrecompraFletra ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxPrecompraFfch ) + "'">>,"Ffchfac" = <<"'" + this.ConvertirDateSql( lxPrecompraFfchfac ) + "'">>,"Fmtdes3" = <<lxPrecompraFmtdes3>>,"Desmntosi3" = <<lxPrecompraDesmntosi3>>,"Fptovenext" = <<lxPrecompraFptovenext>>,"Recpor" = <<lxPrecompraRecpor>>,"Cotiz" = <<lxPrecompraCotiz>>,"Totdescsi" = <<lxPrecompraTotdescsi>>,"Fnumcomp" = <<lxPrecompraFnumcomp>>,"Ffchvenc" = <<"'" + this.ConvertirDateSql( lxPrecompraFfchvenc ) + "'">>,"Mr" = <<lxPrecompraMr>>,"Ncai" = <<lxPrecompraNcai>>,"Fptoven" = <<lxPrecompraFptoven>>,"Fvtocai" = <<"'" + this.ConvertirDateSql( lxPrecompraFvtocai ) + "'">>,"Nroremito" = <<"'" + this.FormatearTextoSql( lxPrecompraNroremito ) + "'">>,"Recmnto" = <<lxPrecompraRecmnto>>,"Fvuelto" = <<lxPrecompraFvuelto>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxPrecompraFperson ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxPrecompraMoneda ) + "'">>,"Ftotal" = <<lxPrecompraFtotal>>,"Recmonto1" = <<lxPrecompraRecmonto1>>,"Recmonto2" = <<lxPrecompraRecmonto2>>,"Codlista" = <<"'" + this.FormatearTextoSql( lxPrecompraCodlista ) + "'">>,"Condpago" = <<"'" + this.FormatearTextoSql( lxPrecompraCondpago ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxPrecompraMotivo ) + "'">>,"Ftransp" = <<"'" + this.FormatearTextoSql( lxPrecompraFtransp ) + "'">>,"Totimpue" = <<lxPrecompraTotimpue>>,"Totrecar" = <<lxPrecompraTotrecar>>,"Totrecarsi" = <<lxPrecompraTotrecarsi>>,"Totdesc" = <<lxPrecompraTotdesc>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxPrecompraCodigo ) + "'">> and  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpPreComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PreCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpPrec where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpPreComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
					
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxIditemarticulos = loItem.Iditemarticulos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNroitem = lnContadorNroItem
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxMontodto1 = loItem.Montodto1
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajeiva = loItem.Porcentajeiva
					lxMontocfi = loItem.Montocfi
					lxPorcentajecfi = loItem.Porcentajecfi
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxIdorigen = loItem.Idorigen
					lxIditem = loItem.Iditem
					lxAfe_nroitem = loItem.Afe_nroitem
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
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
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PreCompraDet("AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_cantidad>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_condicionivacompras>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajedto1>>, <<lxMontodto1>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajeiva>>, <<lxMontocfi>>, <<lxPorcentajecfi>>, <<lxPrecioconimpuestos>>, <<lxTipolistadeprecio>>, <<lxIdorigen>>, <<lxIditem>>, <<lxAfe_nroitem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
					
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxPorcentaje = loItem.Porcentaje
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpPrec("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxPrecompraTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.PRECOMPRA where " + this.ConvertirFuncionesSql( " PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30" ) )
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
			Local lxPrecompraCodigo
			lxPrecompraCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Descfw" as "Descripcionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Recmnto1" as "Recargomontoconimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Signomov" as "Signodemovimiento", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fptovenext" as "Puntodeventaextendido", "Recpor" as "Recargoporcentaje", "Cotiz" as "Cotizacion", "Totdescsi" as "Totaldescuentossinimpuestos", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fptoven" as "Puntodeventa", "Fvtocai" as "Fechavtocai", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PRECOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxPrecompraCodigo ) + "'">> and  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30
			endtext
			use in select('c_PRESUPUESTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRESUPUESTODECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_PRESUPUESTODECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPreComp where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.PreCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPrec where cCod = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			Local lxPreCompraFACTTIPO As Variant, lxPreCompraNumInt As Variant
			lxPreCompraFACTTIPO = .TipoComprobante
			lxPreCompraNumInt = .NumInt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Descfw" as "Descripcionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Recmnto1" as "Recargomontoconimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Signomov" as "Signodemovimiento", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fptovenext" as "Puntodeventaextendido", "Recpor" as "Recargoporcentaje", "Cotiz" as "Cotizacion", "Totdescsi" as "Totaldescuentossinimpuestos", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fptoven" as "Puntodeventa", "Fvtocai" as "Fechavtocai", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PRECOMPRA where  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30 And FACTTIPO = <<lxPreCompraFACTTIPO>> and NumInt = <<lxPreCompraNumInt>>
			endtext
			use in select('c_PRESUPUESTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRESUPUESTODECOMPRA', set( 'Datasession' ) )
			if reccount( 'c_PRESUPUESTODECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPreComp where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.PreCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPrec where cCod = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxPrecompraCodigo as Variant
		llRetorno = .t.
		lxPrecompraCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PRECOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxPrecompraCodigo ) + "'">> and  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30
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
				lcOrden =  str( .TipoComprobante, 2, 0) + str( .NumInt, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Descfw" as "Descripcionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Recmnto1" as "Recargomontoconimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Signomov" as "Signodemovimiento", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fptovenext" as "Puntodeventaextendido", "Recpor" as "Recargoporcentaje", "Cotiz" as "Cotizacion", "Totdescsi" as "Totaldescuentossinimpuestos", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fptoven" as "Puntodeventa", "Fvtocai" as "Fechavtocai", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PRECOMPRA where  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30 order by FACTTIPO,NumInt
			endtext
			use in select('c_PRESUPUESTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRESUPUESTODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPreComp where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.PreCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPrec where cCod = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + str( .NumInt, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Descfw" as "Descripcionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Recmnto1" as "Recargomontoconimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Signomov" as "Signodemovimiento", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fptovenext" as "Puntodeventaextendido", "Recpor" as "Recargoporcentaje", "Cotiz" as "Cotizacion", "Totdescsi" as "Totaldescuentossinimpuestos", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fptoven" as "Puntodeventa", "Fvtocai" as "Fechavtocai", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PRECOMPRA where  str( FACTTIPO, 2, 0) + str( NumInt, 10, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30 order by FACTTIPO,NumInt
			endtext
			use in select('c_PRESUPUESTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRESUPUESTODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPreComp where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.PreCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPrec where cCod = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + str( .NumInt, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Descfw" as "Descripcionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Recmnto1" as "Recargomontoconimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Signomov" as "Signodemovimiento", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fptovenext" as "Puntodeventaextendido", "Recpor" as "Recargoporcentaje", "Cotiz" as "Cotizacion", "Totdescsi" as "Totaldescuentossinimpuestos", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fptoven" as "Puntodeventa", "Fvtocai" as "Fechavtocai", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PRECOMPRA where  str( FACTTIPO, 2, 0) + str( NumInt, 10, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30 order by FACTTIPO desc,NumInt desc
			endtext
			use in select('c_PRESUPUESTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRESUPUESTODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPreComp where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.PreCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPrec where cCod = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + str( .NumInt, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Descfw" as "Descripcionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Recmnto1" as "Recargomontoconimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Signomov" as "Signodemovimiento", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fptovenext" as "Puntodeventaextendido", "Recpor" as "Recargoporcentaje", "Cotiz" as "Cotizacion", "Totdescsi" as "Totaldescuentossinimpuestos", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fptoven" as "Puntodeventa", "Fvtocai" as "Fechavtocai", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PRECOMPRA where  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30 order by FACTTIPO desc,NumInt desc
			endtext
			use in select('c_PRESUPUESTODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRESUPUESTODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPreComp where Codigo = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.PreCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPrec where cCod = <<"'" + this.FormatearTextoSql( c_PRESUPUESTODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fmodifw,Fecexpo,Fd2,Faltafw,Fectrans,Fcuit,Idcaja,Fpodes2,Fpodes1,Fpodes,Fturno,Bdal" + ;
"tafw,Fhora,Zadsfw,Bdmodifw,Vmodifw,Valtafw,Smodifw,Saltafw,Ualtafw,Hmodifw,Simbmon,Horaimpo,Umodifw," + ;
"Descfw,Haltafw,Esttrans,Horaexpo,Timestamp,Totalcant,Recmnto1,Recmnto2,Recmntosi1,Subtotsisi,Condiva" + ;
"lp,Subtotcisi,Fsubtot,Sitfiscpro,Fsubton,Facttipo,Signomov,Recmntosi2,Recmntosi,Desmntosi,Desmntosi2" + ;
",Desmntosi1,Desauto,Anulado,Fcompfis,Tcrg1361,Codigo,Idvuelto,Monsis,Fmtdes1,Fdescu,Fmtdes2,Numint,F" + ;
"impuesto,Fobs,Fletra,Ffch,Ffchfac,Fmtdes3,Desmntosi3,Fptovenext,Recpor,Cotiz,Totdescsi,Fnumcomp,Ffch" + ;
"venc,Mr,Ncai,Fptoven,Fvtocai,Nroremito,Recmnto,Fvuelto,Fperson,Moneda,Ftotal,Recmonto1,Recmonto2,Cod" + ;
"lista,Condpago,Motivo,Ftransp,Totimpue,Totrecar,Totrecarsi,Totdesc" + ;
" from ZooLogic.PRECOMPRA where  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30 and " + lcFiltro )
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
			local  lxPrecompraFecimpo, lxPrecompraFmodifw, lxPrecompraFecexpo, lxPrecompraFd2, lxPrecompraFaltafw, lxPrecompraFectrans, lxPrecompraFcuit, lxPrecompraIdcaja, lxPrecompraFpodes2, lxPrecompraFpodes1, lxPrecompraFpodes, lxPrecompraFturno, lxPrecompraBdaltafw, lxPrecompraFhora, lxPrecompraZadsfw, lxPrecompraBdmodifw, lxPrecompraVmodifw, lxPrecompraValtafw, lxPrecompraSmodifw, lxPrecompraSaltafw, lxPrecompraUaltafw, lxPrecompraHmodifw, lxPrecompraSimbmon, lxPrecompraHoraimpo, lxPrecompraUmodifw, lxPrecompraDescfw, lxPrecompraHaltafw, lxPrecompraEsttrans, lxPrecompraHoraexpo, lxPrecompraTimestamp, lxPrecompraTotalcant, lxPrecompraRecmnto1, lxPrecompraRecmnto2, lxPrecompraRecmntosi1, lxPrecompraSubtotsisi, lxPrecompraCondivalp, lxPrecompraSubtotcisi, lxPrecompraFsubtot, lxPrecompraSitfiscpro, lxPrecompraFsubton, lxPrecompraFacttipo, lxPrecompraSignomov, lxPrecompraRecmntosi2, lxPrecompraRecmntosi, lxPrecompraDesmntosi, lxPrecompraDesmntosi2, lxPrecompraDesmntosi1, lxPrecompraDesauto, lxPrecompraAnulado, lxPrecompraFcompfis, lxPrecompraTcrg1361, lxPrecompraCodigo, lxPrecompraIdvuelto, lxPrecompraMonsis, lxPrecompraFmtdes1, lxPrecompraFdescu, lxPrecompraFmtdes2, lxPrecompraNumint, lxPrecompraFimpuesto, lxPrecompraFobs, lxPrecompraFletra, lxPrecompraFfch, lxPrecompraFfchfac, lxPrecompraFmtdes3, lxPrecompraDesmntosi3, lxPrecompraFptovenext, lxPrecompraRecpor, lxPrecompraCotiz, lxPrecompraTotdescsi, lxPrecompraFnumcomp, lxPrecompraFfchvenc, lxPrecompraMr, lxPrecompraNcai, lxPrecompraFptoven, lxPrecompraFvtocai, lxPrecompraNroremito, lxPrecompraRecmnto, lxPrecompraFvuelto, lxPrecompraFperson, lxPrecompraMoneda, lxPrecompraFtotal, lxPrecompraRecmonto1, lxPrecompraRecmonto2, lxPrecompraCodlista, lxPrecompraCondpago, lxPrecompraMotivo, lxPrecompraFtransp, lxPrecompraTotimpue, lxPrecompraTotrecar, lxPrecompraTotrecarsi, lxPrecompraTotdesc
				lxPrecompraFecimpo = ctod( '  /  /    ' )			lxPrecompraFmodifw = ctod( '  /  /    ' )			lxPrecompraFecexpo = ctod( '  /  /    ' )			lxPrecompraFd2 = ctod( '  /  /    ' )			lxPrecompraFaltafw = ctod( '  /  /    ' )			lxPrecompraFectrans = ctod( '  /  /    ' )			lxPrecompraFcuit = []			lxPrecompraIdcaja = 0			lxPrecompraFpodes2 = 0			lxPrecompraFpodes1 = 0			lxPrecompraFpodes = 0			lxPrecompraFturno = 0			lxPrecompraBdaltafw = []			lxPrecompraFhora = []			lxPrecompraZadsfw = []			lxPrecompraBdmodifw = []			lxPrecompraVmodifw = []			lxPrecompraValtafw = []			lxPrecompraSmodifw = []			lxPrecompraSaltafw = []			lxPrecompraUaltafw = []			lxPrecompraHmodifw = []			lxPrecompraSimbmon = []			lxPrecompraHoraimpo = []			lxPrecompraUmodifw = []			lxPrecompraDescfw = []			lxPrecompraHaltafw = []			lxPrecompraEsttrans = []			lxPrecompraHoraexpo = []			lxPrecompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecompraTotalcant = 0			lxPrecompraRecmnto1 = 0			lxPrecompraRecmnto2 = 0			lxPrecompraRecmntosi1 = 0			lxPrecompraSubtotsisi = 0			lxPrecompraCondivalp = 0			lxPrecompraSubtotcisi = 0			lxPrecompraFsubtot = 0			lxPrecompraSitfiscpro = 0			lxPrecompraFsubton = 0			lxPrecompraFacttipo = 0			lxPrecompraSignomov = 0			lxPrecompraRecmntosi2 = 0			lxPrecompraRecmntosi = 0			lxPrecompraDesmntosi = 0			lxPrecompraDesmntosi2 = 0			lxPrecompraDesmntosi1 = 0			lxPrecompraDesauto = .F.			lxPrecompraAnulado = .F.			lxPrecompraFcompfis = .F.			lxPrecompraTcrg1361 = 0			lxPrecompraCodigo = []			lxPrecompraIdvuelto = []			lxPrecompraMonsis = []			lxPrecompraFmtdes1 = 0			lxPrecompraFdescu = 0			lxPrecompraFmtdes2 = 0			lxPrecompraNumint = 0			lxPrecompraFimpuesto = 0			lxPrecompraFobs = []			lxPrecompraFletra = []			lxPrecompraFfch = ctod( '  /  /    ' )			lxPrecompraFfchfac = ctod( '  /  /    ' )			lxPrecompraFmtdes3 = 0			lxPrecompraDesmntosi3 = 0			lxPrecompraFptovenext = 0			lxPrecompraRecpor = 0			lxPrecompraCotiz = 0			lxPrecompraTotdescsi = 0			lxPrecompraFnumcomp = 0			lxPrecompraFfchvenc = ctod( '  /  /    ' )			lxPrecompraMr = 0			lxPrecompraNcai = 0			lxPrecompraFptoven = 0			lxPrecompraFvtocai = ctod( '  /  /    ' )			lxPrecompraNroremito = []			lxPrecompraRecmnto = 0			lxPrecompraFvuelto = 0			lxPrecompraFperson = []			lxPrecompraMoneda = []			lxPrecompraFtotal = 0			lxPrecompraRecmonto1 = 0			lxPrecompraRecmonto2 = 0			lxPrecompraCodlista = []			lxPrecompraCondpago = []			lxPrecompraMotivo = []			lxPrecompraFtransp = []			lxPrecompraTotimpue = 0			lxPrecompraTotrecar = 0			lxPrecompraTotrecarsi = 0			lxPrecompraTotdesc = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpPreComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PreCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpPrec where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PRECOMPRA where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PRECOMPRA' + '_' + tcCampo
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
		lcWhere = " Where  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Descfw" as "Descripcionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Recmnto1" as "Recargomontoconimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Signomov" as "Signodemovimiento", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fptovenext" as "Puntodeventaextendido", "Recpor" as "Recargoporcentaje", "Cotiz" as "Cotizacion", "Totdescsi" as "Totaldescuentossinimpuestos", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fptoven" as "Puntodeventa", "Fvtocai" as "Fechavtocai", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PRECOMPRA', '', tnTope )
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
	Function ObtenerDatosDetalleImpuestosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPPRECOMP.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpPreComp', 'ImpuestosDetalle', tnTope )
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
	Function ObtenerDatosDetalleFacturaDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PRECOMPRADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleFacturaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PreCompraDet', 'FacturaDetalle', tnTope )
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
	Function ObtenerDatosDetalleImpuestosComprobante( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPPREC.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosComprobante( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpPrec', 'ImpuestosComprobante', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
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
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCPRO AS SITUACIONFISCAL'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUTO AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'TIPOCOMPROBANTERG1361'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCRG1361 AS TIPOCOMPROBANTERG1361'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES1 AS MONTODESCUENTOCONIMPUESTOS1'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'NUMINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINT AS NUMINT'
				Case lcAtributo == 'IMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FIMPUESTO AS IMPUESTOS'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'FECHAFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHFAC AS FECHAFACTURA'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'PUNTODEVENTAEXTENDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVENEXT AS PUNTODEVENTAEXTENDIDO'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPOR AS RECARGOPORCENTAJE'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHVENC AS FECHAVENCIMIENTO'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR AS RECARGOMONTO'
				Case lcAtributo == 'CAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCAI AS CAI'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'FECHAVTOCAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVTOCAI AS FECHAVTOCAI'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREMITO AS REMITO'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO AS RECARGOMONTOCONIMPUESTOS'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS PROVEEDOR'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO1 AS RECARGOMONTO1'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO2 AS RECARGOMONTO2'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'CONDICIONPAGOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONPAGOPREFERENTE'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'TRANSPORTISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTRANSP AS TRANSPORTISTA'
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
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMATE AS MATERIAL'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAC AS ARTICULO_PORCENTAJEIVACOMPRAS'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'ARTICULO_CONDICIONIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAC AS ARTICULO_CONDICIONIVACOMPRAS'
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
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
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
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOIVA AS MONTOIVA'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'KIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FKIT AS KIT'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFITOT AS MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
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
	Function ObtenerCamposSelectDetalleImpuestosComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODIGOINTERNO'
				Case lcAtributo == 'TIPOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOI AS TIPOIMPUESTO'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'MINIMONOIMPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINOIMP AS MINIMONOIMPONIBLE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
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
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCPRO'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTERG1361'
				lcCampo = 'TCRG1361'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS1'
				lcCampo = 'FMTDES1'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'NUMINT'
				lcCampo = 'NUMINT'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOS'
				lcCampo = 'FIMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAFACTURA'
				lcCampo = 'FFCHFAC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAEXTENDIDO'
				lcCampo = 'FPTOVENEXT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPOR'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FFCHVENC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'MR'
			Case upper( alltrim( tcAtributo ) ) == 'CAI'
				lcCampo = 'NCAI'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOCAI'
				lcCampo = 'FVTOCAI'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'NROREMITO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS'
				lcCampo = 'RECMNTO'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'RECMONTO1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'RECMONTO2'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONPAGOPREFERENTE'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTA'
				lcCampo = 'FTRANSP'
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
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'FAMATE'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVACOMPRAS'
				lcCampo = 'APORCIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVACOMPRAS'
				lcCampo = 'ACONDIVAC'
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
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
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
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'FMTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'KIT'
				lcCampo = 'FKIT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				lcCampo = 'FCFITOT'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
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
	Function ObtenerCampoDetalleImpuestosComprobante( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOINTERNO'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTO'
				lcCampo = 'TIPOI'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMONOIMPONIBLE'
				lcCampo = 'MINOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
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
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPPRECOMP'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'FACTURADETALLE'
			lcRetorno = 'PRECOMPRADET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPPREC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxPrecompraFecimpo, lxPrecompraFmodifw, lxPrecompraFecexpo, lxPrecompraFd2, lxPrecompraFaltafw, lxPrecompraFectrans, lxPrecompraFcuit, lxPrecompraIdcaja, lxPrecompraFpodes2, lxPrecompraFpodes1, lxPrecompraFpodes, lxPrecompraFturno, lxPrecompraBdaltafw, lxPrecompraFhora, lxPrecompraZadsfw, lxPrecompraBdmodifw, lxPrecompraVmodifw, lxPrecompraValtafw, lxPrecompraSmodifw, lxPrecompraSaltafw, lxPrecompraUaltafw, lxPrecompraHmodifw, lxPrecompraSimbmon, lxPrecompraHoraimpo, lxPrecompraUmodifw, lxPrecompraDescfw, lxPrecompraHaltafw, lxPrecompraEsttrans, lxPrecompraHoraexpo, lxPrecompraTimestamp, lxPrecompraTotalcant, lxPrecompraRecmnto1, lxPrecompraRecmnto2, lxPrecompraRecmntosi1, lxPrecompraSubtotsisi, lxPrecompraCondivalp, lxPrecompraSubtotcisi, lxPrecompraFsubtot, lxPrecompraSitfiscpro, lxPrecompraFsubton, lxPrecompraFacttipo, lxPrecompraSignomov, lxPrecompraRecmntosi2, lxPrecompraRecmntosi, lxPrecompraDesmntosi, lxPrecompraDesmntosi2, lxPrecompraDesmntosi1, lxPrecompraDesauto, lxPrecompraAnulado, lxPrecompraFcompfis, lxPrecompraTcrg1361, lxPrecompraCodigo, lxPrecompraIdvuelto, lxPrecompraMonsis, lxPrecompraFmtdes1, lxPrecompraFdescu, lxPrecompraFmtdes2, lxPrecompraNumint, lxPrecompraFimpuesto, lxPrecompraFobs, lxPrecompraFletra, lxPrecompraFfch, lxPrecompraFfchfac, lxPrecompraFmtdes3, lxPrecompraDesmntosi3, lxPrecompraFptovenext, lxPrecompraRecpor, lxPrecompraCotiz, lxPrecompraTotdescsi, lxPrecompraFnumcomp, lxPrecompraFfchvenc, lxPrecompraMr, lxPrecompraNcai, lxPrecompraFptoven, lxPrecompraFvtocai, lxPrecompraNroremito, lxPrecompraRecmnto, lxPrecompraFvuelto, lxPrecompraFperson, lxPrecompraMoneda, lxPrecompraFtotal, lxPrecompraRecmonto1, lxPrecompraRecmonto2, lxPrecompraCodlista, lxPrecompraCondpago, lxPrecompraMotivo, lxPrecompraFtransp, lxPrecompraTotimpue, lxPrecompraTotrecar, lxPrecompraTotrecarsi, lxPrecompraTotdesc
				lxPrecompraFecimpo =  .Fechaimpo			lxPrecompraFmodifw =  .Fechamodificacionfw			lxPrecompraFecexpo =  .Fechaexpo			lxPrecompraFd2 =  .Fechamodificacion			lxPrecompraFaltafw =  .Fechaaltafw			lxPrecompraFectrans =  .Fechatransferencia			lxPrecompraFcuit =  .Cuit			lxPrecompraIdcaja =  .Caja_PK 			lxPrecompraFpodes2 =  .Porcentajedescuento2			lxPrecompraFpodes1 =  .Porcentajedescuento1			lxPrecompraFpodes =  .Porcentajedescuento			lxPrecompraFturno =  .Turno			lxPrecompraBdaltafw =  .Basededatosaltafw			lxPrecompraFhora =  .Hora			lxPrecompraZadsfw =  .Zadsfw			lxPrecompraBdmodifw =  .Basededatosmodificacionfw			lxPrecompraVmodifw =  .Versionmodificacionfw			lxPrecompraValtafw =  .Versionaltafw			lxPrecompraSmodifw =  .Seriemodificacionfw			lxPrecompraSaltafw =  .Seriealtafw			lxPrecompraUaltafw =  .Usuarioaltafw			lxPrecompraHmodifw =  .Horamodificacionfw			lxPrecompraSimbmon =  .Simbolomonetariocomprobante			lxPrecompraHoraimpo =  .Horaimpo			lxPrecompraUmodifw =  .Usuariomodificacionfw			lxPrecompraDescfw =  .Descripcionfw			lxPrecompraHaltafw =  .Horaaltafw			lxPrecompraEsttrans =  .Estadotransferencia			lxPrecompraHoraexpo =  .Horaexpo			lxPrecompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecompraTotalcant =  .Totalcantidad			lxPrecompraRecmnto1 =  .Recargomontoconimpuestos1			lxPrecompraRecmnto2 =  .Recargomontoconimpuestos2			lxPrecompraRecmntosi1 =  .Recargomontosinimpuestos1			lxPrecompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxPrecompraCondivalp =  .Condicioniva			lxPrecompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxPrecompraFsubtot =  .Subtotalbruto			lxPrecompraSitfiscpro =  .Situacionfiscal_PK 			lxPrecompraFsubton =  .Subtotalneto			lxPrecompraFacttipo =  .Tipocomprobante			lxPrecompraSignomov =  .Signodemovimiento			lxPrecompraRecmntosi2 =  .Recargomontosinimpuestos2			lxPrecompraRecmntosi =  .Recargomontosinimpuestos			lxPrecompraDesmntosi =  .Montodescuentosinimpuestos			lxPrecompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxPrecompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxPrecompraDesauto =  .Descuentoautomatico			lxPrecompraAnulado =  .Anulado			lxPrecompraFcompfis =  .Comprobantefiscal			lxPrecompraTcrg1361 =  .Tipocomprobanterg1361			lxPrecompraCodigo =  .Codigo			lxPrecompraIdvuelto =  upper( .IdVuelto_PK ) 			lxPrecompraMonsis =  upper( .MonedaSistema_PK ) 			lxPrecompraFmtdes1 =  .Montodescuentoconimpuestos1			lxPrecompraFdescu =  .Descuento			lxPrecompraFmtdes2 =  .Montodescuentoconimpuestos2			lxPrecompraNumint =  .Numint			lxPrecompraFimpuesto =  .Impuestos			lxPrecompraFobs =  .Obs			lxPrecompraFletra =  .Letra			lxPrecompraFfch =  .Fecha			lxPrecompraFfchfac =  .Fechafactura			lxPrecompraFmtdes3 =  .Montodescuentoconimpuestos3			lxPrecompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxPrecompraFptovenext =  .Puntodeventaextendido			lxPrecompraRecpor =  .Recargoporcentaje			lxPrecompraCotiz =  .Cotizacion			lxPrecompraTotdescsi =  .Totaldescuentossinimpuestos			lxPrecompraFnumcomp =  .Numero			lxPrecompraFfchvenc =  .Fechavencimiento			lxPrecompraMr =  .Recargomonto			lxPrecompraNcai =  .Cai			lxPrecompraFptoven =  .Puntodeventa			lxPrecompraFvtocai =  .Fechavtocai			lxPrecompraNroremito =  .Remito			lxPrecompraRecmnto =  .Recargomontoconimpuestos			lxPrecompraFvuelto =  .Vuelto			lxPrecompraFperson =  upper( .Proveedor_PK ) 			lxPrecompraMoneda =  upper( .MonedaComprobante_PK ) 			lxPrecompraFtotal =  .Total			lxPrecompraRecmonto1 =  .Recargomonto1			lxPrecompraRecmonto2 =  .Recargomonto2			lxPrecompraCodlista =  upper( .ListaDePrecios_PK ) 			lxPrecompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxPrecompraMotivo =  upper( .Motivo_PK ) 			lxPrecompraFtransp =  upper( .Transportista_PK ) 			lxPrecompraTotimpue =  .Totalimpuestos			lxPrecompraTotrecar =  .Totalrecargos			lxPrecompraTotrecarsi =  .Totalrecargossinimpuestos			lxPrecompraTotdesc =  .Totaldescuentos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PRECOMPRA ( "Fecimpo","Fmodifw","Fecexpo","Fd2","Faltafw","Fectrans","Fcuit","Idcaja","Fpodes2","Fpodes1","Fpodes","Fturno","Bdaltafw","Fhora","Zadsfw","Bdmodifw","Vmodifw","Valtafw","Smodifw","Saltafw","Ualtafw","Hmodifw","Simbmon","Horaimpo","Umodifw","Descfw","Haltafw","Esttrans","Horaexpo","Timestamp","Totalcant","Recmnto1","Recmnto2","Recmntosi1","Subtotsisi","Condivalp","Subtotcisi","Fsubtot","Sitfiscpro","Fsubton","Facttipo","Signomov","Recmntosi2","Recmntosi","Desmntosi","Desmntosi2","Desmntosi1","Desauto","Anulado","Fcompfis","Tcrg1361","Codigo","Idvuelto","Monsis","Fmtdes1","Fdescu","Fmtdes2","Numint","Fimpuesto","Fobs","Fletra","Ffch","Ffchfac","Fmtdes3","Desmntosi3","Fptovenext","Recpor","Cotiz","Totdescsi","Fnumcomp","Ffchvenc","Mr","Ncai","Fptoven","Fvtocai","Nroremito","Recmnto","Fvuelto","Fperson","Moneda","Ftotal","Recmonto1","Recmonto2","Codlista","Condpago","Motivo","Ftransp","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxPrecompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraFcuit ) + "'" >>, <<lxPrecompraIdcaja >>, <<lxPrecompraFpodes2 >>, <<lxPrecompraFpodes1 >>, <<lxPrecompraFpodes >>, <<lxPrecompraFturno >>, <<"'" + this.FormatearTextoSql( lxPrecompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraHoraexpo ) + "'" >>, <<lxPrecompraTimestamp >>, <<lxPrecompraTotalcant >>, <<lxPrecompraRecmnto1 >>, <<lxPrecompraRecmnto2 >>, <<lxPrecompraRecmntosi1 >>, <<lxPrecompraSubtotsisi >>, <<lxPrecompraCondivalp >>, <<lxPrecompraSubtotcisi >>, <<lxPrecompraFsubtot >>, <<lxPrecompraSitfiscpro >>, <<lxPrecompraFsubton >>, <<lxPrecompraFacttipo >>, <<lxPrecompraSignomov >>, <<lxPrecompraRecmntosi2 >>, <<lxPrecompraRecmntosi >>, <<lxPrecompraDesmntosi >>, <<lxPrecompraDesmntosi2 >>, <<lxPrecompraDesmntosi1 >>, <<iif( lxPrecompraDesauto, 1, 0 ) >>, <<iif( lxPrecompraAnulado, 1, 0 ) >>, <<iif( lxPrecompraFcompfis, 1, 0 ) >>, <<lxPrecompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxPrecompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraMonsis ) + "'" >>, <<lxPrecompraFmtdes1 >>, <<lxPrecompraFdescu >>, <<lxPrecompraFmtdes2 >>, <<lxPrecompraNumint >>, <<lxPrecompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxPrecompraFobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraFletra ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFfch ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecompraFfchfac ) + "'" >>, <<lxPrecompraFmtdes3 >>, <<lxPrecompraDesmntosi3 >>, <<lxPrecompraFptovenext >>, <<lxPrecompraRecpor >>, <<lxPrecompraCotiz >>, <<lxPrecompraTotdescsi >>, <<lxPrecompraFnumcomp >>, <<"'" + this.ConvertirDateSql( lxPrecompraFfchvenc ) + "'" >>, <<lxPrecompraMr >>, <<lxPrecompraNcai >>, <<lxPrecompraFptoven >>, <<"'" + this.ConvertirDateSql( lxPrecompraFvtocai ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraNroremito ) + "'" >>, <<lxPrecompraRecmnto >>, <<lxPrecompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxPrecompraFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraMoneda ) + "'" >>, <<lxPrecompraFtotal >>, <<lxPrecompraRecmonto1 >>, <<lxPrecompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxPrecompraCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraCondpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecompraFtransp ) + "'" >>, <<lxPrecompraTotimpue >>, <<lxPrecompraTotrecar >>, <<lxPrecompraTotrecarsi >>, <<lxPrecompraTotdesc >> )
		endtext
		loColeccion.cTabla = 'PRECOMPRA' 
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
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpPreComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxIditemarticulos = loItem.Iditemarticulos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNroitem = lnContadorNroItem
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxMontodto1 = loItem.Montodto1
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajeiva = loItem.Porcentajeiva
					lxMontocfi = loItem.Montocfi
					lxPorcentajecfi = loItem.Porcentajecfi
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxIdorigen = loItem.Idorigen
					lxIditem = loItem.Iditem
					lxAfe_nroitem = loItem.Afe_nroitem
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
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
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PreCompraDet("AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_cantidad>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_condicionivacompras>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajedto1>>, <<lxMontodto1>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajeiva>>, <<lxMontocfi>>, <<lxPorcentajecfi>>, <<lxPrecioconimpuestos>>, <<lxTipolistadeprecio>>, <<lxIdorigen>>, <<lxIditem>>, <<lxAfe_nroitem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxPorcentaje = loItem.Porcentaje
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpPrec("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxPrecompraFecimpo, lxPrecompraFmodifw, lxPrecompraFecexpo, lxPrecompraFd2, lxPrecompraFaltafw, lxPrecompraFectrans, lxPrecompraFcuit, lxPrecompraIdcaja, lxPrecompraFpodes2, lxPrecompraFpodes1, lxPrecompraFpodes, lxPrecompraFturno, lxPrecompraBdaltafw, lxPrecompraFhora, lxPrecompraZadsfw, lxPrecompraBdmodifw, lxPrecompraVmodifw, lxPrecompraValtafw, lxPrecompraSmodifw, lxPrecompraSaltafw, lxPrecompraUaltafw, lxPrecompraHmodifw, lxPrecompraSimbmon, lxPrecompraHoraimpo, lxPrecompraUmodifw, lxPrecompraDescfw, lxPrecompraHaltafw, lxPrecompraEsttrans, lxPrecompraHoraexpo, lxPrecompraTimestamp, lxPrecompraTotalcant, lxPrecompraRecmnto1, lxPrecompraRecmnto2, lxPrecompraRecmntosi1, lxPrecompraSubtotsisi, lxPrecompraCondivalp, lxPrecompraSubtotcisi, lxPrecompraFsubtot, lxPrecompraSitfiscpro, lxPrecompraFsubton, lxPrecompraFacttipo, lxPrecompraSignomov, lxPrecompraRecmntosi2, lxPrecompraRecmntosi, lxPrecompraDesmntosi, lxPrecompraDesmntosi2, lxPrecompraDesmntosi1, lxPrecompraDesauto, lxPrecompraAnulado, lxPrecompraFcompfis, lxPrecompraTcrg1361, lxPrecompraCodigo, lxPrecompraIdvuelto, lxPrecompraMonsis, lxPrecompraFmtdes1, lxPrecompraFdescu, lxPrecompraFmtdes2, lxPrecompraNumint, lxPrecompraFimpuesto, lxPrecompraFobs, lxPrecompraFletra, lxPrecompraFfch, lxPrecompraFfchfac, lxPrecompraFmtdes3, lxPrecompraDesmntosi3, lxPrecompraFptovenext, lxPrecompraRecpor, lxPrecompraCotiz, lxPrecompraTotdescsi, lxPrecompraFnumcomp, lxPrecompraFfchvenc, lxPrecompraMr, lxPrecompraNcai, lxPrecompraFptoven, lxPrecompraFvtocai, lxPrecompraNroremito, lxPrecompraRecmnto, lxPrecompraFvuelto, lxPrecompraFperson, lxPrecompraMoneda, lxPrecompraFtotal, lxPrecompraRecmonto1, lxPrecompraRecmonto2, lxPrecompraCodlista, lxPrecompraCondpago, lxPrecompraMotivo, lxPrecompraFtransp, lxPrecompraTotimpue, lxPrecompraTotrecar, lxPrecompraTotrecarsi, lxPrecompraTotdesc
				lxPrecompraFecimpo =  .Fechaimpo			lxPrecompraFmodifw =  .Fechamodificacionfw			lxPrecompraFecexpo =  .Fechaexpo			lxPrecompraFd2 =  .Fechamodificacion			lxPrecompraFaltafw =  .Fechaaltafw			lxPrecompraFectrans =  .Fechatransferencia			lxPrecompraFcuit =  .Cuit			lxPrecompraIdcaja =  .Caja_PK 			lxPrecompraFpodes2 =  .Porcentajedescuento2			lxPrecompraFpodes1 =  .Porcentajedescuento1			lxPrecompraFpodes =  .Porcentajedescuento			lxPrecompraFturno =  .Turno			lxPrecompraBdaltafw =  .Basededatosaltafw			lxPrecompraFhora =  .Hora			lxPrecompraZadsfw =  .Zadsfw			lxPrecompraBdmodifw =  .Basededatosmodificacionfw			lxPrecompraVmodifw =  .Versionmodificacionfw			lxPrecompraValtafw =  .Versionaltafw			lxPrecompraSmodifw =  .Seriemodificacionfw			lxPrecompraSaltafw =  .Seriealtafw			lxPrecompraUaltafw =  .Usuarioaltafw			lxPrecompraHmodifw =  .Horamodificacionfw			lxPrecompraSimbmon =  .Simbolomonetariocomprobante			lxPrecompraHoraimpo =  .Horaimpo			lxPrecompraUmodifw =  .Usuariomodificacionfw			lxPrecompraDescfw =  .Descripcionfw			lxPrecompraHaltafw =  .Horaaltafw			lxPrecompraEsttrans =  .Estadotransferencia			lxPrecompraHoraexpo =  .Horaexpo			lxPrecompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecompraTotalcant =  .Totalcantidad			lxPrecompraRecmnto1 =  .Recargomontoconimpuestos1			lxPrecompraRecmnto2 =  .Recargomontoconimpuestos2			lxPrecompraRecmntosi1 =  .Recargomontosinimpuestos1			lxPrecompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxPrecompraCondivalp =  .Condicioniva			lxPrecompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxPrecompraFsubtot =  .Subtotalbruto			lxPrecompraSitfiscpro =  .Situacionfiscal_PK 			lxPrecompraFsubton =  .Subtotalneto			lxPrecompraFacttipo =  .Tipocomprobante			lxPrecompraSignomov =  .Signodemovimiento			lxPrecompraRecmntosi2 =  .Recargomontosinimpuestos2			lxPrecompraRecmntosi =  .Recargomontosinimpuestos			lxPrecompraDesmntosi =  .Montodescuentosinimpuestos			lxPrecompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxPrecompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxPrecompraDesauto =  .Descuentoautomatico			lxPrecompraAnulado =  .Anulado			lxPrecompraFcompfis =  .Comprobantefiscal			lxPrecompraTcrg1361 =  .Tipocomprobanterg1361			lxPrecompraCodigo =  .Codigo			lxPrecompraIdvuelto =  upper( .IdVuelto_PK ) 			lxPrecompraMonsis =  upper( .MonedaSistema_PK ) 			lxPrecompraFmtdes1 =  .Montodescuentoconimpuestos1			lxPrecompraFdescu =  .Descuento			lxPrecompraFmtdes2 =  .Montodescuentoconimpuestos2			lxPrecompraNumint =  .Numint			lxPrecompraFimpuesto =  .Impuestos			lxPrecompraFobs =  .Obs			lxPrecompraFletra =  .Letra			lxPrecompraFfch =  .Fecha			lxPrecompraFfchfac =  .Fechafactura			lxPrecompraFmtdes3 =  .Montodescuentoconimpuestos3			lxPrecompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxPrecompraFptovenext =  .Puntodeventaextendido			lxPrecompraRecpor =  .Recargoporcentaje			lxPrecompraCotiz =  .Cotizacion			lxPrecompraTotdescsi =  .Totaldescuentossinimpuestos			lxPrecompraFnumcomp =  .Numero			lxPrecompraFfchvenc =  .Fechavencimiento			lxPrecompraMr =  .Recargomonto			lxPrecompraNcai =  .Cai			lxPrecompraFptoven =  .Puntodeventa			lxPrecompraFvtocai =  .Fechavtocai			lxPrecompraNroremito =  .Remito			lxPrecompraRecmnto =  .Recargomontoconimpuestos			lxPrecompraFvuelto =  .Vuelto			lxPrecompraFperson =  upper( .Proveedor_PK ) 			lxPrecompraMoneda =  upper( .MonedaComprobante_PK ) 			lxPrecompraFtotal =  .Total			lxPrecompraRecmonto1 =  .Recargomonto1			lxPrecompraRecmonto2 =  .Recargomonto2			lxPrecompraCodlista =  upper( .ListaDePrecios_PK ) 			lxPrecompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxPrecompraMotivo =  upper( .Motivo_PK ) 			lxPrecompraFtransp =  upper( .Transportista_PK ) 			lxPrecompraTotimpue =  .Totalimpuestos			lxPrecompraTotrecar =  .Totalrecargos			lxPrecompraTotrecarsi =  .Totalrecargossinimpuestos			lxPrecompraTotdesc =  .Totaldescuentos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30]
			text to lcSentencia noshow textmerge
				update ZooLogic.PRECOMPRA set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPrecompraFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPrecompraFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPrecompraFecexpo ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxPrecompraFd2 ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxPrecompraFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxPrecompraFectrans ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxPrecompraFcuit ) + "'">>, "Idcaja" = <<lxPrecompraIdcaja>>, "Fpodes2" = <<lxPrecompraFpodes2>>, "Fpodes1" = <<lxPrecompraFpodes1>>, "Fpodes" = <<lxPrecompraFpodes>>, "Fturno" = <<lxPrecompraFturno>>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPrecompraBdaltafw ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxPrecompraFhora ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxPrecompraZadsfw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraBdmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxPrecompraValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxPrecompraSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxPrecompraUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraHmodifw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxPrecompraSimbmon ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxPrecompraHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxPrecompraUmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxPrecompraDescfw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxPrecompraHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxPrecompraEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxPrecompraHoraexpo ) + "'">>, "Timestamp" = <<lxPrecompraTimestamp>>, "Totalcant" = <<lxPrecompraTotalcant>>, "Recmnto1" = <<lxPrecompraRecmnto1>>, "Recmnto2" = <<lxPrecompraRecmnto2>>, "Recmntosi1" = <<lxPrecompraRecmntosi1>>, "Subtotsisi" = <<lxPrecompraSubtotsisi>>, "Condivalp" = <<lxPrecompraCondivalp>>, "Subtotcisi" = <<lxPrecompraSubtotcisi>>, "Fsubtot" = <<lxPrecompraFsubtot>>, "Sitfiscpro" = <<lxPrecompraSitfiscpro>>, "Fsubton" = <<lxPrecompraFsubton>>, "Facttipo" = <<lxPrecompraFacttipo>>, "Signomov" = <<lxPrecompraSignomov>>, "Recmntosi2" = <<lxPrecompraRecmntosi2>>, "Recmntosi" = <<lxPrecompraRecmntosi>>, "Desmntosi" = <<lxPrecompraDesmntosi>>, "Desmntosi2" = <<lxPrecompraDesmntosi2>>, "Desmntosi1" = <<lxPrecompraDesmntosi1>>, "Desauto" = <<iif( lxPrecompraDesauto, 1, 0 )>>, "Anulado" = <<iif( lxPrecompraAnulado, 1, 0 )>>, "Fcompfis" = <<iif( lxPrecompraFcompfis, 1, 0 )>>, "Tcrg1361" = <<lxPrecompraTcrg1361>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxPrecompraCodigo ) + "'">>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxPrecompraIdvuelto ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxPrecompraMonsis ) + "'">>, "Fmtdes1" = <<lxPrecompraFmtdes1>>, "Fdescu" = <<lxPrecompraFdescu>>, "Fmtdes2" = <<lxPrecompraFmtdes2>>, "Numint" = <<lxPrecompraNumint>>, "Fimpuesto" = <<lxPrecompraFimpuesto>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxPrecompraFobs ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxPrecompraFletra ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxPrecompraFfch ) + "'">>, "Ffchfac" = <<"'" + this.ConvertirDateSql( lxPrecompraFfchfac ) + "'">>, "Fmtdes3" = <<lxPrecompraFmtdes3>>, "Desmntosi3" = <<lxPrecompraDesmntosi3>>, "Fptovenext" = <<lxPrecompraFptovenext>>, "Recpor" = <<lxPrecompraRecpor>>, "Cotiz" = <<lxPrecompraCotiz>>, "Totdescsi" = <<lxPrecompraTotdescsi>>, "Fnumcomp" = <<lxPrecompraFnumcomp>>, "Ffchvenc" = <<"'" + this.ConvertirDateSql( lxPrecompraFfchvenc ) + "'">>, "Mr" = <<lxPrecompraMr>>, "Ncai" = <<lxPrecompraNcai>>, "Fptoven" = <<lxPrecompraFptoven>>, "Fvtocai" = <<"'" + this.ConvertirDateSql( lxPrecompraFvtocai ) + "'">>, "Nroremito" = <<"'" + this.FormatearTextoSql( lxPrecompraNroremito ) + "'">>, "Recmnto" = <<lxPrecompraRecmnto>>, "Fvuelto" = <<lxPrecompraFvuelto>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxPrecompraFperson ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxPrecompraMoneda ) + "'">>, "Ftotal" = <<lxPrecompraFtotal>>, "Recmonto1" = <<lxPrecompraRecmonto1>>, "Recmonto2" = <<lxPrecompraRecmonto2>>, "Codlista" = <<"'" + this.FormatearTextoSql( lxPrecompraCodlista ) + "'">>, "Condpago" = <<"'" + this.FormatearTextoSql( lxPrecompraCondpago ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxPrecompraMotivo ) + "'">>, "Ftransp" = <<"'" + this.FormatearTextoSql( lxPrecompraFtransp ) + "'">>, "Totimpue" = <<lxPrecompraTotimpue>>, "Totrecar" = <<lxPrecompraTotrecar>>, "Totrecarsi" = <<lxPrecompraTotrecarsi>>, "Totdesc" = <<lxPrecompraTotdesc>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PRECOMPRA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpPreComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PreCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpPrec where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpPreComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxIditemarticulos = loItem.Iditemarticulos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNroitem = lnContadorNroItem
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxMontodto1 = loItem.Montodto1
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajeiva = loItem.Porcentajeiva
					lxMontocfi = loItem.Montocfi
					lxPorcentajecfi = loItem.Porcentajecfi
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxIdorigen = loItem.Idorigen
					lxIditem = loItem.Iditem
					lxAfe_nroitem = loItem.Afe_nroitem
					lxPreciounitario = loItem.Preciounitario
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
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
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PreCompraDet("AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_cantidad>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_condicionivacompras>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajedto1>>, <<lxMontodto1>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajeiva>>, <<lxMontocfi>>, <<lxPorcentajecfi>>, <<lxPrecioconimpuestos>>, <<lxTipolistadeprecio>>, <<lxIdorigen>>, <<lxIditem>>, <<lxAfe_nroitem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxPorcentaje = loItem.Porcentaje
					lxMinimonoimponible = loItem.Minimonoimponible
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpPrec("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30]
		loColeccion.Agregar( 'delete from ZooLogic.PRECOMPRA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpPreComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PreCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpPrec where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'PRECOMPRA' 
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
					"Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
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
			lcRetorno = [update ZooLogic.PRECOMPRA set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PRECOMPRA where  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PRECOMPRA where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxPreCompraFACTTIPO as variant, lxPreCompraNumInt as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PRESUPUESTODECOMPRA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PRECOMPRA Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and NumInt = ] + transform( &lcCursor..NumInt     ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.PRECOMPRA set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, SitFiscPro = ] + transform( &lcCursor..SitFiscPro )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, DesAuto = ] + Transform( iif( &lcCursor..DesAuto, 1, 0 ))+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, tcrg1361 = ] + transform( &lcCursor..tcrg1361 )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, NumInt = ] + transform( &lcCursor..NumInt )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FFCHFAC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, FPTOVENEXT = ] + transform( &lcCursor..FPTOVENEXT )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FFCHVENC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'"+ [, MR = ] + transform( &lcCursor..MR )+ [, NCAI = ] + transform( &lcCursor..NCAI )+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, FVTOCAI = ] + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'"+ [, NROREMITO = ] + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, RecMonto1 = ] + transform( &lcCursor..RecMonto1 )+ [, RecMonto2 = ] + transform( &lcCursor..RecMonto2 )+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, CONDPAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, FTransp = ] + "'" + this.FormatearTextoSql( &lcCursor..FTransp ) + "'"+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, totdesc = ] + transform( &lcCursor..totdesc ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.PRECOMPRA Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FMODIFW, FECEXPO, FD2, FALTAFW, FECTRANS, fCuit, IdCaja, FPODES2, FPODES1, FPODES, FTurno, BDALTAFW, FHORA, ZADSFW, BDMODIFW, VMODIFW, VALTAFW, SMODIFW, SALTAFW, UALTAFW, HMODIFW, SimbMon, HORAIMPO, UMODIFW, DescFW, HALTAFW, ESTTRANS, HORAEXPO, TIMESTAMP, TotalCant, RecMnto1, RecMnto2, RecMntoSI1, SubTotSISI, CondivaLp, SubTotCISI, FSubTOT, SitFiscPro, fSubToN, FACTTIPO, signomov, RecMntoSI2, RecMntoSI, DesMntoSI, DesMntoSI2, DesMntoSI1, DesAuto, Anulado, FCOMPFIS, tcrg1361, CODIGO, idVuelto, MonSis, FMTDES1, fDescu, FMTDES2, NumInt, fImpuesto, FObs, FLETRA, FFCH, FFCHFAC, FMTDES3, DesMntoSI3, FPTOVENEXT, RecPor, Cotiz, totdescSI, FNUMCOMP, FFCHVENC, MR, NCAI, FPTOVEN, FVTOCAI, NROREMITO, RecMnto, FVuelto, FPerson, Moneda, FTotal, RecMonto1, RecMonto2, CodLista, CONDPAGO, MOTIVO, FTransp, totimpue, totrecar, totrecarSI, totdesc
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..FPODES1 ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..FTurno ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..SitFiscPro ) + ',' + transform( &lcCursor..fSubToN )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + transform( &lcCursor..RecMntoSI ) + ',' + transform( &lcCursor..DesMntoSI ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + Transform( iif( &lcCursor..DesAuto, 1, 0 )) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..tcrg1361 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + transform( &lcCursor..FMTDES1 ) + ',' + transform( &lcCursor..fDescu ) + ',' + transform( &lcCursor..FMTDES2 ) + ',' + transform( &lcCursor..NumInt ) + ',' + transform( &lcCursor..fImpuesto )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'" + ',' + transform( &lcCursor..FMTDES3 ) + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + transform( &lcCursor..FPTOVENEXT ) + ',' + transform( &lcCursor..RecPor )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..totdescSI ) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'" + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..NCAI ) + ',' + transform( &lcCursor..FPTOVEN ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecMnto ) + ',' + transform( &lcCursor..FVuelto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + transform( &lcCursor..RecMonto1 ) + ',' + transform( &lcCursor..RecMonto2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FTransp ) + "'" + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..totrecar ) + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..totdesc )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.PRECOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PRESUPUESTODECOMPRA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpPreComp Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.PreCompraDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpPrec Where cCod] + lcIn  )
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSPREC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpPreComp ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSPRECOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","FCANT","FPRECIO","FCFI","MNTDES","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.PreCompraDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_Cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.APorcIvaC  ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.ACondIvaC  ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOPRECOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpPrec ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + transform( cDetallesExistentes.porcen     ) + ',' + transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSPRECOMPRA',this.oEntidad.cPrefijoRecibir + 'PRESUPUESTODECOMPRA')
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSPRECOMPRA', this.oEntidad.cPrefijoRecibir + 'PRESUPUESTODECOMPRA')
		
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
			Case  lcAlias == lcPrefijo + 'PRESUPUESTODECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PRESUPUESTODECOMPRA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PRESUPUESTODECOMPRA_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSPREC'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSPRECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOPRECOMPRA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PreCompra')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PRESUPUESTODECOMPRA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..NumInt )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PRESUPUESTODECOMPRA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PRESUPUESTODECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( FACTTIPO, 2, 0) + str( NumInt, 10, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( FACTTIPO, 2, 0) + str( NumInt, 10, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PRESUPUESTODECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PreCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PreCompra
Create Table ZooLogic.TablaTrabajo_PreCompra ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fd2" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"fturno" numeric( 1, 0 )  null, 
"bdaltafw" char( 8 )  null, 
"fhora" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"bdmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"simbmon" char( 3 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"descfw" char( 200 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"recmnto1" numeric( 15, 2 )  null, 
"recmnto2" numeric( 15, 2 )  null, 
"recmntosi1" numeric( 15, 2 )  null, 
"subtotsisi" numeric( 15, 2 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"subtotcisi" numeric( 15, 2 )  null, 
"fsubtot" numeric( 15, 2 )  null, 
"sitfiscpro" numeric( 2, 0 )  null, 
"fsubton" numeric( 15, 2 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"signomov" numeric( 2, 0 )  null, 
"recmntosi2" numeric( 15, 2 )  null, 
"recmntosi" numeric( 15, 2 )  null, 
"desmntosi" numeric( 15, 2 )  null, 
"desmntosi2" numeric( 15, 2 )  null, 
"desmntosi1" numeric( 15, 2 )  null, 
"desauto" bit  null, 
"anulado" bit  null, 
"fcompfis" bit  null, 
"tcrg1361" numeric( 1, 0 )  null, 
"codigo" char( 38 )  null, 
"idvuelto" char( 5 )  null, 
"monsis" char( 10 )  null, 
"fmtdes1" numeric( 15, 2 )  null, 
"fdescu" numeric( 15, 2 )  null, 
"fmtdes2" numeric( 15, 2 )  null, 
"numint" numeric( 10, 0 )  null, 
"fimpuesto" numeric( 15, 2 )  null, 
"fobs" varchar(max)  null, 
"fletra" char( 1 )  null, 
"ffch" datetime  null, 
"ffchfac" datetime  null, 
"fmtdes3" numeric( 15, 2 )  null, 
"desmntosi3" numeric( 15, 2 )  null, 
"fptovenext" numeric( 5, 0 )  null, 
"recpor" numeric( 6, 2 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"totdescsi" numeric( 15, 2 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"ffchvenc" datetime  null, 
"mr" numeric( 15, 2 )  null, 
"ncai" numeric( 14, 0 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"fvtocai" datetime  null, 
"nroremito" char( 15 )  null, 
"recmnto" numeric( 15, 2 )  null, 
"fvuelto" numeric( 15, 2 )  null, 
"fperson" char( 10 )  null, 
"moneda" char( 10 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"recmonto1" numeric( 15, 2 )  null, 
"recmonto2" numeric( 15, 2 )  null, 
"codlista" char( 6 )  null, 
"condpago" char( 5 )  null, 
"motivo" char( 3 )  null, 
"ftransp" char( 15 )  null, 
"totimpue" numeric( 15, 2 )  null, 
"totrecar" numeric( 15, 2 )  null, 
"totrecarsi" numeric( 15, 2 )  null, 
"totdesc" numeric( 15, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PreCompra' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PreCompra' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PRESUPUESTODECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('sitfiscpro','sitfiscpro')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('desauto','desauto')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('tcrg1361','tcrg1361')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('numint','numint')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('ffchfac','ffchfac')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('fptovenext','fptovenext')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('ffchvenc','ffchvenc')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('ncai','ncai')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('fvtocai','fvtocai')
			.AgregarMapeo('nroremito','nroremito')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('recmonto1','recmonto1')
			.AgregarMapeo('recmonto2','recmonto2')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('condpago','condpago')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('ftransp','ftransp')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('totdesc','totdesc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PreCompra'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.SITFISCPRO = isnull( d.SITFISCPRO, t.SITFISCPRO ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.DESAUTO = isnull( d.DESAUTO, t.DESAUTO ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.TCRG1361 = isnull( d.TCRG1361, t.TCRG1361 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.NUMINT = isnull( d.NUMINT, t.NUMINT ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FFCHFAC = isnull( d.FFCHFAC, t.FFCHFAC ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.FPTOVENEXT = isnull( d.FPTOVENEXT, t.FPTOVENEXT ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FFCHVENC = isnull( d.FFCHVENC, t.FFCHVENC ),t.MR = isnull( d.MR, t.MR ),t.NCAI = isnull( d.NCAI, t.NCAI ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.FVTOCAI = isnull( d.FVTOCAI, t.FVTOCAI ),t.NROREMITO = isnull( d.NROREMITO, t.NROREMITO ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.RECMONTO1 = isnull( d.RECMONTO1, t.RECMONTO1 ),t.RECMONTO2 = isnull( d.RECMONTO2, t.RECMONTO2 ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.FTRANSP = isnull( d.FTRANSP, t.FTRANSP ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC )
					from ZooLogic.PRECOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.NumInt = d.NumInt
				-- Fin Updates
				insert into ZooLogic.PRECOMPRA(Fecimpo,Fmodifw,Fecexpo,Fd2,Faltafw,Fectrans,Fcuit,Idcaja,Fpodes2,Fpodes1,Fpodes,Fturno,Bdaltafw,Fhora,Zadsfw,Bdmodifw,Vmodifw,Valtafw,Smodifw,Saltafw,Ualtafw,Hmodifw,Simbmon,Horaimpo,Umodifw,Descfw,Haltafw,Esttrans,Horaexpo,Timestamp,Totalcant,Recmnto1,Recmnto2,Recmntosi1,Subtotsisi,Condivalp,Subtotcisi,Fsubtot,Sitfiscpro,Fsubton,Facttipo,Signomov,Recmntosi2,Recmntosi,Desmntosi,Desmntosi2,Desmntosi1,Desauto,Anulado,Fcompfis,Tcrg1361,Codigo,Idvuelto,Monsis,Fmtdes1,Fdescu,Fmtdes2,Numint,Fimpuesto,Fobs,Fletra,Ffch,Ffchfac,Fmtdes3,Desmntosi3,Fptovenext,Recpor,Cotiz,Totdescsi,Fnumcomp,Ffchvenc,Mr,Ncai,Fptoven,Fvtocai,Nroremito,Recmnto,Fvuelto,Fperson,Moneda,Ftotal,Recmonto1,Recmonto2,Codlista,Condpago,Motivo,Ftransp,Totimpue,Totrecar,Totrecarsi,Totdesc)
					Select isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FD2,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FPODES2,0),isnull( d.FPODES1,0),isnull( d.FPODES,0),isnull( d.FTURNO,0),isnull( d.BDALTAFW,''),isnull( d.FHORA,''),isnull( d.ZADSFW,''),isnull( d.BDMODIFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SIMBMON,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.DESCFW,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.TIMESTAMP,0),isnull( d.TOTALCANT,0),isnull( d.RECMNTO1,0),isnull( d.RECMNTO2,0),isnull( d.RECMNTOSI1,0),isnull( d.SUBTOTSISI,0),isnull( d.CONDIVALP,0),isnull( d.SUBTOTCISI,0),isnull( d.FSUBTOT,0),isnull( d.SITFISCPRO,0),isnull( d.FSUBTON,0),isnull( d.FACTTIPO,0),isnull( d.SIGNOMOV,0),isnull( d.RECMNTOSI2,0),isnull( d.RECMNTOSI,0),isnull( d.DESMNTOSI,0),isnull( d.DESMNTOSI2,0),isnull( d.DESMNTOSI1,0),isnull( d.DESAUTO,0),isnull( d.ANULADO,0),isnull( d.FCOMPFIS,0),isnull( d.TCRG1361,0),isnull( d.CODIGO,''),isnull( d.IDVUELTO,''),isnull( d.MONSIS,''),isnull( d.FMTDES1,0),isnull( d.FDESCU,0),isnull( d.FMTDES2,0),isnull( d.NUMINT,0),isnull( d.FIMPUESTO,0),isnull( d.FOBS,''),isnull( d.FLETRA,''),isnull( d.FFCH,''),isnull( d.FFCHFAC,''),isnull( d.FMTDES3,0),isnull( d.DESMNTOSI3,0),isnull( d.FPTOVENEXT,0),isnull( d.RECPOR,0),isnull( d.COTIZ,0),isnull( d.TOTDESCSI,0),isnull( d.FNUMCOMP,0),isnull( d.FFCHVENC,''),isnull( d.MR,0),isnull( d.NCAI,0),isnull( d.FPTOVEN,0),isnull( d.FVTOCAI,''),isnull( d.NROREMITO,''),isnull( d.RECMNTO,0),isnull( d.FVUELTO,0),isnull( d.FPERSON,''),isnull( d.MONEDA,''),isnull( d.FTOTAL,0),isnull( d.RECMONTO1,0),isnull( d.RECMONTO2,0),isnull( d.CODLISTA,''),isnull( d.CONDPAGO,''),isnull( d.MOTIVO,''),isnull( d.FTRANSP,''),isnull( d.TOTIMPUE,0),isnull( d.TOTRECAR,0),isnull( d.TOTRECARSI,0),isnull( d.TOTDESC,0)
						From deleted d left join ZooLogic.PRECOMPRA pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.PRECOMPRA cc 
							 on  d.FACTTIPO = cc.FACTTIPO
							 and  d.NumInt = cc.NumInt
						Where pk.CODIGO Is Null 
							 and cc.FACTTIPO Is Null 
							 and cc.NumInt Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', NÚMERO INTERNO ' + cast( d.NumInt as Varchar(10) ) + '','La clave principal no es la esperada'
					from ZooLogic.PRECOMPRA t inner join deleted d 
							on   t.FACTTIPO = d.FACTTIPO
							 and  t.NumInt = d.NumInt
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', NÚMERO INTERNO ' + cast( d.NumInt as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ZooLogic.PRECOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.FACTTIPO = h.FACTTIPO
							 and   t.NumInt = h.NumInt
							where   h.FACTTIPO is null 
							 and   h.NumInt is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PRECOMPRA_CompAfe
ON ZooLogic.TablaTrabajo_PRECOMPRA_CompAfe
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
	function ObtenerTriggerDeleteImportacion_ImpPreComp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PRECOMPRA_ImpPreComp
ON ZooLogic.TablaTrabajo_PRECOMPRA_ImpPreComp
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
from ZooLogic.ImpPreComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpPreComp
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
From deleted d left join ZooLogic.ImpPreComp pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_PreCompraDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PRECOMPRA_PreCompraDet
ON ZooLogic.TablaTrabajo_PRECOMPRA_PreCompraDet
AFTER DELETE
As
Begin
Update t Set 
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.FAMATE = isnull( d.FAMATE, t.FAMATE ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.APORCIVAC = isnull( d.APORCIVAC, t.APORCIVAC ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.ACONDIVAC = isnull( d.ACONDIVAC, t.ACONDIVAC ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.COMP = isnull( d.COMP, t.COMP ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
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
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.PreCompraDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.PreCompraDet
( 
"AFELETRA",
"AFENUMCOM",
"AFEPTOVEN",
"FAMATE",
"AFE_COD",
"IDITEM",
"MNTPTOT",
"MNTPRECCI",
"AFECANT",
"AFETS",
"MNTPPER",
"APORCIVAC",
"AFESALDO",
"ACONDIVAC",
"AJUSIMP",
"AJUCIMP",
"COMP",
"FBRUTO",
"ARTPERCEP",
"MNDESSI",
"MNTPDESSI",
"MNTPRECSI",
"MNPDSI",
"MNTPDESCI",
"MNDESCI",
"AFETIPOCOM",
"NROITEM",
"FNETO",
"FX2",
"FMTOIVA",
"FPORDTO1",
"FMTODTO1",
"FKIT",
"FCFITOT",
"FPORIVA",
"FMTOCFI",
"FPORCFI",
"PRUNCONIMP",
"FN11",
"IDITEMORIG",
"CIDITEM",
"AFENROITEM",
"FPRUN",
"PRUNSINIMP",
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
d.FAMATE,
d.AFE_COD,
d.IDITEM,
d.MNTPTOT,
d.MNTPRECCI,
d.AFECANT,
d.AFETS,
d.MNTPPER,
d.APORCIVAC,
d.AFESALDO,
d.ACONDIVAC,
d.AJUSIMP,
d.AJUCIMP,
d.COMP,
d.FBRUTO,
d.ARTPERCEP,
d.MNDESSI,
d.MNTPDESSI,
d.MNTPRECSI,
d.MNPDSI,
d.MNTPDESCI,
d.MNDESCI,
d.AFETIPOCOM,
d.NROITEM,
d.FNETO,
d.FX2,
d.FMTOIVA,
d.FPORDTO1,
d.FMTODTO1,
d.FKIT,
d.FCFITOT,
d.FPORIVA,
d.FMTOCFI,
d.FPORCFI,
d.PRUNCONIMP,
d.FN11,
d.IDITEMORIG,
d.CIDITEM,
d.AFENROITEM,
d.FPRUN,
d.PRUNSINIMP,
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
d.FCANT,
d.FPRECIO,
d.FCFI,
d.MNTDES,
d.FMONTO
From deleted d left join ZooLogic.PreCompraDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpPrec( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PRECOMPRA_ImpPrec
ON ZooLogic.TablaTrabajo_PRECOMPRA_ImpPrec
AFTER DELETE
As
Begin
Update t Set 
t.CODINT = isnull( d.CODINT, t.CODINT ),
t.TIPOI = isnull( d.TIPOI, t.TIPOI ),
t.PORCEN = isnull( d.PORCEN, t.PORCEN ),
t.MINOIMP = isnull( d.MINOIMP, t.MINOIMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CCOD = isnull( d.CCOD, t.CCOD ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.ImpPrec t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpPrec
( 
"CODINT",
"TIPOI",
"PORCEN",
"MINOIMP",
"NROITEM",
"CCOD",
"CODIMP",
"DESCRI",
"MONTO"
 )
Select 
d.CODINT,
d.TIPOI,
d.PORCEN,
d.MINOIMP,
d.NROITEM,
d.CCOD,
d.CODIMP,
d.DESCRI,
d.MONTO
From deleted d left join ZooLogic.ImpPrec pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PreCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PreCompra
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PRESUPUESTODECOMPRA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_PRESUPUESTODECOMPRA.Cuit, [] )
					.Caja_PK =  nvl( c_PRESUPUESTODECOMPRA.Caja, 0 )
					.Porcentajedescuento2 = nvl( c_PRESUPUESTODECOMPRA.Porcentajedescuento2, 0 )
					.Porcentajedescuento1 = nvl( c_PRESUPUESTODECOMPRA.Porcentajedescuento1, 0 )
					.Porcentajedescuento = nvl( c_PRESUPUESTODECOMPRA.Porcentajedescuento, 0 )
					.Turno = nvl( c_PRESUPUESTODECOMPRA.Turno, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Basededatosaltafw = nvl( c_PRESUPUESTODECOMPRA.Basededatosaltafw, [] )
					.Hora = nvl( c_PRESUPUESTODECOMPRA.Hora, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosmodificacionfw = nvl( c_PRESUPUESTODECOMPRA.Basededatosmodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_PRESUPUESTODECOMPRA.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_PRESUPUESTODECOMPRA.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_PRESUPUESTODECOMPRA.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_PRESUPUESTODECOMPRA.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_PRESUPUESTODECOMPRA.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_PRESUPUESTODECOMPRA.Horamodificacionfw, [] )
					.Simbolomonetariocomprobante = nvl( c_PRESUPUESTODECOMPRA.Simbolomonetariocomprobante, [] )
					.Horaimpo = nvl( c_PRESUPUESTODECOMPRA.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_PRESUPUESTODECOMPRA.Usuariomodificacionfw, [] )
					.Descripcionfw = nvl( c_PRESUPUESTODECOMPRA.Descripcionfw, [] )
					.Horaaltafw = nvl( c_PRESUPUESTODECOMPRA.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_PRESUPUESTODECOMPRA.Estadotransferencia, [] )
					.Horaexpo = nvl( c_PRESUPUESTODECOMPRA.Horaexpo, [] )
					.Timestamp = nvl( c_PRESUPUESTODECOMPRA.Timestamp, 0 )
					.Totalcantidad = nvl( c_PRESUPUESTODECOMPRA.Totalcantidad, 0 )
					.Recargomontoconimpuestos1 = nvl( c_PRESUPUESTODECOMPRA.Recargomontoconimpuestos1, 0 )
					.Recargomontoconimpuestos2 = nvl( c_PRESUPUESTODECOMPRA.Recargomontoconimpuestos2, 0 )
					.Recargomontosinimpuestos1 = nvl( c_PRESUPUESTODECOMPRA.Recargomontosinimpuestos1, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_PRESUPUESTODECOMPRA.Subtotalsinimpuestossobreitems, 0 )
					.Condicioniva = nvl( c_PRESUPUESTODECOMPRA.Condicioniva, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_PRESUPUESTODECOMPRA.Subtotalconimpuestossobreitems, 0 )
					.Subtotalbruto = nvl( c_PRESUPUESTODECOMPRA.Subtotalbruto, 0 )
					.Situacionfiscal_PK =  nvl( c_PRESUPUESTODECOMPRA.Situacionfiscal, 0 )
					.Subtotalneto = nvl( c_PRESUPUESTODECOMPRA.Subtotalneto, 0 )
					.Tipocomprobante = nvl( c_PRESUPUESTODECOMPRA.Tipocomprobante, 0 )
					.Signodemovimiento = nvl( c_PRESUPUESTODECOMPRA.Signodemovimiento, 0 )
					.Recargomontosinimpuestos2 = nvl( c_PRESUPUESTODECOMPRA.Recargomontosinimpuestos2, 0 )
					.Recargomontosinimpuestos = nvl( c_PRESUPUESTODECOMPRA.Recargomontosinimpuestos, 0 )
					.Montodescuentosinimpuestos = nvl( c_PRESUPUESTODECOMPRA.Montodescuentosinimpuestos, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_PRESUPUESTODECOMPRA.Montodescuentosinimpuestos2, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_PRESUPUESTODECOMPRA.Montodescuentosinimpuestos1, 0 )
					.Descuentoautomatico = nvl( c_PRESUPUESTODECOMPRA.Descuentoautomatico, .F. )
					.Anulado = nvl( c_PRESUPUESTODECOMPRA.Anulado, .F. )
					.Comprobantefiscal = nvl( c_PRESUPUESTODECOMPRA.Comprobantefiscal, .F. )
					.Tipocomprobanterg1361 = nvl( c_PRESUPUESTODECOMPRA.Tipocomprobanterg1361, 0 )
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Codigo = nvl( c_PRESUPUESTODECOMPRA.Codigo, [] )
					.Idvuelto_PK =  nvl( c_PRESUPUESTODECOMPRA.Idvuelto, [] )
					.Monedasistema_PK =  nvl( c_PRESUPUESTODECOMPRA.Monedasistema, [] )
					.Montodescuentoconimpuestos1 = nvl( c_PRESUPUESTODECOMPRA.Montodescuentoconimpuestos1, 0 )
					.Descuento = nvl( c_PRESUPUESTODECOMPRA.Descuento, 0 )
					.Montodescuentoconimpuestos2 = nvl( c_PRESUPUESTODECOMPRA.Montodescuentoconimpuestos2, 0 )
					.Numint = nvl( c_PRESUPUESTODECOMPRA.Numint, 0 )
					.Impuestos = nvl( c_PRESUPUESTODECOMPRA.Impuestos, 0 )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Letra = nvl( c_PRESUPUESTODECOMPRA.Letra, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fecha, ctod( '  /  /    ' ) ) )
					.Fechafactura = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fechafactura, ctod( '  /  /    ' ) ) )
					.Montodescuentoconimpuestos3 = nvl( c_PRESUPUESTODECOMPRA.Montodescuentoconimpuestos3, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_PRESUPUESTODECOMPRA.Montodescuentosinimpuestos3, 0 )
					.Puntodeventaextendido = nvl( c_PRESUPUESTODECOMPRA.Puntodeventaextendido, 0 )
					.Recargoporcentaje = nvl( c_PRESUPUESTODECOMPRA.Recargoporcentaje, 0 )
					.Cotizacion = nvl( c_PRESUPUESTODECOMPRA.Cotizacion, 0 )
					.Totaldescuentossinimpuestos = nvl( c_PRESUPUESTODECOMPRA.Totaldescuentossinimpuestos, 0 )
					.Numero = nvl( c_PRESUPUESTODECOMPRA.Numero, 0 )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Recargomonto = nvl( c_PRESUPUESTODECOMPRA.Recargomonto, 0 )
					.Cai = nvl( c_PRESUPUESTODECOMPRA.Cai, 0 )
					.Puntodeventa = nvl( c_PRESUPUESTODECOMPRA.Puntodeventa, 0 )
					.Fechavtocai = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRESUPUESTODECOMPRA.Fechavtocai, ctod( '  /  /    ' ) ) )
					.Remito = nvl( c_PRESUPUESTODECOMPRA.Remito, [] )
					.Recargomontoconimpuestos = nvl( c_PRESUPUESTODECOMPRA.Recargomontoconimpuestos, 0 )
					.Vuelto = nvl( c_PRESUPUESTODECOMPRA.Vuelto, 0 )
					.Proveedor_PK =  nvl( c_PRESUPUESTODECOMPRA.Proveedor, [] )
					.Monedacomprobante_PK =  nvl( c_PRESUPUESTODECOMPRA.Monedacomprobante, [] )
					.Total = nvl( c_PRESUPUESTODECOMPRA.Total, 0 )
					.Recargomonto1 = nvl( c_PRESUPUESTODECOMPRA.Recargomonto1, 0 )
					.Recargomonto2 = nvl( c_PRESUPUESTODECOMPRA.Recargomonto2, 0 )
					.Listadeprecios_PK =  nvl( c_PRESUPUESTODECOMPRA.Listadeprecios, [] )
					.Condicionpagopreferente_PK =  nvl( c_PRESUPUESTODECOMPRA.Condicionpagopreferente, [] )
					.Motivo_PK =  nvl( c_PRESUPUESTODECOMPRA.Motivo, [] )
					.Transportista_PK =  nvl( c_PRESUPUESTODECOMPRA.Transportista, [] )
					.Totalimpuestos = nvl( c_PRESUPUESTODECOMPRA.Totalimpuestos, 0 )
					.Totalrecargos = nvl( c_PRESUPUESTODECOMPRA.Totalrecargos, 0 )
					.Totalrecargossinimpuestos = nvl( c_PRESUPUESTODECOMPRA.Totalrecargossinimpuestos, 0 )
					.Totaldescuentos = nvl( c_PRESUPUESTODECOMPRA.Totaldescuentos, 0 )
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
			lxRetorno = c_PRESUPUESTODECOMPRA.CODIGO
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
				lcSentencia = "UPDATE ZooLogic.PreCompraDet"
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
		return c_PRESUPUESTODECOMPRA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PRECOMPRA' )
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
								from ZooLogic.PRECOMPRA 
								Where   PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PRECOMPRA", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes1" as "Porcentajedescuento1", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Descfw" as "Descripcionfw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Recmnto1" as "Recargomontoconimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Signomov" as "Signodemovimiento", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Desmntosi" as "Montodescuentosinimpuestos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fptovenext" as "Puntodeventaextendido", "Recpor" as "Recargoporcentaje", "Cotiz" as "Cotizacion", "Totdescsi" as "Totaldescuentossinimpuestos", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fptoven" as "Puntodeventa", "Fvtocai" as "Fechavtocai", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Fperson" as "Proveedor", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PRECOMPRA 
								Where   PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30
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
	Tabla = 'PRECOMPRA'
	Filtro = " PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30"
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
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHAIMPO                               " tabla="PRECOMPRA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHAMODIFICACIONFW                     " tabla="PRECOMPRA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHAEXPO                               " tabla="PRECOMPRA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHAMODIFICACION                       " tabla="PRECOMPRA      " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHAALTAFW                             " tabla="PRECOMPRA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHATRANSFERENCIA                      " tabla="PRECOMPRA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="CUIT                                    " tabla="PRECOMPRA      " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="proveedor.cuit                                                                                                                                                                                                                                                " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="CAJA                                    " tabla="PRECOMPRA      " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                            " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="PORCENTAJEDESCUENTO2                    " tabla="PRECOMPRA      " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje descuento 2                                                                                                                                          " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="PORCENTAJEDESCUENTO1                    " tabla="PRECOMPRA      " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje descuento 1                                                                                                                                          " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="PORCENTAJEDESCUENTO                     " tabla="PRECOMPRA      " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Porcentaje de descuento                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TURNO                                   " tabla="PRECOMPRA      " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="BASEDEDATOSALTAFW                       " tabla="PRECOMPRA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="HORA                                    " tabla="PRECOMPRA      " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="ZADSFW                                  " tabla="PRECOMPRA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PRECOMPRA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="VERSIONMODIFICACIONFW                   " tabla="PRECOMPRA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="VERSIONALTAFW                           " tabla="PRECOMPRA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="SERIEMODIFICACIONFW                     " tabla="PRECOMPRA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="SERIEALTAFW                             " tabla="PRECOMPRA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="USUARIOALTAFW                           " tabla="PRECOMPRA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="HORAMODIFICACIONFW                      " tabla="PRECOMPRA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="PRECOMPRA      " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="HORAIMPO                                " tabla="PRECOMPRA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="USUARIOMODIFICACIONFW                   " tabla="PRECOMPRA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="DESCRIPCIONFW                           " tabla="PRECOMPRA      " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="HORAALTAFW                              " tabla="PRECOMPRA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="ESTADOTRANSFERENCIA                     " tabla="PRECOMPRA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="HORAEXPO                                " tabla="PRECOMPRA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TIMESTAMP                               " tabla="PRECOMPRA      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TOTALCANTIDAD                           " tabla="PRECOMPRA      " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Total Cantidad                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="PRECOMPRA      " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 1                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="PRECOMPRA      " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 2                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="PRECOMPRA      " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="PRECOMPRA      " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="CONDICIONIVA                            " tabla="PRECOMPRA      " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="PRECOMPRA      " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="SUBTOTALBRUTO                           " tabla="PRECOMPRA      " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="SITUACIONFISCAL                         " tabla="PRECOMPRA      " campo="SITFISCPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Situación fiscal                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="proveedor.SituacionFiscal                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="SUBTOTALNETO                            " tabla="PRECOMPRA      " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TIPOCOMPROBANTE                         " tabla="PRECOMPRA      " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=30                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="SIGNODEMOVIMIENTO                       " tabla="PRECOMPRA      " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="PRECOMPRA      " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="PRECOMPRA      " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="PRECOMPRA      " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="PRECOMPRA      " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="PRECOMPRA      " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="DESCUENTOAUTOMATICO                     " tabla="PRECOMPRA      " campo="DESAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="ANULADO                                 " tabla="PRECOMPRA      " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Está anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="COMPROBANTEFISCAL                       " tabla="PRECOMPRA      " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TIPOCOMPROBANTERG1361                   " tabla="PRECOMPRA      " campo="TCRG1361  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo factura                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="IMPUESTOSDETALLE                        " tabla="IMPPRECOMP     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOSPREC      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FACTURADETALLE                          " tabla="PRECOMPRADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Artículos                                                                                                                                                       " dominio="DETALLEITEMARTICULOSPRECOMPRA " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="CODIGO                                  " tabla="PRECOMPRA      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Nro. interno                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="IDVUELTO                                " tabla="PRECOMPRA      " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código vuelto                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MONEDASISTEMA                           " tabla="PRECOMPRA      " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Sistema                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="PRECOMPRA      " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 1                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="DESCUENTO                               " tabla="PRECOMPRA      " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Monto % descuento                                                                                                                                               " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="PRECOMPRA      " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 2                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="NUMINT                                  " tabla="PRECOMPRA      " campo="NUMINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número interno                                                                                                                                                  " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="IMPUESTOS                               " tabla="PRECOMPRA      " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="I.V.A.                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPPREC        " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOPRECOMPRA  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="OBS                                     " tabla="PRECOMPRA      " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="LETRA                                   " tabla="PRECOMPRA      " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="4" etiqueta="Letra comprobante                                                                                                                                               " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHA                                   " tabla="PRECOMPRA      " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="412" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHAFACTURA                            " tabla="PRECOMPRA      " campo="FFCHFAC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Emisión                                                                                                                                                         " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="PRECOMPRA      " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Monto descuento con impuestos                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="PRECOMPRA      " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="PUNTODEVENTAEXTENDIDO                   " tabla="PRECOMPRA      " campo="FPTOVENEXT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Punto de venta                                                                                                                                                  " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOPORCENTAJE                       " tabla="PRECOMPRA      " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Recargo porcentaje                                                                                                                                              " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="COTIZACION                              " tabla="PRECOMPRA      " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="418" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="PRECOMPRA      " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos sin impuestos                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="14" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="NUMERO                                  " tabla="PRECOMPRA      " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHAVENCIMIENTO                        " tabla="PRECOMPRA      " campo="FFCHVENC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="420" etiqueta="Vencimiento                                                                                                                                                     " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOMONTO                            " tabla="PRECOMPRA      " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Recargo % monto                                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="CAI                                     " tabla="PRECOMPRA      " campo="NCAI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="C.A.I./C.A.E.                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="PUNTODEVENTA                            " tabla="PRECOMPRA      " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Pto. de venta                                                                                                                                                   " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="FECHAVTOCAI                             " tabla="PRECOMPRA      " campo="FVTOCAI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento C.A.I./C.A.E.                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="REMITO                                  " tabla="PRECOMPRA      " campo="NROREMITO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Remito                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="A 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="PRECOMPRA      " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="VUELTO                                  " tabla="PRECOMPRA      " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="PROVEEDOR                               " tabla="PRECOMPRA      " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MONEDACOMPROBANTE                       " tabla="PRECOMPRA      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Moneda comprobante                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TOTAL                                   " tabla="PRECOMPRA      " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOMONTO1                           " tabla="PRECOMPRA      " campo="RECMONTO1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto 1                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="RECARGOMONTO2                           " tabla="PRECOMPRA      " campo="RECMONTO2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Recargo monto                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="LISTADEPRECIOS                          " tabla="PRECOMPRA      " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferenteCompras                                                                                                                                                                                  " obligatorio="true" admitebusqueda="430" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="CONDICIONPAGOPREFERENTE                 " tabla="PRECOMPRA      " campo="CONDPAGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="MOTIVO                                  " tabla="PRECOMPRA      " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TRANSPORTISTA                           " tabla="PRECOMPRA      " campo="FTRANSP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Transportista                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TOTALIMPUESTOS                          " tabla="PRECOMPRA      " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total impuestos                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TOTALRECARGOS                           " tabla="PRECOMPRA      " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="PRECOMPRA      " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo sin impuestos                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRESUPUESTODECOMPRA                     " atributo="TOTALDESCUENTOS                         " tabla="PRECOMPRA      " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuento                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On PRECOMPRA.FPERSON = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On PRECOMPRA.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On PRECOMPRA.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="433" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On PRECOMPRA.CONDPAGO = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On PRECOMPRA.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="437" etiqueta="Detalle Tra.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On PRECOMPRA.FTRANSP = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="ARTICULO                                " tabla="PRECOMPRADET   " campo="FART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleArtículos, Artículo                                                                                                                                      " dominio="CONSOPORTEPREPANTALLA         " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="ARTICULODETALLE                         " tabla="PRECOMPRADET   " campo="FTXT      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleArtículos, Artículo descripción                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="COLOR                                   " tabla="PRECOMPRADET   " campo="FCOLO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleArtículos, Color                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="COLORDETALLE                            " tabla="PRECOMPRADET   " campo="FCOTXT    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleArtículos, Color descripción                                                                                                                             " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="TALLE                                   " tabla="PRECOMPRADET   " campo="FTALL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleArtículos, Talle                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="CANTIDAD                                " tabla="PRECOMPRADET   " campo="FCANT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleArtículos, Cantidad                                                                                                                                      " dominio="NUMERICODECIMALPARAMETRIZADOCO" detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="PRECIO                                  " tabla="PRECOMPRADET   " campo="FPRECIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleArtículos, Precio                                                                                                                                        " dominio="PRECIONONEGATIVOPARAMETROFOCO " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="DESCUENTO                               " tabla="PRECOMPRADET   " campo="FCFI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="DetalleArtículos, % Descuento                                                                                                                                   " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="MONTODESCUENTO                          " tabla="PRECOMPRADET   " campo="MNTDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleArtículos, Monto descuento                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSPRECOMPRA                  " atributo="MONTO                                   " tabla="PRECOMPRADET   " campo="FMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleArtículos, Monto                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PRECOMPRADET On PRECOMPRA.CODIGO = PRECOMPRADET.CODIGO And  PRECOMPRA.CODIGO != '' AND PRECOMPRA.FACTTIPO = 30                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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