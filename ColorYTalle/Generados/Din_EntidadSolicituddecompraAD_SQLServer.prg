
define class Din_EntidadSOLICITUDDECOMPRAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_SOLICITUDDECOMPRA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0)]
	cTagClaveCandidata = '_SOCCC'
	cTagClavePk = '_SOCPK'
	cTablaPrincipal = 'SOLCOMPRA'
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
			local  lxSolcompraFmodifw, lxSolcompraFectrans, lxSolcompraFecimpo, lxSolcompraFd2, lxSolcompraFecexpo, lxSolcompraFcuit, lxSolcompraIdcaja, lxSolcompraFpodes1, lxSolcompraFpodes2, lxSolcompraFpodes, lxSolcompraFletra, lxSolcompraFturno, lxSolcompraFaltafw, lxSolcompraHaltafw, lxSolcompraBdmodifw, lxSolcompraBdaltafw, lxSolcompraValtafw, lxSolcompraUmodifw, lxSolcompraSaltafw, lxSolcompraUaltafw, lxSolcompraSmodifw, lxSolcompraHmodifw, lxSolcompraVmodifw, lxSolcompraEsttrans, lxSolcompraFhora, lxSolcompraDescfw, lxSolcompraZadsfw, lxSolcompraHoraimpo, lxSolcompraHoraexpo, lxSolcompraSimbmon, lxSolcompraTimestamp, lxSolcompraTotalcant, lxSolcompraSubtotsisi, lxSolcompraSubtotcisi, lxSolcompraRecmnto2, lxSolcompraRecmnto1, lxSolcompraCondivalp, lxSolcompraRecmntosi, lxSolcompraSignomov, lxSolcompraSitfiscpro, lxSolcompraFsubton, lxSolcompraFsubtot, lxSolcompraRecmntosi1, lxSolcompraFacttipo, lxSolcompraDesmntosi2, lxSolcompraDesmntosi1, lxSolcompraDesmntosi, lxSolcompraRecmntosi2, lxSolcompraDesauto, lxSolcompraAnulado, lxSolcompraFcompfis, lxSolcompraTcrg1361, lxSolcompraMonsis, lxSolcompraCodigo, lxSolcompraIdvuelto, lxSolcompraFmtdes2, lxSolcompraFmtdes1, lxSolcompraFdescu, lxSolcompraFptoven, lxSolcompraFimpuesto, lxSolcompraFobs, lxSolcompraFfchfac, lxSolcompraFnumcomp, lxSolcompraFmtdes3, lxSolcompraDesmntosi3, lxSolcompraRecpor, lxSolcompraTotdescsi, lxSolcompraFfch, lxSolcompraMr, lxSolcompraNcai, lxSolcompraFperson, lxSolcompraFvtocai, lxSolcompraCotiz, lxSolcompraNroremito, lxSolcompraRecmnto, lxSolcompraFvuelto, lxSolcompraMoneda, lxSolcompraFfchvenc, lxSolcompraCodlista, lxSolcompraFtotal, lxSolcompraRecmonto1, lxSolcompraRecmonto2, lxSolcompraCondpago, lxSolcompraMotivo, lxSolcompraTotimpue, lxSolcompraTotrecarsi, lxSolcompraTotrecar, lxSolcompraTotdesc
				lxSolcompraFmodifw =  .Fechamodificacionfw			lxSolcompraFectrans =  .Fechatransferencia			lxSolcompraFecimpo =  .Fechaimpo			lxSolcompraFd2 =  .Fechamodificacion			lxSolcompraFecexpo =  .Fechaexpo			lxSolcompraFcuit =  .Cuit			lxSolcompraIdcaja =  .Caja_PK 			lxSolcompraFpodes1 =  .Porcentajedescuento1			lxSolcompraFpodes2 =  .Porcentajedescuento2			lxSolcompraFpodes =  .Porcentajedescuento			lxSolcompraFletra =  .Letra			lxSolcompraFturno =  .Turno			lxSolcompraFaltafw =  .Fechaaltafw			lxSolcompraHaltafw =  .Horaaltafw			lxSolcompraBdmodifw =  .Basededatosmodificacionfw			lxSolcompraBdaltafw =  .Basededatosaltafw			lxSolcompraValtafw =  .Versionaltafw			lxSolcompraUmodifw =  .Usuariomodificacionfw			lxSolcompraSaltafw =  .Seriealtafw			lxSolcompraUaltafw =  .Usuarioaltafw			lxSolcompraSmodifw =  .Seriemodificacionfw			lxSolcompraHmodifw =  .Horamodificacionfw			lxSolcompraVmodifw =  .Versionmodificacionfw			lxSolcompraEsttrans =  .Estadotransferencia			lxSolcompraFhora =  .Hora			lxSolcompraDescfw =  .Descripcionfw			lxSolcompraZadsfw =  .Zadsfw			lxSolcompraHoraimpo =  .Horaimpo			lxSolcompraHoraexpo =  .Horaexpo			lxSolcompraSimbmon =  .Simbolomonetariocomprobante			lxSolcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxSolcompraTotalcant =  .Totalcantidad			lxSolcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxSolcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxSolcompraRecmnto2 =  .Recargomontoconimpuestos2			lxSolcompraRecmnto1 =  .Recargomontoconimpuestos1			lxSolcompraCondivalp =  .Condicioniva			lxSolcompraRecmntosi =  .Recargomontosinimpuestos			lxSolcompraSignomov =  .Signodemovimiento			lxSolcompraSitfiscpro =  .Situacionfiscal_PK 			lxSolcompraFsubton =  .Subtotalneto			lxSolcompraFsubtot =  .Subtotalbruto			lxSolcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxSolcompraFacttipo =  .Tipocomprobante			lxSolcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxSolcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxSolcompraDesmntosi =  .Montodescuentosinimpuestos			lxSolcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxSolcompraDesauto =  .Descuentoautomatico			lxSolcompraAnulado =  .Anulado			lxSolcompraFcompfis =  .Comprobantefiscal			lxSolcompraTcrg1361 =  .Tipocomprobanterg1361			lxSolcompraMonsis =  upper( .MonedaSistema_PK ) 			lxSolcompraCodigo =  .Codigo			lxSolcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxSolcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxSolcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxSolcompraFdescu =  .Descuento			lxSolcompraFptoven =  .Puntodeventa			lxSolcompraFimpuesto =  .Impuestos			lxSolcompraFobs =  .Obs			lxSolcompraFfchfac =  .Fechafactura			lxSolcompraFnumcomp =  .Numero			lxSolcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxSolcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxSolcompraRecpor =  .Recargoporcentaje			lxSolcompraTotdescsi =  .Totaldescuentossinimpuestos			lxSolcompraFfch =  .Fecha			lxSolcompraMr =  .Recargomonto			lxSolcompraNcai =  .Cai			lxSolcompraFperson =  upper( .Proveedor_PK ) 			lxSolcompraFvtocai =  .Fechavtocai			lxSolcompraCotiz =  .Cotizacion			lxSolcompraNroremito =  .Remito			lxSolcompraRecmnto =  .Recargomontoconimpuestos			lxSolcompraFvuelto =  .Vuelto			lxSolcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxSolcompraFfchvenc =  .Fechavencimiento			lxSolcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxSolcompraFtotal =  .Total			lxSolcompraRecmonto1 =  .Recargomonto1			lxSolcompraRecmonto2 =  .Recargomonto2			lxSolcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxSolcompraMotivo =  upper( .Motivo_PK ) 			lxSolcompraTotimpue =  .Totalimpuestos			lxSolcompraTotrecarsi =  .Totalrecargossinimpuestos			lxSolcompraTotrecar =  .Totalrecargos			lxSolcompraTotdesc =  .Totaldescuentos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxSolcompraCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.SOLCOMPRA ( "Fmodifw","Fectrans","Fecimpo","Fd2","Fecexpo","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fletra","Fturno","Faltafw","Haltafw","Bdmodifw","Bdaltafw","Valtafw","Umodifw","Saltafw","Ualtafw","Smodifw","Hmodifw","Vmodifw","Esttrans","Fhora","Descfw","Zadsfw","Horaimpo","Horaexpo","Simbmon","Timestamp","Totalcant","Subtotsisi","Subtotcisi","Recmnto2","Recmnto1","Condivalp","Recmntosi","Signomov","Sitfiscpro","Fsubton","Fsubtot","Recmntosi1","Facttipo","Desmntosi2","Desmntosi1","Desmntosi","Recmntosi2","Desauto","Anulado","Fcompfis","Tcrg1361","Monsis","Codigo","Idvuelto","Fmtdes2","Fmtdes1","Fdescu","Fptoven","Fimpuesto","Fobs","Ffchfac","Fnumcomp","Fmtdes3","Desmntosi3","Recpor","Totdescsi","Ffch","Mr","Ncai","Fperson","Fvtocai","Cotiz","Nroremito","Recmnto","Fvuelto","Moneda","Ffchvenc","Codlista","Ftotal","Recmonto1","Recmonto2","Condpago","Motivo","Totimpue","Totrecarsi","Totrecar","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxSolcompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraFcuit ) + "'" >>, <<lxSolcompraIdcaja >>, <<lxSolcompraFpodes1 >>, <<lxSolcompraFpodes2 >>, <<lxSolcompraFpodes >>, <<"'" + this.FormatearTextoSql( lxSolcompraFletra ) + "'" >>, <<lxSolcompraFturno >>, <<"'" + this.ConvertirDateSql( lxSolcompraFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraSimbmon ) + "'" >>, <<lxSolcompraTimestamp >>, <<lxSolcompraTotalcant >>, <<lxSolcompraSubtotsisi >>, <<lxSolcompraSubtotcisi >>, <<lxSolcompraRecmnto2 >>, <<lxSolcompraRecmnto1 >>, <<lxSolcompraCondivalp >>, <<lxSolcompraRecmntosi >>, <<lxSolcompraSignomov >>, <<lxSolcompraSitfiscpro >>, <<lxSolcompraFsubton >>, <<lxSolcompraFsubtot >>, <<lxSolcompraRecmntosi1 >>, <<lxSolcompraFacttipo >>, <<lxSolcompraDesmntosi2 >>, <<lxSolcompraDesmntosi1 >>, <<lxSolcompraDesmntosi >>, <<lxSolcompraRecmntosi2 >>, <<iif( lxSolcompraDesauto, 1, 0 ) >>, <<iif( lxSolcompraAnulado, 1, 0 ) >>, <<iif( lxSolcompraFcompfis, 1, 0 ) >>, <<lxSolcompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxSolcompraMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraIdvuelto ) + "'" >>, <<lxSolcompraFmtdes2 >>, <<lxSolcompraFmtdes1 >>, <<lxSolcompraFdescu >>, <<lxSolcompraFptoven >>, <<lxSolcompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxSolcompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFfchfac ) + "'" >>, <<lxSolcompraFnumcomp >>, <<lxSolcompraFmtdes3 >>, <<lxSolcompraDesmntosi3 >>, <<lxSolcompraRecpor >>, <<lxSolcompraTotdescsi >>, <<"'" + this.ConvertirDateSql( lxSolcompraFfch ) + "'" >>, <<lxSolcompraMr >>, <<lxSolcompraNcai >>, <<"'" + this.FormatearTextoSql( lxSolcompraFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFvtocai ) + "'" >>, <<lxSolcompraCotiz >>, <<"'" + this.FormatearTextoSql( lxSolcompraNroremito ) + "'" >>, <<lxSolcompraRecmnto >>, <<lxSolcompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxSolcompraMoneda ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFfchvenc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraCodlista ) + "'" >>, <<lxSolcompraFtotal >>, <<lxSolcompraRecmonto1 >>, <<lxSolcompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxSolcompraCondpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraMotivo ) + "'" >>, <<lxSolcompraTotimpue >>, <<lxSolcompraTotrecarsi >>, <<lxSolcompraTotrecar >>, <<lxSolcompraTotdesc >> )
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
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SolCompraDet("AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","seniacance","MNTPIVA","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_cantidad>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_condicionivacompras>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajedto1>>, <<lxMontodto1>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajeiva>>, <<lxMontocfi>>, <<lxPorcentajecfi>>, <<lxPrecioconimpuestos>>, <<lxTipolistadeprecio>>, <<lxIdorigen>>, <<lxIditem>>, <<lxAfe_nroitem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpSolComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
						Insert into ZooLogic.ImpSolC("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxSolcompraTimestamp
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
			local  lxSolcompraFmodifw, lxSolcompraFectrans, lxSolcompraFecimpo, lxSolcompraFd2, lxSolcompraFecexpo, lxSolcompraFcuit, lxSolcompraIdcaja, lxSolcompraFpodes1, lxSolcompraFpodes2, lxSolcompraFpodes, lxSolcompraFletra, lxSolcompraFturno, lxSolcompraFaltafw, lxSolcompraHaltafw, lxSolcompraBdmodifw, lxSolcompraBdaltafw, lxSolcompraValtafw, lxSolcompraUmodifw, lxSolcompraSaltafw, lxSolcompraUaltafw, lxSolcompraSmodifw, lxSolcompraHmodifw, lxSolcompraVmodifw, lxSolcompraEsttrans, lxSolcompraFhora, lxSolcompraDescfw, lxSolcompraZadsfw, lxSolcompraHoraimpo, lxSolcompraHoraexpo, lxSolcompraSimbmon, lxSolcompraTimestamp, lxSolcompraTotalcant, lxSolcompraSubtotsisi, lxSolcompraSubtotcisi, lxSolcompraRecmnto2, lxSolcompraRecmnto1, lxSolcompraCondivalp, lxSolcompraRecmntosi, lxSolcompraSignomov, lxSolcompraSitfiscpro, lxSolcompraFsubton, lxSolcompraFsubtot, lxSolcompraRecmntosi1, lxSolcompraFacttipo, lxSolcompraDesmntosi2, lxSolcompraDesmntosi1, lxSolcompraDesmntosi, lxSolcompraRecmntosi2, lxSolcompraDesauto, lxSolcompraAnulado, lxSolcompraFcompfis, lxSolcompraTcrg1361, lxSolcompraMonsis, lxSolcompraCodigo, lxSolcompraIdvuelto, lxSolcompraFmtdes2, lxSolcompraFmtdes1, lxSolcompraFdescu, lxSolcompraFptoven, lxSolcompraFimpuesto, lxSolcompraFobs, lxSolcompraFfchfac, lxSolcompraFnumcomp, lxSolcompraFmtdes3, lxSolcompraDesmntosi3, lxSolcompraRecpor, lxSolcompraTotdescsi, lxSolcompraFfch, lxSolcompraMr, lxSolcompraNcai, lxSolcompraFperson, lxSolcompraFvtocai, lxSolcompraCotiz, lxSolcompraNroremito, lxSolcompraRecmnto, lxSolcompraFvuelto, lxSolcompraMoneda, lxSolcompraFfchvenc, lxSolcompraCodlista, lxSolcompraFtotal, lxSolcompraRecmonto1, lxSolcompraRecmonto2, lxSolcompraCondpago, lxSolcompraMotivo, lxSolcompraTotimpue, lxSolcompraTotrecarsi, lxSolcompraTotrecar, lxSolcompraTotdesc
				lxSolcompraFmodifw =  .Fechamodificacionfw			lxSolcompraFectrans =  .Fechatransferencia			lxSolcompraFecimpo =  .Fechaimpo			lxSolcompraFd2 =  .Fechamodificacion			lxSolcompraFecexpo =  .Fechaexpo			lxSolcompraFcuit =  .Cuit			lxSolcompraIdcaja =  .Caja_PK 			lxSolcompraFpodes1 =  .Porcentajedescuento1			lxSolcompraFpodes2 =  .Porcentajedescuento2			lxSolcompraFpodes =  .Porcentajedescuento			lxSolcompraFletra =  .Letra			lxSolcompraFturno =  .Turno			lxSolcompraFaltafw =  .Fechaaltafw			lxSolcompraHaltafw =  .Horaaltafw			lxSolcompraBdmodifw =  .Basededatosmodificacionfw			lxSolcompraBdaltafw =  .Basededatosaltafw			lxSolcompraValtafw =  .Versionaltafw			lxSolcompraUmodifw =  .Usuariomodificacionfw			lxSolcompraSaltafw =  .Seriealtafw			lxSolcompraUaltafw =  .Usuarioaltafw			lxSolcompraSmodifw =  .Seriemodificacionfw			lxSolcompraHmodifw =  .Horamodificacionfw			lxSolcompraVmodifw =  .Versionmodificacionfw			lxSolcompraEsttrans =  .Estadotransferencia			lxSolcompraFhora =  .Hora			lxSolcompraDescfw =  .Descripcionfw			lxSolcompraZadsfw =  .Zadsfw			lxSolcompraHoraimpo =  .Horaimpo			lxSolcompraHoraexpo =  .Horaexpo			lxSolcompraSimbmon =  .Simbolomonetariocomprobante			lxSolcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxSolcompraTotalcant =  .Totalcantidad			lxSolcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxSolcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxSolcompraRecmnto2 =  .Recargomontoconimpuestos2			lxSolcompraRecmnto1 =  .Recargomontoconimpuestos1			lxSolcompraCondivalp =  .Condicioniva			lxSolcompraRecmntosi =  .Recargomontosinimpuestos			lxSolcompraSignomov =  .Signodemovimiento			lxSolcompraSitfiscpro =  .Situacionfiscal_PK 			lxSolcompraFsubton =  .Subtotalneto			lxSolcompraFsubtot =  .Subtotalbruto			lxSolcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxSolcompraFacttipo =  .Tipocomprobante			lxSolcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxSolcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxSolcompraDesmntosi =  .Montodescuentosinimpuestos			lxSolcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxSolcompraDesauto =  .Descuentoautomatico			lxSolcompraAnulado =  .Anulado			lxSolcompraFcompfis =  .Comprobantefiscal			lxSolcompraTcrg1361 =  .Tipocomprobanterg1361			lxSolcompraMonsis =  upper( .MonedaSistema_PK ) 			lxSolcompraCodigo =  .Codigo			lxSolcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxSolcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxSolcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxSolcompraFdescu =  .Descuento			lxSolcompraFptoven =  .Puntodeventa			lxSolcompraFimpuesto =  .Impuestos			lxSolcompraFobs =  .Obs			lxSolcompraFfchfac =  .Fechafactura			lxSolcompraFnumcomp =  .Numero			lxSolcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxSolcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxSolcompraRecpor =  .Recargoporcentaje			lxSolcompraTotdescsi =  .Totaldescuentossinimpuestos			lxSolcompraFfch =  .Fecha			lxSolcompraMr =  .Recargomonto			lxSolcompraNcai =  .Cai			lxSolcompraFperson =  upper( .Proveedor_PK ) 			lxSolcompraFvtocai =  .Fechavtocai			lxSolcompraCotiz =  .Cotizacion			lxSolcompraNroremito =  .Remito			lxSolcompraRecmnto =  .Recargomontoconimpuestos			lxSolcompraFvuelto =  .Vuelto			lxSolcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxSolcompraFfchvenc =  .Fechavencimiento			lxSolcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxSolcompraFtotal =  .Total			lxSolcompraRecmonto1 =  .Recargomonto1			lxSolcompraRecmonto2 =  .Recargomonto2			lxSolcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxSolcompraMotivo =  upper( .Motivo_PK ) 			lxSolcompraTotimpue =  .Totalimpuestos			lxSolcompraTotrecarsi =  .Totalrecargossinimpuestos			lxSolcompraTotrecar =  .Totalrecargos			lxSolcompraTotdesc =  .Totaldescuentos
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
				update ZooLogic.SOLCOMPRA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSolcompraFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxSolcompraFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxSolcompraFecimpo ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxSolcompraFd2 ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxSolcompraFecexpo ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxSolcompraFcuit ) + "'">>,"Idcaja" = <<lxSolcompraIdcaja>>,"Fpodes1" = <<lxSolcompraFpodes1>>,"Fpodes2" = <<lxSolcompraFpodes2>>,"Fpodes" = <<lxSolcompraFpodes>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxSolcompraFletra ) + "'">>,"Fturno" = <<lxSolcompraFturno>>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxSolcompraFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxSolcompraHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSolcompraBdaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxSolcompraValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxSolcompraSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxSolcompraUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraVmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxSolcompraEsttrans ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxSolcompraFhora ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxSolcompraDescfw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxSolcompraZadsfw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxSolcompraHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxSolcompraHoraexpo ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxSolcompraSimbmon ) + "'">>,"Timestamp" = <<lxSolcompraTimestamp>>,"Totalcant" = <<lxSolcompraTotalcant>>,"Subtotsisi" = <<lxSolcompraSubtotsisi>>,"Subtotcisi" = <<lxSolcompraSubtotcisi>>,"Recmnto2" = <<lxSolcompraRecmnto2>>,"Recmnto1" = <<lxSolcompraRecmnto1>>,"Condivalp" = <<lxSolcompraCondivalp>>,"Recmntosi" = <<lxSolcompraRecmntosi>>,"Signomov" = <<lxSolcompraSignomov>>,"Sitfiscpro" = <<lxSolcompraSitfiscpro>>,"Fsubton" = <<lxSolcompraFsubton>>,"Fsubtot" = <<lxSolcompraFsubtot>>,"Recmntosi1" = <<lxSolcompraRecmntosi1>>,"Facttipo" = <<lxSolcompraFacttipo>>,"Desmntosi2" = <<lxSolcompraDesmntosi2>>,"Desmntosi1" = <<lxSolcompraDesmntosi1>>,"Desmntosi" = <<lxSolcompraDesmntosi>>,"Recmntosi2" = <<lxSolcompraRecmntosi2>>,"Desauto" = <<iif( lxSolcompraDesauto, 1, 0 )>>,"Anulado" = <<iif( lxSolcompraAnulado, 1, 0 )>>,"Fcompfis" = <<iif( lxSolcompraFcompfis, 1, 0 )>>,"Tcrg1361" = <<lxSolcompraTcrg1361>>,"Monsis" = <<"'" + this.FormatearTextoSql( lxSolcompraMonsis ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxSolcompraCodigo ) + "'">>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxSolcompraIdvuelto ) + "'">>,"Fmtdes2" = <<lxSolcompraFmtdes2>>,"Fmtdes1" = <<lxSolcompraFmtdes1>>,"Fdescu" = <<lxSolcompraFdescu>>,"Fptoven" = <<lxSolcompraFptoven>>,"Fimpuesto" = <<lxSolcompraFimpuesto>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxSolcompraFobs ) + "'">>,"Ffchfac" = <<"'" + this.ConvertirDateSql( lxSolcompraFfchfac ) + "'">>,"Fnumcomp" = <<lxSolcompraFnumcomp>>,"Fmtdes3" = <<lxSolcompraFmtdes3>>,"Desmntosi3" = <<lxSolcompraDesmntosi3>>,"Recpor" = <<lxSolcompraRecpor>>,"Totdescsi" = <<lxSolcompraTotdescsi>>,"Ffch" = <<"'" + this.ConvertirDateSql( lxSolcompraFfch ) + "'">>,"Mr" = <<lxSolcompraMr>>,"Ncai" = <<lxSolcompraNcai>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxSolcompraFperson ) + "'">>,"Fvtocai" = <<"'" + this.ConvertirDateSql( lxSolcompraFvtocai ) + "'">>,"Cotiz" = <<lxSolcompraCotiz>>,"Nroremito" = <<"'" + this.FormatearTextoSql( lxSolcompraNroremito ) + "'">>,"Recmnto" = <<lxSolcompraRecmnto>>,"Fvuelto" = <<lxSolcompraFvuelto>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxSolcompraMoneda ) + "'">>,"Ffchvenc" = <<"'" + this.ConvertirDateSql( lxSolcompraFfchvenc ) + "'">>,"Codlista" = <<"'" + this.FormatearTextoSql( lxSolcompraCodlista ) + "'">>,"Ftotal" = <<lxSolcompraFtotal>>,"Recmonto1" = <<lxSolcompraRecmonto1>>,"Recmonto2" = <<lxSolcompraRecmonto2>>,"Condpago" = <<"'" + this.FormatearTextoSql( lxSolcompraCondpago ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxSolcompraMotivo ) + "'">>,"Totimpue" = <<lxSolcompraTotimpue>>,"Totrecarsi" = <<lxSolcompraTotrecarsi>>,"Totrecar" = <<lxSolcompraTotrecar>>,"Totdesc" = <<lxSolcompraTotdesc>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxSolcompraCodigo ) + "'">> and  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SolCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpSolComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpSolC where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SolCompraDet("AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","seniacance","MNTPIVA","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_cantidad>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_condicionivacompras>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajedto1>>, <<lxMontodto1>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajeiva>>, <<lxMontocfi>>, <<lxPorcentajecfi>>, <<lxPrecioconimpuestos>>, <<lxTipolistadeprecio>>, <<lxIdorigen>>, <<lxIditem>>, <<lxAfe_nroitem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpSolComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
						Insert into ZooLogic.ImpSolC("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxSolcompraTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.SOLCOMPRA where " + this.ConvertirFuncionesSql( " SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39" ) )
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
			Local lxSolcompraCodigo
			lxSolcompraCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fletra" as "Letra", "Fturno" as "Turno", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Simbmon" as "Simbolomonetariocomprobante", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Condivalp" as "Condicioniva", "Recmntosi" as "Recargomontosinimpuestos", "Signomov" as "Signodemovimiento", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Fsubtot" as "Subtotalbruto", "Recmntosi1" as "Recargomontosinimpuestos1", "Facttipo" as "Tipocomprobante", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Monsis" as "Monedasistema", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fptoven" as "Puntodeventa", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Cotiz" as "Cotizacion", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Moneda" as "Monedacomprobante", "Ffchvenc" as "Fechavencimiento", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.SOLCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxSolcompraCodigo ) + "'">> and  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39
			endtext
			use in select('c_SOLICITUDDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SOLICITUDDECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_SOLICITUDDECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SolCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpSolComp where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpSolC where cCod = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			Local lxSolCompraFACTTIPO As Variant, lxSolCompraFLETRA As Variant, lxSolCompraFPTOVEN As Variant, lxSolCompraFNUMCOMP As Variant
			lxSolCompraFACTTIPO = .TipoComprobante
			lxSolCompraFLETRA = .Letra
			lxSolCompraFPTOVEN = .PuntoDeVenta
			lxSolCompraFNUMCOMP = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fletra" as "Letra", "Fturno" as "Turno", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Simbmon" as "Simbolomonetariocomprobante", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Condivalp" as "Condicioniva", "Recmntosi" as "Recargomontosinimpuestos", "Signomov" as "Signodemovimiento", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Fsubtot" as "Subtotalbruto", "Recmntosi1" as "Recargomontosinimpuestos1", "Facttipo" as "Tipocomprobante", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Monsis" as "Monedasistema", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fptoven" as "Puntodeventa", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Cotiz" as "Cotizacion", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Moneda" as "Monedacomprobante", "Ffchvenc" as "Fechavencimiento", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.SOLCOMPRA where  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39 And FACTTIPO = <<lxSolCompraFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxSolCompraFLETRA ) + "'">> and FPTOVEN = <<lxSolCompraFPTOVEN>> and FNUMCOMP = <<lxSolCompraFNUMCOMP>>
			endtext
			use in select('c_SOLICITUDDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SOLICITUDDECOMPRA', set( 'Datasession' ) )
			if reccount( 'c_SOLICITUDDECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SolCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpSolComp where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpSolC where cCod = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxSolcompraCodigo as Variant
		llRetorno = .t.
		lxSolcompraCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.SOLCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxSolcompraCodigo ) + "'">> and  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fletra" as "Letra", "Fturno" as "Turno", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Simbmon" as "Simbolomonetariocomprobante", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Condivalp" as "Condicioniva", "Recmntosi" as "Recargomontosinimpuestos", "Signomov" as "Signodemovimiento", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Fsubtot" as "Subtotalbruto", "Recmntosi1" as "Recargomontosinimpuestos1", "Facttipo" as "Tipocomprobante", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Monsis" as "Monedasistema", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fptoven" as "Puntodeventa", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Cotiz" as "Cotizacion", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Moneda" as "Monedacomprobante", "Ffchvenc" as "Fechavencimiento", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.SOLCOMPRA where  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_SOLICITUDDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SOLICITUDDECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SolCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpSolComp where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpSolC where cCod = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fletra" as "Letra", "Fturno" as "Turno", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Simbmon" as "Simbolomonetariocomprobante", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Condivalp" as "Condicioniva", "Recmntosi" as "Recargomontosinimpuestos", "Signomov" as "Signodemovimiento", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Fsubtot" as "Subtotalbruto", "Recmntosi1" as "Recargomontosinimpuestos1", "Facttipo" as "Tipocomprobante", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Monsis" as "Monedasistema", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fptoven" as "Puntodeventa", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Cotiz" as "Cotizacion", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Moneda" as "Monedacomprobante", "Ffchvenc" as "Fechavencimiento", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.SOLCOMPRA where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_SOLICITUDDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SOLICITUDDECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SolCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpSolComp where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpSolC where cCod = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fletra" as "Letra", "Fturno" as "Turno", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Simbmon" as "Simbolomonetariocomprobante", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Condivalp" as "Condicioniva", "Recmntosi" as "Recargomontosinimpuestos", "Signomov" as "Signodemovimiento", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Fsubtot" as "Subtotalbruto", "Recmntosi1" as "Recargomontosinimpuestos1", "Facttipo" as "Tipocomprobante", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Monsis" as "Monedasistema", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fptoven" as "Puntodeventa", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Cotiz" as "Cotizacion", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Moneda" as "Monedacomprobante", "Ffchvenc" as "Fechavencimiento", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.SOLCOMPRA where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_SOLICITUDDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SOLICITUDDECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SolCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpSolComp where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpSolC where cCod = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fletra" as "Letra", "Fturno" as "Turno", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Simbmon" as "Simbolomonetariocomprobante", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Condivalp" as "Condicioniva", "Recmntosi" as "Recargomontosinimpuestos", "Signomov" as "Signodemovimiento", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Fsubtot" as "Subtotalbruto", "Recmntosi1" as "Recargomontosinimpuestos1", "Facttipo" as "Tipocomprobante", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Monsis" as "Monedasistema", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fptoven" as "Puntodeventa", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Cotiz" as "Cotizacion", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Moneda" as "Monedacomprobante", "Ffchvenc" as "Fechavencimiento", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos" from ZooLogic.SOLCOMPRA where  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_SOLICITUDDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SOLICITUDDECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SolCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpSolComp where Codigo = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Porcen" as "Porcentaje", "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpSolC where cCod = <<"'" + this.FormatearTextoSql( c_SOLICITUDDECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecimpo,Fd2,Fecexpo,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fletra,Fturno,Falta" + ;
