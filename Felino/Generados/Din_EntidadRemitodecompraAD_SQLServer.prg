
define class Din_EntidadREMITODECOMPRAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REMITODECOMPRA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + str( NumInt, 10, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + str( #tabla#.NumInt, 10, 0)]
	cTagClaveCandidata = '_RCOCC'
	cTagClavePk = '_RCOPK'
	cTablaPrincipal = 'REMCOMPRA'
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
			local  lxRemcompraFmodifw, lxRemcompraFaltafw, lxRemcompraFecimpo, lxRemcompraFd2, lxRemcompraFecexpo, lxRemcompraFectrans, lxRemcompraFcuit, lxRemcompraIdcaja, lxRemcompraFpodes2, lxRemcompraFpodes, lxRemcompraFpodes1, lxRemcompraFturno, lxRemcompraDesmntosi2, lxRemcompraTimestamp, lxRemcompraDesmntosi1, lxRemcompraFptoven, lxRemcompraDesmntosi, lxRemcompraTotalcant, lxRemcompraRecmntosi2, lxRemcompraSignomov, lxRemcompraFacttipo, lxRemcompraRecmntosi1, lxRemcompraFsubton, lxRemcompraSitfiscpro, lxRemcompraCondivalp, lxRemcompraFsubtot, lxRemcompraRecmntosi, lxRemcompraSubtotsisi, lxRemcompraRecmnto1, lxRemcompraSubtotcisi, lxRemcompraRecmnto2, lxRemcompraDesauto, lxRemcompraFcompfis, lxRemcompraAnulado, lxRemcompraHoraimpo, lxRemcompraUmodifw, lxRemcompraHaltafw, lxRemcompraHoraexpo, lxRemcompraHmodifw, lxRemcompraFhora, lxRemcompraDescfw, lxRemcompraSmodifw, lxRemcompraUaltafw, lxRemcompraValtafw, lxRemcompraSaltafw, lxRemcompraZadsfw, lxRemcompraVmodifw, lxRemcompraBdaltafw, lxRemcompraSimbmon, lxRemcompraBdmodifw, lxRemcompraEsttrans, lxRemcompraTcrg1361, lxRemcompraCodigo, lxRemcompraIdvuelto, lxRemcompraMoneda, lxRemcompraMonsis, lxRemcompraFmtdes1, lxRemcompraFdescu, lxRemcompraFmtdes2, lxRemcompraFletra, lxRemcompraNumint, lxRemcompraFimpuesto, lxRemcompraFobs, lxRemcompraFfch, lxRemcompraFfchfac, lxRemcompraFptovenext, lxRemcompraDesmntosi3, lxRemcompraFmtdes3, lxRemcompraImpman, lxRemcompraRecpor, lxRemcompraFnumcomp, lxRemcompraTotdescsi, lxRemcompraMr, lxRemcompraNcai, lxRemcompraRecmnto, lxRemcompraFperson, lxRemcompraFvtocai, lxRemcompraFvuelto, lxRemcompraNroremito, lxRemcompraCodlista, lxRemcompraCondpago, lxRemcompraFtotal, lxRemcompraRecmonto1, lxRemcompraRecmonto2, lxRemcompraMotivo, lxRemcompraFtransp, lxRemcompraCotiz, lxRemcompraTotimpue, lxRemcompraTotrecar, lxRemcompraTotrecarsi, lxRemcompraTotdesc
				lxRemcompraFmodifw =  .Fechamodificacionfw			lxRemcompraFaltafw =  .Fechaaltafw			lxRemcompraFecimpo =  .Fechaimpo			lxRemcompraFd2 =  .Fechamodificacion			lxRemcompraFecexpo =  .Fechaexpo			lxRemcompraFectrans =  .Fechatransferencia			lxRemcompraFcuit =  .Cuit			lxRemcompraIdcaja =  .Caja_PK 			lxRemcompraFpodes2 =  .Porcentajedescuento2			lxRemcompraFpodes =  .Porcentajedescuento			lxRemcompraFpodes1 =  .Porcentajedescuento1			lxRemcompraFturno =  .Turno			lxRemcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxRemcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxRemcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxRemcompraFptoven =  .Puntodeventa			lxRemcompraDesmntosi =  .Montodescuentosinimpuestos			lxRemcompraTotalcant =  .Totalcantidad			lxRemcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxRemcompraSignomov =  .Signodemovimiento			lxRemcompraFacttipo =  .Tipocomprobante			lxRemcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxRemcompraFsubton =  .Subtotalneto			lxRemcompraSitfiscpro =  .Situacionfiscal_PK 			lxRemcompraCondivalp =  .Condicioniva			lxRemcompraFsubtot =  .Subtotalbruto			lxRemcompraRecmntosi =  .Recargomontosinimpuestos			lxRemcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxRemcompraRecmnto1 =  .Recargomontoconimpuestos1			lxRemcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxRemcompraRecmnto2 =  .Recargomontoconimpuestos2			lxRemcompraDesauto =  .Descuentoautomatico			lxRemcompraFcompfis =  .Comprobantefiscal			lxRemcompraAnulado =  .Anulado			lxRemcompraHoraimpo =  .Horaimpo			lxRemcompraUmodifw =  .Usuariomodificacionfw			lxRemcompraHaltafw =  .Horaaltafw			lxRemcompraHoraexpo =  .Horaexpo			lxRemcompraHmodifw =  .Horamodificacionfw			lxRemcompraFhora =  .Hora			lxRemcompraDescfw =  .Descripcionfw			lxRemcompraSmodifw =  .Seriemodificacionfw			lxRemcompraUaltafw =  .Usuarioaltafw			lxRemcompraValtafw =  .Versionaltafw			lxRemcompraSaltafw =  .Seriealtafw			lxRemcompraZadsfw =  .Zadsfw			lxRemcompraVmodifw =  .Versionmodificacionfw			lxRemcompraBdaltafw =  .Basededatosaltafw			lxRemcompraSimbmon =  .Simbolomonetariocomprobante			lxRemcompraBdmodifw =  .Basededatosmodificacionfw			lxRemcompraEsttrans =  .Estadotransferencia			lxRemcompraTcrg1361 =  .Tipocomprobanterg1361			lxRemcompraCodigo =  .Codigo			lxRemcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxRemcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxRemcompraMonsis =  upper( .MonedaSistema_PK ) 			lxRemcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxRemcompraFdescu =  .Descuento			lxRemcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxRemcompraFletra =  .Letra			lxRemcompraNumint =  .Numint			lxRemcompraFimpuesto =  .Impuestos			lxRemcompraFobs =  .Obs			lxRemcompraFfch =  .Fecha			lxRemcompraFfchfac =  .Fechafactura			lxRemcompraFptovenext =  .Puntodeventaextendido			lxRemcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxRemcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxRemcompraImpman =  .Impuestosmanuales			lxRemcompraRecpor =  .Recargoporcentaje			lxRemcompraFnumcomp =  .Numero			lxRemcompraTotdescsi =  .Totaldescuentossinimpuestos			lxRemcompraMr =  .Recargomonto			lxRemcompraNcai =  .Cai			lxRemcompraRecmnto =  .Recargomontoconimpuestos			lxRemcompraFperson =  upper( .Proveedor_PK ) 			lxRemcompraFvtocai =  .Fechavtocai			lxRemcompraFvuelto =  .Vuelto			lxRemcompraNroremito =  .Remito			lxRemcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxRemcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxRemcompraFtotal =  .Total			lxRemcompraRecmonto1 =  .Recargomonto1			lxRemcompraRecmonto2 =  .Recargomonto2			lxRemcompraMotivo =  upper( .Motivo_PK ) 			lxRemcompraFtransp =  upper( .Transportista_PK ) 			lxRemcompraCotiz =  .Cotizacion			lxRemcompraTotimpue =  .Totalimpuestos			lxRemcompraTotrecar =  .Totalrecargos			lxRemcompraTotrecarsi =  .Totalrecargossinimpuestos			lxRemcompraTotdesc =  .Totaldescuentos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRemcompraCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.REMCOMPRA ( "Fmodifw","Faltafw","Fecimpo","Fd2","Fecexpo","Fectrans","Fcuit","Idcaja","Fpodes2","Fpodes","Fpodes1","Fturno","Desmntosi2","Timestamp","Desmntosi1","Fptoven","Desmntosi","Totalcant","Recmntosi2","Signomov","Facttipo","Recmntosi1","Fsubton","Sitfiscpro","Condivalp","Fsubtot","Recmntosi","Subtotsisi","Recmnto1","Subtotcisi","Recmnto2","Desauto","Fcompfis","Anulado","Horaimpo","Umodifw","Haltafw","Horaexpo","Hmodifw","Fhora","Descfw","Smodifw","Ualtafw","Valtafw","Saltafw","Zadsfw","Vmodifw","Bdaltafw","Simbmon","Bdmodifw","Esttrans","Tcrg1361","Codigo","Idvuelto","Moneda","Monsis","Fmtdes1","Fdescu","Fmtdes2","Fletra","Numint","Fimpuesto","Fobs","Ffch","Ffchfac","Fptovenext","Desmntosi3","Fmtdes3","Impman","Recpor","Fnumcomp","Totdescsi","Mr","Ncai","Recmnto","Fperson","Fvtocai","Fvuelto","Nroremito","Codlista","Condpago","Ftotal","Recmonto1","Recmonto2","Motivo","Ftransp","Cotiz","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxRemcompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraFcuit ) + "'" >>, <<lxRemcompraIdcaja >>, <<lxRemcompraFpodes2 >>, <<lxRemcompraFpodes >>, <<lxRemcompraFpodes1 >>, <<lxRemcompraFturno >>, <<lxRemcompraDesmntosi2 >>, <<lxRemcompraTimestamp >>, <<lxRemcompraDesmntosi1 >>, <<lxRemcompraFptoven >>, <<lxRemcompraDesmntosi >>, <<lxRemcompraTotalcant >>, <<lxRemcompraRecmntosi2 >>, <<lxRemcompraSignomov >>, <<lxRemcompraFacttipo >>, <<lxRemcompraRecmntosi1 >>, <<lxRemcompraFsubton >>, <<lxRemcompraSitfiscpro >>, <<lxRemcompraCondivalp >>, <<lxRemcompraFsubtot >>, <<lxRemcompraRecmntosi >>, <<lxRemcompraSubtotsisi >>, <<lxRemcompraRecmnto1 >>, <<lxRemcompraSubtotcisi >>, <<lxRemcompraRecmnto2 >>, <<iif( lxRemcompraDesauto, 1, 0 ) >>, <<iif( lxRemcompraFcompfis, 1, 0 ) >>, <<iif( lxRemcompraAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxRemcompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraEsttrans ) + "'" >>, <<lxRemcompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxRemcompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraMonsis ) + "'" >>, <<lxRemcompraFmtdes1 >>, <<lxRemcompraFdescu >>, <<lxRemcompraFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxRemcompraFletra ) + "'" >>, <<lxRemcompraNumint >>, <<lxRemcompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxRemcompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFfch ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFfchfac ) + "'" >>, <<lxRemcompraFptovenext >>, <<lxRemcompraDesmntosi3 >>, <<lxRemcompraFmtdes3 >>, <<iif( lxRemcompraImpman, 1, 0 ) >>, <<lxRemcompraRecpor >>, <<lxRemcompraFnumcomp >>, <<lxRemcompraTotdescsi >>, <<lxRemcompraMr >>, <<lxRemcompraNcai >>, <<lxRemcompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxRemcompraFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFvtocai ) + "'" >>, <<lxRemcompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxRemcompraNroremito ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraCondpago ) + "'" >>, <<lxRemcompraFtotal >>, <<lxRemcompraRecmonto1 >>, <<lxRemcompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxRemcompraMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraFtransp ) + "'" >>, <<lxRemcompraCotiz >>, <<lxRemcompraTotimpue >>, <<lxRemcompraTotrecar >>, <<lxRemcompraTotrecarsi >>, <<lxRemcompraTotdesc >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


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
					lxAfe_letra = loItem.Afe_letra
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxAfe_cantidad = loItem.Afe_cantidad
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxAfe_nroitem = loItem.Afe_nroitem
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAfe_numint = loItem.Afe_numint
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNroitem = lnContadorNroItem
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxOferta = loItem.Oferta
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPreciounitario = loItem.Preciounitario
					lxIditem = loItem.Iditem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
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
						Insert into ZooLogic.RemCompraDet("AfeNUMCOM","AfeLETRA","AfePTOVEN","MNTPRECCI","MNTPTOT","ACondIvaC","AfeSaldo","AfeCANT","MNTPPER","AfeTS","APorcIvaC","MNTPDESSI","AjuSImp","AjuCImp","COMP","AfeNroItem","FBruto","ArtPercep","NumInt","MNTPRECSI","MNDESCI","MNPDSI","MNTPDESCI","MNDESSI","AfeTipoCom","FNETO","FporCFI","NroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","FX2","fporIva","FPRUN","ciditem","iditemOrig","FN11","prunconimp","Prunsinimp","UsarPLista","ProcStock","Afe_Cod","FAMate","IdItem","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_puntodeventa>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoprorrateototal>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxAfe_cantidad>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxAfe_nroitem>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxAfe_numint>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxOferta>>, <<lxPorcentajeiva>>, <<lxPreciounitario>>, <<lxIditem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpRemComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
						Insert into ZooLogic.ImpRemC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxRemcompraTimestamp
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
			local  lxRemcompraFmodifw, lxRemcompraFaltafw, lxRemcompraFecimpo, lxRemcompraFd2, lxRemcompraFecexpo, lxRemcompraFectrans, lxRemcompraFcuit, lxRemcompraIdcaja, lxRemcompraFpodes2, lxRemcompraFpodes, lxRemcompraFpodes1, lxRemcompraFturno, lxRemcompraDesmntosi2, lxRemcompraTimestamp, lxRemcompraDesmntosi1, lxRemcompraFptoven, lxRemcompraDesmntosi, lxRemcompraTotalcant, lxRemcompraRecmntosi2, lxRemcompraSignomov, lxRemcompraFacttipo, lxRemcompraRecmntosi1, lxRemcompraFsubton, lxRemcompraSitfiscpro, lxRemcompraCondivalp, lxRemcompraFsubtot, lxRemcompraRecmntosi, lxRemcompraSubtotsisi, lxRemcompraRecmnto1, lxRemcompraSubtotcisi, lxRemcompraRecmnto2, lxRemcompraDesauto, lxRemcompraFcompfis, lxRemcompraAnulado, lxRemcompraHoraimpo, lxRemcompraUmodifw, lxRemcompraHaltafw, lxRemcompraHoraexpo, lxRemcompraHmodifw, lxRemcompraFhora, lxRemcompraDescfw, lxRemcompraSmodifw, lxRemcompraUaltafw, lxRemcompraValtafw, lxRemcompraSaltafw, lxRemcompraZadsfw, lxRemcompraVmodifw, lxRemcompraBdaltafw, lxRemcompraSimbmon, lxRemcompraBdmodifw, lxRemcompraEsttrans, lxRemcompraTcrg1361, lxRemcompraCodigo, lxRemcompraIdvuelto, lxRemcompraMoneda, lxRemcompraMonsis, lxRemcompraFmtdes1, lxRemcompraFdescu, lxRemcompraFmtdes2, lxRemcompraFletra, lxRemcompraNumint, lxRemcompraFimpuesto, lxRemcompraFobs, lxRemcompraFfch, lxRemcompraFfchfac, lxRemcompraFptovenext, lxRemcompraDesmntosi3, lxRemcompraFmtdes3, lxRemcompraImpman, lxRemcompraRecpor, lxRemcompraFnumcomp, lxRemcompraTotdescsi, lxRemcompraMr, lxRemcompraNcai, lxRemcompraRecmnto, lxRemcompraFperson, lxRemcompraFvtocai, lxRemcompraFvuelto, lxRemcompraNroremito, lxRemcompraCodlista, lxRemcompraCondpago, lxRemcompraFtotal, lxRemcompraRecmonto1, lxRemcompraRecmonto2, lxRemcompraMotivo, lxRemcompraFtransp, lxRemcompraCotiz, lxRemcompraTotimpue, lxRemcompraTotrecar, lxRemcompraTotrecarsi, lxRemcompraTotdesc
				lxRemcompraFmodifw =  .Fechamodificacionfw			lxRemcompraFaltafw =  .Fechaaltafw			lxRemcompraFecimpo =  .Fechaimpo			lxRemcompraFd2 =  .Fechamodificacion			lxRemcompraFecexpo =  .Fechaexpo			lxRemcompraFectrans =  .Fechatransferencia			lxRemcompraFcuit =  .Cuit			lxRemcompraIdcaja =  .Caja_PK 			lxRemcompraFpodes2 =  .Porcentajedescuento2			lxRemcompraFpodes =  .Porcentajedescuento			lxRemcompraFpodes1 =  .Porcentajedescuento1			lxRemcompraFturno =  .Turno			lxRemcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxRemcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxRemcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxRemcompraFptoven =  .Puntodeventa			lxRemcompraDesmntosi =  .Montodescuentosinimpuestos			lxRemcompraTotalcant =  .Totalcantidad			lxRemcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxRemcompraSignomov =  .Signodemovimiento			lxRemcompraFacttipo =  .Tipocomprobante			lxRemcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxRemcompraFsubton =  .Subtotalneto			lxRemcompraSitfiscpro =  .Situacionfiscal_PK 			lxRemcompraCondivalp =  .Condicioniva			lxRemcompraFsubtot =  .Subtotalbruto			lxRemcompraRecmntosi =  .Recargomontosinimpuestos			lxRemcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxRemcompraRecmnto1 =  .Recargomontoconimpuestos1			lxRemcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxRemcompraRecmnto2 =  .Recargomontoconimpuestos2			lxRemcompraDesauto =  .Descuentoautomatico			lxRemcompraFcompfis =  .Comprobantefiscal			lxRemcompraAnulado =  .Anulado			lxRemcompraHoraimpo =  .Horaimpo			lxRemcompraUmodifw =  .Usuariomodificacionfw			lxRemcompraHaltafw =  .Horaaltafw			lxRemcompraHoraexpo =  .Horaexpo			lxRemcompraHmodifw =  .Horamodificacionfw			lxRemcompraFhora =  .Hora			lxRemcompraDescfw =  .Descripcionfw			lxRemcompraSmodifw =  .Seriemodificacionfw			lxRemcompraUaltafw =  .Usuarioaltafw			lxRemcompraValtafw =  .Versionaltafw			lxRemcompraSaltafw =  .Seriealtafw			lxRemcompraZadsfw =  .Zadsfw			lxRemcompraVmodifw =  .Versionmodificacionfw			lxRemcompraBdaltafw =  .Basededatosaltafw			lxRemcompraSimbmon =  .Simbolomonetariocomprobante			lxRemcompraBdmodifw =  .Basededatosmodificacionfw			lxRemcompraEsttrans =  .Estadotransferencia			lxRemcompraTcrg1361 =  .Tipocomprobanterg1361			lxRemcompraCodigo =  .Codigo			lxRemcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxRemcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxRemcompraMonsis =  upper( .MonedaSistema_PK ) 			lxRemcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxRemcompraFdescu =  .Descuento			lxRemcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxRemcompraFletra =  .Letra			lxRemcompraNumint =  .Numint			lxRemcompraFimpuesto =  .Impuestos			lxRemcompraFobs =  .Obs			lxRemcompraFfch =  .Fecha			lxRemcompraFfchfac =  .Fechafactura			lxRemcompraFptovenext =  .Puntodeventaextendido			lxRemcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxRemcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxRemcompraImpman =  .Impuestosmanuales			lxRemcompraRecpor =  .Recargoporcentaje			lxRemcompraFnumcomp =  .Numero			lxRemcompraTotdescsi =  .Totaldescuentossinimpuestos			lxRemcompraMr =  .Recargomonto			lxRemcompraNcai =  .Cai			lxRemcompraRecmnto =  .Recargomontoconimpuestos			lxRemcompraFperson =  upper( .Proveedor_PK ) 			lxRemcompraFvtocai =  .Fechavtocai			lxRemcompraFvuelto =  .Vuelto			lxRemcompraNroremito =  .Remito			lxRemcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxRemcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxRemcompraFtotal =  .Total			lxRemcompraRecmonto1 =  .Recargomonto1			lxRemcompraRecmonto2 =  .Recargomonto2			lxRemcompraMotivo =  upper( .Motivo_PK ) 			lxRemcompraFtransp =  upper( .Transportista_PK ) 			lxRemcompraCotiz =  .Cotizacion			lxRemcompraTotimpue =  .Totalimpuestos			lxRemcompraTotrecar =  .Totalrecargos			lxRemcompraTotrecarsi =  .Totalrecargossinimpuestos			lxRemcompraTotdesc =  .Totaldescuentos
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
				update ZooLogic.REMCOMPRA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRemcompraFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRemcompraFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxRemcompraFecimpo ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxRemcompraFd2 ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxRemcompraFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxRemcompraFectrans ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxRemcompraFcuit ) + "'">>,"Idcaja" = <<lxRemcompraIdcaja>>,"Fpodes2" = <<lxRemcompraFpodes2>>,"Fpodes" = <<lxRemcompraFpodes>>,"Fpodes1" = <<lxRemcompraFpodes1>>,"Fturno" = <<lxRemcompraFturno>>,"Desmntosi2" = <<lxRemcompraDesmntosi2>>,"Timestamp" = <<lxRemcompraTimestamp>>,"Desmntosi1" = <<lxRemcompraDesmntosi1>>,"Fptoven" = <<lxRemcompraFptoven>>,"Desmntosi" = <<lxRemcompraDesmntosi>>,"Totalcant" = <<lxRemcompraTotalcant>>,"Recmntosi2" = <<lxRemcompraRecmntosi2>>,"Signomov" = <<lxRemcompraSignomov>>,"Facttipo" = <<lxRemcompraFacttipo>>,"Recmntosi1" = <<lxRemcompraRecmntosi1>>,"Fsubton" = <<lxRemcompraFsubton>>,"Sitfiscpro" = <<lxRemcompraSitfiscpro>>,"Condivalp" = <<lxRemcompraCondivalp>>,"Fsubtot" = <<lxRemcompraFsubtot>>,"Recmntosi" = <<lxRemcompraRecmntosi>>,"Subtotsisi" = <<lxRemcompraSubtotsisi>>,"Recmnto1" = <<lxRemcompraRecmnto1>>,"Subtotcisi" = <<lxRemcompraSubtotcisi>>,"Recmnto2" = <<lxRemcompraRecmnto2>>,"Desauto" = <<iif( lxRemcompraDesauto, 1, 0 )>>,"Fcompfis" = <<iif( lxRemcompraFcompfis, 1, 0 )>>,"Anulado" = <<iif( lxRemcompraAnulado, 1, 0 )>>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRemcompraHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraUmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRemcompraHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRemcompraHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraHmodifw ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxRemcompraFhora ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxRemcompraDescfw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRemcompraUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRemcompraValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRemcompraSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRemcompraZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraVmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRemcompraBdaltafw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxRemcompraSimbmon ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRemcompraEsttrans ) + "'">>,"Tcrg1361" = <<lxRemcompraTcrg1361>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxRemcompraCodigo ) + "'">>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxRemcompraIdvuelto ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxRemcompraMoneda ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxRemcompraMonsis ) + "'">>,"Fmtdes1" = <<lxRemcompraFmtdes1>>,"Fdescu" = <<lxRemcompraFdescu>>,"Fmtdes2" = <<lxRemcompraFmtdes2>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxRemcompraFletra ) + "'">>,"Numint" = <<lxRemcompraNumint>>,"Fimpuesto" = <<lxRemcompraFimpuesto>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxRemcompraFobs ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxRemcompraFfch ) + "'">>,"Ffchfac" = <<"'" + this.ConvertirDateSql( lxRemcompraFfchfac ) + "'">>,"Fptovenext" = <<lxRemcompraFptovenext>>,"Desmntosi3" = <<lxRemcompraDesmntosi3>>,"Fmtdes3" = <<lxRemcompraFmtdes3>>,"Impman" = <<iif( lxRemcompraImpman, 1, 0 )>>,"Recpor" = <<lxRemcompraRecpor>>,"Fnumcomp" = <<lxRemcompraFnumcomp>>,"Totdescsi" = <<lxRemcompraTotdescsi>>,"Mr" = <<lxRemcompraMr>>,"Ncai" = <<lxRemcompraNcai>>,"Recmnto" = <<lxRemcompraRecmnto>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxRemcompraFperson ) + "'">>,"Fvtocai" = <<"'" + this.ConvertirDateSql( lxRemcompraFvtocai ) + "'">>,"Fvuelto" = <<lxRemcompraFvuelto>>,"Nroremito" = <<"'" + this.FormatearTextoSql( lxRemcompraNroremito ) + "'">>,"Codlista" = <<"'" + this.FormatearTextoSql( lxRemcompraCodlista ) + "'">>,"Condpago" = <<"'" + this.FormatearTextoSql( lxRemcompraCondpago ) + "'">>,"Ftotal" = <<lxRemcompraFtotal>>,"Recmonto1" = <<lxRemcompraRecmonto1>>,"Recmonto2" = <<lxRemcompraRecmonto2>>,"Motivo" = <<"'" + this.FormatearTextoSql( lxRemcompraMotivo ) + "'">>,"Ftransp" = <<"'" + this.FormatearTextoSql( lxRemcompraFtransp ) + "'">>,"Cotiz" = <<lxRemcompraCotiz>>,"Totimpue" = <<lxRemcompraTotimpue>>,"Totrecar" = <<lxRemcompraTotrecar>>,"Totrecarsi" = <<lxRemcompraTotrecarsi>>,"Totdesc" = <<lxRemcompraTotdesc>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxRemcompraCodigo ) + "'">> and  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.RemCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpRemComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpRemC where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
					lxAfe_letra = loItem.Afe_letra
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxAfe_cantidad = loItem.Afe_cantidad
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxAfe_nroitem = loItem.Afe_nroitem
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAfe_numint = loItem.Afe_numint
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNroitem = lnContadorNroItem
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxOferta = loItem.Oferta
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPreciounitario = loItem.Preciounitario
					lxIditem = loItem.Iditem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
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
						Insert into ZooLogic.RemCompraDet("AfeNUMCOM","AfeLETRA","AfePTOVEN","MNTPRECCI","MNTPTOT","ACondIvaC","AfeSaldo","AfeCANT","MNTPPER","AfeTS","APorcIvaC","MNTPDESSI","AjuSImp","AjuCImp","COMP","AfeNroItem","FBruto","ArtPercep","NumInt","MNTPRECSI","MNDESCI","MNPDSI","MNTPDESCI","MNDESSI","AfeTipoCom","FNETO","FporCFI","NroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","FX2","fporIva","FPRUN","ciditem","iditemOrig","FN11","prunconimp","Prunsinimp","UsarPLista","ProcStock","Afe_Cod","FAMate","IdItem","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_puntodeventa>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoprorrateototal>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxAfe_cantidad>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxAfe_nroitem>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxAfe_numint>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxOferta>>, <<lxPorcentajeiva>>, <<lxPreciounitario>>, <<lxIditem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpRemComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
						Insert into ZooLogic.ImpRemC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxRemcompraTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.REMCOMPRA where " + this.ConvertirFuncionesSql( " REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41" ) )
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
			Local lxRemcompraCodigo
			lxRemcompraCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fpodes1" as "Porcentajedescuento1", "Fturno" as "Turno", "Desmntosi2" as "Montodescuentosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.REMCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxRemcompraCodigo ) + "'">> and  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41
			endtext
			use in select('c_REMITODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITODECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_REMITODECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Afecant" as "Afe_cantidad", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Afenroitem" as "Afe_nroitem", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Fx2" as "Oferta", "Fporiva" as "Porcentajeiva", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.RemCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpRemComp where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpRemC where cCod = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			Local lxRemCompraFACTTIPO As Variant, lxRemCompraNumInt As Variant
			lxRemCompraFACTTIPO = .TipoComprobante
			lxRemCompraNumInt = .NumInt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fpodes1" as "Porcentajedescuento1", "Fturno" as "Turno", "Desmntosi2" as "Montodescuentosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.REMCOMPRA where  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41 And FACTTIPO = <<lxRemCompraFACTTIPO>> and NumInt = <<lxRemCompraNumInt>>
			endtext
			use in select('c_REMITODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITODECOMPRA', set( 'Datasession' ) )
			if reccount( 'c_REMITODECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Afecant" as "Afe_cantidad", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Afenroitem" as "Afe_nroitem", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Fx2" as "Oferta", "Fporiva" as "Porcentajeiva", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.RemCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpRemComp where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpRemC where cCod = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxRemcompraCodigo as Variant
		llRetorno = .t.
		lxRemcompraCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.REMCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxRemcompraCodigo ) + "'">> and  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fpodes1" as "Porcentajedescuento1", "Fturno" as "Turno", "Desmntosi2" as "Montodescuentosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.REMCOMPRA where  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41 order by FACTTIPO,NumInt
			endtext
			use in select('c_REMITODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Afecant" as "Afe_cantidad", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Afenroitem" as "Afe_nroitem", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Fx2" as "Oferta", "Fporiva" as "Porcentajeiva", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.RemCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpRemComp where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpRemC where cCod = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fpodes1" as "Porcentajedescuento1", "Fturno" as "Turno", "Desmntosi2" as "Montodescuentosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.REMCOMPRA where  str( FACTTIPO, 2, 0) + str( NumInt, 10, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41 order by FACTTIPO,NumInt
			endtext
			use in select('c_REMITODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Afecant" as "Afe_cantidad", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Afenroitem" as "Afe_nroitem", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Fx2" as "Oferta", "Fporiva" as "Porcentajeiva", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.RemCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpRemComp where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpRemC where cCod = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fpodes1" as "Porcentajedescuento1", "Fturno" as "Turno", "Desmntosi2" as "Montodescuentosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.REMCOMPRA where  str( FACTTIPO, 2, 0) + str( NumInt, 10, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41 order by FACTTIPO desc,NumInt desc
			endtext
			use in select('c_REMITODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Afecant" as "Afe_cantidad", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Afenroitem" as "Afe_nroitem", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Fx2" as "Oferta", "Fporiva" as "Porcentajeiva", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.RemCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpRemComp where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpRemC where cCod = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fpodes1" as "Porcentajedescuento1", "Fturno" as "Turno", "Desmntosi2" as "Montodescuentosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.REMCOMPRA where  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41 order by FACTTIPO desc,NumInt desc
			endtext
			use in select('c_REMITODECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITODECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Afecant" as "Afe_cantidad", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Afenroitem" as "Afe_nroitem", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Fx2" as "Oferta", "Fporiva" as "Porcentajeiva", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.RemCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpRemComp where Codigo = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minoimp" as "Minimonoimponible", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpRemC where cCod = <<"'" + this.FormatearTextoSql( c_REMITODECOMPRA.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Faltafw,Fecimpo,Fd2,Fecexpo,Fectrans,Fcuit,Idcaja,Fpodes2,Fpodes,Fpodes1,Fturno,Desm" + ;
"ntosi2,Timestamp,Desmntosi1,Fptoven,Desmntosi,Totalcant,Recmntosi2,Signomov,Facttipo,Recmntosi1,Fsub" + ;
"ton,Sitfiscpro,Condivalp,Fsubtot,Recmntosi,Subtotsisi,Recmnto1,Subtotcisi,Recmnto2,Desauto,Fcompfis," + ;
"Anulado,Horaimpo,Umodifw,Haltafw,Horaexpo,Hmodifw,Fhora,Descfw,Smodifw,Ualtafw,Valtafw,Saltafw,Zadsf" + ;
"w,Vmodifw,Bdaltafw,Simbmon,Bdmodifw,Esttrans,Tcrg1361,Codigo,Idvuelto,Moneda,Monsis,Fmtdes1,Fdescu,F" + ;
"mtdes2,Fletra,Numint,Fimpuesto,Fobs,Ffch,Ffchfac,Fptovenext,Desmntosi3,Fmtdes3,Impman,Recpor,Fnumcom" + ;
"p,Totdescsi,Mr,Ncai,Recmnto,Fperson,Fvtocai,Fvuelto,Nroremito,Codlista,Condpago,Ftotal,Recmonto1,Rec" + ;
"monto2,Motivo,Ftransp,Cotiz,Totimpue,Totrecar,Totrecarsi,Totdesc" + ;
" from ZooLogic.REMCOMPRA where  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41 and " + lcFiltro )
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
			local  lxRemcompraFmodifw, lxRemcompraFaltafw, lxRemcompraFecimpo, lxRemcompraFd2, lxRemcompraFecexpo, lxRemcompraFectrans, lxRemcompraFcuit, lxRemcompraIdcaja, lxRemcompraFpodes2, lxRemcompraFpodes, lxRemcompraFpodes1, lxRemcompraFturno, lxRemcompraDesmntosi2, lxRemcompraTimestamp, lxRemcompraDesmntosi1, lxRemcompraFptoven, lxRemcompraDesmntosi, lxRemcompraTotalcant, lxRemcompraRecmntosi2, lxRemcompraSignomov, lxRemcompraFacttipo, lxRemcompraRecmntosi1, lxRemcompraFsubton, lxRemcompraSitfiscpro, lxRemcompraCondivalp, lxRemcompraFsubtot, lxRemcompraRecmntosi, lxRemcompraSubtotsisi, lxRemcompraRecmnto1, lxRemcompraSubtotcisi, lxRemcompraRecmnto2, lxRemcompraDesauto, lxRemcompraFcompfis, lxRemcompraAnulado, lxRemcompraHoraimpo, lxRemcompraUmodifw, lxRemcompraHaltafw, lxRemcompraHoraexpo, lxRemcompraHmodifw, lxRemcompraFhora, lxRemcompraDescfw, lxRemcompraSmodifw, lxRemcompraUaltafw, lxRemcompraValtafw, lxRemcompraSaltafw, lxRemcompraZadsfw, lxRemcompraVmodifw, lxRemcompraBdaltafw, lxRemcompraSimbmon, lxRemcompraBdmodifw, lxRemcompraEsttrans, lxRemcompraTcrg1361, lxRemcompraCodigo, lxRemcompraIdvuelto, lxRemcompraMoneda, lxRemcompraMonsis, lxRemcompraFmtdes1, lxRemcompraFdescu, lxRemcompraFmtdes2, lxRemcompraFletra, lxRemcompraNumint, lxRemcompraFimpuesto, lxRemcompraFobs, lxRemcompraFfch, lxRemcompraFfchfac, lxRemcompraFptovenext, lxRemcompraDesmntosi3, lxRemcompraFmtdes3, lxRemcompraImpman, lxRemcompraRecpor, lxRemcompraFnumcomp, lxRemcompraTotdescsi, lxRemcompraMr, lxRemcompraNcai, lxRemcompraRecmnto, lxRemcompraFperson, lxRemcompraFvtocai, lxRemcompraFvuelto, lxRemcompraNroremito, lxRemcompraCodlista, lxRemcompraCondpago, lxRemcompraFtotal, lxRemcompraRecmonto1, lxRemcompraRecmonto2, lxRemcompraMotivo, lxRemcompraFtransp, lxRemcompraCotiz, lxRemcompraTotimpue, lxRemcompraTotrecar, lxRemcompraTotrecarsi, lxRemcompraTotdesc
				lxRemcompraFmodifw = ctod( '  /  /    ' )			lxRemcompraFaltafw = ctod( '  /  /    ' )			lxRemcompraFecimpo = ctod( '  /  /    ' )			lxRemcompraFd2 = ctod( '  /  /    ' )			lxRemcompraFecexpo = ctod( '  /  /    ' )			lxRemcompraFectrans = ctod( '  /  /    ' )			lxRemcompraFcuit = []			lxRemcompraIdcaja = 0			lxRemcompraFpodes2 = 0			lxRemcompraFpodes = 0			lxRemcompraFpodes1 = 0			lxRemcompraFturno = 0			lxRemcompraDesmntosi2 = 0			lxRemcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxRemcompraDesmntosi1 = 0			lxRemcompraFptoven = 0			lxRemcompraDesmntosi = 0			lxRemcompraTotalcant = 0			lxRemcompraRecmntosi2 = 0			lxRemcompraSignomov = 0			lxRemcompraFacttipo = 0			lxRemcompraRecmntosi1 = 0			lxRemcompraFsubton = 0			lxRemcompraSitfiscpro = 0			lxRemcompraCondivalp = 0			lxRemcompraFsubtot = 0			lxRemcompraRecmntosi = 0			lxRemcompraSubtotsisi = 0			lxRemcompraRecmnto1 = 0			lxRemcompraSubtotcisi = 0			lxRemcompraRecmnto2 = 0			lxRemcompraDesauto = .F.			lxRemcompraFcompfis = .F.			lxRemcompraAnulado = .F.			lxRemcompraHoraimpo = []			lxRemcompraUmodifw = []			lxRemcompraHaltafw = []			lxRemcompraHoraexpo = []			lxRemcompraHmodifw = []			lxRemcompraFhora = []			lxRemcompraDescfw = []			lxRemcompraSmodifw = []			lxRemcompraUaltafw = []			lxRemcompraValtafw = []			lxRemcompraSaltafw = []			lxRemcompraZadsfw = []			lxRemcompraVmodifw = []			lxRemcompraBdaltafw = []			lxRemcompraSimbmon = []			lxRemcompraBdmodifw = []			lxRemcompraEsttrans = []			lxRemcompraTcrg1361 = 0			lxRemcompraCodigo = []			lxRemcompraIdvuelto = []			lxRemcompraMoneda = []			lxRemcompraMonsis = []			lxRemcompraFmtdes1 = 0			lxRemcompraFdescu = 0			lxRemcompraFmtdes2 = 0			lxRemcompraFletra = []			lxRemcompraNumint = 0			lxRemcompraFimpuesto = 0			lxRemcompraFobs = []			lxRemcompraFfch = ctod( '  /  /    ' )			lxRemcompraFfchfac = ctod( '  /  /    ' )			lxRemcompraFptovenext = 0			lxRemcompraDesmntosi3 = 0			lxRemcompraFmtdes3 = 0			lxRemcompraImpman = .F.			lxRemcompraRecpor = 0			lxRemcompraFnumcomp = 0			lxRemcompraTotdescsi = 0			lxRemcompraMr = 0			lxRemcompraNcai = 0			lxRemcompraRecmnto = 0			lxRemcompraFperson = []			lxRemcompraFvtocai = ctod( '  /  /    ' )			lxRemcompraFvuelto = 0			lxRemcompraNroremito = []			lxRemcompraCodlista = []			lxRemcompraCondpago = []			lxRemcompraFtotal = 0			lxRemcompraRecmonto1 = 0			lxRemcompraRecmonto2 = 0			lxRemcompraMotivo = []			lxRemcompraFtransp = []			lxRemcompraCotiz = 0			lxRemcompraTotimpue = 0			lxRemcompraTotrecar = 0			lxRemcompraTotrecarsi = 0			lxRemcompraTotdesc = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.RemCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpRemComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpRemC where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.REMCOMPRA where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REMCOMPRA' + '_' + tcCampo
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
		lcWhere = " Where  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fpodes1" as "Porcentajedescuento1", "Fturno" as "Turno", "Desmntosi2" as "Montodescuentosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REMCOMPRA', '', tnTope )
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
		lcWhere = " Where  REMCOMPRADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Afecant" as "Afe_cantidad", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Afenroitem" as "Afe_nroitem", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Fx2" as "Oferta", "Fporiva" as "Porcentajeiva", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleFacturaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'RemCompraDet', 'FacturaDetalle', tnTope )
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
		lcWhere = " Where  IMPREMCOMP.CODIGO != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpRemComp', 'ImpuestosDetalle', tnTope )
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
		lcWhere = " Where  IMPREMC.CCOD != ''"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpRemC', 'ImpuestosComprobante', tnTope )
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
				Case lcAtributo == 'PORCENTAJEDESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES2 AS PORCENTAJEDESCUENTO2'
				Case lcAtributo == 'PORCENTAJEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES AS PORCENTAJEDESCUENTO'
				Case lcAtributo == 'PORCENTAJEDESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES1 AS PORCENTAJEDESCUENTO1'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTURNO AS TURNO'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
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
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUTO AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
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
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
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
				Case lcAtributo == 'IMPUESTOSMANUALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPMAN AS IMPUESTOSMANUALES'
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
				Case lcAtributo == 'FECHAVTOCAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVTOCAI AS FECHAVTOCAI'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREMITO AS REMITO'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'CONDICIONPAGOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONPAGOPREFERENTE'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO1 AS RECARGOMONTO1'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO2 AS RECARGOMONTO2'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'TRANSPORTISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTRANSP AS TRANSPORTISTA'
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
				Case lcAtributo == 'AFE_LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS AFE_LETRA'
				Case lcAtributo == 'AFE_PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS AFE_PUNTODEVENTA'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'ARTICULO_CONDICIONIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAC AS ARTICULO_CONDICIONIVACOMPRAS'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAC AS ARTICULO_PORCENTAJEIVACOMPRAS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'PERCEPCIONIVARG5329'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS PERCEPCIONIVARG5329'
				Case lcAtributo == 'AFE_NUMINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINT AS AFE_NUMINT'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
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
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMATE AS MATERIAL'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
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
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO2'
				lcCampo = 'FPODES2'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO'
				lcCampo = 'FPODES'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO1'
				lcCampo = 'FPODES1'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'FTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
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
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOSMANUALES'
				lcCampo = 'IMPMAN'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOCAI'
				lcCampo = 'FVTOCAI'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'NROREMITO'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONPAGOPREFERENTE'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'RECMONTO1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'RECMONTO2'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTA'
				lcCampo = 'FTRANSP'
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
			Case upper( alltrim( tcAtributo ) ) == 'AFE_LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVACOMPRAS'
				lcCampo = 'ACONDIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVACOMPRAS'
				lcCampo = 'APORCIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVARG5329'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NUMINT'
				lcCampo = 'NUMINT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
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
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'FAMATE'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
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
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'FACTURADETALLE'
			lcRetorno = 'REMCOMPRADET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPREMCOMP'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPREMC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxRemcompraFmodifw, lxRemcompraFaltafw, lxRemcompraFecimpo, lxRemcompraFd2, lxRemcompraFecexpo, lxRemcompraFectrans, lxRemcompraFcuit, lxRemcompraIdcaja, lxRemcompraFpodes2, lxRemcompraFpodes, lxRemcompraFpodes1, lxRemcompraFturno, lxRemcompraDesmntosi2, lxRemcompraTimestamp, lxRemcompraDesmntosi1, lxRemcompraFptoven, lxRemcompraDesmntosi, lxRemcompraTotalcant, lxRemcompraRecmntosi2, lxRemcompraSignomov, lxRemcompraFacttipo, lxRemcompraRecmntosi1, lxRemcompraFsubton, lxRemcompraSitfiscpro, lxRemcompraCondivalp, lxRemcompraFsubtot, lxRemcompraRecmntosi, lxRemcompraSubtotsisi, lxRemcompraRecmnto1, lxRemcompraSubtotcisi, lxRemcompraRecmnto2, lxRemcompraDesauto, lxRemcompraFcompfis, lxRemcompraAnulado, lxRemcompraHoraimpo, lxRemcompraUmodifw, lxRemcompraHaltafw, lxRemcompraHoraexpo, lxRemcompraHmodifw, lxRemcompraFhora, lxRemcompraDescfw, lxRemcompraSmodifw, lxRemcompraUaltafw, lxRemcompraValtafw, lxRemcompraSaltafw, lxRemcompraZadsfw, lxRemcompraVmodifw, lxRemcompraBdaltafw, lxRemcompraSimbmon, lxRemcompraBdmodifw, lxRemcompraEsttrans, lxRemcompraTcrg1361, lxRemcompraCodigo, lxRemcompraIdvuelto, lxRemcompraMoneda, lxRemcompraMonsis, lxRemcompraFmtdes1, lxRemcompraFdescu, lxRemcompraFmtdes2, lxRemcompraFletra, lxRemcompraNumint, lxRemcompraFimpuesto, lxRemcompraFobs, lxRemcompraFfch, lxRemcompraFfchfac, lxRemcompraFptovenext, lxRemcompraDesmntosi3, lxRemcompraFmtdes3, lxRemcompraImpman, lxRemcompraRecpor, lxRemcompraFnumcomp, lxRemcompraTotdescsi, lxRemcompraMr, lxRemcompraNcai, lxRemcompraRecmnto, lxRemcompraFperson, lxRemcompraFvtocai, lxRemcompraFvuelto, lxRemcompraNroremito, lxRemcompraCodlista, lxRemcompraCondpago, lxRemcompraFtotal, lxRemcompraRecmonto1, lxRemcompraRecmonto2, lxRemcompraMotivo, lxRemcompraFtransp, lxRemcompraCotiz, lxRemcompraTotimpue, lxRemcompraTotrecar, lxRemcompraTotrecarsi, lxRemcompraTotdesc
				lxRemcompraFmodifw =  .Fechamodificacionfw			lxRemcompraFaltafw =  .Fechaaltafw			lxRemcompraFecimpo =  .Fechaimpo			lxRemcompraFd2 =  .Fechamodificacion			lxRemcompraFecexpo =  .Fechaexpo			lxRemcompraFectrans =  .Fechatransferencia			lxRemcompraFcuit =  .Cuit			lxRemcompraIdcaja =  .Caja_PK 			lxRemcompraFpodes2 =  .Porcentajedescuento2			lxRemcompraFpodes =  .Porcentajedescuento			lxRemcompraFpodes1 =  .Porcentajedescuento1			lxRemcompraFturno =  .Turno			lxRemcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxRemcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxRemcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxRemcompraFptoven =  .Puntodeventa			lxRemcompraDesmntosi =  .Montodescuentosinimpuestos			lxRemcompraTotalcant =  .Totalcantidad			lxRemcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxRemcompraSignomov =  .Signodemovimiento			lxRemcompraFacttipo =  .Tipocomprobante			lxRemcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxRemcompraFsubton =  .Subtotalneto			lxRemcompraSitfiscpro =  .Situacionfiscal_PK 			lxRemcompraCondivalp =  .Condicioniva			lxRemcompraFsubtot =  .Subtotalbruto			lxRemcompraRecmntosi =  .Recargomontosinimpuestos			lxRemcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxRemcompraRecmnto1 =  .Recargomontoconimpuestos1			lxRemcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxRemcompraRecmnto2 =  .Recargomontoconimpuestos2			lxRemcompraDesauto =  .Descuentoautomatico			lxRemcompraFcompfis =  .Comprobantefiscal			lxRemcompraAnulado =  .Anulado			lxRemcompraHoraimpo =  .Horaimpo			lxRemcompraUmodifw =  .Usuariomodificacionfw			lxRemcompraHaltafw =  .Horaaltafw			lxRemcompraHoraexpo =  .Horaexpo			lxRemcompraHmodifw =  .Horamodificacionfw			lxRemcompraFhora =  .Hora			lxRemcompraDescfw =  .Descripcionfw			lxRemcompraSmodifw =  .Seriemodificacionfw			lxRemcompraUaltafw =  .Usuarioaltafw			lxRemcompraValtafw =  .Versionaltafw			lxRemcompraSaltafw =  .Seriealtafw			lxRemcompraZadsfw =  .Zadsfw			lxRemcompraVmodifw =  .Versionmodificacionfw			lxRemcompraBdaltafw =  .Basededatosaltafw			lxRemcompraSimbmon =  .Simbolomonetariocomprobante			lxRemcompraBdmodifw =  .Basededatosmodificacionfw			lxRemcompraEsttrans =  .Estadotransferencia			lxRemcompraTcrg1361 =  .Tipocomprobanterg1361			lxRemcompraCodigo =  .Codigo			lxRemcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxRemcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxRemcompraMonsis =  upper( .MonedaSistema_PK ) 			lxRemcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxRemcompraFdescu =  .Descuento			lxRemcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxRemcompraFletra =  .Letra			lxRemcompraNumint =  .Numint			lxRemcompraFimpuesto =  .Impuestos			lxRemcompraFobs =  .Obs			lxRemcompraFfch =  .Fecha			lxRemcompraFfchfac =  .Fechafactura			lxRemcompraFptovenext =  .Puntodeventaextendido			lxRemcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxRemcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxRemcompraImpman =  .Impuestosmanuales			lxRemcompraRecpor =  .Recargoporcentaje			lxRemcompraFnumcomp =  .Numero			lxRemcompraTotdescsi =  .Totaldescuentossinimpuestos			lxRemcompraMr =  .Recargomonto			lxRemcompraNcai =  .Cai			lxRemcompraRecmnto =  .Recargomontoconimpuestos			lxRemcompraFperson =  upper( .Proveedor_PK ) 			lxRemcompraFvtocai =  .Fechavtocai			lxRemcompraFvuelto =  .Vuelto			lxRemcompraNroremito =  .Remito			lxRemcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxRemcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxRemcompraFtotal =  .Total			lxRemcompraRecmonto1 =  .Recargomonto1			lxRemcompraRecmonto2 =  .Recargomonto2			lxRemcompraMotivo =  upper( .Motivo_PK ) 			lxRemcompraFtransp =  upper( .Transportista_PK ) 			lxRemcompraCotiz =  .Cotizacion			lxRemcompraTotimpue =  .Totalimpuestos			lxRemcompraTotrecar =  .Totalrecargos			lxRemcompraTotrecarsi =  .Totalrecargossinimpuestos			lxRemcompraTotdesc =  .Totaldescuentos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.REMCOMPRA ( "Fmodifw","Faltafw","Fecimpo","Fd2","Fecexpo","Fectrans","Fcuit","Idcaja","Fpodes2","Fpodes","Fpodes1","Fturno","Desmntosi2","Timestamp","Desmntosi1","Fptoven","Desmntosi","Totalcant","Recmntosi2","Signomov","Facttipo","Recmntosi1","Fsubton","Sitfiscpro","Condivalp","Fsubtot","Recmntosi","Subtotsisi","Recmnto1","Subtotcisi","Recmnto2","Desauto","Fcompfis","Anulado","Horaimpo","Umodifw","Haltafw","Horaexpo","Hmodifw","Fhora","Descfw","Smodifw","Ualtafw","Valtafw","Saltafw","Zadsfw","Vmodifw","Bdaltafw","Simbmon","Bdmodifw","Esttrans","Tcrg1361","Codigo","Idvuelto","Moneda","Monsis","Fmtdes1","Fdescu","Fmtdes2","Fletra","Numint","Fimpuesto","Fobs","Ffch","Ffchfac","Fptovenext","Desmntosi3","Fmtdes3","Impman","Recpor","Fnumcomp","Totdescsi","Mr","Ncai","Recmnto","Fperson","Fvtocai","Fvuelto","Nroremito","Codlista","Condpago","Ftotal","Recmonto1","Recmonto2","Motivo","Ftransp","Cotiz","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxRemcompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraFcuit ) + "'" >>, <<lxRemcompraIdcaja >>, <<lxRemcompraFpodes2 >>, <<lxRemcompraFpodes >>, <<lxRemcompraFpodes1 >>, <<lxRemcompraFturno >>, <<lxRemcompraDesmntosi2 >>, <<lxRemcompraTimestamp >>, <<lxRemcompraDesmntosi1 >>, <<lxRemcompraFptoven >>, <<lxRemcompraDesmntosi >>, <<lxRemcompraTotalcant >>, <<lxRemcompraRecmntosi2 >>, <<lxRemcompraSignomov >>, <<lxRemcompraFacttipo >>, <<lxRemcompraRecmntosi1 >>, <<lxRemcompraFsubton >>, <<lxRemcompraSitfiscpro >>, <<lxRemcompraCondivalp >>, <<lxRemcompraFsubtot >>, <<lxRemcompraRecmntosi >>, <<lxRemcompraSubtotsisi >>, <<lxRemcompraRecmnto1 >>, <<lxRemcompraSubtotcisi >>, <<lxRemcompraRecmnto2 >>, <<iif( lxRemcompraDesauto, 1, 0 ) >>, <<iif( lxRemcompraFcompfis, 1, 0 ) >>, <<iif( lxRemcompraAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxRemcompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraEsttrans ) + "'" >>, <<lxRemcompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxRemcompraCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraMonsis ) + "'" >>, <<lxRemcompraFmtdes1 >>, <<lxRemcompraFdescu >>, <<lxRemcompraFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxRemcompraFletra ) + "'" >>, <<lxRemcompraNumint >>, <<lxRemcompraFimpuesto >>, <<"'" + this.FormatearTextoSql( lxRemcompraFobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFfch ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFfchfac ) + "'" >>, <<lxRemcompraFptovenext >>, <<lxRemcompraDesmntosi3 >>, <<lxRemcompraFmtdes3 >>, <<iif( lxRemcompraImpman, 1, 0 ) >>, <<lxRemcompraRecpor >>, <<lxRemcompraFnumcomp >>, <<lxRemcompraTotdescsi >>, <<lxRemcompraMr >>, <<lxRemcompraNcai >>, <<lxRemcompraRecmnto >>, <<"'" + this.FormatearTextoSql( lxRemcompraFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemcompraFvtocai ) + "'" >>, <<lxRemcompraFvuelto >>, <<"'" + this.FormatearTextoSql( lxRemcompraNroremito ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraCondpago ) + "'" >>, <<lxRemcompraFtotal >>, <<lxRemcompraRecmonto1 >>, <<lxRemcompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxRemcompraMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemcompraFtransp ) + "'" >>, <<lxRemcompraCotiz >>, <<lxRemcompraTotimpue >>, <<lxRemcompraTotrecar >>, <<lxRemcompraTotrecarsi >>, <<lxRemcompraTotdesc >> )
		endtext
		loColeccion.cTabla = 'REMCOMPRA' 
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
					lxAfe_letra = loItem.Afe_letra
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxAfe_cantidad = loItem.Afe_cantidad
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxAfe_nroitem = loItem.Afe_nroitem
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAfe_numint = loItem.Afe_numint
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNroitem = lnContadorNroItem
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxOferta = loItem.Oferta
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPreciounitario = loItem.Preciounitario
					lxIditem = loItem.Iditem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
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
						Insert into ZooLogic.RemCompraDet("AfeNUMCOM","AfeLETRA","AfePTOVEN","MNTPRECCI","MNTPTOT","ACondIvaC","AfeSaldo","AfeCANT","MNTPPER","AfeTS","APorcIvaC","MNTPDESSI","AjuSImp","AjuCImp","COMP","AfeNroItem","FBruto","ArtPercep","NumInt","MNTPRECSI","MNDESCI","MNPDSI","MNTPDESCI","MNDESSI","AfeTipoCom","FNETO","FporCFI","NroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","FX2","fporIva","FPRUN","ciditem","iditemOrig","FN11","prunconimp","Prunsinimp","UsarPLista","ProcStock","Afe_Cod","FAMate","IdItem","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_puntodeventa>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoprorrateototal>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxAfe_cantidad>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxAfe_nroitem>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxAfe_numint>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxOferta>>, <<lxPorcentajeiva>>, <<lxPreciounitario>>, <<lxIditem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpRemComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
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
						Insert into ZooLogic.ImpRemC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxRemcompraFmodifw, lxRemcompraFaltafw, lxRemcompraFecimpo, lxRemcompraFd2, lxRemcompraFecexpo, lxRemcompraFectrans, lxRemcompraFcuit, lxRemcompraIdcaja, lxRemcompraFpodes2, lxRemcompraFpodes, lxRemcompraFpodes1, lxRemcompraFturno, lxRemcompraDesmntosi2, lxRemcompraTimestamp, lxRemcompraDesmntosi1, lxRemcompraFptoven, lxRemcompraDesmntosi, lxRemcompraTotalcant, lxRemcompraRecmntosi2, lxRemcompraSignomov, lxRemcompraFacttipo, lxRemcompraRecmntosi1, lxRemcompraFsubton, lxRemcompraSitfiscpro, lxRemcompraCondivalp, lxRemcompraFsubtot, lxRemcompraRecmntosi, lxRemcompraSubtotsisi, lxRemcompraRecmnto1, lxRemcompraSubtotcisi, lxRemcompraRecmnto2, lxRemcompraDesauto, lxRemcompraFcompfis, lxRemcompraAnulado, lxRemcompraHoraimpo, lxRemcompraUmodifw, lxRemcompraHaltafw, lxRemcompraHoraexpo, lxRemcompraHmodifw, lxRemcompraFhora, lxRemcompraDescfw, lxRemcompraSmodifw, lxRemcompraUaltafw, lxRemcompraValtafw, lxRemcompraSaltafw, lxRemcompraZadsfw, lxRemcompraVmodifw, lxRemcompraBdaltafw, lxRemcompraSimbmon, lxRemcompraBdmodifw, lxRemcompraEsttrans, lxRemcompraTcrg1361, lxRemcompraCodigo, lxRemcompraIdvuelto, lxRemcompraMoneda, lxRemcompraMonsis, lxRemcompraFmtdes1, lxRemcompraFdescu, lxRemcompraFmtdes2, lxRemcompraFletra, lxRemcompraNumint, lxRemcompraFimpuesto, lxRemcompraFobs, lxRemcompraFfch, lxRemcompraFfchfac, lxRemcompraFptovenext, lxRemcompraDesmntosi3, lxRemcompraFmtdes3, lxRemcompraImpman, lxRemcompraRecpor, lxRemcompraFnumcomp, lxRemcompraTotdescsi, lxRemcompraMr, lxRemcompraNcai, lxRemcompraRecmnto, lxRemcompraFperson, lxRemcompraFvtocai, lxRemcompraFvuelto, lxRemcompraNroremito, lxRemcompraCodlista, lxRemcompraCondpago, lxRemcompraFtotal, lxRemcompraRecmonto1, lxRemcompraRecmonto2, lxRemcompraMotivo, lxRemcompraFtransp, lxRemcompraCotiz, lxRemcompraTotimpue, lxRemcompraTotrecar, lxRemcompraTotrecarsi, lxRemcompraTotdesc
				lxRemcompraFmodifw =  .Fechamodificacionfw			lxRemcompraFaltafw =  .Fechaaltafw			lxRemcompraFecimpo =  .Fechaimpo			lxRemcompraFd2 =  .Fechamodificacion			lxRemcompraFecexpo =  .Fechaexpo			lxRemcompraFectrans =  .Fechatransferencia			lxRemcompraFcuit =  .Cuit			lxRemcompraIdcaja =  .Caja_PK 			lxRemcompraFpodes2 =  .Porcentajedescuento2			lxRemcompraFpodes =  .Porcentajedescuento			lxRemcompraFpodes1 =  .Porcentajedescuento1			lxRemcompraFturno =  .Turno			lxRemcompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxRemcompraTimestamp = goLibrerias.ObtenerTimestamp()			lxRemcompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxRemcompraFptoven =  .Puntodeventa			lxRemcompraDesmntosi =  .Montodescuentosinimpuestos			lxRemcompraTotalcant =  .Totalcantidad			lxRemcompraRecmntosi2 =  .Recargomontosinimpuestos2			lxRemcompraSignomov =  .Signodemovimiento			lxRemcompraFacttipo =  .Tipocomprobante			lxRemcompraRecmntosi1 =  .Recargomontosinimpuestos1			lxRemcompraFsubton =  .Subtotalneto			lxRemcompraSitfiscpro =  .Situacionfiscal_PK 			lxRemcompraCondivalp =  .Condicioniva			lxRemcompraFsubtot =  .Subtotalbruto			lxRemcompraRecmntosi =  .Recargomontosinimpuestos			lxRemcompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxRemcompraRecmnto1 =  .Recargomontoconimpuestos1			lxRemcompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxRemcompraRecmnto2 =  .Recargomontoconimpuestos2			lxRemcompraDesauto =  .Descuentoautomatico			lxRemcompraFcompfis =  .Comprobantefiscal			lxRemcompraAnulado =  .Anulado			lxRemcompraHoraimpo =  .Horaimpo			lxRemcompraUmodifw =  .Usuariomodificacionfw			lxRemcompraHaltafw =  .Horaaltafw			lxRemcompraHoraexpo =  .Horaexpo			lxRemcompraHmodifw =  .Horamodificacionfw			lxRemcompraFhora =  .Hora			lxRemcompraDescfw =  .Descripcionfw			lxRemcompraSmodifw =  .Seriemodificacionfw			lxRemcompraUaltafw =  .Usuarioaltafw			lxRemcompraValtafw =  .Versionaltafw			lxRemcompraSaltafw =  .Seriealtafw			lxRemcompraZadsfw =  .Zadsfw			lxRemcompraVmodifw =  .Versionmodificacionfw			lxRemcompraBdaltafw =  .Basededatosaltafw			lxRemcompraSimbmon =  .Simbolomonetariocomprobante			lxRemcompraBdmodifw =  .Basededatosmodificacionfw			lxRemcompraEsttrans =  .Estadotransferencia			lxRemcompraTcrg1361 =  .Tipocomprobanterg1361			lxRemcompraCodigo =  .Codigo			lxRemcompraIdvuelto =  upper( .IdVuelto_PK ) 			lxRemcompraMoneda =  upper( .MonedaComprobante_PK ) 			lxRemcompraMonsis =  upper( .MonedaSistema_PK ) 			lxRemcompraFmtdes1 =  .Montodescuentoconimpuestos1			lxRemcompraFdescu =  .Descuento			lxRemcompraFmtdes2 =  .Montodescuentoconimpuestos2			lxRemcompraFletra =  .Letra			lxRemcompraNumint =  .Numint			lxRemcompraFimpuesto =  .Impuestos			lxRemcompraFobs =  .Obs			lxRemcompraFfch =  .Fecha			lxRemcompraFfchfac =  .Fechafactura			lxRemcompraFptovenext =  .Puntodeventaextendido			lxRemcompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxRemcompraFmtdes3 =  .Montodescuentoconimpuestos3			lxRemcompraImpman =  .Impuestosmanuales			lxRemcompraRecpor =  .Recargoporcentaje			lxRemcompraFnumcomp =  .Numero			lxRemcompraTotdescsi =  .Totaldescuentossinimpuestos			lxRemcompraMr =  .Recargomonto			lxRemcompraNcai =  .Cai			lxRemcompraRecmnto =  .Recargomontoconimpuestos			lxRemcompraFperson =  upper( .Proveedor_PK ) 			lxRemcompraFvtocai =  .Fechavtocai			lxRemcompraFvuelto =  .Vuelto			lxRemcompraNroremito =  .Remito			lxRemcompraCodlista =  upper( .ListaDePrecios_PK ) 			lxRemcompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxRemcompraFtotal =  .Total			lxRemcompraRecmonto1 =  .Recargomonto1			lxRemcompraRecmonto2 =  .Recargomonto2			lxRemcompraMotivo =  upper( .Motivo_PK ) 			lxRemcompraFtransp =  upper( .Transportista_PK ) 			lxRemcompraCotiz =  .Cotizacion			lxRemcompraTotimpue =  .Totalimpuestos			lxRemcompraTotrecar =  .Totalrecargos			lxRemcompraTotrecarsi =  .Totalrecargossinimpuestos			lxRemcompraTotdesc =  .Totaldescuentos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41]
			text to lcSentencia noshow textmerge
				update ZooLogic.REMCOMPRA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRemcompraFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRemcompraFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRemcompraFecimpo ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxRemcompraFd2 ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRemcompraFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxRemcompraFectrans ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxRemcompraFcuit ) + "'">>, "Idcaja" = <<lxRemcompraIdcaja>>, "Fpodes2" = <<lxRemcompraFpodes2>>, "Fpodes" = <<lxRemcompraFpodes>>, "Fpodes1" = <<lxRemcompraFpodes1>>, "Fturno" = <<lxRemcompraFturno>>, "Desmntosi2" = <<lxRemcompraDesmntosi2>>, "Timestamp" = <<lxRemcompraTimestamp>>, "Desmntosi1" = <<lxRemcompraDesmntosi1>>, "Fptoven" = <<lxRemcompraFptoven>>, "Desmntosi" = <<lxRemcompraDesmntosi>>, "Totalcant" = <<lxRemcompraTotalcant>>, "Recmntosi2" = <<lxRemcompraRecmntosi2>>, "Signomov" = <<lxRemcompraSignomov>>, "Facttipo" = <<lxRemcompraFacttipo>>, "Recmntosi1" = <<lxRemcompraRecmntosi1>>, "Fsubton" = <<lxRemcompraFsubton>>, "Sitfiscpro" = <<lxRemcompraSitfiscpro>>, "Condivalp" = <<lxRemcompraCondivalp>>, "Fsubtot" = <<lxRemcompraFsubtot>>, "Recmntosi" = <<lxRemcompraRecmntosi>>, "Subtotsisi" = <<lxRemcompraSubtotsisi>>, "Recmnto1" = <<lxRemcompraRecmnto1>>, "Subtotcisi" = <<lxRemcompraSubtotcisi>>, "Recmnto2" = <<lxRemcompraRecmnto2>>, "Desauto" = <<iif( lxRemcompraDesauto, 1, 0 )>>, "Fcompfis" = <<iif( lxRemcompraFcompfis, 1, 0 )>>, "Anulado" = <<iif( lxRemcompraAnulado, 1, 0 )>>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRemcompraHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraUmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRemcompraHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRemcompraHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraHmodifw ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxRemcompraFhora ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxRemcompraDescfw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRemcompraUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRemcompraValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRemcompraSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRemcompraZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraVmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRemcompraBdaltafw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxRemcompraSimbmon ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRemcompraBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRemcompraEsttrans ) + "'">>, "Tcrg1361" = <<lxRemcompraTcrg1361>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxRemcompraCodigo ) + "'">>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxRemcompraIdvuelto ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxRemcompraMoneda ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxRemcompraMonsis ) + "'">>, "Fmtdes1" = <<lxRemcompraFmtdes1>>, "Fdescu" = <<lxRemcompraFdescu>>, "Fmtdes2" = <<lxRemcompraFmtdes2>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxRemcompraFletra ) + "'">>, "Numint" = <<lxRemcompraNumint>>, "Fimpuesto" = <<lxRemcompraFimpuesto>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxRemcompraFobs ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxRemcompraFfch ) + "'">>, "Ffchfac" = <<"'" + this.ConvertirDateSql( lxRemcompraFfchfac ) + "'">>, "Fptovenext" = <<lxRemcompraFptovenext>>, "Desmntosi3" = <<lxRemcompraDesmntosi3>>, "Fmtdes3" = <<lxRemcompraFmtdes3>>, "Impman" = <<iif( lxRemcompraImpman, 1, 0 )>>, "Recpor" = <<lxRemcompraRecpor>>, "Fnumcomp" = <<lxRemcompraFnumcomp>>, "Totdescsi" = <<lxRemcompraTotdescsi>>, "Mr" = <<lxRemcompraMr>>, "Ncai" = <<lxRemcompraNcai>>, "Recmnto" = <<lxRemcompraRecmnto>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxRemcompraFperson ) + "'">>, "Fvtocai" = <<"'" + this.ConvertirDateSql( lxRemcompraFvtocai ) + "'">>, "Fvuelto" = <<lxRemcompraFvuelto>>, "Nroremito" = <<"'" + this.FormatearTextoSql( lxRemcompraNroremito ) + "'">>, "Codlista" = <<"'" + this.FormatearTextoSql( lxRemcompraCodlista ) + "'">>, "Condpago" = <<"'" + this.FormatearTextoSql( lxRemcompraCondpago ) + "'">>, "Ftotal" = <<lxRemcompraFtotal>>, "Recmonto1" = <<lxRemcompraRecmonto1>>, "Recmonto2" = <<lxRemcompraRecmonto2>>, "Motivo" = <<"'" + this.FormatearTextoSql( lxRemcompraMotivo ) + "'">>, "Ftransp" = <<"'" + this.FormatearTextoSql( lxRemcompraFtransp ) + "'">>, "Cotiz" = <<lxRemcompraCotiz>>, "Totimpue" = <<lxRemcompraTotimpue>>, "Totrecar" = <<lxRemcompraTotrecar>>, "Totrecarsi" = <<lxRemcompraTotrecarsi>>, "Totdesc" = <<lxRemcompraTotdesc>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REMCOMPRA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.RemCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpRemComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpRemC where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
					lxAfe_letra = loItem.Afe_letra
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_saldo = loItem.Afe_saldo
					lxAfe_cantidad = loItem.Afe_cantidad
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxComportamiento = loItem.Comportamiento
					lxAfe_nroitem = loItem.Afe_nroitem
					lxBruto = loItem.Bruto
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAfe_numint = loItem.Afe_numint
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxNeto = loItem.Neto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNroitem = lnContadorNroItem
					lxMontoiva = loItem.Montoiva
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxOferta = loItem.Oferta
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPreciounitario = loItem.Preciounitario
					lxIditem = loItem.Iditem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxAfe_codigo = loItem.Afe_codigo
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
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
						Insert into ZooLogic.RemCompraDet("AfeNUMCOM","AfeLETRA","AfePTOVEN","MNTPRECCI","MNTPTOT","ACondIvaC","AfeSaldo","AfeCANT","MNTPPER","AfeTS","APorcIvaC","MNTPDESSI","AjuSImp","AjuCImp","COMP","AfeNroItem","FBruto","ArtPercep","NumInt","MNTPRECSI","MNDESCI","MNPDSI","MNTPDESCI","MNDESSI","AfeTipoCom","FNETO","FporCFI","NroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","FX2","fporIva","FPRUN","ciditem","iditemOrig","FN11","prunconimp","Prunsinimp","UsarPLista","ProcStock","Afe_Cod","FAMate","IdItem","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_puntodeventa>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoprorrateototal>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_saldo>>, <<lxAfe_cantidad>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxArticulo_porcentajeivacompras>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxComportamiento>>, <<lxAfe_nroitem>>, <<lxBruto>>, <<lxPercepcionivarg5329>>, <<lxAfe_numint>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxNeto>>, <<lxPorcentajecfi>>, <<lxNroitem>>, <<lxMontoiva>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxOferta>>, <<lxPorcentajeiva>>, <<lxPreciounitario>>, <<lxIditem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
						Insert into ZooLogic.ImpRemComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
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
						Insert into ZooLogic.ImpRemC("minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto" ) values ( <<lxMinimonoimponible>>, <<lxNroitem>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41]
		loColeccion.Agregar( 'delete from ZooLogic.REMCOMPRA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.RemCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpRemComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpRemC where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'REMCOMPRA' 
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
					"Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afesaldo" as "Afe_saldo", "Afecant" as "Afe_cantidad", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Aporcivac" as "Articulo_porcentajeivacompras", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Comp" as "Comportamiento", "Afenroitem" as "Afe_nroitem", "Fbruto" as "Bruto", "Artpercep" as "Percepcionivarg5329", "Numint" as "Afe_numint", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Fneto" as "Neto", "Fporcfi" as "Porcentajecfi", "Nroitem" as "Nroitem", "Fmtoiva" as "Montoiva", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Fx2" as "Oferta", "Fporiva" as "Porcentajeiva", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Afe_cod" as "Afe_codigo", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Mntpiva" as "Montoprorrateoiva", "Seniacance" as "Idseniacancelada", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
		return lcAtributos
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.REMCOMPRA where  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.REMCOMPRA where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxRemCompraFACTTIPO as variant, lxRemCompraNumInt as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITODECOMPRA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.REMCOMPRA Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and NumInt = ] + transform( &lcCursor..NumInt     ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.REMCOMPRA set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, SitFiscPro = ] + transform( &lcCursor..SitFiscPro )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, DesAuto = ] + Transform( iif( &lcCursor..DesAuto, 1, 0 ))+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, tcrg1361 = ] + transform( &lcCursor..tcrg1361 )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, NumInt = ] + transform( &lcCursor..NumInt )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FFCHFAC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"+ [, FPTOVENEXT = ] + transform( &lcCursor..FPTOVENEXT )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, ImpMan = ] + Transform( iif( &lcCursor..ImpMan, 1, 0 ))+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, MR = ] + transform( &lcCursor..MR )+ [, NCAI = ] + transform( &lcCursor..NCAI )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FVTOCAI = ] + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'"+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, NROREMITO = ] + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, CONDPAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, RecMonto1 = ] + transform( &lcCursor..RecMonto1 )+ [, RecMonto2 = ] + transform( &lcCursor..RecMonto2 )+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, FTransp = ] + "'" + this.FormatearTextoSql( &lcCursor..FTransp ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, totdesc = ] + transform( &lcCursor..totdesc ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.REMCOMPRA Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FALTAFW, FECIMPO, FD2, FECEXPO, FECTRANS, fCuit, IdCaja, FPODES2, FPODES, FPODES1, FTurno, DesMntoSI2, TIMESTAMP, DesMntoSI1, FPTOVEN, DesMntoSI, TotalCant, RecMntoSI2, signomov, FACTTIPO, RecMntoSI1, fSubToN, SitFiscPro, CondivaLp, FSubTOT, RecMntoSI, SubTotSISI, RecMnto1, SubTotCISI, RecMnto2, DesAuto, FCOMPFIS, Anulado, HORAIMPO, UMODIFW, HALTAFW, HORAEXPO, HMODIFW, FHORA, DescFW, SMODIFW, UALTAFW, VALTAFW, SALTAFW, ZADSFW, VMODIFW, BDALTAFW, SimbMon, BDMODIFW, ESTTRANS, tcrg1361, CODIGO, idVuelto, Moneda, MonSis, FMTDES1, fDescu, FMTDES2, FLETRA, NumInt, fImpuesto, FObs, FFCH, FFCHFAC, FPTOVENEXT, DesMntoSI3, FMTDES3, ImpMan, RecPor, FNUMCOMP, totdescSI, MR, NCAI, RecMnto, FPerson, FVTOCAI, FVuelto, NROREMITO, CodLista, CONDPAGO, FTotal, RecMonto1, RecMonto2, MOTIVO, FTransp, Cotiz, totimpue, totrecar, totrecarSI, totdesc
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..FPODES1 ) + ',' + transform( &lcCursor..FTurno ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..DesMntoSI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..SitFiscPro ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..RecMntoSI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + Transform( iif( &lcCursor..DesAuto, 1, 0 )) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + transform( &lcCursor..tcrg1361 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + transform( &lcCursor..FMTDES1 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..fDescu ) + ',' + transform( &lcCursor..FMTDES2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..NumInt ) + ',' + transform( &lcCursor..fImpuesto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FPTOVENEXT ) + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + transform( &lcCursor..FMTDES3 ) + ',' + Transform( iif( &lcCursor..ImpMan, 1, 0 )) + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..totdescSI ) + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..NCAI ) + ',' + transform( &lcCursor..RecMnto )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'" + ',' + transform( &lcCursor..FVuelto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'" + ',' + transform( &lcCursor..FTotal )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecMonto1 ) + ',' + transform( &lcCursor..RecMonto2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FTransp ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..totrecar ) + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..totdesc )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.REMCOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITODECOMPRA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.RemCompraDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpRemComp Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpRemC Where cCod] + lcIn  )
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSREMCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeNUMCOM","AfeLETRA","AfePTOVEN","MNTPRECCI","MNTPTOT","ACondIvaC","AfeSaldo","AfeCANT","MNTPPER","AfeTS","APorcIvaC","MNTPDESSI","AjuSImp","AjuCImp","COMP","AfeNroItem","FBruto","ArtPercep","NumInt","MNTPRECSI","MNDESCI","MNPDSI","MNTPDESCI","MNDESSI","AfeTipoCom","FNETO","FporCFI","NroItem","FmtoIVA","FmtoCFI","FmtoDTO1","FCFITot","FKIT","FporDTO1","FX2","fporIva","FPRUN","ciditem","iditemOrig","FN11","prunconimp","Prunsinimp","UsarPLista","ProcStock","Afe_Cod","FAMate","IdItem","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","FCOTXT","FTALL","MNTPIVA","seniacance","FCANT","FPRECIO","FCFI","MNTDES","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.RemCompraDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.ACondIvaC  ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.APorcIvaC  ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.NumInt     ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afe_Cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSREMC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpRemComp ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOREMCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"minoimp","NroItem","porcen","TipoI","codint","cCod","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpRemC ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.porcen     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSREMCOMPRA', this.oEntidad.cPrefijoRecibir + 'REMITODECOMPRA')
		
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
			Case  lcAlias == lcPrefijo + 'REMITODECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REMITODECOMPRA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REMITODECOMPRA_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSREMCOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSREMC'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOREMCOMPRA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_RemCompra')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REMITODECOMPRA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..NumInt )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REMITODECOMPRA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITODECOMPRA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITODECOMPRA'
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
		* Validar ANTERIORES A 1/1/1753  FVTOCAI   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_RemCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_RemCompra
