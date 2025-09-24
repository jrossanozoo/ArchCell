
define class Din_EntidadPEDIDODECOMPRAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PEDIDODECOMPRA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0)]
	cTagClaveCandidata = '_PCOCC'
	cTagClavePk = '_PCOPK'
	cTablaPrincipal = 'PEDCOMPRA'
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
			local  lxPedcompraFmodifw, lxPedcompraFaltafw, lxPedcompraFecimpo, lxPedcompraFd2, lxPedcompraFecexpo, lxPedcompraFectrans, lxPedcompraFcuit, lxPedcompraIdcaja, lxPedcompraFpodes1, lxPedcompraFpodes2, lxPedcompraFpodes, lxPedcompraFturno, lxPedcompraTimestamp, lxPedcompraDesmntosi1, lxPedcompraFptoven, lxPedcompraDesmntosi2, lxPedcompraTotalcant, lxPedcompraDesmntosi, lxPedcompraSignomov, lxPedcompraFacttipo, lxPedcompraFsubtot, lxPedcompraRecmntosi2, lxPedcompraSitfiscpro, lxPedcompraCondivalp, lxPedcompraFsubton, lxPedcompraRecmntosi1, lxPedcompraRecmnto2, lxPedcompraRecmnto1, lxPedcompraSubtotsisi, lxPedcompraRecmntosi, lxPedcompraSubtotcisi, lxPedcompraFcompfis, lxPedcompraDesauto, lxPedcompraAnulado, lxPedcompraDescfw, lxPedcompraFhora, lxPedcompraHoraimpo, lxPedcompraHaltafw, lxPedcompraHoraexpo, lxPedcompraHmodifw, lxPedcompraUaltafw, lxPedcompraUmodifw, lxPedcompraVmodifw, lxPedcompraZadsfw, lxPedcompraSaltafw, lxPedcompraSmodifw, lxPedcompraValtafw, lxPedcompraBdaltafw, lxPedcompraBdmodifw, lxPedcompraEsttrans, lxPedcompraSimbmon, lxPedcompraTcrg1361, lxPedcompraIdvuelto, lxPedcompraCodigo, lxPedcompraMoneda, lxPedcompraMonsis, lxPedcompraFmtdes1, lxPedcompraFmtdes2, lxPedcompraFdescu, lxPedcompraFletra, lxPedcompraNumint, lxPedcompraFimpuesto, lxPedcompraFobs, lxPedcompraFfch, lxPedcompraFfchfac, lxPedcompraFptovenext, lxPedcompraDesmntosi3, lxPedcompraFmtdes3, lxPedcompraFfchentr, lxPedcompraRecpor, lxPedcompraFnumcomp, lxPedcompraTotdescsi, lxPedcompraMr, lxPedcompraNcai, lxPedcompraRecmnto, lxPedcompraFperson, lxPedcompraMotivo, lxPedcompraFvtocai, lxPedcompraFvuelto, lxPedcompraNroremito, lxPedcompraFtransp, lxPedcompraCodlista, lxPedcompraCondpago, lxPedcompraFtotal, lxPedcompraCotiz, lxPedcompraRecmonto2, lxPedcompraRecmonto1, lxPedcompraTotimpue, lxPedcompraTotrecar, lxPedcompraTotrecarsi, lxPedcompraTotdesc
				lxPedcompraFmodifw =  .Fechamodificacionfw			lxPedcompraFaltafw =  .Fechaaltafw			lxPedcompraFecimpo =  .Fechaimpo			lxPedcompraFd2 =  .Fechamodificacion			lxPedcompraFecexpo =  .Fechaexpo			lxPedcompraFectrans =  .Fechatransferencia			lxPedcompraFcuit =  .Cuit			lxPedcompraIdcaja =  .Caja_PK 			lxPedcompraFpodes1 =  .Porcentajedescuento1			lxPedcompraFpodes2 =  .Porcentajedescuento2			lxPedcompraFpodes =  .Porcentajedescuento			lxPedcompraFturno =  .Turno			lxPedcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPedcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxPedcompraFptoven =  .Puntodeventa			lxPedcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxPedcompraTotalcant =  .Totalcantidad			lxPedcompraDesmntosi =  .Montodescuentosinimpuestos			lxPedcompraSignomov =  .Signodemovimiento			lxPedcompraFacttipo =  .Tipocomprobante			lxPedcompraFsubtot =  .Subtotalbruto			lxPedcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxPedcompraSitfiscpro =  .Situacionfiscal_PK 			lxPedcompraCondivalp =  .Condicioniva			lxPedcompraFsubton =  .Subtotalneto			lxPedcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxPedcompraRecmnto2 =  .Recargomontoconimpuestos2			lxPedcompraRecmnto1 =  .Recargomontoconimpuestos1			lxPedcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxPedcompraRecmntosi =  .Recargomontosinimpuestos			lxPedcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxPedcompraFcompfis =  .Comprobantefiscal			lxPedcompraDesauto =  .Descuentoautomatico			lxPedcompraAnulado =  .Anulado			lxPedcompraDescfw =  .Descripcionfw			lxPedcompraFhora =  .Hora			lxPedcompraHoraimpo =  .Horaimpo			lxPedcompraHaltafw =  .Horaaltafw			lxPedcompraHoraexpo =  .Horaexpo			lxPedcompraHmodifw =  .Horamodificacionfw			lxPedcompraUaltafw =  .Usuarioaltafw			lxPedcompraUmodifw =  .Usuariomodificacionfw			lxPedcompraVmodifw =  .Versionmodificacionfw			lxPedcompraZadsfw =  .Zadsfw			lxPedcompraSaltafw =  .Seriealtafw			lxPedcompraSmodifw =  .Seriemodificacionfw			lxPedcompraValtafw =  .Versionaltafw			lxPedcompraBdaltafw =  .Basededatosaltafw			lxPedcompraBdmodifw =  .Basededatosmodificacionfw			lxPedcompraEsttrans =  .Estadotransferencia			lxPedcompraSimbmon =  .Simbolomonetariocomprobante			lxPedcompraTcrg1361 =  .Tipocomprobanterg1361			lxPedcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxPedcompraCodigo =  .Codigo			lxPedcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxPedcompraMonsis =  upper( .MonedaSistema_PK ) 			lxPedcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxPedcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxPedcompraFdescu =  .Descuento			lxPedcompraFletra =  .Letra			lxPedcompraNumint =  .Numint			lxPedcompraFimpuesto =  .Impuestos			lxPedcompraFobs =  .Obs			lxPedcompraFfch =  .Fecha			lxPedcompraFfchfac =  .Fechafactura			lxPedcompraFptovenext =  .Puntodeventaextendido			lxPedcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxPedcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxPedcompraFfchentr =  .Fechaentrega			lxPedcompraRecpor =  .Recargoporcentaje			lxPedcompraFnumcomp =  .Numero			lxPedcompraTotdescsi =  .Totaldescuentossinimpuestos			lxPedcompraMr =  .Recargomonto			lxPedcompraNcai =  .Cai			lxPedcompraRecmnto =  .Recargomontoconimpuestos			lxPedcompraFperson =  upper( .Proveedor_PK ) 			lxPedcompraMotivo =  upper( .Motivo_PK ) 			lxPedcompraFvtocai =  .Fechavtocai			lxPedcompraFvuelto =  .Vuelto			lxPedcompraNroremito =  .Remito			lxPedcompraFtransp =  upper( .Transportista_PK ) 			lxPedcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxPedcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxPedcompraFtotal =  .Total			lxPedcompraCotiz =  .Cotizacion			lxPedcompraRecmonto2 =  .Recargomonto2			lxPedcompraRecmonto1 =  .Recargomonto1			lxPedcompraTotimpue =  .Totalimpuestos			lxPedcompraTotrecar =  .Totalrecargos			lxPedcompraTotrecarsi =  .Totalrecargossinimpuestos			lxPedcompraTotdesc =  .Totaldescuentos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxPedcompraCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PEDCOMPRA ( "Fmodifw","Faltafw","Fecimpo","Fd2","Fecexpo","Fectrans","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fturno","Timestamp","Desmntosi1","Fptoven","Desmntosi2","Totalcant","Desmntosi","Signomov","Facttipo","Fsubtot","Recmntosi2","Sitfiscpro","Condivalp","Fsubton","Recmntosi1","Recmnto2","Recmnto1","Subtotsisi","Recmntosi","Subtotcisi","Fcompfis","Desauto","Anulado","Descfw","Fhora","Horaimpo","Haltafw","Horaexpo","Hmodifw","Ualtafw","Umodifw","Vmodifw","Zadsfw","Saltafw","Smodifw","Valtafw","Bdaltafw","Bdmodifw","Esttrans","Simbmon","Tcrg1361","Idvuelto","Codigo","Moneda","Monsis","Fmtdes1","Fmtdes2","Fdescu","Fletra","Numint","Fimpuesto","Fobs","Ffch","Ffchfac","Fptovenext","Desmntosi3","Fmtdes3","Ffchentr","Recpor","Fnumcomp","Totdescsi","Mr","Ncai","Recmnto","Fperson","Motivo","Fvtocai","Fvuelto","Nroremito","Ftransp","Codlista","Condpago","Ftotal","Cotiz","Recmonto2","Recmonto1","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxPedcompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraFcuit ) + "'" >>, <<lxPedcompraIdcaja >>, <<lxPedcompraFpodes1 >>, <<lxPedcompraFpodes2 >>, <<lxPedcompraFpodes >>, <<lxPedcompraFturno >>, <<lxPedcompraTimestamp >>, <<lxPedcompraDesmntosi1 >>, <<lxPedcompraFptoven >>, <<lxPedcompraDesmntosi2 >>, <<lxPedcompraTotalcant >>, <<lxPedcompraDesmntosi >>, <<lxPedcompraSignomov >>, <<lxPedcompraFacttipo >>, <<lxPedcompraFsubtot >>, <<lxPedcompraRecmntosi2 >>, <<lxPedcompraSitfiscpro >>, <<lxPedcompraCondivalp >>, <<lxPedcompraFsubton >>, <<lxPedcompraRecmntosi1 >>, <<lxPedcompraRecmnto2 >>, <<lxPedcompraRecmnto1 >>, <<lxPedcompraSubtotsisi >>, <<lxPedcompraRecmntosi >>, <<lxPedcompraSubtotcisi >>, <<iif( lxPedcompraFcompfis, 1, 0 ) >>, <<iif( lxPedcompraDesauto, 1, 0 ) >>, <<iif( lxPedcompraAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPedcompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraSimbmon ) + "'" >>, <<lxPedcompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxPedcompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraMonsis ) + "'" >>, <<lxPedcompraFmtdes1 >>, <<lxPedcompraFmtdes2 >>, <<lxPedcompraFdescu >>, <<"'" + this.FormatearTextoSql( lxPedcompraFletra ) + "'" >>, <<lxPedcompraNumint >>, <<lxPedcompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxPedcompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFfch ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFfchfac ) + "'" >>, <<lxPedcompraFptovenext >>, <<lxPedcompraDesmntosi3 >>, <<lxPedcompraFmtdes3 >>, <<"'" + this.ConvertirDateSql( lxPedcompraFfchentr ) + "'" >>, <<lxPedcompraRecpor >>, <<lxPedcompraFnumcomp >>, <<lxPedcompraTotdescsi >>, <<lxPedcompraMr >>, <<lxPedcompraNcai >>, <<lxPedcompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxPedcompraFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraMotivo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFvtocai ) + "'" >>, <<lxPedcompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxPedcompraNroremito ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraFtransp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraCondpago ) + "'" >>, <<lxPedcompraFtotal >>, <<lxPedcompraCotiz >>, <<lxPedcompraRecmonto2 >>, <<lxPedcompraRecmonto1 >>, <<lxPedcompraTotimpue >>, <<lxPedcompraTotrecar >>, <<lxPedcompraTotrecarsi >>, <<lxPedcompraTotdesc >> )
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
						Insert into ZooLogic.PedCompraDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxOferta>>, <<lxAfe_nroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxIditem>>, <<lxPorcentajeiva>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpPedComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
						Insert into ZooLogic.ImpPedC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxPedcompraTimestamp
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
				lcError  = this.oEntidad.ObtenerMensajeClaveCandidataExistente()
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
			local  lxPedcompraFmodifw, lxPedcompraFaltafw, lxPedcompraFecimpo, lxPedcompraFd2, lxPedcompraFecexpo, lxPedcompraFectrans, lxPedcompraFcuit, lxPedcompraIdcaja, lxPedcompraFpodes1, lxPedcompraFpodes2, lxPedcompraFpodes, lxPedcompraFturno, lxPedcompraTimestamp, lxPedcompraDesmntosi1, lxPedcompraFptoven, lxPedcompraDesmntosi2, lxPedcompraTotalcant, lxPedcompraDesmntosi, lxPedcompraSignomov, lxPedcompraFacttipo, lxPedcompraFsubtot, lxPedcompraRecmntosi2, lxPedcompraSitfiscpro, lxPedcompraCondivalp, lxPedcompraFsubton, lxPedcompraRecmntosi1, lxPedcompraRecmnto2, lxPedcompraRecmnto1, lxPedcompraSubtotsisi, lxPedcompraRecmntosi, lxPedcompraSubtotcisi, lxPedcompraFcompfis, lxPedcompraDesauto, lxPedcompraAnulado, lxPedcompraDescfw, lxPedcompraFhora, lxPedcompraHoraimpo, lxPedcompraHaltafw, lxPedcompraHoraexpo, lxPedcompraHmodifw, lxPedcompraUaltafw, lxPedcompraUmodifw, lxPedcompraVmodifw, lxPedcompraZadsfw, lxPedcompraSaltafw, lxPedcompraSmodifw, lxPedcompraValtafw, lxPedcompraBdaltafw, lxPedcompraBdmodifw, lxPedcompraEsttrans, lxPedcompraSimbmon, lxPedcompraTcrg1361, lxPedcompraIdvuelto, lxPedcompraCodigo, lxPedcompraMoneda, lxPedcompraMonsis, lxPedcompraFmtdes1, lxPedcompraFmtdes2, lxPedcompraFdescu, lxPedcompraFletra, lxPedcompraNumint, lxPedcompraFimpuesto, lxPedcompraFobs, lxPedcompraFfch, lxPedcompraFfchfac, lxPedcompraFptovenext, lxPedcompraDesmntosi3, lxPedcompraFmtdes3, lxPedcompraFfchentr, lxPedcompraRecpor, lxPedcompraFnumcomp, lxPedcompraTotdescsi, lxPedcompraMr, lxPedcompraNcai, lxPedcompraRecmnto, lxPedcompraFperson, lxPedcompraMotivo, lxPedcompraFvtocai, lxPedcompraFvuelto, lxPedcompraNroremito, lxPedcompraFtransp, lxPedcompraCodlista, lxPedcompraCondpago, lxPedcompraFtotal, lxPedcompraCotiz, lxPedcompraRecmonto2, lxPedcompraRecmonto1, lxPedcompraTotimpue, lxPedcompraTotrecar, lxPedcompraTotrecarsi, lxPedcompraTotdesc
				lxPedcompraFmodifw =  .Fechamodificacionfw			lxPedcompraFaltafw =  .Fechaaltafw			lxPedcompraFecimpo =  .Fechaimpo			lxPedcompraFd2 =  .Fechamodificacion			lxPedcompraFecexpo =  .Fechaexpo			lxPedcompraFectrans =  .Fechatransferencia			lxPedcompraFcuit =  .Cuit			lxPedcompraIdcaja =  .Caja_PK 			lxPedcompraFpodes1 =  .Porcentajedescuento1			lxPedcompraFpodes2 =  .Porcentajedescuento2			lxPedcompraFpodes =  .Porcentajedescuento			lxPedcompraFturno =  .Turno			lxPedcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPedcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxPedcompraFptoven =  .Puntodeventa			lxPedcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxPedcompraTotalcant =  .Totalcantidad			lxPedcompraDesmntosi =  .Montodescuentosinimpuestos			lxPedcompraSignomov =  .Signodemovimiento			lxPedcompraFacttipo =  .Tipocomprobante			lxPedcompraFsubtot =  .Subtotalbruto			lxPedcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxPedcompraSitfiscpro =  .Situacionfiscal_PK 			lxPedcompraCondivalp =  .Condicioniva			lxPedcompraFsubton =  .Subtotalneto			lxPedcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxPedcompraRecmnto2 =  .Recargomontoconimpuestos2			lxPedcompraRecmnto1 =  .Recargomontoconimpuestos1			lxPedcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxPedcompraRecmntosi =  .Recargomontosinimpuestos			lxPedcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxPedcompraFcompfis =  .Comprobantefiscal			lxPedcompraDesauto =  .Descuentoautomatico			lxPedcompraAnulado =  .Anulado			lxPedcompraDescfw =  .Descripcionfw			lxPedcompraFhora =  .Hora			lxPedcompraHoraimpo =  .Horaimpo			lxPedcompraHaltafw =  .Horaaltafw			lxPedcompraHoraexpo =  .Horaexpo			lxPedcompraHmodifw =  .Horamodificacionfw			lxPedcompraUaltafw =  .Usuarioaltafw			lxPedcompraUmodifw =  .Usuariomodificacionfw			lxPedcompraVmodifw =  .Versionmodificacionfw			lxPedcompraZadsfw =  .Zadsfw			lxPedcompraSaltafw =  .Seriealtafw			lxPedcompraSmodifw =  .Seriemodificacionfw			lxPedcompraValtafw =  .Versionaltafw			lxPedcompraBdaltafw =  .Basededatosaltafw			lxPedcompraBdmodifw =  .Basededatosmodificacionfw			lxPedcompraEsttrans =  .Estadotransferencia			lxPedcompraSimbmon =  .Simbolomonetariocomprobante			lxPedcompraTcrg1361 =  .Tipocomprobanterg1361			lxPedcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxPedcompraCodigo =  .Codigo			lxPedcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxPedcompraMonsis =  upper( .MonedaSistema_PK ) 			lxPedcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxPedcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxPedcompraFdescu =  .Descuento			lxPedcompraFletra =  .Letra			lxPedcompraNumint =  .Numint			lxPedcompraFimpuesto =  .Impuestos			lxPedcompraFobs =  .Obs			lxPedcompraFfch =  .Fecha			lxPedcompraFfchfac =  .Fechafactura			lxPedcompraFptovenext =  .Puntodeventaextendido			lxPedcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxPedcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxPedcompraFfchentr =  .Fechaentrega			lxPedcompraRecpor =  .Recargoporcentaje			lxPedcompraFnumcomp =  .Numero			lxPedcompraTotdescsi =  .Totaldescuentossinimpuestos			lxPedcompraMr =  .Recargomonto			lxPedcompraNcai =  .Cai			lxPedcompraRecmnto =  .Recargomontoconimpuestos			lxPedcompraFperson =  upper( .Proveedor_PK ) 			lxPedcompraMotivo =  upper( .Motivo_PK ) 			lxPedcompraFvtocai =  .Fechavtocai			lxPedcompraFvuelto =  .Vuelto			lxPedcompraNroremito =  .Remito			lxPedcompraFtransp =  upper( .Transportista_PK ) 			lxPedcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxPedcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxPedcompraFtotal =  .Total			lxPedcompraCotiz =  .Cotizacion			lxPedcompraRecmonto2 =  .Recargomonto2			lxPedcompraRecmonto1 =  .Recargomonto1			lxPedcompraTotimpue =  .Totalimpuestos			lxPedcompraTotrecar =  .Totalrecargos			lxPedcompraTotrecarsi =  .Totalrecargossinimpuestos			lxPedcompraTotdesc =  .Totaldescuentos
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
				update ZooLogic.PEDCOMPRA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPedcompraFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxPedcompraFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxPedcompraFecimpo ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxPedcompraFd2 ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxPedcompraFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxPedcompraFectrans ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxPedcompraFcuit ) + "'">>,"Idcaja" = <<lxPedcompraIdcaja>>,"Fpodes1" = <<lxPedcompraFpodes1>>,"Fpodes2" = <<lxPedcompraFpodes2>>,"Fpodes" = <<lxPedcompraFpodes>>,"Fturno" = <<lxPedcompraFturno>>,"Timestamp" = <<lxPedcompraTimestamp>>,"Desmntosi1" = <<lxPedcompraDesmntosi1>>,"Fptoven" = <<lxPedcompraFptoven>>,"Desmntosi2" = <<lxPedcompraDesmntosi2>>,"Totalcant" = <<lxPedcompraTotalcant>>,"Desmntosi" = <<lxPedcompraDesmntosi>>,"Signomov" = <<lxPedcompraSignomov>>,"Facttipo" = <<lxPedcompraFacttipo>>,"Fsubtot" = <<lxPedcompraFsubtot>>,"Recmntosi2" = <<lxPedcompraRecmntosi2>>,"Sitfiscpro" = <<lxPedcompraSitfiscpro>>,"Condivalp" = <<lxPedcompraCondivalp>>,"Fsubton" = <<lxPedcompraFsubton>>,"Recmntosi1" = <<lxPedcompraRecmntosi1>>,"Recmnto2" = <<lxPedcompraRecmnto2>>,"Recmnto1" = <<lxPedcompraRecmnto1>>,"Subtotsisi" = <<lxPedcompraSubtotsisi>>,"Recmntosi" = <<lxPedcompraRecmntosi>>,"Subtotcisi" = <<lxPedcompraSubtotcisi>>,"Fcompfis" = <<iif( lxPedcompraFcompfis, 1, 0 )>>,"Desauto" = <<iif( lxPedcompraDesauto, 1, 0 )>>,"Anulado" = <<iif( lxPedcompraAnulado, 1, 0 )>>,"Descfw" = <<"'" + this.FormatearTextoSql( lxPedcompraDescfw ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxPedcompraFhora ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxPedcompraHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxPedcompraHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxPedcompraHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxPedcompraUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxPedcompraZadsfw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxPedcompraSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraSmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxPedcompraValtafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPedcompraBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxPedcompraEsttrans ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxPedcompraSimbmon ) + "'">>,"Tcrg1361" = <<lxPedcompraTcrg1361>>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxPedcompraIdvuelto ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxPedcompraCodigo ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxPedcompraMoneda ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxPedcompraMonsis ) + "'">>,"Fmtdes1" = <<lxPedcompraFmtdes1>>,"Fmtdes2" = <<lxPedcompraFmtdes2>>,"Fdescu" = <<lxPedcompraFdescu>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxPedcompraFletra ) + "'">>,"Numint" = <<lxPedcompraNumint>>,"Fimpuesto" = <<lxPedcompraFimpuesto>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxPedcompraFobs ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxPedcompraFfch ) + "'">>,"Ffchfac" = <<"'" + this.ConvertirDateSql( lxPedcompraFfchfac ) + "'">>,"Fptovenext" = <<lxPedcompraFptovenext>>,"Desmntosi3" = <<lxPedcompraDesmntosi3>>,"Fmtdes3" = <<lxPedcompraFmtdes3>>,"Ffchentr" = <<"'" + this.ConvertirDateSql( lxPedcompraFfchentr ) + "'">>,"Recpor" = <<lxPedcompraRecpor>>,"Fnumcomp" = <<lxPedcompraFnumcomp>>,"Totdescsi" = <<lxPedcompraTotdescsi>>,"Mr" = <<lxPedcompraMr>>,"Ncai" = <<lxPedcompraNcai>>,"Recmnto" = <<lxPedcompraRecmnto>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxPedcompraFperson ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxPedcompraMotivo ) + "'">>,"Fvtocai" = <<"'" + this.ConvertirDateSql( lxPedcompraFvtocai ) + "'">>,"Fvuelto" = <<lxPedcompraFvuelto>>,"Nroremito" = <<"'" + this.FormatearTextoSql( lxPedcompraNroremito ) + "'">>,"Ftransp" = <<"'" + this.FormatearTextoSql( lxPedcompraFtransp ) + "'">>,"Codlista" = <<"'" + this.FormatearTextoSql( lxPedcompraCodlista ) + "'">>,"Condpago" = <<"'" + this.FormatearTextoSql( lxPedcompraCondpago ) + "'">>,"Ftotal" = <<lxPedcompraFtotal>>,"Cotiz" = <<lxPedcompraCotiz>>,"Recmonto2" = <<lxPedcompraRecmonto2>>,"Recmonto1" = <<lxPedcompraRecmonto1>>,"Totimpue" = <<lxPedcompraTotimpue>>,"Totrecar" = <<lxPedcompraTotrecar>>,"Totrecarsi" = <<lxPedcompraTotrecarsi>>,"Totdesc" = <<lxPedcompraTotdesc>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxPedcompraCodigo ) + "'">> and  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PedCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpPedComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpPedC where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
						Insert into ZooLogic.PedCompraDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxOferta>>, <<lxAfe_nroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxIditem>>, <<lxPorcentajeiva>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpPedComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
						Insert into ZooLogic.ImpPedC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxPedcompraTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.PEDCOMPRA where " + this.ConvertirFuncionesSql( " PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38" ) )
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
			Local lxPedcompraCodigo
			lxPedcompraCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Desmntosi" as "Montodescuentosinimpuestos", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Recmntosi2" as "Recargomontosinimpuestos2", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Simbmon" as "Simbolomonetariocomprobante", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fdescu" as "Descuento", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Ffchentr" as "Fechaentrega", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Motivo" as "Motivo", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Ftransp" as "Transportista", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PEDCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxPedcompraCodigo ) + "'">> and  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38
			endtext
			use in select('c_PEDIDODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PEDIDODECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_PEDIDODECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.PedCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPedComp where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPedC where cCod = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			Local lxPedCompraFACTTIPO As Variant, lxPedCompraFLETRA As Variant, lxPedCompraFPTOVEN As Variant, lxPedCompraFNUMCOMP As Variant
			lxPedCompraFACTTIPO = .TipoComprobante
			lxPedCompraFLETRA = .Letra
			lxPedCompraFPTOVEN = .PuntoDeVenta
			lxPedCompraFNUMCOMP = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Desmntosi" as "Montodescuentosinimpuestos", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Recmntosi2" as "Recargomontosinimpuestos2", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Simbmon" as "Simbolomonetariocomprobante", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fdescu" as "Descuento", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Ffchentr" as "Fechaentrega", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Motivo" as "Motivo", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Ftransp" as "Transportista", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PEDCOMPRA where  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38 And FACTTIPO = <<lxPedCompraFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxPedCompraFLETRA ) + "'">> and FPTOVEN = <<lxPedCompraFPTOVEN>> and FNUMCOMP = <<lxPedCompraFNUMCOMP>>
			endtext
			use in select('c_PEDIDODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PEDIDODECOMPRA', set( 'Datasession' ) )
			if reccount( 'c_PEDIDODECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.PedCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPedComp where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPedC where cCod = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxPedcompraCodigo as Variant
		llRetorno = .t.
		lxPedcompraCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PEDCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxPedcompraCodigo ) + "'">> and  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Desmntosi" as "Montodescuentosinimpuestos", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Recmntosi2" as "Recargomontosinimpuestos2", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Simbmon" as "Simbolomonetariocomprobante", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fdescu" as "Descuento", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Ffchentr" as "Fechaentrega", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Motivo" as "Motivo", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Ftransp" as "Transportista", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PEDCOMPRA where  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP
			endtext
			use in select('c_PEDIDODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PEDIDODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.PedCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPedComp where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPedC where cCod = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Desmntosi" as "Montodescuentosinimpuestos", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Recmntosi2" as "Recargomontosinimpuestos2", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Simbmon" as "Simbolomonetariocomprobante", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fdescu" as "Descuento", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Ffchentr" as "Fechaentrega", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Motivo" as "Motivo", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Ftransp" as "Transportista", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PEDCOMPRA where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP
			endtext
			use in select('c_PEDIDODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PEDIDODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.PedCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPedComp where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPedC where cCod = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Desmntosi" as "Montodescuentosinimpuestos", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Recmntosi2" as "Recargomontosinimpuestos2", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Simbmon" as "Simbolomonetariocomprobante", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fdescu" as "Descuento", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Ffchentr" as "Fechaentrega", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Motivo" as "Motivo", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Ftransp" as "Transportista", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PEDCOMPRA where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc
			endtext
			use in select('c_PEDIDODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PEDIDODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.PedCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPedComp where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPedC where cCod = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Desmntosi" as "Montodescuentosinimpuestos", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Recmntosi2" as "Recargomontosinimpuestos2", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Simbmon" as "Simbolomonetariocomprobante", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fdescu" as "Descuento", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Ffchentr" as "Fechaentrega", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Motivo" as "Motivo", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Ftransp" as "Transportista", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.PEDCOMPRA where  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc
			endtext
			use in select('c_PEDIDODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PEDIDODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Fart" as "Articulo", "Afets" as "Afe_timestamp", "Afecant" as "Afe_cantidad", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntptot" as "Montoprorrateototal", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Mndesci" as "Montodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fx2" as "Oferta", "Afenroitem" as "Afe_nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Ciditem" as "Iditem", "Fporiva" as "Porcentajeiva", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Iditemorig" as "Idorigen", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Afe_cod" as "Afe_codigo", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.PedCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpPedComp where Codigo = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpPedC where cCod = <<"'" + this.FormatearTextoSql( c_PEDIDODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Faltafw,Fecimpo,Fd2,Fecexpo,Fectrans,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fturno,Time" + ;
"stamp,Desmntosi1,Fptoven,Desmntosi2,Totalcant,Desmntosi,Signomov,Facttipo,Fsubtot,Recmntosi2,Sitfisc" + ;
"pro,Condivalp,Fsubton,Recmntosi1,Recmnto2,Recmnto1,Subtotsisi,Recmntosi,Subtotcisi,Fcompfis,Desauto," + ;
"Anulado,Descfw,Fhora,Horaimpo,Haltafw,Horaexpo,Hmodifw,Ualtafw,Umodifw,Vmodifw,Zadsfw,Saltafw,Smodif" + ;
"w,Valtafw,Bdaltafw,Bdmodifw,Esttrans,Simbmon,Tcrg1361,Idvuelto,Codigo,Moneda,Monsis,Fmtdes1,Fmtdes2," + ;
"Fdescu,Fletra,Numint,Fimpuesto,Fobs,Ffch,Ffchfac,Fptovenext,Desmntosi3,Fmtdes3,Ffchentr,Recpor,Fnumc" + ;
"omp,Totdescsi,Mr,Ncai,Recmnto,Fperson,Motivo,Fvtocai,Fvuelto,Nroremito,Ftransp,Codlista,Condpago,Fto" + ;
"tal,Cotiz,Recmonto2,Recmonto1,Totimpue,Totrecar,Totrecarsi,Totdesc" + ;
" from ZooLogic.PEDCOMPRA where  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38 and " + lcFiltro )
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
			local  lxPedcompraFmodifw, lxPedcompraFaltafw, lxPedcompraFecimpo, lxPedcompraFd2, lxPedcompraFecexpo, lxPedcompraFectrans, lxPedcompraFcuit, lxPedcompraIdcaja, lxPedcompraFpodes1, lxPedcompraFpodes2, lxPedcompraFpodes, lxPedcompraFturno, lxPedcompraTimestamp, lxPedcompraDesmntosi1, lxPedcompraFptoven, lxPedcompraDesmntosi2, lxPedcompraTotalcant, lxPedcompraDesmntosi, lxPedcompraSignomov, lxPedcompraFacttipo, lxPedcompraFsubtot, lxPedcompraRecmntosi2, lxPedcompraSitfiscpro, lxPedcompraCondivalp, lxPedcompraFsubton, lxPedcompraRecmntosi1, lxPedcompraRecmnto2, lxPedcompraRecmnto1, lxPedcompraSubtotsisi, lxPedcompraRecmntosi, lxPedcompraSubtotcisi, lxPedcompraFcompfis, lxPedcompraDesauto, lxPedcompraAnulado, lxPedcompraDescfw, lxPedcompraFhora, lxPedcompraHoraimpo, lxPedcompraHaltafw, lxPedcompraHoraexpo, lxPedcompraHmodifw, lxPedcompraUaltafw, lxPedcompraUmodifw, lxPedcompraVmodifw, lxPedcompraZadsfw, lxPedcompraSaltafw, lxPedcompraSmodifw, lxPedcompraValtafw, lxPedcompraBdaltafw, lxPedcompraBdmodifw, lxPedcompraEsttrans, lxPedcompraSimbmon, lxPedcompraTcrg1361, lxPedcompraIdvuelto, lxPedcompraCodigo, lxPedcompraMoneda, lxPedcompraMonsis, lxPedcompraFmtdes1, lxPedcompraFmtdes2, lxPedcompraFdescu, lxPedcompraFletra, lxPedcompraNumint, lxPedcompraFimpuesto, lxPedcompraFobs, lxPedcompraFfch, lxPedcompraFfchfac, lxPedcompraFptovenext, lxPedcompraDesmntosi3, lxPedcompraFmtdes3, lxPedcompraFfchentr, lxPedcompraRecpor, lxPedcompraFnumcomp, lxPedcompraTotdescsi, lxPedcompraMr, lxPedcompraNcai, lxPedcompraRecmnto, lxPedcompraFperson, lxPedcompraMotivo, lxPedcompraFvtocai, lxPedcompraFvuelto, lxPedcompraNroremito, lxPedcompraFtransp, lxPedcompraCodlista, lxPedcompraCondpago, lxPedcompraFtotal, lxPedcompraCotiz, lxPedcompraRecmonto2, lxPedcompraRecmonto1, lxPedcompraTotimpue, lxPedcompraTotrecar, lxPedcompraTotrecarsi, lxPedcompraTotdesc
				lxPedcompraFmodifw = ctod( '  /  /    ' )			lxPedcompraFaltafw = ctod( '  /  /    ' )			lxPedcompraFecimpo = ctod( '  /  /    ' )			lxPedcompraFd2 = ctod( '  /  /    ' )			lxPedcompraFecexpo = ctod( '  /  /    ' )			lxPedcompraFectrans = ctod( '  /  /    ' )			lxPedcompraFcuit = []			lxPedcompraIdcaja = 0			lxPedcompraFpodes1 = 0			lxPedcompraFpodes2 = 0			lxPedcompraFpodes = 0			lxPedcompraFturno = 0			lxPedcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPedcompraDesmntosi1 = 0			lxPedcompraFptoven = 0			lxPedcompraDesmntosi2 = 0			lxPedcompraTotalcant = 0			lxPedcompraDesmntosi = 0			lxPedcompraSignomov = 0			lxPedcompraFacttipo = 0			lxPedcompraFsubtot = 0			lxPedcompraRecmntosi2 = 0			lxPedcompraSitfiscpro = 0			lxPedcompraCondivalp = 0			lxPedcompraFsubton = 0			lxPedcompraRecmntosi1 = 0			lxPedcompraRecmnto2 = 0			lxPedcompraRecmnto1 = 0			lxPedcompraSubtotsisi = 0			lxPedcompraRecmntosi = 0			lxPedcompraSubtotcisi = 0			lxPedcompraFcompfis = .F.			lxPedcompraDesauto = .F.			lxPedcompraAnulado = .F.			lxPedcompraDescfw = []			lxPedcompraFhora = []			lxPedcompraHoraimpo = []			lxPedcompraHaltafw = []			lxPedcompraHoraexpo = []			lxPedcompraHmodifw = []			lxPedcompraUaltafw = []			lxPedcompraUmodifw = []			lxPedcompraVmodifw = []			lxPedcompraZadsfw = []			lxPedcompraSaltafw = []			lxPedcompraSmodifw = []			lxPedcompraValtafw = []			lxPedcompraBdaltafw = []			lxPedcompraBdmodifw = []			lxPedcompraEsttrans = []			lxPedcompraSimbmon = []			lxPedcompraTcrg1361 = 0			lxPedcompraIdvuelto = []			lxPedcompraCodigo = []			lxPedcompraMoneda = []			lxPedcompraMonsis = []			lxPedcompraFmtdes1 = 0			lxPedcompraFmtdes2 = 0			lxPedcompraFdescu = 0			lxPedcompraFletra = []			lxPedcompraNumint = 0			lxPedcompraFimpuesto = 0			lxPedcompraFobs = []			lxPedcompraFfch = ctod( '  /  /    ' )			lxPedcompraFfchfac = ctod( '  /  /    ' )			lxPedcompraFptovenext = 0			lxPedcompraDesmntosi3 = 0			lxPedcompraFmtdes3 = 0			lxPedcompraFfchentr = ctod( '  /  /    ' )			lxPedcompraRecpor = 0			lxPedcompraFnumcomp = 0			lxPedcompraTotdescsi = 0			lxPedcompraMr = 0			lxPedcompraNcai = 0			lxPedcompraRecmnto = 0			lxPedcompraFperson = []			lxPedcompraMotivo = []			lxPedcompraFvtocai = ctod( '  /  /    ' )			lxPedcompraFvuelto = 0			lxPedcompraNroremito = []			lxPedcompraFtransp = []			lxPedcompraCodlista = []			lxPedcompraCondpago = []			lxPedcompraFtotal = 0			lxPedcompraCotiz = 0			lxPedcompraRecmonto2 = 0			lxPedcompraRecmonto1 = 0			lxPedcompraTotimpue = 0			lxPedcompraTotrecar = 0			lxPedcompraTotrecarsi = 0			lxPedcompraTotdesc = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PedCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpPedComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpPedC where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PEDCOMPRA where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PEDCOMPRA' + '_' + tcCampo
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
		lcWhere = " Where  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Desmntosi" as "Montodescuentosinimpuestos", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Recmntosi2" as "Recargomontosinimpuestos2", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Simbmon" as "Simbolomonetariocomprobante", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fdescu" as "Descuento", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Ffchentr" as "Fechaentrega", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Motivo" as "Motivo", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Ftransp" as "Transportista", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PEDCOMPRA', '', tnTope )
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
		lcWhere = " Where  PEDCOMPRADET.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PedCompraDet', 'FacturaDetalle', tnTope )
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
		lcWhere = " Where  IMPPEDCOMP.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpPedComp', 'ImpuestosDetalle', tnTope )
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
		lcWhere = " Where  IMPPEDC.CCOD != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpPedC', 'ImpuestosComprobante', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
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
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCPRO AS SITUACIONFISCAL'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUTO AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
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
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'NUMINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINT AS NUMINT'
				Case lcAtributo == 'IMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FIMPUESTO AS IMPUESTOS'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'FECHAFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHFAC AS FECHAFACTURA'
				Case lcAtributo == 'PUNTODEVENTAEXTENDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVENEXT AS PUNTODEVENTAEXTENDIDO'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'FECHAENTREGA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHENTR AS FECHAENTREGA'
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
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO AS RECARGOMONTOCONIMPUESTOS'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS PROVEEDOR'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'FECHAVTOCAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVTOCAI AS FECHAVTOCAI'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREMITO AS REMITO'
				Case lcAtributo == 'TRANSPORTISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTRANSP AS TRANSPORTISTA'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCPRO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
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
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMINT'
				lcCampo = 'NUMINT'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOS'
				lcCampo = 'FIMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAFACTURA'
				lcCampo = 'FFCHFAC'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAEXTENDIDO'
				lcCampo = 'FPTOVENEXT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAENTREGA'
				lcCampo = 'FFCHENTR'
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
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS'
				lcCampo = 'RECMNTO'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOCAI'
				lcCampo = 'FVTOCAI'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'NROREMITO'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTA'
				lcCampo = 'FTRANSP'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
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
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'FACTURADETALLE'
			lcRetorno = 'PEDCOMPRADET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPPEDCOMP'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPPEDC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxPedcompraFmodifw, lxPedcompraFaltafw, lxPedcompraFecimpo, lxPedcompraFd2, lxPedcompraFecexpo, lxPedcompraFectrans, lxPedcompraFcuit, lxPedcompraIdcaja, lxPedcompraFpodes1, lxPedcompraFpodes2, lxPedcompraFpodes, lxPedcompraFturno, lxPedcompraTimestamp, lxPedcompraDesmntosi1, lxPedcompraFptoven, lxPedcompraDesmntosi2, lxPedcompraTotalcant, lxPedcompraDesmntosi, lxPedcompraSignomov, lxPedcompraFacttipo, lxPedcompraFsubtot, lxPedcompraRecmntosi2, lxPedcompraSitfiscpro, lxPedcompraCondivalp, lxPedcompraFsubton, lxPedcompraRecmntosi1, lxPedcompraRecmnto2, lxPedcompraRecmnto1, lxPedcompraSubtotsisi, lxPedcompraRecmntosi, lxPedcompraSubtotcisi, lxPedcompraFcompfis, lxPedcompraDesauto, lxPedcompraAnulado, lxPedcompraDescfw, lxPedcompraFhora, lxPedcompraHoraimpo, lxPedcompraHaltafw, lxPedcompraHoraexpo, lxPedcompraHmodifw, lxPedcompraUaltafw, lxPedcompraUmodifw, lxPedcompraVmodifw, lxPedcompraZadsfw, lxPedcompraSaltafw, lxPedcompraSmodifw, lxPedcompraValtafw, lxPedcompraBdaltafw, lxPedcompraBdmodifw, lxPedcompraEsttrans, lxPedcompraSimbmon, lxPedcompraTcrg1361, lxPedcompraIdvuelto, lxPedcompraCodigo, lxPedcompraMoneda, lxPedcompraMonsis, lxPedcompraFmtdes1, lxPedcompraFmtdes2, lxPedcompraFdescu, lxPedcompraFletra, lxPedcompraNumint, lxPedcompraFimpuesto, lxPedcompraFobs, lxPedcompraFfch, lxPedcompraFfchfac, lxPedcompraFptovenext, lxPedcompraDesmntosi3, lxPedcompraFmtdes3, lxPedcompraFfchentr, lxPedcompraRecpor, lxPedcompraFnumcomp, lxPedcompraTotdescsi, lxPedcompraMr, lxPedcompraNcai, lxPedcompraRecmnto, lxPedcompraFperson, lxPedcompraMotivo, lxPedcompraFvtocai, lxPedcompraFvuelto, lxPedcompraNroremito, lxPedcompraFtransp, lxPedcompraCodlista, lxPedcompraCondpago, lxPedcompraFtotal, lxPedcompraCotiz, lxPedcompraRecmonto2, lxPedcompraRecmonto1, lxPedcompraTotimpue, lxPedcompraTotrecar, lxPedcompraTotrecarsi, lxPedcompraTotdesc
				lxPedcompraFmodifw =  .Fechamodificacionfw			lxPedcompraFaltafw =  .Fechaaltafw			lxPedcompraFecimpo =  .Fechaimpo			lxPedcompraFd2 =  .Fechamodificacion			lxPedcompraFecexpo =  .Fechaexpo			lxPedcompraFectrans =  .Fechatransferencia			lxPedcompraFcuit =  .Cuit			lxPedcompraIdcaja =  .Caja_PK 			lxPedcompraFpodes1 =  .Porcentajedescuento1			lxPedcompraFpodes2 =  .Porcentajedescuento2			lxPedcompraFpodes =  .Porcentajedescuento			lxPedcompraFturno =  .Turno			lxPedcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPedcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxPedcompraFptoven =  .Puntodeventa			lxPedcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxPedcompraTotalcant =  .Totalcantidad			lxPedcompraDesmntosi =  .Montodescuentosinimpuestos			lxPedcompraSignomov =  .Signodemovimiento			lxPedcompraFacttipo =  .Tipocomprobante			lxPedcompraFsubtot =  .Subtotalbruto			lxPedcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxPedcompraSitfiscpro =  .Situacionfiscal_PK 			lxPedcompraCondivalp =  .Condicioniva			lxPedcompraFsubton =  .Subtotalneto			lxPedcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxPedcompraRecmnto2 =  .Recargomontoconimpuestos2			lxPedcompraRecmnto1 =  .Recargomontoconimpuestos1			lxPedcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxPedcompraRecmntosi =  .Recargomontosinimpuestos			lxPedcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxPedcompraFcompfis =  .Comprobantefiscal			lxPedcompraDesauto =  .Descuentoautomatico			lxPedcompraAnulado =  .Anulado			lxPedcompraDescfw =  .Descripcionfw			lxPedcompraFhora =  .Hora			lxPedcompraHoraimpo =  .Horaimpo			lxPedcompraHaltafw =  .Horaaltafw			lxPedcompraHoraexpo =  .Horaexpo			lxPedcompraHmodifw =  .Horamodificacionfw			lxPedcompraUaltafw =  .Usuarioaltafw			lxPedcompraUmodifw =  .Usuariomodificacionfw			lxPedcompraVmodifw =  .Versionmodificacionfw			lxPedcompraZadsfw =  .Zadsfw			lxPedcompraSaltafw =  .Seriealtafw			lxPedcompraSmodifw =  .Seriemodificacionfw			lxPedcompraValtafw =  .Versionaltafw			lxPedcompraBdaltafw =  .Basededatosaltafw			lxPedcompraBdmodifw =  .Basededatosmodificacionfw			lxPedcompraEsttrans =  .Estadotransferencia			lxPedcompraSimbmon =  .Simbolomonetariocomprobante			lxPedcompraTcrg1361 =  .Tipocomprobanterg1361			lxPedcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxPedcompraCodigo =  .Codigo			lxPedcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxPedcompraMonsis =  upper( .MonedaSistema_PK ) 			lxPedcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxPedcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxPedcompraFdescu =  .Descuento			lxPedcompraFletra =  .Letra			lxPedcompraNumint =  .Numint			lxPedcompraFimpuesto =  .Impuestos			lxPedcompraFobs =  .Obs			lxPedcompraFfch =  .Fecha			lxPedcompraFfchfac =  .Fechafactura			lxPedcompraFptovenext =  .Puntodeventaextendido			lxPedcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxPedcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxPedcompraFfchentr =  .Fechaentrega			lxPedcompraRecpor =  .Recargoporcentaje			lxPedcompraFnumcomp =  .Numero			lxPedcompraTotdescsi =  .Totaldescuentossinimpuestos			lxPedcompraMr =  .Recargomonto			lxPedcompraNcai =  .Cai			lxPedcompraRecmnto =  .Recargomontoconimpuestos			lxPedcompraFperson =  upper( .Proveedor_PK ) 			lxPedcompraMotivo =  upper( .Motivo_PK ) 			lxPedcompraFvtocai =  .Fechavtocai			lxPedcompraFvuelto =  .Vuelto			lxPedcompraNroremito =  .Remito			lxPedcompraFtransp =  upper( .Transportista_PK ) 			lxPedcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxPedcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxPedcompraFtotal =  .Total			lxPedcompraCotiz =  .Cotizacion			lxPedcompraRecmonto2 =  .Recargomonto2			lxPedcompraRecmonto1 =  .Recargomonto1			lxPedcompraTotimpue =  .Totalimpuestos			lxPedcompraTotrecar =  .Totalrecargos			lxPedcompraTotrecarsi =  .Totalrecargossinimpuestos			lxPedcompraTotdesc =  .Totaldescuentos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PEDCOMPRA ( "Fmodifw","Faltafw","Fecimpo","Fd2","Fecexpo","Fectrans","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fturno","Timestamp","Desmntosi1","Fptoven","Desmntosi2","Totalcant","Desmntosi","Signomov","Facttipo","Fsubtot","Recmntosi2","Sitfiscpro","Condivalp","Fsubton","Recmntosi1","Recmnto2","Recmnto1","Subtotsisi","Recmntosi","Subtotcisi","Fcompfis","Desauto","Anulado","Descfw","Fhora","Horaimpo","Haltafw","Horaexpo","Hmodifw","Ualtafw","Umodifw","Vmodifw","Zadsfw","Saltafw","Smodifw","Valtafw","Bdaltafw","Bdmodifw","Esttrans","Simbmon","Tcrg1361","Idvuelto","Codigo","Moneda","Monsis","Fmtdes1","Fmtdes2","Fdescu","Fletra","Numint","Fimpuesto","Fobs","Ffch","Ffchfac","Fptovenext","Desmntosi3","Fmtdes3","Ffchentr","Recpor","Fnumcomp","Totdescsi","Mr","Ncai","Recmnto","Fperson","Motivo","Fvtocai","Fvuelto","Nroremito","Ftransp","Codlista","Condpago","Ftotal","Cotiz","Recmonto2","Recmonto1","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxPedcompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraFcuit ) + "'" >>, <<lxPedcompraIdcaja >>, <<lxPedcompraFpodes1 >>, <<lxPedcompraFpodes2 >>, <<lxPedcompraFpodes >>, <<lxPedcompraFturno >>, <<lxPedcompraTimestamp >>, <<lxPedcompraDesmntosi1 >>, <<lxPedcompraFptoven >>, <<lxPedcompraDesmntosi2 >>, <<lxPedcompraTotalcant >>, <<lxPedcompraDesmntosi >>, <<lxPedcompraSignomov >>, <<lxPedcompraFacttipo >>, <<lxPedcompraFsubtot >>, <<lxPedcompraRecmntosi2 >>, <<lxPedcompraSitfiscpro >>, <<lxPedcompraCondivalp >>, <<lxPedcompraFsubton >>, <<lxPedcompraRecmntosi1 >>, <<lxPedcompraRecmnto2 >>, <<lxPedcompraRecmnto1 >>, <<lxPedcompraSubtotsisi >>, <<lxPedcompraRecmntosi >>, <<lxPedcompraSubtotcisi >>, <<iif( lxPedcompraFcompfis, 1, 0 ) >>, <<iif( lxPedcompraDesauto, 1, 0 ) >>, <<iif( lxPedcompraAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPedcompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraSimbmon ) + "'" >>, <<lxPedcompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxPedcompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraMonsis ) + "'" >>, <<lxPedcompraFmtdes1 >>, <<lxPedcompraFmtdes2 >>, <<lxPedcompraFdescu >>, <<"'" + this.FormatearTextoSql( lxPedcompraFletra ) + "'" >>, <<lxPedcompraNumint >>, <<lxPedcompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxPedcompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFfch ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFfchfac ) + "'" >>, <<lxPedcompraFptovenext >>, <<lxPedcompraDesmntosi3 >>, <<lxPedcompraFmtdes3 >>, <<"'" + this.ConvertirDateSql( lxPedcompraFfchentr ) + "'" >>, <<lxPedcompraRecpor >>, <<lxPedcompraFnumcomp >>, <<lxPedcompraTotdescsi >>, <<lxPedcompraMr >>, <<lxPedcompraNcai >>, <<lxPedcompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxPedcompraFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraMotivo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPedcompraFvtocai ) + "'" >>, <<lxPedcompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxPedcompraNroremito ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraFtransp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPedcompraCondpago ) + "'" >>, <<lxPedcompraFtotal >>, <<lxPedcompraCotiz >>, <<lxPedcompraRecmonto2 >>, <<lxPedcompraRecmonto1 >>, <<lxPedcompraTotimpue >>, <<lxPedcompraTotrecar >>, <<lxPedcompraTotrecarsi >>, <<lxPedcompraTotdesc >> )
		endtext
		loColeccion.cTabla = 'PEDCOMPRA' 
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
						Insert into ZooLogic.PedCompraDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxOferta>>, <<lxAfe_nroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxIditem>>, <<lxPorcentajeiva>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpPedComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
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
						Insert into ZooLogic.ImpPedC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxPedcompraFmodifw, lxPedcompraFaltafw, lxPedcompraFecimpo, lxPedcompraFd2, lxPedcompraFecexpo, lxPedcompraFectrans, lxPedcompraFcuit, lxPedcompraIdcaja, lxPedcompraFpodes1, lxPedcompraFpodes2, lxPedcompraFpodes, lxPedcompraFturno, lxPedcompraTimestamp, lxPedcompraDesmntosi1, lxPedcompraFptoven, lxPedcompraDesmntosi2, lxPedcompraTotalcant, lxPedcompraDesmntosi, lxPedcompraSignomov, lxPedcompraFacttipo, lxPedcompraFsubtot, lxPedcompraRecmntosi2, lxPedcompraSitfiscpro, lxPedcompraCondivalp, lxPedcompraFsubton, lxPedcompraRecmntosi1, lxPedcompraRecmnto2, lxPedcompraRecmnto1, lxPedcompraSubtotsisi, lxPedcompraRecmntosi, lxPedcompraSubtotcisi, lxPedcompraFcompfis, lxPedcompraDesauto, lxPedcompraAnulado, lxPedcompraDescfw, lxPedcompraFhora, lxPedcompraHoraimpo, lxPedcompraHaltafw, lxPedcompraHoraexpo, lxPedcompraHmodifw, lxPedcompraUaltafw, lxPedcompraUmodifw, lxPedcompraVmodifw, lxPedcompraZadsfw, lxPedcompraSaltafw, lxPedcompraSmodifw, lxPedcompraValtafw, lxPedcompraBdaltafw, lxPedcompraBdmodifw, lxPedcompraEsttrans, lxPedcompraSimbmon, lxPedcompraTcrg1361, lxPedcompraIdvuelto, lxPedcompraCodigo, lxPedcompraMoneda, lxPedcompraMonsis, lxPedcompraFmtdes1, lxPedcompraFmtdes2, lxPedcompraFdescu, lxPedcompraFletra, lxPedcompraNumint, lxPedcompraFimpuesto, lxPedcompraFobs, lxPedcompraFfch, lxPedcompraFfchfac, lxPedcompraFptovenext, lxPedcompraDesmntosi3, lxPedcompraFmtdes3, lxPedcompraFfchentr, lxPedcompraRecpor, lxPedcompraFnumcomp, lxPedcompraTotdescsi, lxPedcompraMr, lxPedcompraNcai, lxPedcompraRecmnto, lxPedcompraFperson, lxPedcompraMotivo, lxPedcompraFvtocai, lxPedcompraFvuelto, lxPedcompraNroremito, lxPedcompraFtransp, lxPedcompraCodlista, lxPedcompraCondpago, lxPedcompraFtotal, lxPedcompraCotiz, lxPedcompraRecmonto2, lxPedcompraRecmonto1, lxPedcompraTotimpue, lxPedcompraTotrecar, lxPedcompraTotrecarsi, lxPedcompraTotdesc
				lxPedcompraFmodifw =  .Fechamodificacionfw			lxPedcompraFaltafw =  .Fechaaltafw			lxPedcompraFecimpo =  .Fechaimpo			lxPedcompraFd2 =  .Fechamodificacion			lxPedcompraFecexpo =  .Fechaexpo			lxPedcompraFectrans =  .Fechatransferencia			lxPedcompraFcuit =  .Cuit			lxPedcompraIdcaja =  .Caja_PK 			lxPedcompraFpodes1 =  .Porcentajedescuento1			lxPedcompraFpodes2 =  .Porcentajedescuento2			lxPedcompraFpodes =  .Porcentajedescuento			lxPedcompraFturno =  .Turno			lxPedcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxPedcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxPedcompraFptoven =  .Puntodeventa			lxPedcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxPedcompraTotalcant =  .Totalcantidad			lxPedcompraDesmntosi =  .Montodescuentosinimpuestos			lxPedcompraSignomov =  .Signodemovimiento			lxPedcompraFacttipo =  .Tipocomprobante			lxPedcompraFsubtot =  .Subtotalbruto			lxPedcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxPedcompraSitfiscpro =  .Situacionfiscal_PK 			lxPedcompraCondivalp =  .Condicioniva			lxPedcompraFsubton =  .Subtotalneto			lxPedcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxPedcompraRecmnto2 =  .Recargomontoconimpuestos2			lxPedcompraRecmnto1 =  .Recargomontoconimpuestos1			lxPedcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxPedcompraRecmntosi =  .Recargomontosinimpuestos			lxPedcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxPedcompraFcompfis =  .Comprobantefiscal			lxPedcompraDesauto =  .Descuentoautomatico			lxPedcompraAnulado =  .Anulado			lxPedcompraDescfw =  .Descripcionfw			lxPedcompraFhora =  .Hora			lxPedcompraHoraimpo =  .Horaimpo			lxPedcompraHaltafw =  .Horaaltafw			lxPedcompraHoraexpo =  .Horaexpo			lxPedcompraHmodifw =  .Horamodificacionfw			lxPedcompraUaltafw =  .Usuarioaltafw			lxPedcompraUmodifw =  .Usuariomodificacionfw			lxPedcompraVmodifw =  .Versionmodificacionfw			lxPedcompraZadsfw =  .Zadsfw			lxPedcompraSaltafw =  .Seriealtafw			lxPedcompraSmodifw =  .Seriemodificacionfw			lxPedcompraValtafw =  .Versionaltafw			lxPedcompraBdaltafw =  .Basededatosaltafw			lxPedcompraBdmodifw =  .Basededatosmodificacionfw			lxPedcompraEsttrans =  .Estadotransferencia			lxPedcompraSimbmon =  .Simbolomonetariocomprobante			lxPedcompraTcrg1361 =  .Tipocomprobanterg1361			lxPedcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxPedcompraCodigo =  .Codigo			lxPedcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxPedcompraMonsis =  upper( .MonedaSistema_PK ) 			lxPedcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxPedcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxPedcompraFdescu =  .Descuento			lxPedcompraFletra =  .Letra			lxPedcompraNumint =  .Numint			lxPedcompraFimpuesto =  .Impuestos			lxPedcompraFobs =  .Obs			lxPedcompraFfch =  .Fecha			lxPedcompraFfchfac =  .Fechafactura			lxPedcompraFptovenext =  .Puntodeventaextendido			lxPedcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxPedcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxPedcompraFfchentr =  .Fechaentrega			lxPedcompraRecpor =  .Recargoporcentaje			lxPedcompraFnumcomp =  .Numero			lxPedcompraTotdescsi =  .Totaldescuentossinimpuestos			lxPedcompraMr =  .Recargomonto			lxPedcompraNcai =  .Cai			lxPedcompraRecmnto =  .Recargomontoconimpuestos			lxPedcompraFperson =  upper( .Proveedor_PK ) 			lxPedcompraMotivo =  upper( .Motivo_PK ) 			lxPedcompraFvtocai =  .Fechavtocai			lxPedcompraFvuelto =  .Vuelto			lxPedcompraNroremito =  .Remito			lxPedcompraFtransp =  upper( .Transportista_PK ) 			lxPedcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxPedcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxPedcompraFtotal =  .Total			lxPedcompraCotiz =  .Cotizacion			lxPedcompraRecmonto2 =  .Recargomonto2			lxPedcompraRecmonto1 =  .Recargomonto1			lxPedcompraTotimpue =  .Totalimpuestos			lxPedcompraTotrecar =  .Totalrecargos			lxPedcompraTotrecarsi =  .Totalrecargossinimpuestos			lxPedcompraTotdesc =  .Totaldescuentos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38]
			text to lcSentencia noshow textmerge
				update ZooLogic.PEDCOMPRA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPedcompraFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxPedcompraFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPedcompraFecimpo ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxPedcompraFd2 ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPedcompraFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxPedcompraFectrans ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxPedcompraFcuit ) + "'">>, "Idcaja" = <<lxPedcompraIdcaja>>, "Fpodes1" = <<lxPedcompraFpodes1>>, "Fpodes2" = <<lxPedcompraFpodes2>>, "Fpodes" = <<lxPedcompraFpodes>>, "Fturno" = <<lxPedcompraFturno>>, "Timestamp" = <<lxPedcompraTimestamp>>, "Desmntosi1" = <<lxPedcompraDesmntosi1>>, "Fptoven" = <<lxPedcompraFptoven>>, "Desmntosi2" = <<lxPedcompraDesmntosi2>>, "Totalcant" = <<lxPedcompraTotalcant>>, "Desmntosi" = <<lxPedcompraDesmntosi>>, "Signomov" = <<lxPedcompraSignomov>>, "Facttipo" = <<lxPedcompraFacttipo>>, "Fsubtot" = <<lxPedcompraFsubtot>>, "Recmntosi2" = <<lxPedcompraRecmntosi2>>, "Sitfiscpro" = <<lxPedcompraSitfiscpro>>, "Condivalp" = <<lxPedcompraCondivalp>>, "Fsubton" = <<lxPedcompraFsubton>>, "Recmntosi1" = <<lxPedcompraRecmntosi1>>, "Recmnto2" = <<lxPedcompraRecmnto2>>, "Recmnto1" = <<lxPedcompraRecmnto1>>, "Subtotsisi" = <<lxPedcompraSubtotsisi>>, "Recmntosi" = <<lxPedcompraRecmntosi>>, "Subtotcisi" = <<lxPedcompraSubtotcisi>>, "Fcompfis" = <<iif( lxPedcompraFcompfis, 1, 0 )>>, "Desauto" = <<iif( lxPedcompraDesauto, 1, 0 )>>, "Anulado" = <<iif( lxPedcompraAnulado, 1, 0 )>>, "Descfw" = <<"'" + this.FormatearTextoSql( lxPedcompraDescfw ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxPedcompraFhora ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxPedcompraHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxPedcompraHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxPedcompraHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxPedcompraUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxPedcompraZadsfw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxPedcompraSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraSmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxPedcompraValtafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPedcompraBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPedcompraBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxPedcompraEsttrans ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxPedcompraSimbmon ) + "'">>, "Tcrg1361" = <<lxPedcompraTcrg1361>>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxPedcompraIdvuelto ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxPedcompraCodigo ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxPedcompraMoneda ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxPedcompraMonsis ) + "'">>, "Fmtdes1" = <<lxPedcompraFmtdes1>>, "Fmtdes2" = <<lxPedcompraFmtdes2>>, "Fdescu" = <<lxPedcompraFdescu>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxPedcompraFletra ) + "'">>, "Numint" = <<lxPedcompraNumint>>, "Fimpuesto" = <<lxPedcompraFimpuesto>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxPedcompraFobs ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxPedcompraFfch ) + "'">>, "Ffchfac" = <<"'" + this.ConvertirDateSql( lxPedcompraFfchfac ) + "'">>, "Fptovenext" = <<lxPedcompraFptovenext>>, "Desmntosi3" = <<lxPedcompraDesmntosi3>>, "Fmtdes3" = <<lxPedcompraFmtdes3>>, "Ffchentr" = <<"'" + this.ConvertirDateSql( lxPedcompraFfchentr ) + "'">>, "Recpor" = <<lxPedcompraRecpor>>, "Fnumcomp" = <<lxPedcompraFnumcomp>>, "Totdescsi" = <<lxPedcompraTotdescsi>>, "Mr" = <<lxPedcompraMr>>, "Ncai" = <<lxPedcompraNcai>>, "Recmnto" = <<lxPedcompraRecmnto>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxPedcompraFperson ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxPedcompraMotivo ) + "'">>, "Fvtocai" = <<"'" + this.ConvertirDateSql( lxPedcompraFvtocai ) + "'">>, "Fvuelto" = <<lxPedcompraFvuelto>>, "Nroremito" = <<"'" + this.FormatearTextoSql( lxPedcompraNroremito ) + "'">>, "Ftransp" = <<"'" + this.FormatearTextoSql( lxPedcompraFtransp ) + "'">>, "Codlista" = <<"'" + this.FormatearTextoSql( lxPedcompraCodlista ) + "'">>, "Condpago" = <<"'" + this.FormatearTextoSql( lxPedcompraCondpago ) + "'">>, "Ftotal" = <<lxPedcompraFtotal>>, "Cotiz" = <<lxPedcompraCotiz>>, "Recmonto2" = <<lxPedcompraRecmonto2>>, "Recmonto1" = <<lxPedcompraRecmonto1>>, "Totimpue" = <<lxPedcompraTotimpue>>, "Totrecar" = <<lxPedcompraTotrecar>>, "Totrecarsi" = <<lxPedcompraTotrecarsi>>, "Totdesc" = <<lxPedcompraTotdesc>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PEDCOMPRA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PedCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpPedComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpPedC where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
						Insert into ZooLogic.PedCompraDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxAfe_timestamp>>, <<lxAfe_cantidad>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateototal>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxMontodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxOferta>>, <<lxAfe_nroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxIditem>>, <<lxPorcentajeiva>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxIdorigen>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpPedComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
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
						Insert into ZooLogic.ImpPedC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38]
		loColeccion.Agregar( 'delete from ZooLogic.PEDCOMPRA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PedCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpPedComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpPedC where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'PEDCOMPRA' 
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
			
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.PEDCOMPRA set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PEDCOMPRA where  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PEDCOMPRA where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxPedCompraFPTOVEN as variant, lxPedCompraFACTTIPO as variant, lxPedCompraFLETRA as variant, lxPedCompraFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PEDIDODECOMPRA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PEDCOMPRA Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.PEDCOMPRA set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, SitFiscPro = ] + transform( &lcCursor..SitFiscPro )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, DesAuto = ] + Transform( iif( &lcCursor..DesAuto, 1, 0 ))+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, tcrg1361 = ] + transform( &lcCursor..tcrg1361 )+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, NumInt = ] + transform( &lcCursor..NumInt )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FFCHFAC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"+ [, FPTOVENEXT = ] + transform( &lcCursor..FPTOVENEXT )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, FFCHENTR = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHENTR ) + "'"+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, MR = ] + transform( &lcCursor..MR )+ [, NCAI = ] + transform( &lcCursor..NCAI )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, FVTOCAI = ] + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'"+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, NROREMITO = ] + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"+ [, FTransp = ] + "'" + this.FormatearTextoSql( &lcCursor..FTransp ) + "'"+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, CONDPAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, RecMonto2 = ] + transform( &lcCursor..RecMonto2 )+ [, RecMonto1 = ] + transform( &lcCursor..RecMonto1 )+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, totdesc = ] + transform( &lcCursor..totdesc ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.PEDCOMPRA Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FALTAFW, FECIMPO, FD2, FECEXPO, FECTRANS, fCuit, IdCaja, FPODES1, FPODES2, FPODES, FTurno, TIMESTAMP, DesMntoSI1, FPTOVEN, DesMntoSI2, TotalCant, DesMntoSI, signomov, FACTTIPO, FSubTOT, RecMntoSI2, SitFiscPro, CondivaLp, fSubToN, RecMntoSI1, RecMnto2, RecMnto1, SubTotSISI, RecMntoSI, SubTotCISI, FCOMPFIS, DesAuto, Anulado, DescFW, FHORA, HORAIMPO, HALTAFW, HORAEXPO, HMODIFW, UALTAFW, UMODIFW, VMODIFW, ZADSFW, SALTAFW, SMODIFW, VALTAFW, BDALTAFW, BDMODIFW, ESTTRANS, SimbMon, tcrg1361, idVuelto, CODIGO, Moneda, MonSis, FMTDES1, FMTDES2, fDescu, FLETRA, NumInt, fImpuesto, FObs, FFCH, FFCHFAC, FPTOVENEXT, DesMntoSI3, FMTDES3, FFCHENTR, RecPor, FNUMCOMP, totdescSI, MR, NCAI, RecMnto, FPerson, MOTIVO, FVTOCAI, FVuelto, NROREMITO, FTransp, CodLista, CONDPAGO, FTotal, Cotiz, RecMonto2, RecMonto1, totimpue, totrecar, totrecarSI, totdesc
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..FPODES1 ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..FTurno ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..TotalCant )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..DesMntoSI ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + transform( &lcCursor..SitFiscPro ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..RecMnto2 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecMnto1 ) + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..RecMntoSI ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..DesAuto, 1, 0 )) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + transform( &lcCursor..tcrg1361 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + transform( &lcCursor..FMTDES1 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FMTDES2 ) + ',' + transform( &lcCursor..fDescu ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..NumInt ) + ',' + transform( &lcCursor..fImpuesto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FPTOVENEXT ) + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + transform( &lcCursor..FMTDES3 ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHENTR ) + "'" + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..totdescSI ) + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..NCAI ) + ',' + transform( &lcCursor..RecMnto )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'" + ',' + transform( &lcCursor..FVuelto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FTransp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..RecMonto2 ) + ',' + transform( &lcCursor..RecMonto1 ) + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..totrecar ) + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..totdesc )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.PEDCOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PEDIDODECOMPRA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.PedCompraDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpPedComp Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpPedC Where cCod] + lcIn  )
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSPEDCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeNUMCOM","AfePTOVEN","AfeLETRA","FART","AfeTS","AfeCANT","MNTPRECCI","ACondIvaC","AfeSaldo","APorcIvaC","MNTPRECSI","MNTPTOT","AjuSImp","AjuCImp","COMP","FBruto","ArtPercep","MNDESCI","MNDESSI","MNTPDESSI","MNTPDESCI","MNTPPER","MNPDSI","AfeTipoCom","FNETO","FX2","AfeNroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporCFI","NroItem","FporDTO1","ciditem","fporIva","FN11","FPRUN","Prunsinimp","prunconimp","iditemOrig","ProcStock","UsarPLista","afe_Cod","IdItem","FAMate","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTDES","MNTPIVA","seniacance","FCANT","FPRECIO","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.PedCompraDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.ACondIvaC  ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.APorcIvaC  ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_Cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSPEDC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpPedComp ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOPEDCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpPedC ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.porcen     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSPEDCOMPRA',this.oEntidad.cPrefijoRecibir + 'PEDIDODECOMPRA')
		this.oEntidad.FacturaDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSPEDCOMPRA',this.oEntidad.cPrefijoRecibir + 'PEDIDODECOMPRA')
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSPEDCOMPRA', this.oEntidad.cPrefijoRecibir + 'PEDIDODECOMPRA')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..FLETRA     )
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
			Case  lcAlias == lcPrefijo + 'PEDIDODECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PEDIDODECOMPRA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PEDIDODECOMPRA_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSPEDCOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSPEDC'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOPEDCOMPRA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PedCompra')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PEDIDODECOMPRA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PEDIDODECOMPRA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PEDIDODECOMPRA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PEDIDODECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  FFCHFAC   
		* Validar ANTERIORES A 1/1/1753  FFCHENTR  
		* Validar ANTERIORES A 1/1/1753  FVTOCAI   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PedCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PedCompra