"fw,Haltafw,Bdmodifw,Bdaltafw,Valtafw,Umodifw,Saltafw,Ualtafw,Smodifw,Hmodifw,Vmodifw,Esttrans,Fhora," + ;
"Descfw,Zadsfw,Horaimpo,Horaexpo,Simbmon,Timestamp,Totalcant,Subtotsisi,Subtotcisi,Recmnto2,Recmnto1," + ;
"Condivalp,Recmntosi,Signomov,Sitfiscpro,Fsubton,Fsubtot,Recmntosi1,Facttipo,Desmntosi2,Desmntosi1,De" + ;
"smntosi,Recmntosi2,Desauto,Anulado,Fcompfis,Tcrg1361,Monsis,Codigo,Idvuelto,Fmtdes2,Fmtdes1,Fdescu,F" + ;
"ptoven,Fimpuesto,Fobs,Ffchfac,Fnumcomp,Fmtdes3,Desmntosi3,Recpor,Totdescsi,Ffch,Mr,Ncai,Fperson,Fvto" + ;
"cai,Cotiz,Nroremito,Recmnto,Fvuelto,Moneda,Ffchvenc,Codlista,Ftotal,Recmonto1,Recmonto2,Condpago,Mot" + ;
"ivo,Totimpue,Totrecarsi,Totrecar,Totdesc" + ;
" from ZooLogic.SOLCOMPRA where  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39 and " + lcFiltro )
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
			local  lxSolcompraFmodifw, lxSolcompraFectrans, lxSolcompraFecimpo, lxSolcompraFd2, lxSolcompraFecexpo, lxSolcompraFcuit, lxSolcompraIdcaja, lxSolcompraFpodes1, lxSolcompraFpodes2, lxSolcompraFpodes, lxSolcompraFletra, lxSolcompraFturno, lxSolcompraFaltafw, lxSolcompraHaltafw, lxSolcompraBdmodifw, lxSolcompraBdaltafw, lxSolcompraValtafw, lxSolcompraUmodifw, lxSolcompraSaltafw, lxSolcompraUaltafw, lxSolcompraSmodifw, lxSolcompraHmodifw, lxSolcompraVmodifw, lxSolcompraEsttrans, lxSolcompraFhora, lxSolcompraDescfw, lxSolcompraZadsfw, lxSolcompraHoraimpo, lxSolcompraHoraexpo, lxSolcompraSimbmon, lxSolcompraTimestamp, lxSolcompraTotalcant, lxSolcompraSubtotsisi, lxSolcompraSubtotcisi, lxSolcompraRecmnto2, lxSolcompraRecmnto1, lxSolcompraCondivalp, lxSolcompraRecmntosi, lxSolcompraSignomov, lxSolcompraSitfiscpro, lxSolcompraFsubton, lxSolcompraFsubtot, lxSolcompraRecmntosi1, lxSolcompraFacttipo, lxSolcompraDesmntosi2, lxSolcompraDesmntosi1, lxSolcompraDesmntosi, lxSolcompraRecmntosi2, lxSolcompraDesauto, lxSolcompraAnulado, lxSolcompraFcompfis, lxSolcompraTcrg1361, lxSolcompraMonsis, lxSolcompraCodigo, lxSolcompraIdvuelto, lxSolcompraFmtdes2, lxSolcompraFmtdes1, lxSolcompraFdescu, lxSolcompraFptoven, lxSolcompraFimpuesto, lxSolcompraFobs, lxSolcompraFfchfac, lxSolcompraFnumcomp, lxSolcompraFmtdes3, lxSolcompraDesmntosi3, lxSolcompraRecpor, lxSolcompraTotdescsi, lxSolcompraFfch, lxSolcompraMr, lxSolcompraNcai, lxSolcompraFperson, lxSolcompraFvtocai, lxSolcompraCotiz, lxSolcompraNroremito, lxSolcompraRecmnto, lxSolcompraFvuelto, lxSolcompraMoneda, lxSolcompraFfchvenc, lxSolcompraCodlista, lxSolcompraFtotal, lxSolcompraRecmonto1, lxSolcompraRecmonto2, lxSolcompraCondpago, lxSolcompraMotivo, lxSolcompraTotimpue, lxSolcompraTotrecarsi, lxSolcompraTotrecar, lxSolcompraTotdesc
				lxSolcompraFmodifw = ctod( '  /  /    ' )			lxSolcompraFectrans = ctod( '  /  /    ' )			lxSolcompraFecimpo = ctod( '  /  /    ' )			lxSolcompraFd2 = ctod( '  /  /    ' )			lxSolcompraFecexpo = ctod( '  /  /    ' )			lxSolcompraFcuit = []			lxSolcompraIdcaja = 0			lxSolcompraFpodes1 = 0			lxSolcompraFpodes2 = 0			lxSolcompraFpodes = 0			lxSolcompraFletra = []			lxSolcompraFturno = 0			lxSolcompraFaltafw = ctod( '  /  /    ' )			lxSolcompraHaltafw = []			lxSolcompraBdmodifw = []			lxSolcompraBdaltafw = []			lxSolcompraValtafw = []			lxSolcompraUmodifw = []			lxSolcompraSaltafw = []			lxSolcompraUaltafw = []			lxSolcompraSmodifw = []			lxSolcompraHmodifw = []			lxSolcompraVmodifw = []			lxSolcompraEsttrans = []			lxSolcompraFhora = []			lxSolcompraDescfw = []			lxSolcompraZadsfw = []			lxSolcompraHoraimpo = []			lxSolcompraHoraexpo = []			lxSolcompraSimbmon = []			lxSolcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxSolcompraTotalcant = 0			lxSolcompraSubtotsisi = 0			lxSolcompraSubtotcisi = 0			lxSolcompraRecmnto2 = 0			lxSolcompraRecmnto1 = 0			lxSolcompraCondivalp = 0			lxSolcompraRecmntosi = 0			lxSolcompraSignomov = 0			lxSolcompraSitfiscpro = 0			lxSolcompraFsubton = 0			lxSolcompraFsubtot = 0			lxSolcompraRecmntosi1 = 0			lxSolcompraFacttipo = 0			lxSolcompraDesmntosi2 = 0			lxSolcompraDesmntosi1 = 0			lxSolcompraDesmntosi = 0			lxSolcompraRecmntosi2 = 0			lxSolcompraDesauto = .F.			lxSolcompraAnulado = .F.			lxSolcompraFcompfis = .F.			lxSolcompraTcrg1361 = 0			lxSolcompraMonsis = []			lxSolcompraCodigo = []			lxSolcompraIdvuelto = []			lxSolcompraFmtdes2 = 0			lxSolcompraFmtdes1 = 0			lxSolcompraFdescu = 0			lxSolcompraFptoven = 0			lxSolcompraFimpuesto = 0			lxSolcompraFobs = []			lxSolcompraFfchfac = ctod( '  /  /    ' )			lxSolcompraFnumcomp = 0			lxSolcompraFmtdes3 = 0			lxSolcompraDesmntosi3 = 0			lxSolcompraRecpor = 0			lxSolcompraTotdescsi = 0			lxSolcompraFfch = ctod( '  /  /    ' )			lxSolcompraMr = 0			lxSolcompraNcai = 0			lxSolcompraFperson = []			lxSolcompraFvtocai = ctod( '  /  /    ' )			lxSolcompraCotiz = 0			lxSolcompraNroremito = []			lxSolcompraRecmnto = 0			lxSolcompraFvuelto = 0			lxSolcompraMoneda = []			lxSolcompraFfchvenc = ctod( '  /  /    ' )			lxSolcompraCodlista = []			lxSolcompraFtotal = 0			lxSolcompraRecmonto1 = 0			lxSolcompraRecmonto2 = 0			lxSolcompraCondpago = []			lxSolcompraMotivo = []			lxSolcompraTotimpue = 0			lxSolcompraTotrecarsi = 0			lxSolcompraTotrecar = 0			lxSolcompraTotdesc = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SolCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpSolComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpSolC where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.SOLCOMPRA where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'SOLCOMPRA' + '_' + tcCampo
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
		lcWhere = " Where  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fletra" as "Letra", "Fturno" as "Turno", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Simbmon" as "Simbolomonetariocomprobante", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Condivalp" as "Condicioniva", "Recmntosi" as "Recargomontosinimpuestos", "Signomov" as "Signodemovimiento", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Fsubtot" as "Subtotalbruto", "Recmntosi1" as "Recargomontosinimpuestos1", "Facttipo" as "Tipocomprobante", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Monsis" as "Monedasistema", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fptoven" as "Puntodeventa", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Cotiz" as "Cotizacion", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Moneda" as "Monedacomprobante", "Ffchvenc" as "Fechavencimiento", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SOLCOMPRA', '', tnTope )
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
		lcWhere = " Where  SOLCOMPRADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleFacturaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SolCompraDet', 'FacturaDetalle', tnTope )
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
		lcWhere = " Where  IMPSOLCOMP.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpSolComp', 'ImpuestosDetalle', tnTope )
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
		lcWhere = " Where  IMPSOLC.CCOD != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpSolC', 'ImpuestosComprobante', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
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
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTURNO AS TURNO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCPRO AS SITUACIONFISCAL'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUTO AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'TIPOCOMPROBANTERG1361'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCRG1361 AS TIPOCOMPROBANTERG1361'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES1 AS MONTODESCUENTOCONIMPUESTOS1'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'IMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FIMPUESTO AS IMPUESTOS'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'FECHAFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHFAC AS FECHAFACTURA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPOR AS RECARGOPORCENTAJE'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR AS RECARGOMONTO'
				Case lcAtributo == 'CAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCAI AS CAI'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS PROVEEDOR'
				Case lcAtributo == 'FECHAVTOCAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVTOCAI AS FECHAVTOCAI'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREMITO AS REMITO'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO AS RECARGOMONTOCONIMPUESTOS'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHVENC AS FECHAVENCIMIENTO'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO1 AS RECARGOMONTO1'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO2 AS RECARGOMONTO2'
				Case lcAtributo == 'CONDICIONPAGOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONPAGOPREFERENTE'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
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
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTALL AS TALLE'
				Case lcAtributo == 'IDSENIACANCELADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIACANCE AS IDSENIACANCELADA'
				Case lcAtributo == 'MONTOPRORRATEOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPIVA AS MONTOPRORRATEOIVA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'FTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCPRO'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTERG1361'
				lcCampo = 'TCRG1361'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS1'
				lcCampo = 'FMTDES1'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOS'
				lcCampo = 'FIMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAFACTURA'
				lcCampo = 'FFCHFAC'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPOR'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'MR'
			Case upper( alltrim( tcAtributo ) ) == 'CAI'
				lcCampo = 'NCAI'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOCAI'
				lcCampo = 'FVTOCAI'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'NROREMITO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS'
				lcCampo = 'RECMNTO'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FFCHVENC'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'RECMONTO1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'RECMONTO2'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONPAGOPREFERENTE'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
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
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'FTALL'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIACANCELADA'
				lcCampo = 'SENIACANCE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIVA'
				lcCampo = 'MNTPIVA'
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
		if upper( alltrim( tcDetalle ) ) == 'FACTURADETALLE'
			lcRetorno = 'SOLCOMPRADET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPSOLCOMP'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPSOLC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxSolcompraFmodifw, lxSolcompraFectrans, lxSolcompraFecimpo, lxSolcompraFd2, lxSolcompraFecexpo, lxSolcompraFcuit, lxSolcompraIdcaja, lxSolcompraFpodes1, lxSolcompraFpodes2, lxSolcompraFpodes, lxSolcompraFletra, lxSolcompraFturno, lxSolcompraFaltafw, lxSolcompraHaltafw, lxSolcompraBdmodifw, lxSolcompraBdaltafw, lxSolcompraValtafw, lxSolcompraUmodifw, lxSolcompraSaltafw, lxSolcompraUaltafw, lxSolcompraSmodifw, lxSolcompraHmodifw, lxSolcompraVmodifw, lxSolcompraEsttrans, lxSolcompraFhora, lxSolcompraDescfw, lxSolcompraZadsfw, lxSolcompraHoraimpo, lxSolcompraHoraexpo, lxSolcompraSimbmon, lxSolcompraTimestamp, lxSolcompraTotalcant, lxSolcompraSubtotsisi, lxSolcompraSubtotcisi, lxSolcompraRecmnto2, lxSolcompraRecmnto1, lxSolcompraCondivalp, lxSolcompraRecmntosi, lxSolcompraSignomov, lxSolcompraSitfiscpro, lxSolcompraFsubton, lxSolcompraFsubtot, lxSolcompraRecmntosi1, lxSolcompraFacttipo, lxSolcompraDesmntosi2, lxSolcompraDesmntosi1, lxSolcompraDesmntosi, lxSolcompraRecmntosi2, lxSolcompraDesauto, lxSolcompraAnulado, lxSolcompraFcompfis, lxSolcompraTcrg1361, lxSolcompraMonsis, lxSolcompraCodigo, lxSolcompraIdvuelto, lxSolcompraFmtdes2, lxSolcompraFmtdes1, lxSolcompraFdescu, lxSolcompraFptoven, lxSolcompraFimpuesto, lxSolcompraFobs, lxSolcompraFfchfac, lxSolcompraFnumcomp, lxSolcompraFmtdes3, lxSolcompraDesmntosi3, lxSolcompraRecpor, lxSolcompraTotdescsi, lxSolcompraFfch, lxSolcompraMr, lxSolcompraNcai, lxSolcompraFperson, lxSolcompraFvtocai, lxSolcompraCotiz, lxSolcompraNroremito, lxSolcompraRecmnto, lxSolcompraFvuelto, lxSolcompraMoneda, lxSolcompraFfchvenc, lxSolcompraCodlista, lxSolcompraFtotal, lxSolcompraRecmonto1, lxSolcompraRecmonto2, lxSolcompraCondpago, lxSolcompraMotivo, lxSolcompraTotimpue, lxSolcompraTotrecarsi, lxSolcompraTotrecar, lxSolcompraTotdesc
				lxSolcompraFmodifw =  .Fechamodificacionfw			lxSolcompraFectrans =  .Fechatransferencia			lxSolcompraFecimpo =  .Fechaimpo			lxSolcompraFd2 =  .Fechamodificacion			lxSolcompraFecexpo =  .Fechaexpo			lxSolcompraFcuit =  .Cuit			lxSolcompraIdcaja =  .Caja_PK 			lxSolcompraFpodes1 =  .Porcentajedescuento1			lxSolcompraFpodes2 =  .Porcentajedescuento2			lxSolcompraFpodes =  .Porcentajedescuento			lxSolcompraFletra =  .Letra			lxSolcompraFturno =  .Turno			lxSolcompraFaltafw =  .Fechaaltafw			lxSolcompraHaltafw =  .Horaaltafw			lxSolcompraBdmodifw =  .Basededatosmodificacionfw			lxSolcompraBdaltafw =  .Basededatosaltafw			lxSolcompraValtafw =  .Versionaltafw			lxSolcompraUmodifw =  .Usuariomodificacionfw			lxSolcompraSaltafw =  .Seriealtafw			lxSolcompraUaltafw =  .Usuarioaltafw			lxSolcompraSmodifw =  .Seriemodificacionfw			lxSolcompraHmodifw =  .Horamodificacionfw			lxSolcompraVmodifw =  .Versionmodificacionfw			lxSolcompraEsttrans =  .Estadotransferencia			lxSolcompraFhora =  .Hora			lxSolcompraDescfw =  .Descripcionfw			lxSolcompraZadsfw =  .Zadsfw			lxSolcompraHoraimpo =  .Horaimpo			lxSolcompraHoraexpo =  .Horaexpo			lxSolcompraSimbmon =  .Simbolomonetariocomprobante			lxSolcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxSolcompraTotalcant =  .Totalcantidad			lxSolcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxSolcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxSolcompraRecmnto2 =  .Recargomontoconimpuestos2			lxSolcompraRecmnto1 =  .Recargomontoconimpuestos1			lxSolcompraCondivalp =  .Condicioniva			lxSolcompraRecmntosi =  .Recargomontosinimpuestos			lxSolcompraSignomov =  .Signodemovimiento			lxSolcompraSitfiscpro =  .Situacionfiscal_PK 			lxSolcompraFsubton =  .Subtotalneto			lxSolcompraFsubtot =  .Subtotalbruto			lxSolcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxSolcompraFacttipo =  .Tipocomprobante			lxSolcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxSolcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxSolcompraDesmntosi =  .Montodescuentosinimpuestos			lxSolcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxSolcompraDesauto =  .Descuentoautomatico			lxSolcompraAnulado =  .Anulado			lxSolcompraFcompfis =  .Comprobantefiscal			lxSolcompraTcrg1361 =  .Tipocomprobanterg1361			lxSolcompraMonsis =  upper( .MonedaSistema_PK ) 			lxSolcompraCodigo =  .Codigo			lxSolcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxSolcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxSolcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxSolcompraFdescu =  .Descuento			lxSolcompraFptoven =  .Puntodeventa			lxSolcompraFimpuesto =  .Impuestos			lxSolcompraFobs =  .Obs			lxSolcompraFfchfac =  .Fechafactura			lxSolcompraFnumcomp =  .Numero			lxSolcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxSolcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxSolcompraRecpor =  .Recargoporcentaje			lxSolcompraTotdescsi =  .Totaldescuentossinimpuestos			lxSolcompraFfch =  .Fecha			lxSolcompraMr =  .Recargomonto			lxSolcompraNcai =  .Cai			lxSolcompraFperson =  upper( .Proveedor_PK ) 			lxSolcompraFvtocai =  .Fechavtocai			lxSolcompraCotiz =  .Cotizacion			lxSolcompraNroremito =  .Remito			lxSolcompraRecmnto =  .Recargomontoconimpuestos			lxSolcompraFvuelto =  .Vuelto			lxSolcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxSolcompraFfchvenc =  .Fechavencimiento			lxSolcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxSolcompraFtotal =  .Total			lxSolcompraRecmonto1 =  .Recargomonto1			lxSolcompraRecmonto2 =  .Recargomonto2			lxSolcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxSolcompraMotivo =  upper( .Motivo_PK ) 			lxSolcompraTotimpue =  .Totalimpuestos			lxSolcompraTotrecarsi =  .Totalrecargossinimpuestos			lxSolcompraTotrecar =  .Totalrecargos			lxSolcompraTotdesc =  .Totaldescuentos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.SOLCOMPRA ( "Fmodifw","Fectrans","Fecimpo","Fd2","Fecexpo","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fletra","Fturno","Faltafw","Haltafw","Bdmodifw","Bdaltafw","Valtafw","Umodifw","Saltafw","Ualtafw","Smodifw","Hmodifw","Vmodifw","Esttrans","Fhora","Descfw","Zadsfw","Horaimpo","Horaexpo","Simbmon","Timestamp","Totalcant","Subtotsisi","Subtotcisi","Recmnto2","Recmnto1","Condivalp","Recmntosi","Signomov","Sitfiscpro","Fsubton","Fsubtot","Recmntosi1","Facttipo","Desmntosi2","Desmntosi1","Desmntosi","Recmntosi2","Desauto","Anulado","Fcompfis","Tcrg1361","Monsis","Codigo","Idvuelto","Fmtdes2","Fmtdes1","Fdescu","Fptoven","Fimpuesto","Fobs","Ffchfac","Fnumcomp","Fmtdes3","Desmntosi3","Recpor","Totdescsi","Ffch","Mr","Ncai","Fperson","Fvtocai","Cotiz","Nroremito","Recmnto","Fvuelto","Moneda","Ffchvenc","Codlista","Ftotal","Recmonto1","Recmonto2","Condpago","Motivo","Totimpue","Totrecarsi","Totrecar","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxSolcompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraFcuit ) + "'" >>, <<lxSolcompraIdcaja >>, <<lxSolcompraFpodes1 >>, <<lxSolcompraFpodes2 >>, <<lxSolcompraFpodes >>, <<"'" + this.FormatearTextoSql( lxSolcompraFletra ) + "'" >>, <<lxSolcompraFturno >>, <<"'" + this.ConvertirDateSql( lxSolcompraFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraSimbmon ) + "'" >>, <<lxSolcompraTimestamp >>, <<lxSolcompraTotalcant >>, <<lxSolcompraSubtotsisi >>, <<lxSolcompraSubtotcisi >>, <<lxSolcompraRecmnto2 >>, <<lxSolcompraRecmnto1 >>, <<lxSolcompraCondivalp >>, <<lxSolcompraRecmntosi >>, <<lxSolcompraSignomov >>, <<lxSolcompraSitfiscpro >>, <<lxSolcompraFsubton >>, <<lxSolcompraFsubtot >>, <<lxSolcompraRecmntosi1 >>, <<lxSolcompraFacttipo >>, <<lxSolcompraDesmntosi2 >>, <<lxSolcompraDesmntosi1 >>, <<lxSolcompraDesmntosi >>, <<lxSolcompraRecmntosi2 >>, <<iif( lxSolcompraDesauto, 1, 0 ) >>, <<iif( lxSolcompraAnulado, 1, 0 ) >>, <<iif( lxSolcompraFcompfis, 1, 0 ) >>, <<lxSolcompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxSolcompraMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraIdvuelto ) + "'" >>, <<lxSolcompraFmtdes2 >>, <<lxSolcompraFmtdes1 >>, <<lxSolcompraFdescu >>, <<lxSolcompraFptoven >>, <<lxSolcompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxSolcompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFfchfac ) + "'" >>, <<lxSolcompraFnumcomp >>, <<lxSolcompraFmtdes3 >>, <<lxSolcompraDesmntosi3 >>, <<lxSolcompraRecpor >>, <<lxSolcompraTotdescsi >>, <<"'" + this.ConvertirDateSql( lxSolcompraFfch ) + "'" >>, <<lxSolcompraMr >>, <<lxSolcompraNcai >>, <<"'" + this.FormatearTextoSql( lxSolcompraFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFvtocai ) + "'" >>, <<lxSolcompraCotiz >>, <<"'" + this.FormatearTextoSql( lxSolcompraNroremito ) + "'" >>, <<lxSolcompraRecmnto >>, <<lxSolcompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxSolcompraMoneda ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSolcompraFfchvenc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraCodlista ) + "'" >>, <<lxSolcompraFtotal >>, <<lxSolcompraRecmonto1 >>, <<lxSolcompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxSolcompraCondpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSolcompraMotivo ) + "'" >>, <<lxSolcompraTotimpue >>, <<lxSolcompraTotrecarsi >>, <<lxSolcompraTotrecar >>, <<lxSolcompraTotdesc >> )
		endtext
		loColeccion.cTabla = 'SOLCOMPRA' 
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
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SolCompraDet("AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","seniacance","MNTPIVA","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_cantidad>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_condicionivacompras>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajedto1>>, <<lxMontodto1>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajeiva>>, <<lxMontocfi>>, <<lxPorcentajecfi>>, <<lxPrecioconimpuestos>>, <<lxTipolistadeprecio>>, <<lxIdorigen>>, <<lxIditem>>, <<lxAfe_nroitem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpSolComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
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
						Insert into ZooLogic.ImpSolC("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxSolcompraFmodifw, lxSolcompraFectrans, lxSolcompraFecimpo, lxSolcompraFd2, lxSolcompraFecexpo, lxSolcompraFcuit, lxSolcompraIdcaja, lxSolcompraFpodes1, lxSolcompraFpodes2, lxSolcompraFpodes, lxSolcompraFletra, lxSolcompraFturno, lxSolcompraFaltafw, lxSolcompraHaltafw, lxSolcompraBdmodifw, lxSolcompraBdaltafw, lxSolcompraValtafw, lxSolcompraUmodifw, lxSolcompraSaltafw, lxSolcompraUaltafw, lxSolcompraSmodifw, lxSolcompraHmodifw, lxSolcompraVmodifw, lxSolcompraEsttrans, lxSolcompraFhora, lxSolcompraDescfw, lxSolcompraZadsfw, lxSolcompraHoraimpo, lxSolcompraHoraexpo, lxSolcompraSimbmon, lxSolcompraTimestamp, lxSolcompraTotalcant, lxSolcompraSubtotsisi, lxSolcompraSubtotcisi, lxSolcompraRecmnto2, lxSolcompraRecmnto1, lxSolcompraCondivalp, lxSolcompraRecmntosi, lxSolcompraSignomov, lxSolcompraSitfiscpro, lxSolcompraFsubton, lxSolcompraFsubtot, lxSolcompraRecmntosi1, lxSolcompraFacttipo, lxSolcompraDesmntosi2, lxSolcompraDesmntosi1, lxSolcompraDesmntosi, lxSolcompraRecmntosi2, lxSolcompraDesauto, lxSolcompraAnulado, lxSolcompraFcompfis, lxSolcompraTcrg1361, lxSolcompraMonsis, lxSolcompraCodigo, lxSolcompraIdvuelto, lxSolcompraFmtdes2, lxSolcompraFmtdes1, lxSolcompraFdescu, lxSolcompraFptoven, lxSolcompraFimpuesto, lxSolcompraFobs, lxSolcompraFfchfac, lxSolcompraFnumcomp, lxSolcompraFmtdes3, lxSolcompraDesmntosi3, lxSolcompraRecpor, lxSolcompraTotdescsi, lxSolcompraFfch, lxSolcompraMr, lxSolcompraNcai, lxSolcompraFperson, lxSolcompraFvtocai, lxSolcompraCotiz, lxSolcompraNroremito, lxSolcompraRecmnto, lxSolcompraFvuelto, lxSolcompraMoneda, lxSolcompraFfchvenc, lxSolcompraCodlista, lxSolcompraFtotal, lxSolcompraRecmonto1, lxSolcompraRecmonto2, lxSolcompraCondpago, lxSolcompraMotivo, lxSolcompraTotimpue, lxSolcompraTotrecarsi, lxSolcompraTotrecar, lxSolcompraTotdesc
				lxSolcompraFmodifw =  .Fechamodificacionfw			lxSolcompraFectrans =  .Fechatransferencia			lxSolcompraFecimpo =  .Fechaimpo			lxSolcompraFd2 =  .Fechamodificacion			lxSolcompraFecexpo =  .Fechaexpo			lxSolcompraFcuit =  .Cuit			lxSolcompraIdcaja =  .Caja_PK 			lxSolcompraFpodes1 =  .Porcentajedescuento1			lxSolcompraFpodes2 =  .Porcentajedescuento2			lxSolcompraFpodes =  .Porcentajedescuento			lxSolcompraFletra =  .Letra			lxSolcompraFturno =  .Turno			lxSolcompraFaltafw =  .Fechaaltafw			lxSolcompraHaltafw =  .Horaaltafw			lxSolcompraBdmodifw =  .Basededatosmodificacionfw			lxSolcompraBdaltafw =  .Basededatosaltafw			lxSolcompraValtafw =  .Versionaltafw			lxSolcompraUmodifw =  .Usuariomodificacionfw			lxSolcompraSaltafw =  .Seriealtafw			lxSolcompraUaltafw =  .Usuarioaltafw			lxSolcompraSmodifw =  .Seriemodificacionfw			lxSolcompraHmodifw =  .Horamodificacionfw			lxSolcompraVmodifw =  .Versionmodificacionfw			lxSolcompraEsttrans =  .Estadotransferencia			lxSolcompraFhora =  .Hora			lxSolcompraDescfw =  .Descripcionfw			lxSolcompraZadsfw =  .Zadsfw			lxSolcompraHoraimpo =  .Horaimpo			lxSolcompraHoraexpo =  .Horaexpo			lxSolcompraSimbmon =  .Simbolomonetariocomprobante			lxSolcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxSolcompraTotalcant =  .Totalcantidad			lxSolcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxSolcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxSolcompraRecmnto2 =  .Recargomontoconimpuestos2			lxSolcompraRecmnto1 =  .Recargomontoconimpuestos1			lxSolcompraCondivalp =  .Condicioniva			lxSolcompraRecmntosi =  .Recargomontosinimpuestos			lxSolcompraSignomov =  .Signodemovimiento			lxSolcompraSitfiscpro =  .Situacionfiscal_PK 			lxSolcompraFsubton =  .Subtotalneto			lxSolcompraFsubtot =  .Subtotalbruto			lxSolcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxSolcompraFacttipo =  .Tipocomprobante			lxSolcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxSolcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxSolcompraDesmntosi =  .Montodescuentosinimpuestos			lxSolcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxSolcompraDesauto =  .Descuentoautomatico			lxSolcompraAnulado =  .Anulado			lxSolcompraFcompfis =  .Comprobantefiscal			lxSolcompraTcrg1361 =  .Tipocomprobanterg1361			lxSolcompraMonsis =  upper( .MonedaSistema_PK ) 			lxSolcompraCodigo =  .Codigo			lxSolcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxSolcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxSolcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxSolcompraFdescu =  .Descuento			lxSolcompraFptoven =  .Puntodeventa			lxSolcompraFimpuesto =  .Impuestos			lxSolcompraFobs =  .Obs			lxSolcompraFfchfac =  .Fechafactura			lxSolcompraFnumcomp =  .Numero			lxSolcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxSolcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxSolcompraRecpor =  .Recargoporcentaje			lxSolcompraTotdescsi =  .Totaldescuentossinimpuestos			lxSolcompraFfch =  .Fecha			lxSolcompraMr =  .Recargomonto			lxSolcompraNcai =  .Cai			lxSolcompraFperson =  upper( .Proveedor_PK ) 			lxSolcompraFvtocai =  .Fechavtocai			lxSolcompraCotiz =  .Cotizacion			lxSolcompraNroremito =  .Remito			lxSolcompraRecmnto =  .Recargomontoconimpuestos			lxSolcompraFvuelto =  .Vuelto			lxSolcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxSolcompraFfchvenc =  .Fechavencimiento			lxSolcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxSolcompraFtotal =  .Total			lxSolcompraRecmonto1 =  .Recargomonto1			lxSolcompraRecmonto2 =  .Recargomonto2			lxSolcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxSolcompraMotivo =  upper( .Motivo_PK ) 			lxSolcompraTotimpue =  .Totalimpuestos			lxSolcompraTotrecarsi =  .Totalrecargossinimpuestos			lxSolcompraTotrecar =  .Totalrecargos			lxSolcompraTotdesc =  .Totaldescuentos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39]
			text to lcSentencia noshow textmerge
				update ZooLogic.SOLCOMPRA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSolcompraFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxSolcompraFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSolcompraFecimpo ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxSolcompraFd2 ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSolcompraFecexpo ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxSolcompraFcuit ) + "'">>, "Idcaja" = <<lxSolcompraIdcaja>>, "Fpodes1" = <<lxSolcompraFpodes1>>, "Fpodes2" = <<lxSolcompraFpodes2>>, "Fpodes" = <<lxSolcompraFpodes>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxSolcompraFletra ) + "'">>, "Fturno" = <<lxSolcompraFturno>>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxSolcompraFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxSolcompraHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSolcompraBdaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxSolcompraValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxSolcompraSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxSolcompraUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxSolcompraVmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxSolcompraEsttrans ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxSolcompraFhora ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxSolcompraDescfw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxSolcompraZadsfw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxSolcompraHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxSolcompraHoraexpo ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxSolcompraSimbmon ) + "'">>, "Timestamp" = <<lxSolcompraTimestamp>>, "Totalcant" = <<lxSolcompraTotalcant>>, "Subtotsisi" = <<lxSolcompraSubtotsisi>>, "Subtotcisi" = <<lxSolcompraSubtotcisi>>, "Recmnto2" = <<lxSolcompraRecmnto2>>, "Recmnto1" = <<lxSolcompraRecmnto1>>, "Condivalp" = <<lxSolcompraCondivalp>>, "Recmntosi" = <<lxSolcompraRecmntosi>>, "Signomov" = <<lxSolcompraSignomov>>, "Sitfiscpro" = <<lxSolcompraSitfiscpro>>, "Fsubton" = <<lxSolcompraFsubton>>, "Fsubtot" = <<lxSolcompraFsubtot>>, "Recmntosi1" = <<lxSolcompraRecmntosi1>>, "Facttipo" = <<lxSolcompraFacttipo>>, "Desmntosi2" = <<lxSolcompraDesmntosi2>>, "Desmntosi1" = <<lxSolcompraDesmntosi1>>, "Desmntosi" = <<lxSolcompraDesmntosi>>, "Recmntosi2" = <<lxSolcompraRecmntosi2>>, "Desauto" = <<iif( lxSolcompraDesauto, 1, 0 )>>, "Anulado" = <<iif( lxSolcompraAnulado, 1, 0 )>>, "Fcompfis" = <<iif( lxSolcompraFcompfis, 1, 0 )>>, "Tcrg1361" = <<lxSolcompraTcrg1361>>, "Monsis" = <<"'" + this.FormatearTextoSql( lxSolcompraMonsis ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxSolcompraCodigo ) + "'">>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxSolcompraIdvuelto ) + "'">>, "Fmtdes2" = <<lxSolcompraFmtdes2>>, "Fmtdes1" = <<lxSolcompraFmtdes1>>, "Fdescu" = <<lxSolcompraFdescu>>, "Fptoven" = <<lxSolcompraFptoven>>, "Fimpuesto" = <<lxSolcompraFimpuesto>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxSolcompraFobs ) + "'">>, "Ffchfac" = <<"'" + this.ConvertirDateSql( lxSolcompraFfchfac ) + "'">>, "Fnumcomp" = <<lxSolcompraFnumcomp>>, "Fmtdes3" = <<lxSolcompraFmtdes3>>, "Desmntosi3" = <<lxSolcompraDesmntosi3>>, "Recpor" = <<lxSolcompraRecpor>>, "Totdescsi" = <<lxSolcompraTotdescsi>>, "Ffch" = <<"'" + this.ConvertirDateSql( lxSolcompraFfch ) + "'">>, "Mr" = <<lxSolcompraMr>>, "Ncai" = <<lxSolcompraNcai>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxSolcompraFperson ) + "'">>, "Fvtocai" = <<"'" + this.ConvertirDateSql( lxSolcompraFvtocai ) + "'">>, "Cotiz" = <<lxSolcompraCotiz>>, "Nroremito" = <<"'" + this.FormatearTextoSql( lxSolcompraNroremito ) + "'">>, "Recmnto" = <<lxSolcompraRecmnto>>, "Fvuelto" = <<lxSolcompraFvuelto>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxSolcompraMoneda ) + "'">>, "Ffchvenc" = <<"'" + this.ConvertirDateSql( lxSolcompraFfchvenc ) + "'">>, "Codlista" = <<"'" + this.FormatearTextoSql( lxSolcompraCodlista ) + "'">>, "Ftotal" = <<lxSolcompraFtotal>>, "Recmonto1" = <<lxSolcompraRecmonto1>>, "Recmonto2" = <<lxSolcompraRecmonto2>>, "Condpago" = <<"'" + this.FormatearTextoSql( lxSolcompraCondpago ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxSolcompraMotivo ) + "'">>, "Totimpue" = <<lxSolcompraTotimpue>>, "Totrecarsi" = <<lxSolcompraTotrecarsi>>, "Totrecar" = <<lxSolcompraTotrecar>>, "Totdesc" = <<lxSolcompraTotdesc>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SOLCOMPRA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SolCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpSolComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpSolC where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SolCompraDet("AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","seniacance","MNTPIVA","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_cantidad>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxArticulo_porcentajeivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_condicionivacompras>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajedto1>>, <<lxMontodto1>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajeiva>>, <<lxMontocfi>>, <<lxPorcentajecfi>>, <<lxPrecioconimpuestos>>, <<lxTipolistadeprecio>>, <<lxIdorigen>>, <<lxIditem>>, <<lxAfe_nroitem>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpSolComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
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
						Insert into ZooLogic.ImpSolC("codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<lxPorcentaje>>, <<lxMinimonoimponible>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39]
		loColeccion.Agregar( 'delete from ZooLogic.SOLCOMPRA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SolCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpSolComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpSolC where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'SOLCOMPRA' 
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
					"Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afecant" as "Afe_cantidad", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Aporcivac" as "Articulo_porcentajeivacompras", "Afesaldo" as "Afe_saldo", "Acondivac" as "Articulo_condicionivacompras", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fpordto1" as "Porcentajedto1", "Fmtodto1" as "Montodto1", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporiva" as "Porcentajeiva", "Fmtocfi" as "Montocfi", "Fporcfi" as "Porcentajecfi", "Prunconimp" as "Precioconimpuestos", "Fn11" as "Tipolistadeprecio", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Afenroitem" as "Afe_nroitem", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
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
			lcRetorno = [update ZooLogic.SOLCOMPRA set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.SOLCOMPRA where  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.SOLCOMPRA where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxSolCompraFLETRA as variant, lxSolCompraFACTTIPO as variant, lxSolCompraFPTOVEN as variant, lxSolCompraFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SOLICITUDDECOMPRA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.SOLCOMPRA Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.SOLCOMPRA set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, SitFiscPro = ] + transform( &lcCursor..SitFiscPro )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, DesAuto = ] + Transform( iif( &lcCursor..DesAuto, 1, 0 ))+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, tcrg1361 = ] + transform( &lcCursor..tcrg1361 )+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FFCHFAC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, MR = ] + transform( &lcCursor..MR )+ [, NCAI = ] + transform( &lcCursor..NCAI )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FVTOCAI = ] + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, NROREMITO = ] + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FFCHVENC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'"+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, RecMonto1 = ] + transform( &lcCursor..RecMonto1 )+ [, RecMonto2 = ] + transform( &lcCursor..RecMonto2 )+ [, CONDPAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totdesc = ] + transform( &lcCursor..totdesc ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.SOLCOMPRA Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FECTRANS, FECIMPO, FD2, FECEXPO, fCuit, IdCaja, FPODES1, FPODES2, FPODES, FLETRA, FTurno, FAltaFW, HAltaFW, BDMODIFW, BDALTAFW, VALTAFW, UMODIFW, SALTAFW, UALTAFW, SMODIFW, HMODIFW, VMODIFW, ESTTRANS, FHORA, DescFW, ZADSFW, HORAIMPO, HORAEXPO, SimbMon, TIMESTAMP, TotalCant, SubTotSISI, SubTotCISI, RecMnto2, RecMnto1, CondivaLp, RecMntoSI, signomov, SitFiscPro, fSubToN, FSubTOT, RecMntoSI1, FACTTIPO, DesMntoSI2, DesMntoSI1, DesMntoSI, RecMntoSI2, DesAuto, Anulado, FCOMPFIS, tcrg1361, MonSis, CODIGO, idVuelto, FMTDES2, FMTDES1, fDescu, FPTOVEN, fImpuesto, FObs, FFCHFAC, FNUMCOMP, FMTDES3, DesMntoSI3, RecPor, totdescSI, FFCH, MR, NCAI, FPerson, FVTOCAI, Cotiz, NROREMITO, RecMnto, FVuelto, Moneda, FFCHVENC, CodLista, FTotal, RecMonto1, RecMonto2, CONDPAGO, MOTIVO, totimpue, totrecarSI, totrecar, totdesc
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'" + ',' + transform( &lcCursor..IdCaja )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FPODES1 ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..FPODES ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..FTurno ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..RecMntoSI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..SitFiscPro ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..DesMntoSI ) + ',' + transform( &lcCursor..RecMntoSI2 )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..DesAuto, 1, 0 )) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + transform( &lcCursor..tcrg1361 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + transform( &lcCursor..FMTDES2 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FMTDES1 ) + ',' + transform( &lcCursor..fDescu ) + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..fImpuesto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'" + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..FMTDES3 ) + ',' + transform( &lcCursor..DesMntoSI3 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..totdescSI ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..NCAI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecMnto ) + ',' + transform( &lcCursor..FVuelto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + transform( &lcCursor..RecMonto1 ) + ',' + transform( &lcCursor..RecMonto2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..totrecar ) + ',' + transform( &lcCursor..totdesc )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.SOLCOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SOLICITUDDECOMPRA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.SolCompraDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpSolComp Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpSolC Where cCod] + lcIn  )
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSSOLCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeLETRA","AfeNUMCOM","AfePTOVEN","FAMate","afe_Cod","IdItem","MNTPTOT","MNTPRECCI","AfeCANT","AfeTS","MNTPPER","APorcIvaC","AfeSaldo","ACondIvaC","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESSI","MNTPDESSI","MNTPRECSI","MNPDSI","MNTPDESCI","MNDESCI","AfeTipoCom","NroItem","FNETO","FX2","FmtoIVA","FporDTO1","FmtoDTO1","FKIT","FCFITot","fporIva","FmtoCFI","FporCFI","prunconimp","FN11","iditemOrig","ciditem","AfeNroItem","FPRUN","Prunsinimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","seniacance","MNTPIVA","FCANT","FPRECIO","FCFI","MNTDES","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.SolCompraDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_Cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.APorcIvaC  ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.ACondIvaC  ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSSOLC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpSolComp ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSOLCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"codint","TipoI","porcen","minoimp","NroItem","cCod","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpSolC ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + transform( cDetallesExistentes.porcen     ) + ',' + transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSSOLCOMPRA',this.oEntidad.cPrefijoRecibir + 'SOLICITUDDECOMPRA')
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSSOLCOMPRA', this.oEntidad.cPrefijoRecibir + 'SOLICITUDDECOMPRA')
		
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
			Case  lcAlias == lcPrefijo + 'SOLICITUDDECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SOLICITUDDECOMPRA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SOLICITUDDECOMPRA_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSSOLCOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSSOLC'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSOLCOMPRA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_SolCompra')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'SOLICITUDDECOMPRA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad SOLICITUDDECOMPRA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SOLICITUDDECOMPRA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SOLICITUDDECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FFCHFAC   
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  FVTOCAI   
		* Validar ANTERIORES A 1/1/1753  FFCHVENC  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SolCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SolCompra