Create Table ZooLogic.TablaTrabajo_RemCompra ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fd2" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fturno" numeric( 1, 0 )  null, 
"desmntosi2" numeric( 15, 2 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"desmntosi1" numeric( 15, 2 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"desmntosi" numeric( 15, 2 )  null, 
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
"recmnto1" numeric( 15, 2 )  null, 
"subtotcisi" numeric( 15, 2 )  null, 
"recmnto2" numeric( 15, 2 )  null, 
"desauto" bit  null, 
"fcompfis" bit  null, 
"anulado" bit  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"fhora" char( 8 )  null, 
"descfw" char( 200 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"simbmon" char( 3 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"tcrg1361" numeric( 1, 0 )  null, 
"codigo" char( 38 )  null, 
"idvuelto" char( 5 )  null, 
"moneda" char( 10 )  null, 
"monsis" char( 10 )  null, 
"fmtdes1" numeric( 15, 2 )  null, 
"fdescu" numeric( 15, 2 )  null, 
"fmtdes2" numeric( 15, 2 )  null, 
"fletra" char( 1 )  null, 
"numint" numeric( 10, 0 )  null, 
"fimpuesto" numeric( 15, 2 )  null, 
"fobs" varchar(max)  null, 
"ffch" datetime  null, 
"ffchfac" datetime  null, 
"fptovenext" numeric( 5, 0 )  null, 
"desmntosi3" numeric( 15, 2 )  null, 
"fmtdes3" numeric( 6, 2 )  null, 
"impman" bit  null, 
"recpor" numeric( 6, 2 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"totdescsi" numeric( 15, 2 )  null, 
"mr" numeric( 15, 2 )  null, 
"ncai" numeric( 14, 0 )  null, 
"recmnto" numeric( 15, 2 )  null, 
"fperson" char( 5 )  null, 
"fvtocai" datetime  null, 
"fvuelto" numeric( 15, 2 )  null, 
"nroremito" char( 15 )  null, 
"codlista" char( 6 )  null, 
"condpago" char( 5 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"recmonto1" numeric( 15, 2 )  null, 
"recmonto2" numeric( 15, 2 )  null, 
"motivo" char( 3 )  null, 
"ftransp" char( 6 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"totimpue" numeric( 15, 2 )  null, 
"totrecar" numeric( 15, 2 )  null, 
"totrecarsi" numeric( 15, 2 )  null, 
"totdesc" numeric( 15, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_RemCompra' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_RemCompra' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITODECOMPRA'
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
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('desmntosi','desmntosi')
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
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('desauto','desauto')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('tcrg1361','tcrg1361')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('numint','numint')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('ffchfac','ffchfac')
			.AgregarMapeo('fptovenext','fptovenext')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('impman','impman')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('ncai','ncai')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fvtocai','fvtocai')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('nroremito','nroremito')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('condpago','condpago')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('recmonto1','recmonto1')
			.AgregarMapeo('recmonto2','recmonto2')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('ftransp','ftransp')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('totdesc','totdesc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_RemCompra'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.SITFISCPRO = isnull( d.SITFISCPRO, t.SITFISCPRO ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.DESAUTO = isnull( d.DESAUTO, t.DESAUTO ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.TCRG1361 = isnull( d.TCRG1361, t.TCRG1361 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.NUMINT = isnull( d.NUMINT, t.NUMINT ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FFCHFAC = isnull( d.FFCHFAC, t.FFCHFAC ),t.FPTOVENEXT = isnull( d.FPTOVENEXT, t.FPTOVENEXT ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.IMPMAN = isnull( d.IMPMAN, t.IMPMAN ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.MR = isnull( d.MR, t.MR ),t.NCAI = isnull( d.NCAI, t.NCAI ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FVTOCAI = isnull( d.FVTOCAI, t.FVTOCAI ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.NROREMITO = isnull( d.NROREMITO, t.NROREMITO ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.RECMONTO1 = isnull( d.RECMONTO1, t.RECMONTO1 ),t.RECMONTO2 = isnull( d.RECMONTO2, t.RECMONTO2 ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.FTRANSP = isnull( d.FTRANSP, t.FTRANSP ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC )
					from ZooLogic.REMCOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.NumInt = d.NumInt
				-- Fin Updates
				insert into ZooLogic.REMCOMPRA(Fmodifw,Faltafw,Fecimpo,Fd2,Fecexpo,Fectrans,Fcuit,Idcaja,Fpodes2,Fpodes,Fpodes1,Fturno,Desmntosi2,Timestamp,Desmntosi1,Fptoven,Desmntosi,Totalcant,Recmntosi2,Signomov,Facttipo,Recmntosi1,Fsubton,Sitfiscpro,Condivalp,Fsubtot,Recmntosi,Subtotsisi,Recmnto1,Subtotcisi,Recmnto2,Desauto,Fcompfis,Anulado,Horaimpo,Umodifw,Haltafw,Horaexpo,Hmodifw,Fhora,Descfw,Smodifw,Ualtafw,Valtafw,Saltafw,Zadsfw,Vmodifw,Bdaltafw,Simbmon,Bdmodifw,Esttrans,Tcrg1361,Codigo,Idvuelto,Moneda,Monsis,Fmtdes1,Fdescu,Fmtdes2,Fletra,Numint,Fimpuesto,Fobs,Ffch,Ffchfac,Fptovenext,Desmntosi3,Fmtdes3,Impman,Recpor,Fnumcomp,Totdescsi,Mr,Ncai,Recmnto,Fperson,Fvtocai,Fvuelto,Nroremito,Codlista,Condpago,Ftotal,Recmonto1,Recmonto2,Motivo,Ftransp,Cotiz,Totimpue,Totrecar,Totrecarsi,Totdesc)
					Select isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FD2,''),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FPODES2,0),isnull( d.FPODES,0),isnull( d.FPODES1,0),isnull( d.FTURNO,0),isnull( d.DESMNTOSI2,0),isnull( d.TIMESTAMP,0),isnull( d.DESMNTOSI1,0),isnull( d.FPTOVEN,0),isnull( d.DESMNTOSI,0),isnull( d.TOTALCANT,0),isnull( d.RECMNTOSI2,0),isnull( d.SIGNOMOV,0),isnull( d.FACTTIPO,0),isnull( d.RECMNTOSI1,0),isnull( d.FSUBTON,0),isnull( d.SITFISCPRO,0),isnull( d.CONDIVALP,0),isnull( d.FSUBTOT,0),isnull( d.RECMNTOSI,0),isnull( d.SUBTOTSISI,0),isnull( d.RECMNTO1,0),isnull( d.SUBTOTCISI,0),isnull( d.RECMNTO2,0),isnull( d.DESAUTO,0),isnull( d.FCOMPFIS,0),isnull( d.ANULADO,0),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.FHORA,''),isnull( d.DESCFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.SIMBMON,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.TCRG1361,0),isnull( d.CODIGO,''),isnull( d.IDVUELTO,''),isnull( d.MONEDA,''),isnull( d.MONSIS,''),isnull( d.FMTDES1,0),isnull( d.FDESCU,0),isnull( d.FMTDES2,0),isnull( d.FLETRA,''),isnull( d.NUMINT,0),isnull( d.FIMPUESTO,0),isnull( d.FOBS,''),isnull( d.FFCH,''),isnull( d.FFCHFAC,''),isnull( d.FPTOVENEXT,0),isnull( d.DESMNTOSI3,0),isnull( d.FMTDES3,0),isnull( d.IMPMAN,0),isnull( d.RECPOR,0),isnull( d.FNUMCOMP,0),isnull( d.TOTDESCSI,0),isnull( d.MR,0),isnull( d.NCAI,0),isnull( d.RECMNTO,0),isnull( d.FPERSON,''),isnull( d.FVTOCAI,''),isnull( d.FVUELTO,0),isnull( d.NROREMITO,''),isnull( d.CODLISTA,''),isnull( d.CONDPAGO,''),isnull( d.FTOTAL,0),isnull( d.RECMONTO1,0),isnull( d.RECMONTO2,0),isnull( d.MOTIVO,''),isnull( d.FTRANSP,''),isnull( d.COTIZ,0),isnull( d.TOTIMPUE,0),isnull( d.TOTRECAR,0),isnull( d.TOTRECARSI,0),isnull( d.TOTDESC,0)
						From deleted d left join ZooLogic.REMCOMPRA pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.REMCOMPRA cc 
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
					from ZooLogic.REMCOMPRA t inner join deleted d 
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
					from ZooLogic.REMCOMPRA t inner join deleted d 
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
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REMCOMPRA_CompAfe
ON ZooLogic.TablaTrabajo_REMCOMPRA_CompAfe
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
	function ObtenerTriggerDeleteImportacion_RemCompraDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REMCOMPRA_RemCompraDet
ON ZooLogic.TablaTrabajo_REMCOMPRA_RemCompraDet
AFTER DELETE
As
Begin
Update t Set 
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.ACONDIVAC = isnull( d.ACONDIVAC, t.ACONDIVAC ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.APORCIVAC = isnull( d.APORCIVAC, t.APORCIVAC ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.COMP = isnull( d.COMP, t.COMP ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.NUMINT = isnull( d.NUMINT, t.NUMINT ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.FAMATE = isnull( d.FAMATE, t.FAMATE ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
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
from ZooLogic.RemCompraDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.RemCompraDet
( 
"AFENUMCOM",
"AFELETRA",
"AFEPTOVEN",
"MNTPRECCI",
"MNTPTOT",
"ACONDIVAC",
"AFESALDO",
"AFECANT",
"MNTPPER",
"AFETS",
"APORCIVAC",
"MNTPDESSI",
"AJUSIMP",
"AJUCIMP",
"COMP",
"AFENROITEM",
"FBRUTO",
"ARTPERCEP",
"NUMINT",
"MNTPRECSI",
"MNDESCI",
"MNPDSI",
"MNTPDESCI",
"MNDESSI",
"AFETIPOCOM",
"FNETO",
"FPORCFI",
"NROITEM",
"FMTOIVA",
"FMTOCFI",
"FMTODTO1",
"FCFITOT",
"FKIT",
"FPORDTO1",
"FX2",
"FPORIVA",
"FPRUN",
"CIDITEM",
"IDITEMORIG",
"FN11",
"PRUNCONIMP",
"PRUNSINIMP",
"USARPLISTA",
"PROCSTOCK",
"AFE_COD",
"FAMATE",
"IDITEM",
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
d.AFENUMCOM,
d.AFELETRA,
d.AFEPTOVEN,
d.MNTPRECCI,
d.MNTPTOT,
d.ACONDIVAC,
d.AFESALDO,
d.AFECANT,
d.MNTPPER,
d.AFETS,
d.APORCIVAC,
d.MNTPDESSI,
d.AJUSIMP,
d.AJUCIMP,
d.COMP,
d.AFENROITEM,
d.FBRUTO,
d.ARTPERCEP,
d.NUMINT,
d.MNTPRECSI,
d.MNDESCI,
d.MNPDSI,
d.MNTPDESCI,
d.MNDESSI,
d.AFETIPOCOM,
d.FNETO,
d.FPORCFI,
d.NROITEM,
d.FMTOIVA,
d.FMTOCFI,
d.FMTODTO1,
d.FCFITOT,
d.FKIT,
d.FPORDTO1,
d.FX2,
d.FPORIVA,
d.FPRUN,
d.CIDITEM,
d.IDITEMORIG,
d.FN11,
d.PRUNCONIMP,
d.PRUNSINIMP,
d.USARPLISTA,
d.PROCSTOCK,
d.AFE_COD,
d.FAMATE,
d.IDITEM,
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
From deleted d left join ZooLogic.RemCompraDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpRemComp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REMCOMPRA_ImpRemComp
ON ZooLogic.TablaTrabajo_REMCOMPRA_ImpRemComp
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
from ZooLogic.ImpRemComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpRemComp
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
From deleted d left join ZooLogic.ImpRemComp pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpRemC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REMCOMPRA_ImpRemC
ON ZooLogic.TablaTrabajo_REMCOMPRA_ImpRemC
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
from ZooLogic.ImpRemC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpRemC
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
From deleted d left join ZooLogic.ImpRemC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_RemCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_RemCompra
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REMITODECOMPRA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITODECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITODECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITODECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITODECOMPRA.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITODECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITODECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_REMITODECOMPRA.Cuit, [] )
					.Caja_PK =  nvl( c_REMITODECOMPRA.Caja, 0 )
					.Porcentajedescuento2 = nvl( c_REMITODECOMPRA.Porcentajedescuento2, 0 )
					.Porcentajedescuento = nvl( c_REMITODECOMPRA.Porcentajedescuento, 0 )
					.Porcentajedescuento1 = nvl( c_REMITODECOMPRA.Porcentajedescuento1, 0 )
					.Turno = nvl( c_REMITODECOMPRA.Turno, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Montodescuentosinimpuestos2 = nvl( c_REMITODECOMPRA.Montodescuentosinimpuestos2, 0 )
					.Timestamp = nvl( c_REMITODECOMPRA.Timestamp, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_REMITODECOMPRA.Montodescuentosinimpuestos1, 0 )
					.Puntodeventa = nvl( c_REMITODECOMPRA.Puntodeventa, 0 )
					.Montodescuentosinimpuestos = nvl( c_REMITODECOMPRA.Montodescuentosinimpuestos, 0 )
					.Totalcantidad = nvl( c_REMITODECOMPRA.Totalcantidad, 0 )
					.Recargomontosinimpuestos2 = nvl( c_REMITODECOMPRA.Recargomontosinimpuestos2, 0 )
					.Signodemovimiento = nvl( c_REMITODECOMPRA.Signodemovimiento, 0 )
					.Tipocomprobante = nvl( c_REMITODECOMPRA.Tipocomprobante, 0 )
					.Recargomontosinimpuestos1 = nvl( c_REMITODECOMPRA.Recargomontosinimpuestos1, 0 )
					.Subtotalneto = nvl( c_REMITODECOMPRA.Subtotalneto, 0 )
					.Situacionfiscal_PK =  nvl( c_REMITODECOMPRA.Situacionfiscal, 0 )
					.Condicioniva = nvl( c_REMITODECOMPRA.Condicioniva, 0 )
					.Subtotalbruto = nvl( c_REMITODECOMPRA.Subtotalbruto, 0 )
					.Recargomontosinimpuestos = nvl( c_REMITODECOMPRA.Recargomontosinimpuestos, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_REMITODECOMPRA.Subtotalsinimpuestossobreitems, 0 )
					.Recargomontoconimpuestos1 = nvl( c_REMITODECOMPRA.Recargomontoconimpuestos1, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_REMITODECOMPRA.Subtotalconimpuestossobreitems, 0 )
					.Recargomontoconimpuestos2 = nvl( c_REMITODECOMPRA.Recargomontoconimpuestos2, 0 )
					.Descuentoautomatico = nvl( c_REMITODECOMPRA.Descuentoautomatico, .F. )
					.Comprobantefiscal = nvl( c_REMITODECOMPRA.Comprobantefiscal, .F. )
					.Anulado = nvl( c_REMITODECOMPRA.Anulado, .F. )
					.Horaimpo = nvl( c_REMITODECOMPRA.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_REMITODECOMPRA.Usuariomodificacionfw, [] )
					.Horaaltafw = nvl( c_REMITODECOMPRA.Horaaltafw, [] )
					.Horaexpo = nvl( c_REMITODECOMPRA.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_REMITODECOMPRA.Horamodificacionfw, [] )
					.Hora = nvl( c_REMITODECOMPRA.Hora, [] )
					.Descripcionfw = nvl( c_REMITODECOMPRA.Descripcionfw, [] )
					.Seriemodificacionfw = nvl( c_REMITODECOMPRA.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_REMITODECOMPRA.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_REMITODECOMPRA.Versionaltafw, [] )
					.Seriealtafw = nvl( c_REMITODECOMPRA.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_REMITODECOMPRA.Versionmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_REMITODECOMPRA.Basededatosaltafw, [] )
					.Simbolomonetariocomprobante = nvl( c_REMITODECOMPRA.Simbolomonetariocomprobante, [] )
					.Basededatosmodificacionfw = nvl( c_REMITODECOMPRA.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_REMITODECOMPRA.Estadotransferencia, [] )
					.Tipocomprobanterg1361 = nvl( c_REMITODECOMPRA.Tipocomprobanterg1361, 0 )
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Codigo = nvl( c_REMITODECOMPRA.Codigo, [] )
					.Idvuelto_PK =  nvl( c_REMITODECOMPRA.Idvuelto, [] )
					.Monedacomprobante_PK =  nvl( c_REMITODECOMPRA.Monedacomprobante, [] )
					.Monedasistema_PK =  nvl( c_REMITODECOMPRA.Monedasistema, [] )
					.Montodescuentoconimpuestos1 = nvl( c_REMITODECOMPRA.Montodescuentoconimpuestos1, 0 )
					.Descuento = nvl( c_REMITODECOMPRA.Descuento, 0 )
					.Montodescuentoconimpuestos2 = nvl( c_REMITODECOMPRA.Montodescuentoconimpuestos2, 0 )
					.Letra = nvl( c_REMITODECOMPRA.Letra, [] )
					.Numint = nvl( c_REMITODECOMPRA.Numint, 0 )
					.Impuestos = nvl( c_REMITODECOMPRA.Impuestos, 0 )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITODECOMPRA.Fecha, ctod( '  /  /    ' ) ) )
					.Fechafactura = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITODECOMPRA.Fechafactura, ctod( '  /  /    ' ) ) )
					.Puntodeventaextendido = nvl( c_REMITODECOMPRA.Puntodeventaextendido, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_REMITODECOMPRA.Montodescuentosinimpuestos3, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_REMITODECOMPRA.Montodescuentoconimpuestos3, 0 )
					.Impuestosmanuales = nvl( c_REMITODECOMPRA.Impuestosmanuales, .F. )
					.Recargoporcentaje = nvl( c_REMITODECOMPRA.Recargoporcentaje, 0 )
					.Numero = nvl( c_REMITODECOMPRA.Numero, 0 )
					.Totaldescuentossinimpuestos = nvl( c_REMITODECOMPRA.Totaldescuentossinimpuestos, 0 )
					.Recargomonto = nvl( c_REMITODECOMPRA.Recargomonto, 0 )
					.Cai = nvl( c_REMITODECOMPRA.Cai, 0 )
					.Recargomontoconimpuestos = nvl( c_REMITODECOMPRA.Recargomontoconimpuestos, 0 )
					.Proveedor_PK =  nvl( c_REMITODECOMPRA.Proveedor, [] )
					.Fechavtocai = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITODECOMPRA.Fechavtocai, ctod( '  /  /    ' ) ) )
					.Vuelto = nvl( c_REMITODECOMPRA.Vuelto, 0 )
					.Remito = nvl( c_REMITODECOMPRA.Remito, [] )
					.Listadeprecios_PK =  nvl( c_REMITODECOMPRA.Listadeprecios, [] )
					.Condicionpagopreferente_PK =  nvl( c_REMITODECOMPRA.Condicionpagopreferente, [] )
					.Total = nvl( c_REMITODECOMPRA.Total, 0 )
					.Recargomonto1 = nvl( c_REMITODECOMPRA.Recargomonto1, 0 )
					.Recargomonto2 = nvl( c_REMITODECOMPRA.Recargomonto2, 0 )
					.Motivo_PK =  nvl( c_REMITODECOMPRA.Motivo, [] )
					.Transportista_PK =  nvl( c_REMITODECOMPRA.Transportista, [] )
					.Cotizacion = nvl( c_REMITODECOMPRA.Cotizacion, 0 )
					.Totalimpuestos = nvl( c_REMITODECOMPRA.Totalimpuestos, 0 )
					.Totalrecargos = nvl( c_REMITODECOMPRA.Totalrecargos, 0 )
					.Totalrecargossinimpuestos = nvl( c_REMITODECOMPRA.Totalrecargossinimpuestos, 0 )
					.Totaldescuentos = nvl( c_REMITODECOMPRA.Totaldescuentos, 0 )
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
			lxRetorno = c_REMITODECOMPRA.CODIGO
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
				lcSentencia = "UPDATE ZooLogic.RemCompraDet"
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
		return c_REMITODECOMPRA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.REMCOMPRA' )
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
								from ZooLogic.REMCOMPRA 
								Where   REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REMCOMPRA", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fpodes1" as "Porcentajedescuento1", "Fturno" as "Turno", "Desmntosi2" as "Montodescuentosinimpuestos2", "Timestamp" as "Timestamp", "Desmntosi1" as "Montodescuentosinimpuestos1", "Fptoven" as "Puntodeventa", "Desmntosi" as "Montodescuentosinimpuestos", "Totalcant" as "Totalcantidad", "Recmntosi2" as "Recargomontosinimpuestos2", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Recmntosi1" as "Recargomontosinimpuestos1", "Fsubton" as "Subtotalneto", "Sitfiscpro" as "Situacionfiscal", "Condivalp" as "Condicioniva", "Fsubtot" as "Subtotalbruto", "Recmntosi" as "Recargomontosinimpuestos", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmnto1" as "Recargomontoconimpuestos1", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmnto2" as "Recargomontoconimpuestos2", "Desauto" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Anulado" as "Anulado", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Fhora" as "Hora", "Descfw" as "Descripcionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Idvuelto" as "Idvuelto", "Moneda" as "Monedacomprobante", "Monsis" as "Monedasistema", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fletra" as "Letra", "Numint" as "Numint", "Fimpuesto" as "Impuestos", "Fobs" as "Obs", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fptovenext" as "Puntodeventaextendido", "Desmntosi3" as "Montodescuentosinimpuestos3", "Fmtdes3" as "Montodescuentoconimpuestos3", "Impman" as "Impuestosmanuales", "Recpor" as "Recargoporcentaje", "Fnumcomp" as "Numero", "Totdescsi" as "Totaldescuentossinimpuestos", "Mr" as "Recargomonto", "Ncai" as "Cai", "Recmnto" as "Recargomontoconimpuestos", "Fperson" as "Proveedor", "Fvtocai" as "Fechavtocai", "Fvuelto" as "Vuelto", "Nroremito" as "Remito", "Codlista" as "Listadeprecios", "Condpago" as "Condicionpagopreferente", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Motivo" as "Motivo", "Ftransp" as "Transportista", "Cotiz" as "Cotizacion", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.REMCOMPRA 
								Where   REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41
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
	Tabla = 'REMCOMPRA'
	Filtro = " REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REMCOMPRA.CODIGO != '' AND REMCOMPRA.FACTTIPO = 41"
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
	<row entidad="REMITODECOMPRA                          " atributo="FECHAMODIFICACIONFW                     " tabla="REMCOMPRA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="FECHAALTAFW                             " tabla="REMCOMPRA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="FECHAIMPO                               " tabla="REMCOMPRA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="FECHAMODIFICACION                       " tabla="REMCOMPRA      " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="FECHAEXPO                               " tabla="REMCOMPRA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="FECHATRANSFERENCIA                      " tabla="REMCOMPRA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="CUIT                                    " tabla="REMCOMPRA      " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="proveedor.cuit                                                                                                                                                                                                                                                " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="CAJA                                    " tabla="REMCOMPRA      " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="PORCENTAJEDESCUENTO2                    " tabla="REMCOMPRA      " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="PORCENTAJEDESCUENTO                     " tabla="REMCOMPRA      " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="% Descuento                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="PORCENTAJEDESCUENTO1                    " tabla="REMCOMPRA      " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TURNO                                   " tabla="REMCOMPRA      " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="REMCOMPRA      " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TIMESTAMP                               " tabla="REMCOMPRA      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="REMCOMPRA      " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="PUNTODEVENTA                            " tabla="REMCOMPRA      " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Pto. de venta                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="REMCOMPRA      " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TOTALCANTIDAD                           " tabla="REMCOMPRA      " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total Cantidad                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="REMCOMPRA      " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="SIGNODEMOVIMIENTO                       " tabla="REMCOMPRA      " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TIPOCOMPROBANTE                         " tabla="REMCOMPRA      " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=41                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="REMCOMPRA      " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="SUBTOTALNETO                            " tabla="REMCOMPRA      " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="SITUACIONFISCAL                         " tabla="REMCOMPRA      " campo="SITFISCPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sit. Fis.                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="proveedor.SituacionFiscal                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="CONDICIONIVA                            " tabla="REMCOMPRA      " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="SUBTOTALBRUTO                           " tabla="REMCOMPRA      " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="REMCOMPRA      " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="REMCOMPRA      " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="REMCOMPRA      " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="REMCOMPRA      " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="REMCOMPRA      " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="DESCUENTOAUTOMATICO                     " tabla="REMCOMPRA      " campo="DESAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="COMPROBANTEFISCAL                       " tabla="REMCOMPRA      " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="ANULADO                                 " tabla="REMCOMPRA      " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Está anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="HORAIMPO                                " tabla="REMCOMPRA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="USUARIOMODIFICACIONFW                   " tabla="REMCOMPRA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="HORAALTAFW                              " tabla="REMCOMPRA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="HORAEXPO                                " tabla="REMCOMPRA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="HORAMODIFICACIONFW                      " tabla="REMCOMPRA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="HORA                                    " tabla="REMCOMPRA      " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="DESCRIPCIONFW                           " tabla="REMCOMPRA      " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="SERIEMODIFICACIONFW                     " tabla="REMCOMPRA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="USUARIOALTAFW                           " tabla="REMCOMPRA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="VERSIONALTAFW                           " tabla="REMCOMPRA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="SERIEALTAFW                             " tabla="REMCOMPRA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="ZADSFW                                  " tabla="REMCOMPRA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="VERSIONMODIFICACIONFW                   " tabla="REMCOMPRA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="BASEDEDATOSALTAFW                       " tabla="REMCOMPRA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="REMCOMPRA      " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REMCOMPRA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="ESTADOTRANSFERENCIA                     " tabla="REMCOMPRA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TIPOCOMPROBANTERG1361                   " tabla="REMCOMPRA      " campo="TCRG1361  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo factura                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="FACTURADETALLE                          " tabla="REMCOMPRADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMARTICULOSREMCOMPRA " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="IMPUESTOSDETALLE                        " tabla="IMPREMCOMP     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOSREMC      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="CODIGO                                  " tabla="REMCOMPRA      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Nro interno                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="IDVUELTO                                " tabla="REMCOMPRA      " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MONEDACOMPROBANTE                       " tabla="REMCOMPRA      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Moneda comprobante                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MONEDASISTEMA                           " tabla="REMCOMPRA      " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="REMCOMPRA      " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="DESCUENTO                               " tabla="REMCOMPRA      " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="% Descuento                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="REMCOMPRA      " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="LETRA                                   " tabla="REMCOMPRA      " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="X                                                                                                                                                                                                                                                             " obligatorio="true" admitebusqueda="6" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="NUMINT                                  " tabla="REMCOMPRA      " campo="NUMINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número interno                                                                                                                                                  " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="IMPUESTOS                               " tabla="REMCOMPRA      " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="I.V.A.                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPREMC        " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOREMCOMPRA  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="OBS                                     " tabla="REMCOMPRA      " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="FECHA                                   " tabla="REMCOMPRA      " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="414" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="FECHAFACTURA                            " tabla="REMCOMPRA      " campo="FFCHFAC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Emisión                                                                                                                                                         " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="PUNTODEVENTAEXTENDIDO                   " tabla="REMCOMPRA      " campo="FPTOVENEXT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="REMCOMPRA      " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="REMCOMPRA      " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="IMPUESTOSMANUALES                       " tabla="REMCOMPRA      " campo="IMPMAN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOPORCENTAJE                       " tabla="REMCOMPRA      " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="% Recargo                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="NUMERO                                  " tabla="REMCOMPRA      " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTEEDITABLE     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="REMCOMPRA      " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="14" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOMONTO                            " tabla="REMCOMPRA      " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="% Recargo                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="CAI                                     " tabla="REMCOMPRA      " campo="NCAI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="C.A.I./C.A.E.                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="REMCOMPRA      " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="PROVEEDOR                               " tabla="REMCOMPRA      " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="FECHAVTOCAI                             " tabla="REMCOMPRA      " campo="FVTOCAI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento C.A.I./C.A.E.                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="VUELTO                                  " tabla="REMCOMPRA      " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="REMITO                                  " tabla="REMCOMPRA      " campo="NROREMITO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Remito                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="A 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="LISTADEPRECIOS                          " tabla="REMCOMPRA      " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferenteCompras                                                                                                                                                                                  " obligatorio="true" admitebusqueda="424" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="CONDICIONPAGOPREFERENTE                 " tabla="REMCOMPRA      " campo="CONDPAGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TOTAL                                   " tabla="REMCOMPRA      " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOMONTO1                           " tabla="REMCOMPRA      " campo="RECMONTO1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="RECARGOMONTO2                           " tabla="REMCOMPRA      " campo="RECMONTO2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="MOTIVO                                  " tabla="REMCOMPRA      " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TRANSPORTISTA                           " tabla="REMCOMPRA      " campo="FTRANSP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Transportista                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="COTIZACION                              " tabla="REMCOMPRA      " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="434" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TOTALIMPUESTOS                          " tabla="REMCOMPRA      " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TOTALRECARGOS                           " tabla="REMCOMPRA      " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="REMCOMPRA      " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITODECOMPRA                          " atributo="TOTALDESCUENTOS                         " tabla="REMCOMPRA      " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On REMCOMPRA.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On REMCOMPRA.FPERSON = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On REMCOMPRA.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="427" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On REMCOMPRA.CONDPAGO = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On REMCOMPRA.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="433" etiqueta="Detalle Tra.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On REMCOMPRA.FTRANSP = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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