Create Table ZooLogic.TablaTrabajo_PedCompra ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fd2" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"fturno" numeric( 1, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"desmntosi1" numeric( 8, 2 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"desmntosi2" numeric( 8, 2 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"desmntosi" numeric( 8, 2 )  null, 
"signomov" numeric( 2, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"fsubtot" numeric( 8, 2 )  null, 
"recmntosi2" numeric( 8, 2 )  null, 
"sitfiscpro" numeric( 2, 0 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"fsubton" numeric( 8, 2 )  null, 
"recmntosi1" numeric( 8, 2 )  null, 
"recmnto2" numeric( 8, 2 )  null, 
"recmnto1" numeric( 8, 2 )  null, 
"subtotsisi" numeric( 10, 2 )  null, 
"recmntosi" numeric( 8, 2 )  null, 
"subtotcisi" numeric( 10, 2 )  null, 
"fcompfis" bit  null, 
"desauto" bit  null, 
"anulado" bit  null, 
"descfw" char( 200 )  null, 
"fhora" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"simbmon" char( 3 )  null, 
"tcrg1361" numeric( 1, 0 )  null, 
"idvuelto" char( 5 )  null, 
"codigo" char( 38 )  null, 
"moneda" char( 10 )  null, 
"monsis" char( 10 )  null, 
"fmtdes1" numeric( 8, 2 )  null, 
"fmtdes2" numeric( 8, 2 )  null, 
"fdescu" numeric( 8, 2 )  null, 
"fletra" char( 1 )  null, 
"numint" numeric( 10, 0 )  null, 
"fimpuesto" numeric( 8, 2 )  null, 
"fobs" varchar(max)  null, 
"ffch" datetime  null, 
"ffchfac" datetime  null, 
"fptovenext" numeric( 5, 0 )  null, 
"desmntosi3" numeric( 8, 2 )  null, 
"fmtdes3" numeric( 6, 2 )  null, 
"ffchentr" datetime  null, 
"recpor" numeric( 6, 2 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"totdescsi" numeric( 8, 2 )  null, 
"mr" numeric( 15, 2 )  null, 
"ncai" numeric( 14, 0 )  null, 
"recmnto" numeric( 8, 2 )  null, 
"fperson" char( 5 )  null, 
"motivo" char( 3 )  null, 
"fvtocai" datetime  null, 
"fvuelto" numeric( 8, 2 )  null, 
"nroremito" char( 15 )  null, 
"ftransp" char( 6 )  null, 
"codlista" char( 6 )  null, 
"condpago" char( 5 )  null, 
"ftotal" numeric( 16, 2 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"recmonto2" numeric( 15, 2 )  null, 
"recmonto1" numeric( 15, 2 )  null, 
"totimpue" numeric( 8, 2 )  null, 
"totrecar" numeric( 8, 2 )  null, 
"totrecarsi" numeric( 8, 2 )  null, 
"totdesc" numeric( 8, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PedCompra' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PedCompra' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PEDIDODECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('sitfiscpro','sitfiscpro')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('desauto','desauto')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('tcrg1361','tcrg1361')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('numint','numint')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('ffchfac','ffchfac')
			.AgregarMapeo('fptovenext','fptovenext')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('ffchentr','ffchentr')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('ncai','ncai')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('fvtocai','fvtocai')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('nroremito','nroremito')
			.AgregarMapeo('ftransp','ftransp')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('condpago','condpago')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('recmonto2','recmonto2')
			.AgregarMapeo('recmonto1','recmonto1')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('totdesc','totdesc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PedCompra'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.SITFISCPRO = isnull( d.SITFISCPRO, t.SITFISCPRO ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.DESAUTO = isnull( d.DESAUTO, t.DESAUTO ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.TCRG1361 = isnull( d.TCRG1361, t.TCRG1361 ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.NUMINT = isnull( d.NUMINT, t.NUMINT ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FFCHFAC = isnull( d.FFCHFAC, t.FFCHFAC ),t.FPTOVENEXT = isnull( d.FPTOVENEXT, t.FPTOVENEXT ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.FFCHENTR = isnull( d.FFCHENTR, t.FFCHENTR ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.MR = isnull( d.MR, t.MR ),t.NCAI = isnull( d.NCAI, t.NCAI ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.FVTOCAI = isnull( d.FVTOCAI, t.FVTOCAI ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.NROREMITO = isnull( d.NROREMITO, t.NROREMITO ),t.FTRANSP = isnull( d.FTRANSP, t.FTRANSP ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.RECMONTO2 = isnull( d.RECMONTO2, t.RECMONTO2 ),t.RECMONTO1 = isnull( d.RECMONTO1, t.RECMONTO1 ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC )
					from ZooLogic.PEDCOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.PEDCOMPRA(Fmodifw,Faltafw,Fecimpo,Fd2,Fecexpo,Fectrans,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fturno,Timestamp,Desmntosi1,Fptoven,Desmntosi2,Totalcant,Desmntosi,Signomov,Facttipo,Fsubtot,Recmntosi2,Sitfiscpro,Condivalp,Fsubton,Recmntosi1,Recmnto2,Recmnto1,Subtotsisi,Recmntosi,Subtotcisi,Fcompfis,Desauto,Anulado,Descfw,Fhora,Horaimpo,Haltafw,Horaexpo,Hmodifw,Ualtafw,Umodifw,Vmodifw,Zadsfw,Saltafw,Smodifw,Valtafw,Bdaltafw,Bdmodifw,Esttrans,Simbmon,Tcrg1361,Idvuelto,Codigo,Moneda,Monsis,Fmtdes1,Fmtdes2,Fdescu,Fletra,Numint,Fimpuesto,Fobs,Ffch,Ffchfac,Fptovenext,Desmntosi3,Fmtdes3,Ffchentr,Recpor,Fnumcomp,Totdescsi,Mr,Ncai,Recmnto,Fperson,Motivo,Fvtocai,Fvuelto,Nroremito,Ftransp,Codlista,Condpago,Ftotal,Cotiz,Recmonto2,Recmonto1,Totimpue,Totrecar,Totrecarsi,Totdesc)
					Select isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FD2,''),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FPODES1,0),isnull( d.FPODES2,0),isnull( d.FPODES,0),isnull( d.FTURNO,0),isnull( d.TIMESTAMP,0),isnull( d.DESMNTOSI1,0),isnull( d.FPTOVEN,0),isnull( d.DESMNTOSI2,0),isnull( d.TOTALCANT,0),isnull( d.DESMNTOSI,0),isnull( d.SIGNOMOV,0),isnull( d.FACTTIPO,0),isnull( d.FSUBTOT,0),isnull( d.RECMNTOSI2,0),isnull( d.SITFISCPRO,0),isnull( d.CONDIVALP,0),isnull( d.FSUBTON,0),isnull( d.RECMNTOSI1,0),isnull( d.RECMNTO2,0),isnull( d.RECMNTO1,0),isnull( d.SUBTOTSISI,0),isnull( d.RECMNTOSI,0),isnull( d.SUBTOTCISI,0),isnull( d.FCOMPFIS,0),isnull( d.DESAUTO,0),isnull( d.ANULADO,0),isnull( d.DESCFW,''),isnull( d.FHORA,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.VALTAFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.SIMBMON,''),isnull( d.TCRG1361,0),isnull( d.IDVUELTO,''),isnull( d.CODIGO,''),isnull( d.MONEDA,''),isnull( d.MONSIS,''),isnull( d.FMTDES1,0),isnull( d.FMTDES2,0),isnull( d.FDESCU,0),isnull( d.FLETRA,''),isnull( d.NUMINT,0),isnull( d.FIMPUESTO,0),isnull( d.FOBS,''),isnull( d.FFCH,''),isnull( d.FFCHFAC,''),isnull( d.FPTOVENEXT,0),isnull( d.DESMNTOSI3,0),isnull( d.FMTDES3,0),isnull( d.FFCHENTR,''),isnull( d.RECPOR,0),isnull( d.FNUMCOMP,0),isnull( d.TOTDESCSI,0),isnull( d.MR,0),isnull( d.NCAI,0),isnull( d.RECMNTO,0),isnull( d.FPERSON,''),isnull( d.MOTIVO,''),isnull( d.FVTOCAI,''),isnull( d.FVUELTO,0),isnull( d.NROREMITO,''),isnull( d.FTRANSP,''),isnull( d.CODLISTA,''),isnull( d.CONDPAGO,''),isnull( d.FTOTAL,0),isnull( d.COTIZ,0),isnull( d.RECMONTO2,0),isnull( d.RECMONTO1,0),isnull( d.TOTIMPUE,0),isnull( d.TOTRECAR,0),isnull( d.TOTRECARSI,0),isnull( d.TOTDESC,0)
						From deleted d left join ZooLogic.PEDCOMPRA pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.PEDCOMPRA cc 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.PEDCOMPRA t inner join deleted d 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.PEDCOMPRA t inner join deleted d 
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
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PEDCOMPRA_CompAfe
ON ZooLogic.TablaTrabajo_PEDCOMPRA_CompAfe
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
	function ObtenerTriggerDeleteImportacion_PedCompraDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PEDCOMPRA_PedCompraDet
ON ZooLogic.TablaTrabajo_PEDCOMPRA_PedCompraDet
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
from ZooLogic.PedCompraDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.PedCompraDet
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
From deleted d left join ZooLogic.PedCompraDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpPedComp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PEDCOMPRA_ImpPedComp
ON ZooLogic.TablaTrabajo_PEDCOMPRA_ImpPedComp
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
from ZooLogic.ImpPedComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpPedComp
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
From deleted d left join ZooLogic.ImpPedComp pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpPedC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_PEDCOMPRA_ImpPedC
ON ZooLogic.TablaTrabajo_PEDCOMPRA_ImpPedC
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
from ZooLogic.ImpPedC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpPedC
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
From deleted d left join ZooLogic.ImpPedC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PedCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PedCompra
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PEDIDODECOMPRA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_PEDIDODECOMPRA.Cuit, [] )
					.Caja_PK =  nvl( c_PEDIDODECOMPRA.Caja, 0 )
					.Porcentajedescuento1 = nvl( c_PEDIDODECOMPRA.Porcentajedescuento1, 0 )
					.Porcentajedescuento2 = nvl( c_PEDIDODECOMPRA.Porcentajedescuento2, 0 )
					.Porcentajedescuento = nvl( c_PEDIDODECOMPRA.Porcentajedescuento, 0 )
					.Turno = nvl( c_PEDIDODECOMPRA.Turno, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Timestamp = nvl( c_PEDIDODECOMPRA.Timestamp, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_PEDIDODECOMPRA.Montodescuentosinimpuestos1, 0 )
					.Puntodeventa = nvl( c_PEDIDODECOMPRA.Puntodeventa, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_PEDIDODECOMPRA.Montodescuentosinimpuestos2, 0 )
					.Totalcantidad = nvl( c_PEDIDODECOMPRA.Totalcantidad, 0 )
					.Montodescuentosinimpuestos = nvl( c_PEDIDODECOMPRA.Montodescuentosinimpuestos, 0 )
					.Signodemovimiento = nvl( c_PEDIDODECOMPRA.Signodemovimiento, 0 )
					.Tipocomprobante = nvl( c_PEDIDODECOMPRA.Tipocomprobante, 0 )
					.Subtotalbruto = nvl( c_PEDIDODECOMPRA.Subtotalbruto, 0 )
					.Recargomontosinimpuestos2 = nvl( c_PEDIDODECOMPRA.Recargomontosinimpuestos2, 0 )
					.Situacionfiscal_PK =  nvl( c_PEDIDODECOMPRA.Situacionfiscal, 0 )
					.Condicioniva = nvl( c_PEDIDODECOMPRA.Condicioniva, 0 )
					.Subtotalneto = nvl( c_PEDIDODECOMPRA.Subtotalneto, 0 )
					.Recargomontosinimpuestos1 = nvl( c_PEDIDODECOMPRA.Recargomontosinimpuestos1, 0 )
					.Recargomontoconimpuestos2 = nvl( c_PEDIDODECOMPRA.Recargomontoconimpuestos2, 0 )
					.Recargomontoconimpuestos1 = nvl( c_PEDIDODECOMPRA.Recargomontoconimpuestos1, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_PEDIDODECOMPRA.Subtotalsinimpuestossobreitems, 0 )
					.Recargomontosinimpuestos = nvl( c_PEDIDODECOMPRA.Recargomontosinimpuestos, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_PEDIDODECOMPRA.Subtotalconimpuestossobreitems, 0 )
					.Comprobantefiscal = nvl( c_PEDIDODECOMPRA.Comprobantefiscal, .F. )
					.Descuentoautomatico = nvl( c_PEDIDODECOMPRA.Descuentoautomatico, .F. )
					.Anulado = nvl( c_PEDIDODECOMPRA.Anulado, .F. )
					.Descripcionfw = nvl( c_PEDIDODECOMPRA.Descripcionfw, [] )
					.Hora = nvl( c_PEDIDODECOMPRA.Hora, [] )
					.Horaimpo = nvl( c_PEDIDODECOMPRA.Horaimpo, [] )
					.Horaaltafw = nvl( c_PEDIDODECOMPRA.Horaaltafw, [] )
					.Horaexpo = nvl( c_PEDIDODECOMPRA.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_PEDIDODECOMPRA.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_PEDIDODECOMPRA.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_PEDIDODECOMPRA.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_PEDIDODECOMPRA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriealtafw = nvl( c_PEDIDODECOMPRA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_PEDIDODECOMPRA.Seriemodificacionfw, [] )
					.Versionaltafw = nvl( c_PEDIDODECOMPRA.Versionaltafw, [] )
					.Basededatosaltafw = nvl( c_PEDIDODECOMPRA.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_PEDIDODECOMPRA.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_PEDIDODECOMPRA.Estadotransferencia, [] )
					.Simbolomonetariocomprobante = nvl( c_PEDIDODECOMPRA.Simbolomonetariocomprobante, [] )
					.Tipocomprobanterg1361 = nvl( c_PEDIDODECOMPRA.Tipocomprobanterg1361, 0 )
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Idvuelto_PK =  nvl( c_PEDIDODECOMPRA.Idvuelto, [] )
					.Codigo = nvl( c_PEDIDODECOMPRA.Codigo, [] )
					.Monedacomprobante_PK =  nvl( c_PEDIDODECOMPRA.Monedacomprobante, [] )
					.Monedasistema_PK =  nvl( c_PEDIDODECOMPRA.Monedasistema, [] )
					.Montodescuentoconimpuestos1 = nvl( c_PEDIDODECOMPRA.Montodescuentoconimpuestos1, 0 )
					.Montodescuentoconimpuestos2 = nvl( c_PEDIDODECOMPRA.Montodescuentoconimpuestos2, 0 )
					.Descuento = nvl( c_PEDIDODECOMPRA.Descuento, 0 )
					.Letra = nvl( c_PEDIDODECOMPRA.Letra, [] )
					.Numint = nvl( c_PEDIDODECOMPRA.Numint, 0 )
					.Impuestos = nvl( c_PEDIDODECOMPRA.Impuestos, 0 )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fecha, ctod( '  /  /    ' ) ) )
					.Fechafactura = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fechafactura, ctod( '  /  /    ' ) ) )
					.Puntodeventaextendido = nvl( c_PEDIDODECOMPRA.Puntodeventaextendido, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_PEDIDODECOMPRA.Montodescuentosinimpuestos3, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_PEDIDODECOMPRA.Montodescuentoconimpuestos3, 0 )
					.Fechaentrega = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fechaentrega, ctod( '  /  /    ' ) ) )
					.Recargoporcentaje = nvl( c_PEDIDODECOMPRA.Recargoporcentaje, 0 )
					.Numero = nvl( c_PEDIDODECOMPRA.Numero, 0 )
					.Totaldescuentossinimpuestos = nvl( c_PEDIDODECOMPRA.Totaldescuentossinimpuestos, 0 )
					.Recargomonto = nvl( c_PEDIDODECOMPRA.Recargomonto, 0 )
					.Cai = nvl( c_PEDIDODECOMPRA.Cai, 0 )
					.Recargomontoconimpuestos = nvl( c_PEDIDODECOMPRA.Recargomontoconimpuestos, 0 )
					.Proveedor_PK =  nvl( c_PEDIDODECOMPRA.Proveedor, [] )
					.Motivo_PK =  nvl( c_PEDIDODECOMPRA.Motivo, [] )
					.Fechavtocai = GoLibrerias.ObtenerFechaFormateada( nvl( c_PEDIDODECOMPRA.Fechavtocai, ctod( '  /  /    ' ) ) )
					.Vuelto = nvl( c_PEDIDODECOMPRA.Vuelto, 0 )
					.Remito = nvl( c_PEDIDODECOMPRA.Remito, [] )
					.Transportista_PK =  nvl( c_PEDIDODECOMPRA.Transportista, [] )
					.Listadeprecios_PK =  nvl( c_PEDIDODECOMPRA.Listadeprecios, [] )
					.Condicionpagopreferente_PK =  nvl( c_PEDIDODECOMPRA.Condicionpagopreferente, [] )
					.Total = nvl( c_PEDIDODECOMPRA.Total, 0 )
					.Cotizacion = nvl( c_PEDIDODECOMPRA.Cotizacion, 0 )
					.Recargomonto2 = nvl( c_PEDIDODECOMPRA.Recargomonto2, 0 )
					.Recargomonto1 = nvl( c_PEDIDODECOMPRA.Recargomonto1, 0 )
					.Totalimpuestos = nvl( c_PEDIDODECOMPRA.Totalimpuestos, 0 )
					.Totalrecargos = nvl( c_PEDIDODECOMPRA.Totalrecargos, 0 )
					.Totalrecargossinimpuestos = nvl( c_PEDIDODECOMPRA.Totalrecargossinimpuestos, 0 )
					.Totaldescuentos = nvl( c_PEDIDODECOMPRA.Totaldescuentos, 0 )
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
			lxRetorno = c_PEDIDODECOMPRA.CODIGO
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
				lcSentencia = "UPDATE ZooLogic.PedCompraDet"
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
		return c_PEDIDODECOMPRA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PEDCOMPRA' )
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
								from ZooLogic.PEDCOMPRA 
								Where   PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PEDCOMPRA", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi2" as "Montodescuentosinimpuestos2", "Totalcant" as "Totalcantidad", "Desmntosi" as "Montodescuentosinimpuestos", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Recmntosi2" as "Recargomontosinimpuestos2", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto2" as "Recargomontoconimpuestos2", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi" as "Recargomontosinimpuestos", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Simbmon" as "Simbolomonetariocomprobante", "Tcrg1361" as "Tipocomprobanterg1361", "Idvuelto" as "Idvuelto", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fdescu" as "Descuento", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Ffchentr" as "Fechaentrega", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Motivo" as "Motivo", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Ftransp" as "Transportista", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Cotiz" as "Cotizacion", "Recmonto2" as "Recargomonto2", "Recmonto1" as "Recargomonto1", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PEDCOMPRA 
								Where   PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38
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
	Tabla = 'PEDCOMPRA'
	Filtro = " PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PEDCOMPRA.CODIGO != '' AND PEDCOMPRA.FACTTIPO = 38"
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
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHAMODIFICACIONFW                     " tabla="PEDCOMPRA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHAALTAFW                             " tabla="PEDCOMPRA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHAIMPO                               " tabla="PEDCOMPRA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHAMODIFICACION                       " tabla="PEDCOMPRA      " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHAEXPO                               " tabla="PEDCOMPRA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHATRANSFERENCIA                      " tabla="PEDCOMPRA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="CUIT                                    " tabla="PEDCOMPRA      " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="proveedor.cuit                                                                                                                                                                                                                                                " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="CAJA                                    " tabla="PEDCOMPRA      " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="PORCENTAJEDESCUENTO1                    " tabla="PEDCOMPRA      " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="PORCENTAJEDESCUENTO2                    " tabla="PEDCOMPRA      " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="PORCENTAJEDESCUENTO                     " tabla="PEDCOMPRA      " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="% Descuento                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TURNO                                   " tabla="PEDCOMPRA      " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TIMESTAMP                               " tabla="PEDCOMPRA      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="PEDCOMPRA      " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="PUNTODEVENTA                            " tabla="PEDCOMPRA      " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Pto. de venta                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="PEDCOMPRA      " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TOTALCANTIDAD                           " tabla="PEDCOMPRA      " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total Cantidad                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="PEDCOMPRA      " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="SIGNODEMOVIMIENTO                       " tabla="PEDCOMPRA      " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TIPOCOMPROBANTE                         " tabla="PEDCOMPRA      " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=38                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="SUBTOTALBRUTO                           " tabla="PEDCOMPRA      " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="PEDCOMPRA      " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="SITUACIONFISCAL                         " tabla="PEDCOMPRA      " campo="SITFISCPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sit. Fis.                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="proveedor.SituacionFiscal                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="CONDICIONIVA                            " tabla="PEDCOMPRA      " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="SUBTOTALNETO                            " tabla="PEDCOMPRA      " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="PEDCOMPRA      " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="PEDCOMPRA      " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="PEDCOMPRA      " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="PEDCOMPRA      " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="PEDCOMPRA      " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="PEDCOMPRA      " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="COMPROBANTEFISCAL                       " tabla="PEDCOMPRA      " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="DESCUENTOAUTOMATICO                     " tabla="PEDCOMPRA      " campo="DESAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="ANULADO                                 " tabla="PEDCOMPRA      " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Está anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="DESCRIPCIONFW                           " tabla="PEDCOMPRA      " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="HORA                                    " tabla="PEDCOMPRA      " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="HORAIMPO                                " tabla="PEDCOMPRA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="HORAALTAFW                              " tabla="PEDCOMPRA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="HORAEXPO                                " tabla="PEDCOMPRA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="HORAMODIFICACIONFW                      " tabla="PEDCOMPRA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="USUARIOALTAFW                           " tabla="PEDCOMPRA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="USUARIOMODIFICACIONFW                   " tabla="PEDCOMPRA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="VERSIONMODIFICACIONFW                   " tabla="PEDCOMPRA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="ZADSFW                                  " tabla="PEDCOMPRA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="SERIEALTAFW                             " tabla="PEDCOMPRA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="SERIEMODIFICACIONFW                     " tabla="PEDCOMPRA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="VERSIONALTAFW                           " tabla="PEDCOMPRA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="BASEDEDATOSALTAFW                       " tabla="PEDCOMPRA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PEDCOMPRA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="ESTADOTRANSFERENCIA                     " tabla="PEDCOMPRA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="PEDCOMPRA      " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TIPOCOMPROBANTERG1361                   " tabla="PEDCOMPRA      " campo="TCRG1361  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo factura                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FACTURADETALLE                          " tabla="PEDCOMPRADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMARTICULOSPEDCOMPRA " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="IMPUESTOSDETALLE                        " tabla="IMPPEDCOMP     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOSPEDC      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="IDVUELTO                                " tabla="PEDCOMPRA      " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="CODIGO                                  " tabla="PEDCOMPRA      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Nro Interno                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MONEDACOMPROBANTE                       " tabla="PEDCOMPRA      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Moneda comprobante                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MONEDASISTEMA                           " tabla="PEDCOMPRA      " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="PEDCOMPRA      " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="PEDCOMPRA      " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="DESCUENTO                               " tabla="PEDCOMPRA      " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="% Descuento                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="LETRA                                   " tabla="PEDCOMPRA      " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="NUMINT                                  " tabla="PEDCOMPRA      " campo="NUMINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Nro. interno                                                                                                                                                    " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="IMPUESTOS                               " tabla="PEDCOMPRA      " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="I.V.A.                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPPEDC        " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOPEDCOMPRA  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="OBS                                     " tabla="PEDCOMPRA      " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHA                                   " tabla="PEDCOMPRA      " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="414" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHAFACTURA                            " tabla="PEDCOMPRA      " campo="FFCHFAC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Emisión                                                                                                                                                         " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="PUNTODEVENTAEXTENDIDO                   " tabla="PEDCOMPRA      " campo="FPTOVENEXT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="PEDCOMPRA      " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="PEDCOMPRA      " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHAENTREGA                            " tabla="PEDCOMPRA      " campo="FFCHENTR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="418" etiqueta="Fecha de entrega                                                                                                                                                " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOPORCENTAJE                       " tabla="PEDCOMPRA      " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="% Recargo                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="NUMERO                                  " tabla="PEDCOMPRA      " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="PEDCOMPRA      " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="14" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOMONTO                            " tabla="PEDCOMPRA      " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="% Recargo                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="CAI                                     " tabla="PEDCOMPRA      " campo="NCAI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="C.A.I./C.A.E.                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="PEDCOMPRA      " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="PROVEEDOR                               " tabla="PEDCOMPRA      " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="MOTIVO                                  " tabla="PEDCOMPRA      " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="FECHAVTOCAI                             " tabla="PEDCOMPRA      " campo="FVTOCAI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento C.A.I./C.A.E.                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="VUELTO                                  " tabla="PEDCOMPRA      " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="REMITO                                  " tabla="PEDCOMPRA      " campo="NROREMITO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Remito                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="A 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TRANSPORTISTA                           " tabla="PEDCOMPRA      " campo="FTRANSP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Transportista                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="LISTADEPRECIOS                          " tabla="PEDCOMPRA      " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferenteCompras                                                                                                                                                                                  " obligatorio="false" admitebusqueda="430" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="CONDICIONPAGOPREFERENTE                 " tabla="PEDCOMPRA      " campo="CONDPAGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TOTAL                                   " tabla="PEDCOMPRA      " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="COTIZACION                              " tabla="PEDCOMPRA      " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="434" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOMONTO2                           " tabla="PEDCOMPRA      " campo="RECMONTO2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="RECARGOMONTO1                           " tabla="PEDCOMPRA      " campo="RECMONTO1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TOTALIMPUESTOS                          " tabla="PEDCOMPRA      " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TOTALRECARGOS                           " tabla="PEDCOMPRA      " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="PEDCOMPRA      " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PEDIDODECOMPRA                          " atributo="TOTALDESCUENTOS                         " tabla="PEDCOMPRA      " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On PEDCOMPRA.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On PEDCOMPRA.FPERSON = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On PEDCOMPRA.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="429" etiqueta="Detalle Tra.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On PEDCOMPRA.FTRANSP = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On PEDCOMPRA.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="433" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On PEDCOMPRA.CONDPAGO = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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