Create Table ZooLogic.TablaTrabajo_SolCompra ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fd2" datetime  null, 
"fecexpo" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"fletra" char( 1 )  null, 
"fturno" numeric( 1, 0 )  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"esttrans" char( 20 )  null, 
"fhora" char( 8 )  null, 
"descfw" char( 200 )  null, 
"zadsfw" varchar(max)  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"simbmon" char( 3 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"subtotsisi" numeric( 15, 2 )  null, 
"subtotcisi" numeric( 15, 2 )  null, 
"recmnto2" numeric( 15, 2 )  null, 
"recmnto1" numeric( 15, 2 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"recmntosi" numeric( 15, 2 )  null, 
"signomov" numeric( 2, 0 )  null, 
"sitfiscpro" numeric( 2, 0 )  null, 
"fsubton" numeric( 15, 2 )  null, 
"fsubtot" numeric( 15, 2 )  null, 
"recmntosi1" numeric( 15, 2 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"desmntosi2" numeric( 15, 2 )  null, 
"desmntosi1" numeric( 15, 2 )  null, 
"desmntosi" numeric( 15, 2 )  null, 
"recmntosi2" numeric( 15, 2 )  null, 
"desauto" bit  null, 
"anulado" bit  null, 
"fcompfis" bit  null, 
"tcrg1361" numeric( 1, 0 )  null, 
"monsis" char( 10 )  null, 
"codigo" char( 38 )  null, 
"idvuelto" char( 5 )  null, 
"fmtdes2" numeric( 15, 2 )  null, 
"fmtdes1" numeric( 15, 2 )  null, 
"fdescu" numeric( 15, 2 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"fimpuesto" numeric( 15, 2 )  null, 
"fobs" varchar(max)  null, 
"ffchfac" datetime  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"fmtdes3" numeric( 15, 2 )  null, 
"desmntosi3" numeric( 15, 2 )  null, 
"recpor" numeric( 6, 2 )  null, 
"totdescsi" numeric( 15, 2 )  null, 
"ffch" datetime  null, 
"mr" numeric( 15, 2 )  null, 
"ncai" numeric( 14, 0 )  null, 
"fperson" char( 10 )  null, 
"fvtocai" datetime  null, 
"cotiz" numeric( 15, 5 )  null, 
"nroremito" char( 15 )  null, 
"recmnto" numeric( 15, 2 )  null, 
"fvuelto" numeric( 15, 2 )  null, 
"moneda" char( 10 )  null, 
"ffchvenc" datetime  null, 
"codlista" char( 6 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"recmonto1" numeric( 15, 2 )  null, 
"recmonto2" numeric( 15, 2 )  null, 
"condpago" char( 5 )  null, 
"motivo" char( 3 )  null, 
"totimpue" numeric( 15, 2 )  null, 
"totrecarsi" numeric( 15, 2 )  null, 
"totrecar" numeric( 15, 2 )  null, 
"totdesc" numeric( 15, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_SolCompra' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_SolCompra' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SOLICITUDDECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('sitfiscpro','sitfiscpro')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('desauto','desauto')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('tcrg1361','tcrg1361')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('ffchfac','ffchfac')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('ncai','ncai')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fvtocai','fvtocai')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('nroremito','nroremito')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('ffchvenc','ffchvenc')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('recmonto1','recmonto1')
			.AgregarMapeo('recmonto2','recmonto2')
			.AgregarMapeo('condpago','condpago')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totdesc','totdesc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_SolCompra'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.SITFISCPRO = isnull( d.SITFISCPRO, t.SITFISCPRO ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.DESAUTO = isnull( d.DESAUTO, t.DESAUTO ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.TCRG1361 = isnull( d.TCRG1361, t.TCRG1361 ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FFCHFAC = isnull( d.FFCHFAC, t.FFCHFAC ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.MR = isnull( d.MR, t.MR ),t.NCAI = isnull( d.NCAI, t.NCAI ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FVTOCAI = isnull( d.FVTOCAI, t.FVTOCAI ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.NROREMITO = isnull( d.NROREMITO, t.NROREMITO ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FFCHVENC = isnull( d.FFCHVENC, t.FFCHVENC ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.RECMONTO1 = isnull( d.RECMONTO1, t.RECMONTO1 ),t.RECMONTO2 = isnull( d.RECMONTO2, t.RECMONTO2 ),t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC )
					from ZooLogic.SOLCOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.SOLCOMPRA(Fmodifw,Fectrans,Fecimpo,Fd2,Fecexpo,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fletra,Fturno,Faltafw,Haltafw,Bdmodifw,Bdaltafw,Valtafw,Umodifw,Saltafw,Ualtafw,Smodifw,Hmodifw,Vmodifw,Esttrans,Fhora,Descfw,Zadsfw,Horaimpo,Horaexpo,Simbmon,Timestamp,Totalcant,Subtotsisi,Subtotcisi,Recmnto2,Recmnto1,Condivalp,Recmntosi,Signomov,Sitfiscpro,Fsubton,Fsubtot,Recmntosi1,Facttipo,Desmntosi2,Desmntosi1,Desmntosi,Recmntosi2,Desauto,Anulado,Fcompfis,Tcrg1361,Monsis,Codigo,Idvuelto,Fmtdes2,Fmtdes1,Fdescu,Fptoven,Fimpuesto,Fobs,Ffchfac,Fnumcomp,Fmtdes3,Desmntosi3,Recpor,Totdescsi,Ffch,Mr,Ncai,Fperson,Fvtocai,Cotiz,Nroremito,Recmnto,Fvuelto,Moneda,Ffchvenc,Codlista,Ftotal,Recmonto1,Recmonto2,Condpago,Motivo,Totimpue,Totrecarsi,Totrecar,Totdesc)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FD2,''),isnull( d.FECEXPO,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FPODES1,0),isnull( d.FPODES2,0),isnull( d.FPODES,0),isnull( d.FLETRA,''),isnull( d.FTURNO,0),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.FHORA,''),isnull( d.DESCFW,''),isnull( d.ZADSFW,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.SIMBMON,''),isnull( d.TIMESTAMP,0),isnull( d.TOTALCANT,0),isnull( d.SUBTOTSISI,0),isnull( d.SUBTOTCISI,0),isnull( d.RECMNTO2,0),isnull( d.RECMNTO1,0),isnull( d.CONDIVALP,0),isnull( d.RECMNTOSI,0),isnull( d.SIGNOMOV,0),isnull( d.SITFISCPRO,0),isnull( d.FSUBTON,0),isnull( d.FSUBTOT,0),isnull( d.RECMNTOSI1,0),isnull( d.FACTTIPO,0),isnull( d.DESMNTOSI2,0),isnull( d.DESMNTOSI1,0),isnull( d.DESMNTOSI,0),isnull( d.RECMNTOSI2,0),isnull( d.DESAUTO,0),isnull( d.ANULADO,0),isnull( d.FCOMPFIS,0),isnull( d.TCRG1361,0),isnull( d.MONSIS,''),isnull( d.CODIGO,''),isnull( d.IDVUELTO,''),isnull( d.FMTDES2,0),isnull( d.FMTDES1,0),isnull( d.FDESCU,0),isnull( d.FPTOVEN,0),isnull( d.FIMPUESTO,0),isnull( d.FOBS,''),isnull( d.FFCHFAC,''),isnull( d.FNUMCOMP,0),isnull( d.FMTDES3,0),isnull( d.DESMNTOSI3,0),isnull( d.RECPOR,0),isnull( d.TOTDESCSI,0),isnull( d.FFCH,''),isnull( d.MR,0),isnull( d.NCAI,0),isnull( d.FPERSON,''),isnull( d.FVTOCAI,''),isnull( d.COTIZ,0),isnull( d.NROREMITO,''),isnull( d.RECMNTO,0),isnull( d.FVUELTO,0),isnull( d.MONEDA,''),isnull( d.FFCHVENC,''),isnull( d.CODLISTA,''),isnull( d.FTOTAL,0),isnull( d.RECMONTO1,0),isnull( d.RECMONTO2,0),isnull( d.CONDPAGO,''),isnull( d.MOTIVO,''),isnull( d.TOTIMPUE,0),isnull( d.TOTRECARSI,0),isnull( d.TOTRECAR,0),isnull( d.TOTDESC,0)
						From deleted d left join ZooLogic.SOLCOMPRA pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.SOLCOMPRA cc 
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
					from ZooLogic.SOLCOMPRA t inner join deleted d 
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
					from ZooLogic.SOLCOMPRA t inner join deleted d 
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
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_SOLCOMPRA_CompAfe
ON ZooLogic.TablaTrabajo_SOLCOMPRA_CompAfe
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
	function ObtenerTriggerDeleteImportacion_SolCompraDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_SOLCOMPRA_SolCompraDet
ON ZooLogic.TablaTrabajo_SOLCOMPRA_SolCompraDet
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
t.FCOTXT = isnull( d.FCOTXT, t.FCOTXT ),
t.FTALL = isnull( d.FTALL, t.FTALL ),
t.SENIACANCE = isnull( d.SENIACANCE, t.SENIACANCE ),
t.MNTPIVA = isnull( d.MNTPIVA, t.MNTPIVA ),
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.SolCompraDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.SolCompraDet
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
"FCOTXT",
"FTALL",
"SENIACANCE",
"MNTPIVA",
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
d.FCOTXT,
d.FTALL,
d.SENIACANCE,
d.MNTPIVA,
d.FCANT,
d.FPRECIO,
d.FCFI,
d.MNTDES,
d.FMONTO
From deleted d left join ZooLogic.SolCompraDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpSolComp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_SOLCOMPRA_ImpSolComp
ON ZooLogic.TablaTrabajo_SOLCOMPRA_ImpSolComp
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
from ZooLogic.ImpSolComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpSolComp
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
From deleted d left join ZooLogic.ImpSolComp pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpSolC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_SOLCOMPRA_ImpSolC
ON ZooLogic.TablaTrabajo_SOLCOMPRA_ImpSolC
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
from ZooLogic.ImpSolC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpSolC
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
From deleted d left join ZooLogic.ImpSolC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SolCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SolCompra
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_SOLICITUDDECOMPRA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_SOLICITUDDECOMPRA.Cuit, [] )
					.Caja_PK =  nvl( c_SOLICITUDDECOMPRA.Caja, 0 )
					.Porcentajedescuento1 = nvl( c_SOLICITUDDECOMPRA.Porcentajedescuento1, 0 )
					.Porcentajedescuento2 = nvl( c_SOLICITUDDECOMPRA.Porcentajedescuento2, 0 )
					.Porcentajedescuento = nvl( c_SOLICITUDDECOMPRA.Porcentajedescuento, 0 )
					.Letra = nvl( c_SOLICITUDDECOMPRA.Letra, [] )
					.Turno = nvl( c_SOLICITUDDECOMPRA.Turno, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_SOLICITUDDECOMPRA.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_SOLICITUDDECOMPRA.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_SOLICITUDDECOMPRA.Basededatosaltafw, [] )
					.Versionaltafw = nvl( c_SOLICITUDDECOMPRA.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_SOLICITUDDECOMPRA.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_SOLICITUDDECOMPRA.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_SOLICITUDDECOMPRA.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_SOLICITUDDECOMPRA.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_SOLICITUDDECOMPRA.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_SOLICITUDDECOMPRA.Versionmodificacionfw, [] )
					.Estadotransferencia = nvl( c_SOLICITUDDECOMPRA.Estadotransferencia, [] )
					.Hora = nvl( c_SOLICITUDDECOMPRA.Hora, [] )
					.Descripcionfw = nvl( c_SOLICITUDDECOMPRA.Descripcionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaimpo = nvl( c_SOLICITUDDECOMPRA.Horaimpo, [] )
					.Horaexpo = nvl( c_SOLICITUDDECOMPRA.Horaexpo, [] )
					.Simbolomonetariocomprobante = nvl( c_SOLICITUDDECOMPRA.Simbolomonetariocomprobante, [] )
					.Timestamp = nvl( c_SOLICITUDDECOMPRA.Timestamp, 0 )
					.Totalcantidad = nvl( c_SOLICITUDDECOMPRA.Totalcantidad, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_SOLICITUDDECOMPRA.Subtotalsinimpuestossobreitems, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_SOLICITUDDECOMPRA.Subtotalconimpuestossobreitems, 0 )
					.Recargomontoconimpuestos2 = nvl( c_SOLICITUDDECOMPRA.Recargomontoconimpuestos2, 0 )
					.Recargomontoconimpuestos1 = nvl( c_SOLICITUDDECOMPRA.Recargomontoconimpuestos1, 0 )
					.Condicioniva = nvl( c_SOLICITUDDECOMPRA.Condicioniva, 0 )
					.Recargomontosinimpuestos = nvl( c_SOLICITUDDECOMPRA.Recargomontosinimpuestos, 0 )
					.Signodemovimiento = nvl( c_SOLICITUDDECOMPRA.Signodemovimiento, 0 )
					.Situacionfiscal_PK =  nvl( c_SOLICITUDDECOMPRA.Situacionfiscal, 0 )
					.Subtotalneto = nvl( c_SOLICITUDDECOMPRA.Subtotalneto, 0 )
					.Subtotalbruto = nvl( c_SOLICITUDDECOMPRA.Subtotalbruto, 0 )
					.Recargomontosinimpuestos1 = nvl( c_SOLICITUDDECOMPRA.Recargomontosinimpuestos1, 0 )
					.Tipocomprobante = nvl( c_SOLICITUDDECOMPRA.Tipocomprobante, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_SOLICITUDDECOMPRA.Montodescuentosinimpuestos2, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_SOLICITUDDECOMPRA.Montodescuentosinimpuestos1, 0 )
					.Montodescuentosinimpuestos = nvl( c_SOLICITUDDECOMPRA.Montodescuentosinimpuestos, 0 )
					.Recargomontosinimpuestos2 = nvl( c_SOLICITUDDECOMPRA.Recargomontosinimpuestos2, 0 )
					.Descuentoautomatico = nvl( c_SOLICITUDDECOMPRA.Descuentoautomatico, .F. )
					.Anulado = nvl( c_SOLICITUDDECOMPRA.Anulado, .F. )
					.Comprobantefiscal = nvl( c_SOLICITUDDECOMPRA.Comprobantefiscal, .F. )
					.Tipocomprobanterg1361 = nvl( c_SOLICITUDDECOMPRA.Tipocomprobanterg1361, 0 )
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Monedasistema_PK =  nvl( c_SOLICITUDDECOMPRA.Monedasistema, [] )
					.Codigo = nvl( c_SOLICITUDDECOMPRA.Codigo, [] )
					.Idvuelto_PK =  nvl( c_SOLICITUDDECOMPRA.Idvuelto, [] )
					.Montodescuentoconimpuestos2 = nvl( c_SOLICITUDDECOMPRA.Montodescuentoconimpuestos2, 0 )
					.Montodescuentoconimpuestos1 = nvl( c_SOLICITUDDECOMPRA.Montodescuentoconimpuestos1, 0 )
					.Descuento = nvl( c_SOLICITUDDECOMPRA.Descuento, 0 )
					.Puntodeventa = nvl( c_SOLICITUDDECOMPRA.Puntodeventa, 0 )
					.Impuestos = nvl( c_SOLICITUDDECOMPRA.Impuestos, 0 )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fechafactura = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fechafactura, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_SOLICITUDDECOMPRA.Numero, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_SOLICITUDDECOMPRA.Montodescuentoconimpuestos3, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_SOLICITUDDECOMPRA.Montodescuentosinimpuestos3, 0 )
					.Recargoporcentaje = nvl( c_SOLICITUDDECOMPRA.Recargoporcentaje, 0 )
					.Totaldescuentossinimpuestos = nvl( c_SOLICITUDDECOMPRA.Totaldescuentossinimpuestos, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fecha, ctod( '  /  /    ' ) ) )
					.Recargomonto = nvl( c_SOLICITUDDECOMPRA.Recargomonto, 0 )
					.Cai = nvl( c_SOLICITUDDECOMPRA.Cai, 0 )
					.Proveedor_PK =  nvl( c_SOLICITUDDECOMPRA.Proveedor, [] )
					.Fechavtocai = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fechavtocai, ctod( '  /  /    ' ) ) )
					.Cotizacion = nvl( c_SOLICITUDDECOMPRA.Cotizacion, 0 )
					.Remito = nvl( c_SOLICITUDDECOMPRA.Remito, [] )
					.Recargomontoconimpuestos = nvl( c_SOLICITUDDECOMPRA.Recargomontoconimpuestos, 0 )
					.Vuelto = nvl( c_SOLICITUDDECOMPRA.Vuelto, 0 )
					.Monedacomprobante_PK =  nvl( c_SOLICITUDDECOMPRA.Monedacomprobante, [] )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_SOLICITUDDECOMPRA.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Listadeprecios_PK =  nvl( c_SOLICITUDDECOMPRA.Listadeprecios, [] )
					.Total = nvl( c_SOLICITUDDECOMPRA.Total, 0 )
					.Recargomonto1 = nvl( c_SOLICITUDDECOMPRA.Recargomonto1, 0 )
					.Recargomonto2 = nvl( c_SOLICITUDDECOMPRA.Recargomonto2, 0 )
					.Condicionpagopreferente_PK =  nvl( c_SOLICITUDDECOMPRA.Condicionpagopreferente, [] )
					.Motivo_PK =  nvl( c_SOLICITUDDECOMPRA.Motivo, [] )
					.Totalimpuestos = nvl( c_SOLICITUDDECOMPRA.Totalimpuestos, 0 )
					.Totalrecargossinimpuestos = nvl( c_SOLICITUDDECOMPRA.Totalrecargossinimpuestos, 0 )
					.Totalrecargos = nvl( c_SOLICITUDDECOMPRA.Totalrecargos, 0 )
					.Totaldescuentos = nvl( c_SOLICITUDDECOMPRA.Totaldescuentos, 0 )
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
			lxRetorno = c_SOLICITUDDECOMPRA.CODIGO
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
				lcSentencia = "UPDATE ZooLogic.SolCompraDet"
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
		return c_SOLICITUDDECOMPRA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.SOLCOMPRA' )
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
								from ZooLogic.SOLCOMPRA 
								Where   SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SOLCOMPRA", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fletra" as "Letra", "Fturno" as "Turno", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Simbmon" as "Simbolomonetariocomprobante", "Timestamp" as "Timestamp", "Totalcant" as "Totalcantidad", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Condivalp" as "Condicioniva", "Recmntosi" as "Recargomontosinimpuestos", "Signomov" as "Signodemovimiento", "Sitfiscpro" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Fsubtot" as "Subtotalbruto", "Recmntosi1" as "Recargomontosinimpuestos1", "Facttipo" as "Tipocomprobante", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Tcrg1361" as "Tipocomprobanterg1361", "Monsis" as "Monedasistema", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fptoven" as "Puntodeventa", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffchfac" as "Fechafactura", "Fnumcomp" as "Numero", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Ffch" as "Fecha", "Mr" as "Recargomonto", "Ncai" as "Cai", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Cotiz" as "Cotizacion", "Nroremito" as "Remito", "Recmnto" as "Recargomontoconimpuestos", "Fvuelto" as "Vuelto", "Moneda" as "Monedacomprobante", "Ffchvenc" as "Fechavencimiento", "Codlista" as "Listadeprecios", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Condpago" as "Condicionpagopreferente", "Motivo" as "Motivo", "Totimpue" as "Totalimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.SOLCOMPRA 
								Where   SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39
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
	Tabla = 'SOLCOMPRA'
	Filtro = " SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39"
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
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHAMODIFICACIONFW                     " tabla="SOLCOMPRA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHATRANSFERENCIA                      " tabla="SOLCOMPRA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHAIMPO                               " tabla="SOLCOMPRA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHAMODIFICACION                       " tabla="SOLCOMPRA      " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHAEXPO                               " tabla="SOLCOMPRA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="CUIT                                    " tabla="SOLCOMPRA      " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="proveedor.cuit                                                                                                                                                                                                                                                " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="CAJA                                    " tabla="SOLCOMPRA      " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                            " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="PORCENTAJEDESCUENTO1                    " tabla="SOLCOMPRA      " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje descuento 1                                                                                                                                          " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="PORCENTAJEDESCUENTO2                    " tabla="SOLCOMPRA      " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje descuento 2                                                                                                                                          " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="PORCENTAJEDESCUENTO                     " tabla="SOLCOMPRA      " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Porcentaje de descuento                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="LETRA                                   " tabla="SOLCOMPRA      " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TURNO                                   " tabla="SOLCOMPRA      " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHAALTAFW                             " tabla="SOLCOMPRA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="HORAALTAFW                              " tabla="SOLCOMPRA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SOLCOMPRA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="BASEDEDATOSALTAFW                       " tabla="SOLCOMPRA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="VERSIONALTAFW                           " tabla="SOLCOMPRA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="USUARIOMODIFICACIONFW                   " tabla="SOLCOMPRA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="SERIEALTAFW                             " tabla="SOLCOMPRA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="USUARIOALTAFW                           " tabla="SOLCOMPRA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="SERIEMODIFICACIONFW                     " tabla="SOLCOMPRA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="HORAMODIFICACIONFW                      " tabla="SOLCOMPRA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="VERSIONMODIFICACIONFW                   " tabla="SOLCOMPRA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="ESTADOTRANSFERENCIA                     " tabla="SOLCOMPRA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="HORA                                    " tabla="SOLCOMPRA      " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="DESCRIPCIONFW                           " tabla="SOLCOMPRA      " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="ZADSFW                                  " tabla="SOLCOMPRA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="HORAIMPO                                " tabla="SOLCOMPRA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="HORAEXPO                                " tabla="SOLCOMPRA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="SOLCOMPRA      " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TIMESTAMP                               " tabla="SOLCOMPRA      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TOTALCANTIDAD                           " tabla="SOLCOMPRA      " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Total Cantidad                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="SOLCOMPRA      " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="SOLCOMPRA      " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="SOLCOMPRA      " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 2                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="SOLCOMPRA      " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 1                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="CONDICIONIVA                            " tabla="SOLCOMPRA      " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="SOLCOMPRA      " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="SIGNODEMOVIMIENTO                       " tabla="SOLCOMPRA      " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="SITUACIONFISCAL                         " tabla="SOLCOMPRA      " campo="SITFISCPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Situación fiscal                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="proveedor.SituacionFiscal                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="SUBTOTALNETO                            " tabla="SOLCOMPRA      " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="SUBTOTALBRUTO                           " tabla="SOLCOMPRA      " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="SOLCOMPRA      " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TIPOCOMPROBANTE                         " tabla="SOLCOMPRA      " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=39                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="16" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="SOLCOMPRA      " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="SOLCOMPRA      " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="SOLCOMPRA      " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="SOLCOMPRA      " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="DESCUENTOAUTOMATICO                     " tabla="SOLCOMPRA      " campo="DESAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="ANULADO                                 " tabla="SOLCOMPRA      " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Está anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="COMPROBANTEFISCAL                       " tabla="SOLCOMPRA      " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TIPOCOMPROBANTERG1361                   " tabla="SOLCOMPRA      " campo="TCRG1361  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo factura                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FACTURADETALLE                          " tabla="SOLCOMPRADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Artículos                                                                                                                                                       " dominio="DETALLEITEMARTICULOSSOLCOMPRA " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="IMPUESTOSDETALLE                        " tabla="IMPSOLCOMP     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOSSOLC      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MONEDASISTEMA                           " tabla="SOLCOMPRA      " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Sistema                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="CODIGO                                  " tabla="SOLCOMPRA      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Nro. interno                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="IDVUELTO                                " tabla="SOLCOMPRA      " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código vuelto                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="SOLCOMPRA      " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 2                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="SOLCOMPRA      " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 1                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="DESCUENTO                               " tabla="SOLCOMPRA      " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Monto de descuento                                                                                                                                              " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="PUNTODEVENTA                            " tabla="SOLCOMPRA      " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="4" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="IMPUESTOS                               " tabla="SOLCOMPRA      " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="I.V.A.                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPSOLC        " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOSOLCOMPRA  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="OBS                                     " tabla="SOLCOMPRA      " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHAFACTURA                            " tabla="SOLCOMPRA      " campo="FFCHFAC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="10" etiqueta="Emisión                                                                                                                                                         " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="NUMERO                                  " tabla="SOLCOMPRA      " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="SOLCOMPRA      " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Monto descuento con impuestos 3                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="SOLCOMPRA      " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOPORCENTAJE                       " tabla="SOLCOMPRA      " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Recargo porcentaje                                                                                                                                              " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="SOLCOMPRA      " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos sin impuestos                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="14" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHA                                   " tabla="SOLCOMPRA      " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="416" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOMONTO                            " tabla="SOLCOMPRA      " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Recargo monto                                                                                                                                                   " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="CAI                                     " tabla="SOLCOMPRA      " campo="NCAI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="C.A.I./C.A.E.                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="PROVEEDOR                               " tabla="SOLCOMPRA      " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHAVTOCAI                             " tabla="SOLCOMPRA      " campo="FVTOCAI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento C.A.I./C.A.E.                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="COTIZACION                              " tabla="SOLCOMPRA      " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="420" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="REMITO                                  " tabla="SOLCOMPRA      " campo="NROREMITO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Remito                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="A 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="SOLCOMPRA      " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="VUELTO                                  " tabla="SOLCOMPRA      " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MONEDACOMPROBANTE                       " tabla="SOLCOMPRA      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Moneda comprobante                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="FECHAVENCIMIENTO                        " tabla="SOLCOMPRA      " campo="FFCHVENC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="424" etiqueta="Vencimiento                                                                                                                                                     " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="LISTADEPRECIOS                          " tabla="SOLCOMPRA      " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferenteCompras                                                                                                                                                                                  " obligatorio="true" admitebusqueda="426" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TOTAL                                   " tabla="SOLCOMPRA      " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOMONTO1                           " tabla="SOLCOMPRA      " campo="RECMONTO1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto 1                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="RECARGOMONTO2                           " tabla="SOLCOMPRA      " campo="RECMONTO2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Recargo monto 2                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="CONDICIONPAGOPREFERENTE                 " tabla="SOLCOMPRA      " campo="CONDPAGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="MOTIVO                                  " tabla="SOLCOMPRA      " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TOTALIMPUESTOS                          " tabla="SOLCOMPRA      " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total impuestos                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="SOLCOMPRA      " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo sin impuestos                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TOTALRECARGOS                           " tabla="SOLCOMPRA      " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SOLICITUDDECOMPRA                       " atributo="TOTALDESCUENTOS                         " tabla="SOLCOMPRA      " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuento                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On SOLCOMPRA.FPERSON = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On SOLCOMPRA.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On SOLCOMPRA.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="431" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On SOLCOMPRA.CONDPAGO = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="433" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On SOLCOMPRA.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="ARTICULO                                " tabla="SOLCOMPRADET   " campo="FART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleArtículos, Artículo                                                                                                                                      " dominio="CONSOPORTEPREPANTALLA         " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="ARTICULODETALLE                         " tabla="SOLCOMPRADET   " campo="FTXT      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleArtículos, Artículo descripción                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="COLOR                                   " tabla="SOLCOMPRADET   " campo="FCOLO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleArtículos, Color                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="COLORDETALLE                            " tabla="SOLCOMPRADET   " campo="FCOTXT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleArtículos, Descripción del color                                                                                                                         " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="TALLE                                   " tabla="SOLCOMPRADET   " campo="FTALL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleArtículos, Talle                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="CANTIDAD                                " tabla="SOLCOMPRADET   " campo="FCANT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleArtículos, Cantidad                                                                                                                                      " dominio="NUMERICODECIMALPARAMETRIZADOCO" detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="PRECIO                                  " tabla="SOLCOMPRADET   " campo="FPRECIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleArtículos, Precio                                                                                                                                        " dominio="PRECIONONEGATIVOPARAMETROFOCO " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="DESCUENTO                               " tabla="SOLCOMPRADET   " campo="FCFI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="DetalleArtículos, % Descuento                                                                                                                                   " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="MONTODESCUENTO                          " tabla="SOLCOMPRADET   " campo="MNTDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleArtículos, Monto descuento                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSSOLCOMPRA                  " atributo="MONTO                                   " tabla="SOLCOMPRADET   " campo="FMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleArtículos, Monto                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SOLCOMPRADET On SOLCOMPRA.CODIGO = SOLCOMPRADET.CODIGO And  SOLCOMPRA.CODIGO != '' AND SOLCOMPRA.FACTTIPO = 39                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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