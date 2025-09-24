
define class Din_EntidadRECIBOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_RECIBO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0)]
	cTagClaveCandidata = '_RECCC'
	cTagClavePk = '_RECPK'
	cTablaPrincipal = 'RECIBO'
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
			local  lxReciboFmodifw, lxReciboFecexpo, lxReciboFecimpo, lxReciboFectrans, lxReciboIdcaja, lxReciboCotiz, lxReciboUaltafw, lxReciboSmodifw, lxReciboHaltafw, lxReciboVmodifw, lxReciboUmodifw, lxReciboEsttrans, lxReciboBdaltafw, lxReciboBdmodifw, lxReciboFaltafw, lxReciboValtafw, lxReciboZadsfw, lxReciboDescfw, lxReciboSimbmon, lxReciboHmodifw, lxReciboSaltafw, lxReciboHoraexpo, lxReciboHoraimpo, lxReciboTimestamp, lxReciboSignomov, lxReciboFacttipo, lxReciboFcompfis, lxReciboIdvuelto, lxReciboMonsis, lxReciboFvuelto, lxReciboFletra, lxReciboFtotal, lxReciboFobs, lxReciboFptoven, lxReciboFnumcomp, lxReciboFperson, lxReciboFfch, lxReciboFven, lxReciboMoneda, lxReciboAnulado, lxReciboFcliente, lxReciboCodigo, lxReciboIvasis
				lxReciboFmodifw =  .Fechamodificacionfw			lxReciboFecexpo =  .Fechaexpo			lxReciboFecimpo =  .Fechaimpo			lxReciboFectrans =  .Fechatransferencia			lxReciboIdcaja =  .Caja_PK 			lxReciboCotiz =  .Cotizacion			lxReciboUaltafw =  .Usuarioaltafw			lxReciboSmodifw =  .Seriemodificacionfw			lxReciboHaltafw =  .Horaaltafw			lxReciboVmodifw =  .Versionmodificacionfw			lxReciboUmodifw =  .Usuariomodificacionfw			lxReciboEsttrans =  .Estadotransferencia			lxReciboBdaltafw =  .Basededatosaltafw			lxReciboBdmodifw =  .Basededatosmodificacionfw			lxReciboFaltafw =  .Fechaaltafw			lxReciboValtafw =  .Versionaltafw			lxReciboZadsfw =  .Zadsfw			lxReciboDescfw =  .Descripcionfw			lxReciboSimbmon =  .Simbolomonetariocomprobante			lxReciboHmodifw =  .Horamodificacionfw			lxReciboSaltafw =  .Seriealtafw			lxReciboHoraexpo =  .Horaexpo			lxReciboHoraimpo =  .Horaimpo			lxReciboTimestamp = goLibrerias.ObtenerTimestamp()			lxReciboSignomov =  .Signodemovimiento			lxReciboFacttipo =  .Tipocomprobante			lxReciboFcompfis =  .Comprobantefiscal			lxReciboIdvuelto =  upper( .IdVuelto_PK ) 			lxReciboMonsis =  upper( .MonedaSistema_PK ) 			lxReciboFvuelto =  .Vuelto			lxReciboFletra =  .Letra			lxReciboFtotal =  .Total			lxReciboFobs =  .Obs			lxReciboFptoven =  .Puntodeventa			lxReciboFnumcomp =  .Numero			lxReciboFperson =  upper( .Cliente_PK ) 			lxReciboFfch =  .Fecha			lxReciboFven =  upper( .Vendedor_PK ) 			lxReciboMoneda =  upper( .MonedaComprobante_PK ) 			lxReciboAnulado =  .Anulado			lxReciboFcliente =  .Clientedescripcion			lxReciboCodigo =  .Codigo			lxReciboIvasis =  .Ivadelsistema
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxReciboCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.RECIBO ( "Fmodifw","Fecexpo","Fecimpo","Fectrans","Idcaja","Cotiz","Ualtafw","Smodifw","Haltafw","Vmodifw","Umodifw","Esttrans","Bdaltafw","Bdmodifw","Faltafw","Valtafw","Zadsfw","Descfw","Simbmon","Hmodifw","Saltafw","Horaexpo","Horaimpo","Timestamp","Signomov","Facttipo","Fcompfis","Idvuelto","Monsis","Fvuelto","Fletra","Ftotal","Fobs","Fptoven","Fnumcomp","Fperson","Ffch","Fven","Moneda","Anulado","Fcliente","Codigo","Ivasis" ) values ( <<"'" + this.ConvertirDateSql( lxReciboFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFectrans ) + "'" >>, <<lxReciboIdcaja >>, <<lxReciboCotiz >>, <<"'" + this.FormatearTextoSql( lxReciboUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboBdmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboHoraimpo ) + "'" >>, <<lxReciboTimestamp >>, <<lxReciboSignomov >>, <<lxReciboFacttipo >>, <<iif( lxReciboFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxReciboIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboMonsis ) + "'" >>, <<lxReciboFvuelto >>, <<"'" + this.FormatearTextoSql( lxReciboFletra ) + "'" >>, <<lxReciboFtotal >>, <<"'" + this.FormatearTextoSql( lxReciboFobs ) + "'" >>, <<lxReciboFptoven >>, <<lxReciboFnumcomp >>, <<"'" + this.FormatearTextoSql( lxReciboFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboFven ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboMoneda ) + "'" >>, <<iif( lxReciboAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxReciboFcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboCodigo ) + "'" >>, <<lxReciboIvasis >> )
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
			for each loItem in this.oEntidad.CompAfec2
				if this.oEntidad.CompAfec2.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
			for each loItem in this.oEntidad.ReciboDetalle
				if this.oEntidad.ReciboDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxVencimiento = loItem.Vencimiento
					lxCaja_PK = loItem.Caja_PK
					lxCodigocomprobante = loItem.Codigocomprobante
					lxCliente = loItem.Cliente
					lxCae = loItem.Cae
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxBasededatosaltafw = loItem.Basededatosaltafw
					lxLetra = loItem.Letra
					lxSecuencia = loItem.Secuencia
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxFecha = loItem.Fecha
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReciboDet("RFecVen","IdCaja","CodComp","Cliente","Cae","Tipo","BDAltaFW","LetraAfec","FACTSEC","NROITEM","PtoAfec","Rtipo","Numafec","lPagoACta","RVal","CODIGO","Fecha","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCae ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosaltafw ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxSecuencia ) + "'">>, <<lxNroitem>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxNumerodecomprobante>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RetencionesRecibidas
				if this.oEntidad.RetencionesRecibidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIdcomprobante = loItem.Idcomprobante
					lxNroitem = lnContadorNroItem
					lxImpuesto_PK = loItem.Impuesto_PK
					lxImpuestodetalle = loItem.Impuestodetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReciRete("idcomprob","NROITEM","codigo","impuesto","impudeta","monto" ) values ( <<"'" + this.FormatearTextoSql( lxIdcomprobante ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuestodetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxReciboTimestamp
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
			local  lxReciboFmodifw, lxReciboFecexpo, lxReciboFecimpo, lxReciboFectrans, lxReciboIdcaja, lxReciboCotiz, lxReciboUaltafw, lxReciboSmodifw, lxReciboHaltafw, lxReciboVmodifw, lxReciboUmodifw, lxReciboEsttrans, lxReciboBdaltafw, lxReciboBdmodifw, lxReciboFaltafw, lxReciboValtafw, lxReciboZadsfw, lxReciboDescfw, lxReciboSimbmon, lxReciboHmodifw, lxReciboSaltafw, lxReciboHoraexpo, lxReciboHoraimpo, lxReciboTimestamp, lxReciboSignomov, lxReciboFacttipo, lxReciboFcompfis, lxReciboIdvuelto, lxReciboMonsis, lxReciboFvuelto, lxReciboFletra, lxReciboFtotal, lxReciboFobs, lxReciboFptoven, lxReciboFnumcomp, lxReciboFperson, lxReciboFfch, lxReciboFven, lxReciboMoneda, lxReciboAnulado, lxReciboFcliente, lxReciboCodigo, lxReciboIvasis
				lxReciboFmodifw =  .Fechamodificacionfw			lxReciboFecexpo =  .Fechaexpo			lxReciboFecimpo =  .Fechaimpo			lxReciboFectrans =  .Fechatransferencia			lxReciboIdcaja =  .Caja_PK 			lxReciboCotiz =  .Cotizacion			lxReciboUaltafw =  .Usuarioaltafw			lxReciboSmodifw =  .Seriemodificacionfw			lxReciboHaltafw =  .Horaaltafw			lxReciboVmodifw =  .Versionmodificacionfw			lxReciboUmodifw =  .Usuariomodificacionfw			lxReciboEsttrans =  .Estadotransferencia			lxReciboBdaltafw =  .Basededatosaltafw			lxReciboBdmodifw =  .Basededatosmodificacionfw			lxReciboFaltafw =  .Fechaaltafw			lxReciboValtafw =  .Versionaltafw			lxReciboZadsfw =  .Zadsfw			lxReciboDescfw =  .Descripcionfw			lxReciboSimbmon =  .Simbolomonetariocomprobante			lxReciboHmodifw =  .Horamodificacionfw			lxReciboSaltafw =  .Seriealtafw			lxReciboHoraexpo =  .Horaexpo			lxReciboHoraimpo =  .Horaimpo			lxReciboTimestamp = goLibrerias.ObtenerTimestamp()			lxReciboSignomov =  .Signodemovimiento			lxReciboFacttipo =  .Tipocomprobante			lxReciboFcompfis =  .Comprobantefiscal			lxReciboIdvuelto =  upper( .IdVuelto_PK ) 			lxReciboMonsis =  upper( .MonedaSistema_PK ) 			lxReciboFvuelto =  .Vuelto			lxReciboFletra =  .Letra			lxReciboFtotal =  .Total			lxReciboFobs =  .Obs			lxReciboFptoven =  .Puntodeventa			lxReciboFnumcomp =  .Numero			lxReciboFperson =  upper( .Cliente_PK ) 			lxReciboFfch =  .Fecha			lxReciboFven =  upper( .Vendedor_PK ) 			lxReciboMoneda =  upper( .MonedaComprobante_PK ) 			lxReciboAnulado =  .Anulado			lxReciboFcliente =  .Clientedescripcion			lxReciboCodigo =  .Codigo			lxReciboIvasis =  .Ivadelsistema
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
				update ZooLogic.RECIBO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxReciboFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxReciboFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxReciboFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxReciboFectrans ) + "'">>,"Idcaja" = <<lxReciboIdcaja>>,"Cotiz" = <<lxReciboCotiz>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxReciboUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxReciboSmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxReciboHaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxReciboVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxReciboUmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxReciboEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxReciboBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxReciboBdmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxReciboFaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxReciboValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxReciboZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxReciboDescfw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxReciboSimbmon ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxReciboHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxReciboSaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxReciboHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxReciboHoraimpo ) + "'">>,"Timestamp" = <<lxReciboTimestamp>>,"Signomov" = <<lxReciboSignomov>>,"Facttipo" = <<lxReciboFacttipo>>,"Fcompfis" = <<iif( lxReciboFcompfis, 1, 0 )>>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxReciboIdvuelto ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxReciboMonsis ) + "'">>,"Fvuelto" = <<lxReciboFvuelto>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxReciboFletra ) + "'">>,"Ftotal" = <<lxReciboFtotal>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxReciboFobs ) + "'">>,"Fptoven" = <<lxReciboFptoven>>,"Fnumcomp" = <<lxReciboFnumcomp>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxReciboFperson ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxReciboFfch ) + "'">>,"Fven" = <<"'" + this.FormatearTextoSql( lxReciboFven ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxReciboMoneda ) + "'">>,"Anulado" = <<iif( lxReciboAnulado, 1, 0 )>>,"Fcliente" = <<"'" + this.FormatearTextoSql( lxReciboFcliente ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxReciboCodigo ) + "'">>,"Ivasis" = <<lxReciboIvasis>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxReciboCodigo ) + "'">> and  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ReciboDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ReciRete where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
			for each loItem in this.oEntidad.CompAfec2
				if this.oEntidad.CompAfec2.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
			for each loItem in this.oEntidad.ReciboDetalle
				if this.oEntidad.ReciboDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxVencimiento = loItem.Vencimiento
					lxCaja_PK = loItem.Caja_PK
					lxCodigocomprobante = loItem.Codigocomprobante
					lxCliente = loItem.Cliente
					lxCae = loItem.Cae
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxBasededatosaltafw = loItem.Basededatosaltafw
					lxLetra = loItem.Letra
					lxSecuencia = loItem.Secuencia
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxFecha = loItem.Fecha
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReciboDet("RFecVen","IdCaja","CodComp","Cliente","Cae","Tipo","BDAltaFW","LetraAfec","FACTSEC","NROITEM","PtoAfec","Rtipo","Numafec","lPagoACta","RVal","CODIGO","Fecha","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCae ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosaltafw ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxSecuencia ) + "'">>, <<lxNroitem>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxNumerodecomprobante>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RetencionesRecibidas
				if this.oEntidad.RetencionesRecibidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIdcomprobante = loItem.Idcomprobante
					lxNroitem = lnContadorNroItem
					lxImpuesto_PK = loItem.Impuesto_PK
					lxImpuestodetalle = loItem.Impuestodetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReciRete("idcomprob","NROITEM","codigo","impuesto","impudeta","monto" ) values ( <<"'" + this.FormatearTextoSql( lxIdcomprobante ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuestodetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxReciboTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.RECIBO where " + this.ConvertirFuncionesSql( " RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13" ) )
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
			Local lxReciboCodigo
			lxReciboCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Cotiz" as "Cotizacion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fvuelto" as "Vuelto", "Fletra" as "Letra", "Ftotal" as "Total", "Fobs" as "Obs", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Fperson" as "Cliente", "Ffch" as "Fecha", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Anulado" as "Anulado", "Fcliente" as "Clientedescripcion", "Codigo" as "Codigo", "Ivasis" as "Ivadelsistema" from ZooLogic.RECIBO where "Codigo" = <<"'" + this.FormatearTextoSql( lxReciboCodigo ) + "'">> and  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13
			endtext
			use in select('c_RECIBO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RECIBO', set( 'Datasession' ) )

			if reccount( 'c_RECIBO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Rfecven" as "Vencimiento", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Cliente" as "Cliente", "Cae" as "Cae", "Tipo" as "Tipodecomprobante", "Bdaltafw" as "Basededatosaltafw", "Letraafec" as "Letra", "Factsec" as "Secuencia", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Rtipo" as "Tipo", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecha" as "Fecha", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.ReciboDet where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ReciboDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ReciboDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ReciboDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Idcomprob" as "Idcomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Impudeta" as "Impuestodetalle", "Monto" as "Monto" from ZooLogic.ReciRete where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesRecibidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesRecibidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesRecibidas
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxReciboFACTTIPO As Variant, lxReciboFLETRA As Variant, lxReciboFPTOVEN As Variant, lxReciboFNUMCOMP As Variant
			lxReciboFACTTIPO = .TipoComprobante
			lxReciboFLETRA = .Letra
			lxReciboFPTOVEN = .PuntoDeVenta
			lxReciboFNUMCOMP = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Cotiz" as "Cotizacion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fvuelto" as "Vuelto", "Fletra" as "Letra", "Ftotal" as "Total", "Fobs" as "Obs", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Fperson" as "Cliente", "Ffch" as "Fecha", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Anulado" as "Anulado", "Fcliente" as "Clientedescripcion", "Codigo" as "Codigo", "Ivasis" as "Ivadelsistema" from ZooLogic.RECIBO where  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13 And FACTTIPO = <<lxReciboFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxReciboFLETRA ) + "'">> and FPTOVEN = <<lxReciboFPTOVEN>> and FNUMCOMP = <<lxReciboFNUMCOMP>>
			endtext
			use in select('c_RECIBO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RECIBO', set( 'Datasession' ) )
			if reccount( 'c_RECIBO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Rfecven" as "Vencimiento", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Cliente" as "Cliente", "Cae" as "Cae", "Tipo" as "Tipodecomprobante", "Bdaltafw" as "Basededatosaltafw", "Letraafec" as "Letra", "Factsec" as "Secuencia", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Rtipo" as "Tipo", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecha" as "Fecha", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.ReciboDet where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ReciboDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ReciboDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ReciboDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Idcomprob" as "Idcomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Impudeta" as "Impuestodetalle", "Monto" as "Monto" from ZooLogic.ReciRete where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesRecibidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesRecibidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesRecibidas
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxReciboCodigo as Variant
		llRetorno = .t.
		lxReciboCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.RECIBO where "Codigo" = <<"'" + this.FormatearTextoSql( lxReciboCodigo ) + "'">> and  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Cotiz" as "Cotizacion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fvuelto" as "Vuelto", "Fletra" as "Letra", "Ftotal" as "Total", "Fobs" as "Obs", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Fperson" as "Cliente", "Ffch" as "Fecha", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Anulado" as "Anulado", "Fcliente" as "Clientedescripcion", "Codigo" as "Codigo", "Ivasis" as "Ivadelsistema" from ZooLogic.RECIBO where  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13 order by FAltaFW,HAltaFW,FNUMCOMP,CODIGO
			endtext
			use in select('c_RECIBO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RECIBO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Rfecven" as "Vencimiento", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Cliente" as "Cliente", "Cae" as "Cae", "Tipo" as "Tipodecomprobante", "Bdaltafw" as "Basededatosaltafw", "Letraafec" as "Letra", "Factsec" as "Secuencia", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Rtipo" as "Tipo", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecha" as "Fecha", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.ReciboDet where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ReciboDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ReciboDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ReciboDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Idcomprob" as "Idcomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Impudeta" as "Impuestodetalle", "Monto" as "Monto" from ZooLogic.ReciRete where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesRecibidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesRecibidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesRecibidas
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Cotiz" as "Cotizacion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fvuelto" as "Vuelto", "Fletra" as "Letra", "Ftotal" as "Total", "Fobs" as "Obs", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Fperson" as "Cliente", "Ffch" as "Fecha", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Anulado" as "Anulado", "Fcliente" as "Clientedescripcion", "Codigo" as "Codigo", "Ivasis" as "Ivadelsistema" from ZooLogic.RECIBO where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + str( FNUMCOMP, 8, 0) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13 order by FAltaFW,HAltaFW,FNUMCOMP,CODIGO
			endtext
			use in select('c_RECIBO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RECIBO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Rfecven" as "Vencimiento", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Cliente" as "Cliente", "Cae" as "Cae", "Tipo" as "Tipodecomprobante", "Bdaltafw" as "Basededatosaltafw", "Letraafec" as "Letra", "Factsec" as "Secuencia", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Rtipo" as "Tipo", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecha" as "Fecha", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.ReciboDet where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ReciboDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ReciboDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ReciboDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Idcomprob" as "Idcomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Impudeta" as "Impuestodetalle", "Monto" as "Monto" from ZooLogic.ReciRete where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesRecibidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesRecibidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesRecibidas
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Cotiz" as "Cotizacion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fvuelto" as "Vuelto", "Fletra" as "Letra", "Ftotal" as "Total", "Fobs" as "Obs", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Fperson" as "Cliente", "Ffch" as "Fecha", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Anulado" as "Anulado", "Fcliente" as "Clientedescripcion", "Codigo" as "Codigo", "Ivasis" as "Ivadelsistema" from ZooLogic.RECIBO where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + str( FNUMCOMP, 8, 0) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13 order by FAltaFW desc,HAltaFW desc,FNUMCOMP desc,CODIGO desc
			endtext
			use in select('c_RECIBO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RECIBO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Rfecven" as "Vencimiento", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Cliente" as "Cliente", "Cae" as "Cae", "Tipo" as "Tipodecomprobante", "Bdaltafw" as "Basededatosaltafw", "Letraafec" as "Letra", "Factsec" as "Secuencia", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Rtipo" as "Tipo", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecha" as "Fecha", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.ReciboDet where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ReciboDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ReciboDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ReciboDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Idcomprob" as "Idcomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Impudeta" as "Impuestodetalle", "Monto" as "Monto" from ZooLogic.ReciRete where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesRecibidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesRecibidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesRecibidas
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + str( .Numero, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Cotiz" as "Cotizacion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fvuelto" as "Vuelto", "Fletra" as "Letra", "Ftotal" as "Total", "Fobs" as "Obs", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Fperson" as "Cliente", "Ffch" as "Fecha", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Anulado" as "Anulado", "Fcliente" as "Clientedescripcion", "Codigo" as "Codigo", "Ivasis" as "Ivadelsistema" from ZooLogic.RECIBO where  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13 order by FAltaFW desc,HAltaFW desc,FNUMCOMP desc,CODIGO desc
			endtext
			use in select('c_RECIBO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RECIBO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Rfecven" as "Vencimiento", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Cliente" as "Cliente", "Cae" as "Cae", "Tipo" as "Tipodecomprobante", "Bdaltafw" as "Basededatosaltafw", "Letraafec" as "Letra", "Factsec" as "Secuencia", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Rtipo" as "Tipo", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecha" as "Fecha", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.ReciboDet where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ReciboDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ReciboDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ReciboDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Idcomprob" as "Idcomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Impudeta" as "Impuestodetalle", "Monto" as "Monto" from ZooLogic.ReciRete where CODIGO = <<"'" + this.FormatearTextoSql( c_RECIBO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesRecibidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesRecibidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesRecibidas
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecexpo,Fecimpo,Fectrans,Idcaja,Cotiz,Ualtafw,Smodifw,Haltafw,Vmodifw,Umodifw,Esttra" + ;
"ns,Bdaltafw,Bdmodifw,Faltafw,Valtafw,Zadsfw,Descfw,Simbmon,Hmodifw,Saltafw,Horaexpo,Horaimpo,Timesta" + ;
"mp,Signomov,Facttipo,Fcompfis,Idvuelto,Monsis,Fvuelto,Fletra,Ftotal,Fobs,Fptoven,Fnumcomp,Fperson,Ff" + ;
"ch,Fven,Moneda,Anulado,Fcliente,Codigo,Ivasis" + ;
" from ZooLogic.RECIBO where  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13 and " + lcFiltro )
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
			local  lxReciboFmodifw, lxReciboFecexpo, lxReciboFecimpo, lxReciboFectrans, lxReciboIdcaja, lxReciboCotiz, lxReciboUaltafw, lxReciboSmodifw, lxReciboHaltafw, lxReciboVmodifw, lxReciboUmodifw, lxReciboEsttrans, lxReciboBdaltafw, lxReciboBdmodifw, lxReciboFaltafw, lxReciboValtafw, lxReciboZadsfw, lxReciboDescfw, lxReciboSimbmon, lxReciboHmodifw, lxReciboSaltafw, lxReciboHoraexpo, lxReciboHoraimpo, lxReciboTimestamp, lxReciboSignomov, lxReciboFacttipo, lxReciboFcompfis, lxReciboIdvuelto, lxReciboMonsis, lxReciboFvuelto, lxReciboFletra, lxReciboFtotal, lxReciboFobs, lxReciboFptoven, lxReciboFnumcomp, lxReciboFperson, lxReciboFfch, lxReciboFven, lxReciboMoneda, lxReciboAnulado, lxReciboFcliente, lxReciboCodigo, lxReciboIvasis
				lxReciboFmodifw = ctod( '  /  /    ' )			lxReciboFecexpo = ctod( '  /  /    ' )			lxReciboFecimpo = ctod( '  /  /    ' )			lxReciboFectrans = ctod( '  /  /    ' )			lxReciboIdcaja = 0			lxReciboCotiz = 0			lxReciboUaltafw = []			lxReciboSmodifw = []			lxReciboHaltafw = []			lxReciboVmodifw = []			lxReciboUmodifw = []			lxReciboEsttrans = []			lxReciboBdaltafw = []			lxReciboBdmodifw = []			lxReciboFaltafw = ctod( '  /  /    ' )			lxReciboValtafw = []			lxReciboZadsfw = []			lxReciboDescfw = []			lxReciboSimbmon = []			lxReciboHmodifw = []			lxReciboSaltafw = []			lxReciboHoraexpo = []			lxReciboHoraimpo = []			lxReciboTimestamp = goLibrerias.ObtenerTimestamp()			lxReciboSignomov = 0			lxReciboFacttipo = 0			lxReciboFcompfis = .F.			lxReciboIdvuelto = []			lxReciboMonsis = []			lxReciboFvuelto = 0			lxReciboFletra = []			lxReciboFtotal = 0			lxReciboFobs = []			lxReciboFptoven = 0			lxReciboFnumcomp = 0			lxReciboFperson = []			lxReciboFfch = ctod( '  /  /    ' )			lxReciboFven = []			lxReciboMoneda = []			lxReciboAnulado = .F.			lxReciboFcliente = []			lxReciboCodigo = []			lxReciboIvasis = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ReciboDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ReciRete where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.RECIBO where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'RECIBO' + '_' + tcCampo
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
		lcWhere = " Where  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Cotiz" as "Cotizacion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fvuelto" as "Vuelto", "Fletra" as "Letra", "Ftotal" as "Total", "Fobs" as "Obs", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Fperson" as "Cliente", "Ffch" as "Fecha", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Anulado" as "Anulado", "Fcliente" as "Clientedescripcion", "Codigo" as "Codigo", "Ivasis" as "Ivadelsistema"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'RECIBO', '', tnTope )
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
	Function ObtenerDatosDetalleCompAfec2( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPAFE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCompAfec2( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CompAfe', 'CompAfec2', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCompAfec2( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCompAfec2( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleReciboDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  RECIBODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Rfecven" as "Vencimiento", "Idcaja" as "Caja", "Codcomp" as "Codigocomprobante", "Cliente" as "Cliente", "Cae" as "Cae", "Tipo" as "Tipodecomprobante", "Bdaltafw" as "Basededatosaltafw", "Letraafec" as "Letra", "Factsec" as "Secuencia", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Rtipo" as "Tipo", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecha" as "Fecha", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleReciboDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ReciboDet', 'ReciboDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleReciboDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleReciboDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleRetencionesRecibidas( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  RECIRETE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Idcomprob" as "Idcomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Impudeta" as "Impuestodetalle", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleRetencionesRecibidas( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ReciRete', 'RetencionesRecibidas', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleRetencionesRecibidas( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleRetencionesRecibidas( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS CLIENTE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVEN AS VENDEDOR'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCLIENTE AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IVADELSISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVASIS AS IVADELSISTEMA'
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
	Function ObtenerCamposSelectDetalleCompAfec2( tcCampos As String ) As String
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
	Function ObtenerCamposSelectDetalleReciboDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'VENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RFECVEN AS VENCIMIENTO'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CAE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAE AS CAE'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPODECOMPROBANTE'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRAAFEC AS LETRA'
				Case lcAtributo == 'SECUENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSEC AS SECUENCIA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOAFEC AS PUNTODEVENTA'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RTIPO AS TIPO'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMAFEC AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'ESPAGOACUENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPAGOACTA AS ESPAGOACUENTA'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RVAL AS VALOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'ANOTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANOTACION AS ANOTACION'
				Case lcAtributo == 'SALDOAUX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALDOAUX AS SALDOAUX'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RMONTO AS MONTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleRetencionesRecibidas( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCOMPROB AS IDCOMPROBANTE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPUESTO AS IMPUESTO'
				Case lcAtributo == 'IMPUESTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPUDETA AS IMPUESTODETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'FVEN'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'FCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IVADELSISTEMA'
				lcCampo = 'IVASIS'
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
	Function ObtenerCampoDetalleCompAfec2( tcAtributo As String ) As String
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
	Function ObtenerCampoDetalleReciboDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'VENCIMIENTO'
				lcCampo = 'RFECVEN'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CAE'
				lcCampo = 'CAE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRAAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'SECUENCIA'
				lcCampo = 'FACTSEC'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'RTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'ESPAGOACUENTA'
				lcCampo = 'LPAGOACTA'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'RVAL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'ANOTACION'
				lcCampo = 'ANOTACION'
			Case upper( alltrim( tcAtributo ) ) == 'SALDOAUX'
				lcCampo = 'SALDOAUX'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'RMONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleRetencionesRecibidas( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDCOMPROBANTE'
				lcCampo = 'IDCOMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTO'
				lcCampo = 'IMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTODETALLE'
				lcCampo = 'IMPUDETA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'VALORESDETALLE'
			lcRetorno = 'VAL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC2'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'RECIBODETALLE'
			lcRetorno = 'RECIBODET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'RETENCIONESRECIBIDAS'
			lcRetorno = 'RECIRETE'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxReciboFmodifw, lxReciboFecexpo, lxReciboFecimpo, lxReciboFectrans, lxReciboIdcaja, lxReciboCotiz, lxReciboUaltafw, lxReciboSmodifw, lxReciboHaltafw, lxReciboVmodifw, lxReciboUmodifw, lxReciboEsttrans, lxReciboBdaltafw, lxReciboBdmodifw, lxReciboFaltafw, lxReciboValtafw, lxReciboZadsfw, lxReciboDescfw, lxReciboSimbmon, lxReciboHmodifw, lxReciboSaltafw, lxReciboHoraexpo, lxReciboHoraimpo, lxReciboTimestamp, lxReciboSignomov, lxReciboFacttipo, lxReciboFcompfis, lxReciboIdvuelto, lxReciboMonsis, lxReciboFvuelto, lxReciboFletra, lxReciboFtotal, lxReciboFobs, lxReciboFptoven, lxReciboFnumcomp, lxReciboFperson, lxReciboFfch, lxReciboFven, lxReciboMoneda, lxReciboAnulado, lxReciboFcliente, lxReciboCodigo, lxReciboIvasis
				lxReciboFmodifw =  .Fechamodificacionfw			lxReciboFecexpo =  .Fechaexpo			lxReciboFecimpo =  .Fechaimpo			lxReciboFectrans =  .Fechatransferencia			lxReciboIdcaja =  .Caja_PK 			lxReciboCotiz =  .Cotizacion			lxReciboUaltafw =  .Usuarioaltafw			lxReciboSmodifw =  .Seriemodificacionfw			lxReciboHaltafw =  .Horaaltafw			lxReciboVmodifw =  .Versionmodificacionfw			lxReciboUmodifw =  .Usuariomodificacionfw			lxReciboEsttrans =  .Estadotransferencia			lxReciboBdaltafw =  .Basededatosaltafw			lxReciboBdmodifw =  .Basededatosmodificacionfw			lxReciboFaltafw =  .Fechaaltafw			lxReciboValtafw =  .Versionaltafw			lxReciboZadsfw =  .Zadsfw			lxReciboDescfw =  .Descripcionfw			lxReciboSimbmon =  .Simbolomonetariocomprobante			lxReciboHmodifw =  .Horamodificacionfw			lxReciboSaltafw =  .Seriealtafw			lxReciboHoraexpo =  .Horaexpo			lxReciboHoraimpo =  .Horaimpo			lxReciboTimestamp = goLibrerias.ObtenerTimestamp()			lxReciboSignomov =  .Signodemovimiento			lxReciboFacttipo =  .Tipocomprobante			lxReciboFcompfis =  .Comprobantefiscal			lxReciboIdvuelto =  upper( .IdVuelto_PK ) 			lxReciboMonsis =  upper( .MonedaSistema_PK ) 			lxReciboFvuelto =  .Vuelto			lxReciboFletra =  .Letra			lxReciboFtotal =  .Total			lxReciboFobs =  .Obs			lxReciboFptoven =  .Puntodeventa			lxReciboFnumcomp =  .Numero			lxReciboFperson =  upper( .Cliente_PK ) 			lxReciboFfch =  .Fecha			lxReciboFven =  upper( .Vendedor_PK ) 			lxReciboMoneda =  upper( .MonedaComprobante_PK ) 			lxReciboAnulado =  .Anulado			lxReciboFcliente =  .Clientedescripcion			lxReciboCodigo =  .Codigo			lxReciboIvasis =  .Ivadelsistema
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.RECIBO ( "Fmodifw","Fecexpo","Fecimpo","Fectrans","Idcaja","Cotiz","Ualtafw","Smodifw","Haltafw","Vmodifw","Umodifw","Esttrans","Bdaltafw","Bdmodifw","Faltafw","Valtafw","Zadsfw","Descfw","Simbmon","Hmodifw","Saltafw","Horaexpo","Horaimpo","Timestamp","Signomov","Facttipo","Fcompfis","Idvuelto","Monsis","Fvuelto","Fletra","Ftotal","Fobs","Fptoven","Fnumcomp","Fperson","Ffch","Fven","Moneda","Anulado","Fcliente","Codigo","Ivasis" ) values ( <<"'" + this.ConvertirDateSql( lxReciboFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFectrans ) + "'" >>, <<lxReciboIdcaja >>, <<lxReciboCotiz >>, <<"'" + this.FormatearTextoSql( lxReciboUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboBdmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboHoraimpo ) + "'" >>, <<lxReciboTimestamp >>, <<lxReciboSignomov >>, <<lxReciboFacttipo >>, <<iif( lxReciboFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxReciboIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboMonsis ) + "'" >>, <<lxReciboFvuelto >>, <<"'" + this.FormatearTextoSql( lxReciboFletra ) + "'" >>, <<lxReciboFtotal >>, <<"'" + this.FormatearTextoSql( lxReciboFobs ) + "'" >>, <<lxReciboFptoven >>, <<lxReciboFnumcomp >>, <<"'" + this.FormatearTextoSql( lxReciboFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReciboFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboFven ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboMoneda ) + "'" >>, <<iif( lxReciboAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxReciboFcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReciboCodigo ) + "'" >>, <<lxReciboIvasis >> )
		endtext
		loColeccion.cTabla = 'RECIBO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

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
			for each loItem in this.oEntidad.CompAfec2
				if this.oEntidad.CompAfec2.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
			for each loItem in this.oEntidad.ReciboDetalle
				if this.oEntidad.ReciboDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxVencimiento = loItem.Vencimiento
					lxCaja_PK = loItem.Caja_PK
					lxCodigocomprobante = loItem.Codigocomprobante
					lxCliente = loItem.Cliente
					lxCae = loItem.Cae
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxBasededatosaltafw = loItem.Basededatosaltafw
					lxLetra = loItem.Letra
					lxSecuencia = loItem.Secuencia
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxFecha = loItem.Fecha
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReciboDet("RFecVen","IdCaja","CodComp","Cliente","Cae","Tipo","BDAltaFW","LetraAfec","FACTSEC","NROITEM","PtoAfec","Rtipo","Numafec","lPagoACta","RVal","CODIGO","Fecha","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCae ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosaltafw ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxSecuencia ) + "'">>, <<lxNroitem>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxNumerodecomprobante>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RetencionesRecibidas
				if this.oEntidad.RetencionesRecibidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIdcomprobante = loItem.Idcomprobante
					lxNroitem = lnContadorNroItem
					lxImpuesto_PK = loItem.Impuesto_PK
					lxImpuestodetalle = loItem.Impuestodetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReciRete("idcomprob","NROITEM","codigo","impuesto","impudeta","monto" ) values ( <<"'" + this.FormatearTextoSql( lxIdcomprobante ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuestodetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxReciboFmodifw, lxReciboFecexpo, lxReciboFecimpo, lxReciboFectrans, lxReciboIdcaja, lxReciboCotiz, lxReciboUaltafw, lxReciboSmodifw, lxReciboHaltafw, lxReciboVmodifw, lxReciboUmodifw, lxReciboEsttrans, lxReciboBdaltafw, lxReciboBdmodifw, lxReciboFaltafw, lxReciboValtafw, lxReciboZadsfw, lxReciboDescfw, lxReciboSimbmon, lxReciboHmodifw, lxReciboSaltafw, lxReciboHoraexpo, lxReciboHoraimpo, lxReciboTimestamp, lxReciboSignomov, lxReciboFacttipo, lxReciboFcompfis, lxReciboIdvuelto, lxReciboMonsis, lxReciboFvuelto, lxReciboFletra, lxReciboFtotal, lxReciboFobs, lxReciboFptoven, lxReciboFnumcomp, lxReciboFperson, lxReciboFfch, lxReciboFven, lxReciboMoneda, lxReciboAnulado, lxReciboFcliente, lxReciboCodigo, lxReciboIvasis
				lxReciboFmodifw =  .Fechamodificacionfw			lxReciboFecexpo =  .Fechaexpo			lxReciboFecimpo =  .Fechaimpo			lxReciboFectrans =  .Fechatransferencia			lxReciboIdcaja =  .Caja_PK 			lxReciboCotiz =  .Cotizacion			lxReciboUaltafw =  .Usuarioaltafw			lxReciboSmodifw =  .Seriemodificacionfw			lxReciboHaltafw =  .Horaaltafw			lxReciboVmodifw =  .Versionmodificacionfw			lxReciboUmodifw =  .Usuariomodificacionfw			lxReciboEsttrans =  .Estadotransferencia			lxReciboBdaltafw =  .Basededatosaltafw			lxReciboBdmodifw =  .Basededatosmodificacionfw			lxReciboFaltafw =  .Fechaaltafw			lxReciboValtafw =  .Versionaltafw			lxReciboZadsfw =  .Zadsfw			lxReciboDescfw =  .Descripcionfw			lxReciboSimbmon =  .Simbolomonetariocomprobante			lxReciboHmodifw =  .Horamodificacionfw			lxReciboSaltafw =  .Seriealtafw			lxReciboHoraexpo =  .Horaexpo			lxReciboHoraimpo =  .Horaimpo			lxReciboTimestamp = goLibrerias.ObtenerTimestamp()			lxReciboSignomov =  .Signodemovimiento			lxReciboFacttipo =  .Tipocomprobante			lxReciboFcompfis =  .Comprobantefiscal			lxReciboIdvuelto =  upper( .IdVuelto_PK ) 			lxReciboMonsis =  upper( .MonedaSistema_PK ) 			lxReciboFvuelto =  .Vuelto			lxReciboFletra =  .Letra			lxReciboFtotal =  .Total			lxReciboFobs =  .Obs			lxReciboFptoven =  .Puntodeventa			lxReciboFnumcomp =  .Numero			lxReciboFperson =  upper( .Cliente_PK ) 			lxReciboFfch =  .Fecha			lxReciboFven =  upper( .Vendedor_PK ) 			lxReciboMoneda =  upper( .MonedaComprobante_PK ) 			lxReciboAnulado =  .Anulado			lxReciboFcliente =  .Clientedescripcion			lxReciboCodigo =  .Codigo			lxReciboIvasis =  .Ivadelsistema
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13]
			text to lcSentencia noshow textmerge
				update ZooLogic.RECIBO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxReciboFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxReciboFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxReciboFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxReciboFectrans ) + "'">>, "Idcaja" = <<lxReciboIdcaja>>, "Cotiz" = <<lxReciboCotiz>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxReciboUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxReciboSmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxReciboHaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxReciboVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxReciboUmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxReciboEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxReciboBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxReciboBdmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxReciboFaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxReciboValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxReciboZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxReciboDescfw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxReciboSimbmon ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxReciboHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxReciboSaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxReciboHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxReciboHoraimpo ) + "'">>, "Timestamp" = <<lxReciboTimestamp>>, "Signomov" = <<lxReciboSignomov>>, "Facttipo" = <<lxReciboFacttipo>>, "Fcompfis" = <<iif( lxReciboFcompfis, 1, 0 )>>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxReciboIdvuelto ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxReciboMonsis ) + "'">>, "Fvuelto" = <<lxReciboFvuelto>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxReciboFletra ) + "'">>, "Ftotal" = <<lxReciboFtotal>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxReciboFobs ) + "'">>, "Fptoven" = <<lxReciboFptoven>>, "Fnumcomp" = <<lxReciboFnumcomp>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxReciboFperson ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxReciboFfch ) + "'">>, "Fven" = <<"'" + this.FormatearTextoSql( lxReciboFven ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxReciboMoneda ) + "'">>, "Anulado" = <<iif( lxReciboAnulado, 1, 0 )>>, "Fcliente" = <<"'" + this.FormatearTextoSql( lxReciboFcliente ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxReciboCodigo ) + "'">>, "Ivasis" = <<lxReciboIvasis>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'RECIBO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ReciboDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ReciRete where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
			for each loItem in this.oEntidad.CompAfec2
				if this.oEntidad.CompAfec2.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
			for each loItem in this.oEntidad.ReciboDetalle
				if this.oEntidad.ReciboDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxVencimiento = loItem.Vencimiento
					lxCaja_PK = loItem.Caja_PK
					lxCodigocomprobante = loItem.Codigocomprobante
					lxCliente = loItem.Cliente
					lxCae = loItem.Cae
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxBasededatosaltafw = loItem.Basededatosaltafw
					lxLetra = loItem.Letra
					lxSecuencia = loItem.Secuencia
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxFecha = loItem.Fecha
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReciboDet("RFecVen","IdCaja","CodComp","Cliente","Cae","Tipo","BDAltaFW","LetraAfec","FACTSEC","NROITEM","PtoAfec","Rtipo","Numafec","lPagoACta","RVal","CODIGO","Fecha","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCae ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosaltafw ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxSecuencia ) + "'">>, <<lxNroitem>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxNumerodecomprobante>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RetencionesRecibidas
				if this.oEntidad.RetencionesRecibidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIdcomprobante = loItem.Idcomprobante
					lxNroitem = lnContadorNroItem
					lxImpuesto_PK = loItem.Impuesto_PK
					lxImpuestodetalle = loItem.Impuestodetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ReciRete("idcomprob","NROITEM","codigo","impuesto","impudeta","monto" ) values ( <<"'" + this.FormatearTextoSql( lxIdcomprobante ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuestodetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13]
		loColeccion.Agregar( 'delete from ZooLogic.RECIBO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ReciboDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ReciRete where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'RECIBO' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

		with this.oEntidad
			.ReciboDetalle.oItem.oCompCtacteitemrecibo.lNuevo = .EsNuevo()
			.ReciboDetalle.oItem.oCompCtacteitemrecibo.lEdicion = .EsEdicion()
			.ReciboDetalle.oItem.oCompCtacteitemrecibo.lEliminar = .lEliminar
			.ReciboDetalle.oItem.oCompCtacteitemrecibo.lAnular = .lAnular
			loColSentencias = .ReciboDetalle.oItem.oCompCtacteitemrecibo.grabar()
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
			
			.RetencionesRecibidas.oItem.oCompRetencionesrecibidas.lNuevo = .EsNuevo()
			.RetencionesRecibidas.oItem.oCompRetencionesrecibidas.lEdicion = .EsEdicion()
			.RetencionesRecibidas.oItem.oCompRetencionesrecibidas.lEliminar = .lEliminar
			.RetencionesRecibidas.oItem.oCompRetencionesrecibidas.lAnular = .lAnular
			loColSentencias = .RetencionesRecibidas.oItem.oCompRetencionesrecibidas.grabar()
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
			lcRetorno = [update ZooLogic.RECIBO set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.RECIBO where  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.RECIBO where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxReciboFACTTIPO as variant, lxReciboFLETRA as variant, lxReciboFPTOVEN as variant, lxReciboFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'RECIBO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.RECIBO Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.RECIBO set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FVEN = ] + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FCLIENTE = ] + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, IvaSis = ] + transform( &lcCursor..IvaSis ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.RECIBO Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FECEXPO, FECIMPO, FECTRANS, IdCaja, Cotiz, UALTAFW, SMODIFW, HAltaFW, VMODIFW, UMODIFW, ESTTRANS, BDALTAFW, BDMODIFW, FAltaFW, VALTAFW, ZADSFW, DescFW, SimbMon, HMODIFW, SALTAFW, HORAEXPO, HORAIMPO, TIMESTAMP, signomov, FACTTIPO, FCOMPFIS, idVuelto, MonSis, FVuelto, FLETRA, FTotal, FObs, FPTOVEN, FNUMCOMP, FPerson, FFCH, FVEN, Moneda, Anulado, FCLIENTE, CODIGO, IvaSis
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..Cotiz ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + transform( &lcCursor..FVuelto )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + transform( &lcCursor..IvaSis )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.RECIBO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'RECIBO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.VAL Where JJNUM] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ReciboDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ReciRete Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMRECIBO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"RFecVen","IdCaja","CodComp","Cliente","Cae","Tipo","BDAltaFW","LetraAfec","FACTSEC","NROITEM","PtoAfec","Rtipo","Numafec","lPagoACta","RVal","CODIGO","Fecha","Descrip","anotacion","SaldoAux","RMonto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ReciboDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.RFecVen    ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodComp    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cliente    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cae        ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Tipo       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.BDAltaFW   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LetraAfec  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FACTSEC    ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.PtoAfec    ) + ',' + transform( cDetallesExistentes.Rtipo      ) + ',' + transform( cDetallesExistentes.Numafec    ) + ',' + Transform( iif( cDetallesExistentes.lPagoACta , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.RVal       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.Fecha      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.anotacion  ) + "'" + ',' + transform( cDetallesExistentes.SaldoAux   ) + ',' + transform( cDetallesExistentes.RMonto     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMRETENCIONRECIBO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"idcomprob","NROITEM","codigo","impuesto","impudeta","monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ReciRete ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.idcomprob  ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.impuesto   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.impudeta   ) + "'" + ',' + transform( cDetallesExistentes.monto      ) + ' )'  )
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
		this.oEntidad.ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMVALORES',this.oEntidad.cPrefijoRecibir + 'RECIBO')
		this.oEntidad.ReciboDetalle.oItem.oCompCtacteitemrecibo.Recibir( this.oEntidad, 'ReciboDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMRECIBO',this.oEntidad.cPrefijoRecibir + 'RECIBO')
		this.oEntidad.RetencionesRecibidas.oItem.oCompRetencionesrecibidas.Recibir( this.oEntidad, 'RetencionesRecibidas',this.oEntidad.cPrefijoRecibir + 'ITEMRETENCIONRECIBO',this.oEntidad.cPrefijoRecibir + 'RECIBO')
		
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
			Case  lcAlias == lcPrefijo + 'RECIBO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'RECIBO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'RECIBO_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALORES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMRECIBO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMRETENCIONRECIBO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_Recibo')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'RECIBO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad RECIBO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'RECIBO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'RECIBO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FFCH      
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Recibo') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Recibo
Create Table ZooLogic.TablaTrabajo_Recibo ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"idcaja" numeric( 2, 0 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"haltafw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"faltafw" datetime  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"simbmon" char( 3 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"signomov" numeric( 2, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"fcompfis" bit  null, 
"idvuelto" char( 5 )  null, 
"monsis" char( 10 )  null, 
"fvuelto" numeric( 15, 2 )  null, 
"fletra" char( 1 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"fobs" varchar(max)  null, 
"fptoven" numeric( 4, 0 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"fperson" char( 10 )  null, 
"ffch" datetime  null, 
"fven" char( 10 )  null, 
"moneda" char( 10 )  null, 
"anulado" bit  null, 
"fcliente" char( 185 )  null, 
"codigo" char( 38 )  null, 
"ivasis" numeric( 10, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_Recibo' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_Recibo' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'RECIBO'
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
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('fven','fven')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fcliente','fcliente')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('ivasis','ivasis')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_Recibo'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FVEN = isnull( d.FVEN, t.FVEN ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FCLIENTE = isnull( d.FCLIENTE, t.FCLIENTE ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.IVASIS = isnull( d.IVASIS, t.IVASIS )
					from ZooLogic.RECIBO t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.RECIBO(Fmodifw,Fecexpo,Fecimpo,Fectrans,Idcaja,Cotiz,Ualtafw,Smodifw,Haltafw,Vmodifw,Umodifw,Esttrans,Bdaltafw,Bdmodifw,Faltafw,Valtafw,Zadsfw,Descfw,Simbmon,Hmodifw,Saltafw,Horaexpo,Horaimpo,Timestamp,Signomov,Facttipo,Fcompfis,Idvuelto,Monsis,Fvuelto,Fletra,Ftotal,Fobs,Fptoven,Fnumcomp,Fperson,Ffch,Fven,Moneda,Anulado,Fcliente,Codigo,Ivasis)
					Select isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.IDCAJA,0),isnull( d.COTIZ,0),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.SIMBMON,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.TIMESTAMP,0),isnull( d.SIGNOMOV,0),isnull( d.FACTTIPO,0),isnull( d.FCOMPFIS,0),isnull( d.IDVUELTO,''),isnull( d.MONSIS,''),isnull( d.FVUELTO,0),isnull( d.FLETRA,''),isnull( d.FTOTAL,0),isnull( d.FOBS,''),isnull( d.FPTOVEN,0),isnull( d.FNUMCOMP,0),isnull( d.FPERSON,''),isnull( d.FFCH,''),isnull( d.FVEN,''),isnull( d.MONEDA,''),isnull( d.ANULADO,0),isnull( d.FCLIENTE,''),isnull( d.CODIGO,''),isnull( d.IVASIS,0)
						From deleted d left join ZooLogic.RECIBO pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.RECIBO cc 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.RECIBO t inner join deleted d 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.RECIBO t inner join deleted d 
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
	function ObtenerTriggerDeleteImportacion_VAL( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_RECIBO_VAL
ON ZooLogic.TablaTrabajo_RECIBO_VAL
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
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_RECIBO_CompAfe
ON ZooLogic.TablaTrabajo_RECIBO_CompAfe
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
	function ObtenerTriggerDeleteImportacion_ReciboDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_RECIBO_ReciboDet
ON ZooLogic.TablaTrabajo_RECIBO_ReciboDet
AFTER DELETE
As
Begin
Update t Set 
t.RFECVEN = isnull( d.RFECVEN, t.RFECVEN ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),
t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),
t.CAE = isnull( d.CAE, t.CAE ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),
t.LETRAAFEC = isnull( d.LETRAAFEC, t.LETRAAFEC ),
t.FACTSEC = isnull( d.FACTSEC, t.FACTSEC ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PTOAFEC = isnull( d.PTOAFEC, t.PTOAFEC ),
t.RTIPO = isnull( d.RTIPO, t.RTIPO ),
t.NUMAFEC = isnull( d.NUMAFEC, t.NUMAFEC ),
t.LPAGOACTA = isnull( d.LPAGOACTA, t.LPAGOACTA ),
t.RVAL = isnull( d.RVAL, t.RVAL ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FECHA = isnull( d.FECHA, t.FECHA ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.ANOTACION = isnull( d.ANOTACION, t.ANOTACION ),
t.SALDOAUX = isnull( d.SALDOAUX, t.SALDOAUX ),
t.RMONTO = isnull( d.RMONTO, t.RMONTO )
from ZooLogic.ReciboDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ReciboDet
( 
"RFECVEN",
"IDCAJA",
"CODCOMP",
"CLIENTE",
"CAE",
"TIPO",
"BDALTAFW",
"LETRAAFEC",
"FACTSEC",
"NROITEM",
"PTOAFEC",
"RTIPO",
"NUMAFEC",
"LPAGOACTA",
"RVAL",
"CODIGO",
"FECHA",
"DESCRIP",
"ANOTACION",
"SALDOAUX",
"RMONTO"
 )
Select 
d.RFECVEN,
d.IDCAJA,
d.CODCOMP,
d.CLIENTE,
d.CAE,
d.TIPO,
d.BDALTAFW,
d.LETRAAFEC,
d.FACTSEC,
d.NROITEM,
d.PTOAFEC,
d.RTIPO,
d.NUMAFEC,
d.LPAGOACTA,
d.RVAL,
d.CODIGO,
d.FECHA,
d.DESCRIP,
d.ANOTACION,
d.SALDOAUX,
d.RMONTO
From deleted d left join ZooLogic.ReciboDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ReciRete( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_RECIBO_ReciRete
ON ZooLogic.TablaTrabajo_RECIBO_ReciRete
AFTER DELETE
As
Begin
Update t Set 
t.IDCOMPROB = isnull( d.IDCOMPROB, t.IDCOMPROB ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.IMPUESTO = isnull( d.IMPUESTO, t.IMPUESTO ),
t.IMPUDETA = isnull( d.IMPUDETA, t.IMPUDETA ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.ReciRete t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ReciRete
( 
"IDCOMPROB",
"NROITEM",
"CODIGO",
"IMPUESTO",
"IMPUDETA",
"MONTO"
 )
Select 
d.IDCOMPROB,
d.NROITEM,
d.CODIGO,
d.IMPUESTO,
d.IMPUDETA,
d.MONTO
From deleted d left join ZooLogic.ReciRete pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Recibo') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Recibo
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_RECIBO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_RECIBO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_RECIBO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_RECIBO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_RECIBO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Caja_PK =  nvl( c_RECIBO.Caja, 0 )
					.Cotizacion = nvl( c_RECIBO.Cotizacion, 0 )
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Compafec2.Limpiar()
					.Compafec2.SetearEsNavegacion( .lProcesando )
					.Compafec2.Cargar()
					.Usuarioaltafw = nvl( c_RECIBO.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_RECIBO.Seriemodificacionfw, [] )
					.Horaaltafw = nvl( c_RECIBO.Horaaltafw, [] )
					.Versionmodificacionfw = nvl( c_RECIBO.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_RECIBO.Usuariomodificacionfw, [] )
					.Estadotransferencia = nvl( c_RECIBO.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_RECIBO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_RECIBO.Basededatosmodificacionfw, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_RECIBO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Versionaltafw = nvl( c_RECIBO.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_RECIBO.Descripcionfw, [] )
					.Simbolomonetariocomprobante = nvl( c_RECIBO.Simbolomonetariocomprobante, [] )
					.Horamodificacionfw = nvl( c_RECIBO.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_RECIBO.Seriealtafw, [] )
					.Horaexpo = nvl( c_RECIBO.Horaexpo, [] )
					.Horaimpo = nvl( c_RECIBO.Horaimpo, [] )
					.Timestamp = nvl( c_RECIBO.Timestamp, 0 )
					.Signodemovimiento = nvl( c_RECIBO.Signodemovimiento, 0 )
					.Tipocomprobante = nvl( c_RECIBO.Tipocomprobante, 0 )
					.Comprobantefiscal = nvl( c_RECIBO.Comprobantefiscal, .F. )
					.Recibodetalle.Limpiar()
					.Recibodetalle.SetearEsNavegacion( .lProcesando )
					.Recibodetalle.Cargar()
					.Idvuelto_PK =  nvl( c_RECIBO.Idvuelto, [] )
					.Monedasistema_PK =  nvl( c_RECIBO.Monedasistema, [] )
					.Retencionesrecibidas.Limpiar()
					.Retencionesrecibidas.SetearEsNavegacion( .lProcesando )
					.Retencionesrecibidas.Cargar()
					.Vuelto = nvl( c_RECIBO.Vuelto, 0 )
					.Letra = nvl( c_RECIBO.Letra, [] )
					.Total = nvl( c_RECIBO.Total, 0 )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Puntodeventa = nvl( c_RECIBO.Puntodeventa, 0 )
					.Numero = nvl( c_RECIBO.Numero, 0 )
					.Cliente_PK =  nvl( c_RECIBO.Cliente, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_RECIBO.Fecha, ctod( '  /  /    ' ) ) )
					.Vendedor_PK =  nvl( c_RECIBO.Vendedor, [] )
					.Monedacomprobante_PK =  nvl( c_RECIBO.Monedacomprobante, [] )
					.Anulado = nvl( c_RECIBO.Anulado, .F. )
					.Clientedescripcion = nvl( c_RECIBO.Clientedescripcion, [] )
					.Codigo = nvl( c_RECIBO.Codigo, [] )
					.Ivadelsistema = nvl( c_RECIBO.Ivadelsistema, 0 )
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
			lxRetorno = c_RECIBO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
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

		loDetalle = this.oEntidad.CompAfec2
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

		loDetalle = this.oEntidad.ReciboDetalle
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

		loDetalle = this.oEntidad.RetencionesRecibidas
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
		return c_RECIBO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.RECIBO' )
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
								from ZooLogic.RECIBO 
								Where   RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "RECIBO", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Cotiz" as "Cotizacion", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Faltafw" as "Fechaaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fvuelto" as "Vuelto", "Fletra" as "Letra", "Ftotal" as "Total", "Fobs" as "Obs", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Fperson" as "Cliente", "Ffch" as "Fecha", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Anulado" as "Anulado", "Fcliente" as "Clientedescripcion", "Codigo" as "Codigo", "Ivasis" as "Ivadelsistema"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.RECIBO 
								Where   RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13
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
	Tabla = 'RECIBO'
	Filtro = " RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " RECIBO.CODIGO != '' AND RECIBO.FACTTIPO = 13"
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
	<row entidad="RECIBO                                  " atributo="FECHAMODIFICACIONFW                     " tabla="RECIBO         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="FECHAEXPO                               " tabla="RECIBO         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="FECHAIMPO                               " tabla="RECIBO         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="FECHATRANSFERENCIA                      " tabla="RECIBO         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="CAJA                                    " tabla="RECIBO         " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                            " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="COTIZACION                              " tabla="RECIBO         " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="VALORESDETALLE                          " tabla="VAL            " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Valores                                                                                                                                                         " dominio="DETALLEITEMVALORES            " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="COMPAFEC2                               " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="USUARIOALTAFW                           " tabla="RECIBO         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="SERIEMODIFICACIONFW                     " tabla="RECIBO         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="HORAALTAFW                              " tabla="RECIBO         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="VERSIONMODIFICACIONFW                   " tabla="RECIBO         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="USUARIOMODIFICACIONFW                   " tabla="RECIBO         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="ESTADOTRANSFERENCIA                     " tabla="RECIBO         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="BASEDEDATOSALTAFW                       " tabla="RECIBO         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="RECIBO         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="FECHAALTAFW                             " tabla="RECIBO         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="VERSIONALTAFW                           " tabla="RECIBO         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="ZADSFW                                  " tabla="RECIBO         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="DESCRIPCIONFW                           " tabla="RECIBO         " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="RECIBO         " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="HORAMODIFICACIONFW                      " tabla="RECIBO         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="SERIEALTAFW                             " tabla="RECIBO         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="HORAEXPO                                " tabla="RECIBO         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="HORAIMPO                                " tabla="RECIBO         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="TIMESTAMP                               " tabla="RECIBO         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="SIGNODEMOVIMIENTO                       " tabla="RECIBO         " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="TIPOCOMPROBANTE                         " tabla="RECIBO         " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=13                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="14" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="COMPROBANTEFISCAL                       " tabla="RECIBO         " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="RECIBODETALLE                           " tabla="RECIBODET      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMRECIBO             " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="IDVUELTO                                " tabla="RECIBO         " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código vuelto                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="MONEDASISTEMA                           " tabla="RECIBO         " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Sistema                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="RETENCIONESRECIBIDAS                    " tabla="RECIRETE       " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Retenciones                                                                                                                                                     " dominio="DETALLEITEMRETENCIONRECIBO    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="VUELTOVIRTUAL                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Vuelto                                                                                                                                                          " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="VUELTO                                  " tabla="RECIBO         " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto persistido                                                                                                                                               " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="LETRA                                   " tabla="RECIBO         " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROPTOVTAEDITABLE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="TOTAL                                   " tabla="RECIBO         " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="OBS                                     " tabla="RECIBO         " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Obs.                                                                                                                                                            " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="PUNTODEVENTA                            " tabla="RECIBO         " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROPTOVTAEDITABLE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="NUMERO                                  " tabla="RECIBO         " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="NUMEROPTOVTAEDITABLE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="CLIENTE                                 " tabla="RECIBO         " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="FECHA                                   " tabla="RECIBO         " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=GOLIBRERIAS.OBTENERFECHA()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="VENDEDOR                                " tabla="RECIBO         " campo="FVEN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGOVENDEDOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="MONEDACOMPROBANTE                       " tabla="RECIBO         " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="=goParametros.Felino.Generales.MonedaSistema                                                                                                                                                                                                                  " obligatorio="true" admitebusqueda="412" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="MONTOCONCILIAR                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Monto a conciliar                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="DEUDA                                   " tabla="RECIBO         " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Saldo en cta. cte.                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="PORCENTAJEDESCUENTO                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Porcentaje descuento                                                                                                                                            " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="ANULADO                                 " tabla="RECIBO         " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="CLIENTEDESCRIPCION                      " tabla="RECIBO         " campo="FCLIENTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Cliente descripción                                                                                                                                             " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="CODIGO                                  " tabla="RECIBO         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="16" etiqueta="Nro. Interno                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="DESCUENTOMONTO                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Monto descuento                                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="MONTODEDESCUENTO                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Monto descuento                                                                                                                                                 " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="RECARGOPORCENTAJE                       " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Recargo porcentaje                                                                                                                                              " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="RECARGOMONTO                            " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Recargo monto                                                                                                                                                   " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="MONTODERECARGO                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="DESCUENTOSYRECARGOSENVALORES            " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Desc. y rec. valores                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="61" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="RECIBO                                  " atributo="IVADELSISTEMA                           " tabla="RECIBO         " campo="IVASIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="goparametros.felino.datoSIMPOSITIVOS.ivaINSCRIPTOS                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="81" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="9" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On RECIBO.FPERSON = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On RECIBO.FVEN = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On RECIBO.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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