
define class Din_EntidadORDENDEPAGOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ORDENDEPAGO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 10, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 10, 0)]
	cTagClaveCandidata = '_ODPCC'
	cTagClavePk = '_ODPPK'
	cTablaPrincipal = 'ORDPAGO'
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
			local  lxOrdpagoFmodifw, lxOrdpagoFecimpo, lxOrdpagoFectrans, lxOrdpagoFecexpo, lxOrdpagoIdcaja, lxOrdpagoHoraexpo, lxOrdpagoBdmodifw, lxOrdpagoBdaltafw, lxOrdpagoHoraimpo, lxOrdpagoEsttrans, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoHaltafw, lxOrdpagoFaltafw, lxOrdpagoSimbmon, lxOrdpagoSignomov, lxOrdpagoTimestamp, lxOrdpagoFacttipo, lxOrdpagoFcompfis, lxOrdpagoIdvuelto, lxOrdpagoMonsis, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoCotiz, lxOrdpagoMoneda, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFmodifw =  .Fechamodificacionfw			lxOrdpagoFecimpo =  .Fechaimpo			lxOrdpagoFectrans =  .Fechatransferencia			lxOrdpagoFecexpo =  .Fechaexpo			lxOrdpagoIdcaja =  .Caja_PK 			lxOrdpagoHoraexpo =  .Horaexpo			lxOrdpagoBdmodifw =  .Basededatosmodificacionfw			lxOrdpagoBdaltafw =  .Basededatosaltafw			lxOrdpagoHoraimpo =  .Horaimpo			lxOrdpagoEsttrans =  .Estadotransferencia			lxOrdpagoSmodifw =  .Seriemodificacionfw			lxOrdpagoHmodifw =  .Horamodificacionfw			lxOrdpagoVmodifw =  .Versionmodificacionfw			lxOrdpagoZadsfw =  .Zadsfw			lxOrdpagoUmodifw =  .Usuariomodificacionfw			lxOrdpagoValtafw =  .Versionaltafw			lxOrdpagoSaltafw =  .Seriealtafw			lxOrdpagoUaltafw =  .Usuarioaltafw			lxOrdpagoHaltafw =  .Horaaltafw			lxOrdpagoFaltafw =  .Fechaaltafw			lxOrdpagoSimbmon =  .Simbolomonetariocomprobante			lxOrdpagoSignomov =  .Signodemovimiento			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFacttipo =  .Tipocomprobante			lxOrdpagoFcompfis =  .Comprobantefiscal			lxOrdpagoIdvuelto =  upper( .IdVuelto_PK ) 			lxOrdpagoMonsis =  upper( .MonedaSistema_PK ) 			lxOrdpagoFletra =  .Letra			lxOrdpagoFptoven =  .Puntodeventa			lxOrdpagoImpman =  .Impuestosmanuales			lxOrdpagoFnumcomp =  .Numero			lxOrdpagoFperson =  upper( .Proveedor_PK ) 			lxOrdpagoFfch =  .Fecha			lxOrdpagoFven =  .Usuario			lxOrdpagoCotiz =  .Cotizacion			lxOrdpagoMoneda =  upper( .MonedaComprobante_PK ) 			lxOrdpagoFtotal =  .Total			lxOrdpagoPtovtacdr =  .Puntodeventacdr			lxOrdpagoNumcdr =  .Numerocdr			lxOrdpagoFobs =  .Obs			lxOrdpagoFvuelto =  .Vuelto			lxOrdpagoAnulado =  .Anulado			lxOrdpagoFproved =  .Proveedordescripcion			lxOrdpagoCodigo =  .Codigo
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxOrdpagoCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ORDPAGO ( "Fmodifw","Fecimpo","Fectrans","Fecexpo","Idcaja","Horaexpo","Bdmodifw","Bdaltafw","Horaimpo","Esttrans","Smodifw","Hmodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Saltafw","Ualtafw","Haltafw","Faltafw","Simbmon","Signomov","Timestamp","Facttipo","Fcompfis","Idvuelto","Monsis","Fletra","Fptoven","Impman","Fnumcomp","Fperson","Ffch","Fven","Cotiz","Moneda","Ftotal","Ptovtacdr","Numcdr","Fobs","Fvuelto","Anulado","Fproved","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxOrdpagoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFecexpo ) + "'" >>, <<lxOrdpagoIdcaja >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSimbmon ) + "'" >>, <<lxOrdpagoSignomov >>, <<lxOrdpagoTimestamp >>, <<lxOrdpagoFacttipo >>, <<iif( lxOrdpagoFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOrdpagoIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFletra ) + "'" >>, <<lxOrdpagoFptoven >>, <<iif( lxOrdpagoImpman, 1, 0 ) >>, <<lxOrdpagoFnumcomp >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFven ) + "'" >>, <<lxOrdpagoCotiz >>, <<"'" + this.FormatearTextoSql( lxOrdpagoMoneda ) + "'" >>, <<lxOrdpagoFtotal >>, <<lxOrdpagoPtovtacdr >>, <<lxOrdpagoNumcdr >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFobs ) + "'" >>, <<lxOrdpagoFvuelto >>, <<iif( lxOrdpagoAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFproved ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'" >> )
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
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxTipodocumento = loItem.Tipodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxCotiza = loItem.Cotiza
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
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
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxCotiza>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePagoDetalle
				if this.oEntidad.OrdenDePagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTotalcomprobanteconimpuestos = loItem.Totalcomprobanteconimpuestos
					lxTotalcomprobantegravado = loItem.Totalcomprobantegravado
					lxTotalcomprobantesinimpuestos = loItem.Totalcomprobantesinimpuestos
					lxPuntodeventa = loItem.Puntodeventa
					lxNroitem = lnContadorNroItem
					lxTotalcomprobanteiva = loItem.Totalcomprobanteiva
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxTipo = loItem.Tipo
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OrdPagoDet("Fecha","IdCaja","Tipo","LetraAfec","CodComp","TotComCI","TotComGRAV","TotComSI","PtoAfec","NROITEM","TotComIVA","Numafec","Rtipo","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<lxTotalcomprobanteconimpuestos>>, <<lxTotalcomprobantegravado>>, <<lxTotalcomprobantesinimpuestos>>, <<lxPuntodeventa>>, <<lxNroitem>>, <<lxTotalcomprobanteiva>>, <<lxNumerodecomprobante>>, <<lxTipo>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
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
					
					lxCodigocdr = loItem.Codigocdr
					lxTipoimpuestocdr = loItem.Tipoimpuestocdr
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpODP("CodigoCDR","TipoImp","NROITEM","Codigo","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuestocdr ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxOrdpagoTimestamp
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
			local  lxOrdpagoFmodifw, lxOrdpagoFecimpo, lxOrdpagoFectrans, lxOrdpagoFecexpo, lxOrdpagoIdcaja, lxOrdpagoHoraexpo, lxOrdpagoBdmodifw, lxOrdpagoBdaltafw, lxOrdpagoHoraimpo, lxOrdpagoEsttrans, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoHaltafw, lxOrdpagoFaltafw, lxOrdpagoSimbmon, lxOrdpagoSignomov, lxOrdpagoTimestamp, lxOrdpagoFacttipo, lxOrdpagoFcompfis, lxOrdpagoIdvuelto, lxOrdpagoMonsis, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoCotiz, lxOrdpagoMoneda, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFmodifw =  .Fechamodificacionfw			lxOrdpagoFecimpo =  .Fechaimpo			lxOrdpagoFectrans =  .Fechatransferencia			lxOrdpagoFecexpo =  .Fechaexpo			lxOrdpagoIdcaja =  .Caja_PK 			lxOrdpagoHoraexpo =  .Horaexpo			lxOrdpagoBdmodifw =  .Basededatosmodificacionfw			lxOrdpagoBdaltafw =  .Basededatosaltafw			lxOrdpagoHoraimpo =  .Horaimpo			lxOrdpagoEsttrans =  .Estadotransferencia			lxOrdpagoSmodifw =  .Seriemodificacionfw			lxOrdpagoHmodifw =  .Horamodificacionfw			lxOrdpagoVmodifw =  .Versionmodificacionfw			lxOrdpagoZadsfw =  .Zadsfw			lxOrdpagoUmodifw =  .Usuariomodificacionfw			lxOrdpagoValtafw =  .Versionaltafw			lxOrdpagoSaltafw =  .Seriealtafw			lxOrdpagoUaltafw =  .Usuarioaltafw			lxOrdpagoHaltafw =  .Horaaltafw			lxOrdpagoFaltafw =  .Fechaaltafw			lxOrdpagoSimbmon =  .Simbolomonetariocomprobante			lxOrdpagoSignomov =  .Signodemovimiento			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFacttipo =  .Tipocomprobante			lxOrdpagoFcompfis =  .Comprobantefiscal			lxOrdpagoIdvuelto =  upper( .IdVuelto_PK ) 			lxOrdpagoMonsis =  upper( .MonedaSistema_PK ) 			lxOrdpagoFletra =  .Letra			lxOrdpagoFptoven =  .Puntodeventa			lxOrdpagoImpman =  .Impuestosmanuales			lxOrdpagoFnumcomp =  .Numero			lxOrdpagoFperson =  upper( .Proveedor_PK ) 			lxOrdpagoFfch =  .Fecha			lxOrdpagoFven =  .Usuario			lxOrdpagoCotiz =  .Cotizacion			lxOrdpagoMoneda =  upper( .MonedaComprobante_PK ) 			lxOrdpagoFtotal =  .Total			lxOrdpagoPtovtacdr =  .Puntodeventacdr			lxOrdpagoNumcdr =  .Numerocdr			lxOrdpagoFobs =  .Obs			lxOrdpagoFvuelto =  .Vuelto			lxOrdpagoAnulado =  .Anulado			lxOrdpagoFproved =  .Proveedordescripcion			lxOrdpagoCodigo =  .Codigo
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
				update ZooLogic.ORDPAGO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxOrdpagoFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxOrdpagoFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxOrdpagoFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxOrdpagoFecexpo ) + "'">>,"Idcaja" = <<lxOrdpagoIdcaja>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxOrdpagoHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoBdaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxOrdpagoHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxOrdpagoEsttrans ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxOrdpagoZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoUaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoHaltafw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxOrdpagoFaltafw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxOrdpagoSimbmon ) + "'">>,"Signomov" = <<lxOrdpagoSignomov>>,"Timestamp" = <<lxOrdpagoTimestamp>>,"Facttipo" = <<lxOrdpagoFacttipo>>,"Fcompfis" = <<iif( lxOrdpagoFcompfis, 1, 0 )>>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxOrdpagoIdvuelto ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxOrdpagoMonsis ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxOrdpagoFletra ) + "'">>,"Fptoven" = <<lxOrdpagoFptoven>>,"Impman" = <<iif( lxOrdpagoImpman, 1, 0 )>>,"Fnumcomp" = <<lxOrdpagoFnumcomp>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxOrdpagoFperson ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxOrdpagoFfch ) + "'">>,"Fven" = <<"'" + this.FormatearTextoSql( lxOrdpagoFven ) + "'">>,"Cotiz" = <<lxOrdpagoCotiz>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxOrdpagoMoneda ) + "'">>,"Ftotal" = <<lxOrdpagoFtotal>>,"Ptovtacdr" = <<lxOrdpagoPtovtacdr>>,"Numcdr" = <<lxOrdpagoNumcdr>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxOrdpagoFobs ) + "'">>,"Fvuelto" = <<lxOrdpagoFvuelto>>,"Anulado" = <<iif( lxOrdpagoAnulado, 1, 0 )>>,"Fproved" = <<"'" + this.FormatearTextoSql( lxOrdpagoFproved ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'">> and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ValFacComp where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.OrdPagoDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpODP where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxTipodocumento = loItem.Tipodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxCotiza = loItem.Cotiza
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
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
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxCotiza>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePagoDetalle
				if this.oEntidad.OrdenDePagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTotalcomprobanteconimpuestos = loItem.Totalcomprobanteconimpuestos
					lxTotalcomprobantegravado = loItem.Totalcomprobantegravado
					lxTotalcomprobantesinimpuestos = loItem.Totalcomprobantesinimpuestos
					lxPuntodeventa = loItem.Puntodeventa
					lxNroitem = lnContadorNroItem
					lxTotalcomprobanteiva = loItem.Totalcomprobanteiva
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxTipo = loItem.Tipo
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OrdPagoDet("Fecha","IdCaja","Tipo","LetraAfec","CodComp","TotComCI","TotComGRAV","TotComSI","PtoAfec","NROITEM","TotComIVA","Numafec","Rtipo","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<lxTotalcomprobanteconimpuestos>>, <<lxTotalcomprobantegravado>>, <<lxTotalcomprobantesinimpuestos>>, <<lxPuntodeventa>>, <<lxNroitem>>, <<lxTotalcomprobanteiva>>, <<lxNumerodecomprobante>>, <<lxTipo>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
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
					
					lxCodigocdr = loItem.Codigocdr
					lxTipoimpuestocdr = loItem.Tipoimpuestocdr
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpODP("CodigoCDR","TipoImp","NROITEM","Codigo","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuestocdr ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxOrdpagoTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.ORDPAGO where " + this.ConvertirFuncionesSql( " ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31" ) )
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
			Local lxOrdpagoCodigo
			lxOrdpagoCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Idcaja" as "Caja", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Signomov" as "Signodemovimiento", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Cotiz" as "Cotizacion", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'">> and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )

			if reccount( 'c_ORDENDEPAGO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codcomp" as "Codigocomprobante", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Totcomsi" as "Totalcomprobantesinimpuestos", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Rtipo" as "Tipo", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigocdr" as "Codigocdr", "Tipoimp" as "Tipoimpuestocdr", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
			Local lxOrdPagoFACTTIPO As Variant, lxOrdPagoFLETRA As Variant, lxOrdPagoFPTOVEN As Variant, lxOrdPagoFNUMCOMP As Variant
			lxOrdPagoFACTTIPO = .TipoComprobante
			lxOrdPagoFLETRA = .Letra
			lxOrdPagoFPTOVEN = .PuntoDeVenta
			lxOrdPagoFNUMCOMP = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Idcaja" as "Caja", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Signomov" as "Signodemovimiento", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Cotiz" as "Cotizacion", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 And FACTTIPO = <<lxOrdPagoFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxOrdPagoFLETRA ) + "'">> and FPTOVEN = <<lxOrdPagoFPTOVEN>> and FNUMCOMP = <<lxOrdPagoFNUMCOMP>>
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			if reccount( 'c_ORDENDEPAGO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codcomp" as "Codigocomprobante", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Totcomsi" as "Totalcomprobantesinimpuestos", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Rtipo" as "Tipo", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigocdr" as "Codigocdr", "Tipoimp" as "Tipoimpuestocdr", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxOrdpagoCodigo as Variant
		llRetorno = .t.
		lxOrdpagoCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ORDPAGO where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'">> and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Idcaja" as "Caja", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Signomov" as "Signodemovimiento", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Cotiz" as "Cotizacion", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codcomp" as "Codigocomprobante", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Totcomsi" as "Totalcomprobantesinimpuestos", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Rtipo" as "Tipo", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigocdr" as "Codigocdr", "Tipoimp" as "Tipoimpuestocdr", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Idcaja" as "Caja", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Signomov" as "Signodemovimiento", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Cotiz" as "Cotizacion", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codcomp" as "Codigocomprobante", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Totcomsi" as "Totalcomprobantesinimpuestos", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Rtipo" as "Tipo", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigocdr" as "Codigocdr", "Tipoimp" as "Tipoimpuestocdr", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Idcaja" as "Caja", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Signomov" as "Signodemovimiento", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Cotiz" as "Cotizacion", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codcomp" as "Codigocomprobante", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Totcomsi" as "Totalcomprobantesinimpuestos", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Rtipo" as "Tipo", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigocdr" as "Codigocdr", "Tipoimp" as "Tipoimpuestocdr", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Idcaja" as "Caja", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Signomov" as "Signodemovimiento", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Cotiz" as "Cotizacion", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codcomp" as "Codigocomprobante", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Totcomsi" as "Totalcomprobantesinimpuestos", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Rtipo" as "Tipo", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigocdr" as "Codigocdr", "Tipoimp" as "Tipoimpuestocdr", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecimpo,Fectrans,Fecexpo,Idcaja,Horaexpo,Bdmodifw,Bdaltafw,Horaimpo,Esttrans,Smodifw" + ;
",Hmodifw,Vmodifw,Zadsfw,Umodifw,Valtafw,Saltafw,Ualtafw,Haltafw,Faltafw,Simbmon,Signomov,Timestamp,F" + ;
"acttipo,Fcompfis,Idvuelto,Monsis,Fletra,Fptoven,Impman,Fnumcomp,Fperson,Ffch,Fven,Cotiz,Moneda,Ftota" + ;
"l,Ptovtacdr,Numcdr,Fobs,Fvuelto,Anulado,Fproved,Codigo" + ;
" from ZooLogic.ORDPAGO where  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 and " + lcFiltro )
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
			local  lxOrdpagoFmodifw, lxOrdpagoFecimpo, lxOrdpagoFectrans, lxOrdpagoFecexpo, lxOrdpagoIdcaja, lxOrdpagoHoraexpo, lxOrdpagoBdmodifw, lxOrdpagoBdaltafw, lxOrdpagoHoraimpo, lxOrdpagoEsttrans, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoHaltafw, lxOrdpagoFaltafw, lxOrdpagoSimbmon, lxOrdpagoSignomov, lxOrdpagoTimestamp, lxOrdpagoFacttipo, lxOrdpagoFcompfis, lxOrdpagoIdvuelto, lxOrdpagoMonsis, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoCotiz, lxOrdpagoMoneda, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFmodifw = ctod( '  /  /    ' )			lxOrdpagoFecimpo = ctod( '  /  /    ' )			lxOrdpagoFectrans = ctod( '  /  /    ' )			lxOrdpagoFecexpo = ctod( '  /  /    ' )			lxOrdpagoIdcaja = 0			lxOrdpagoHoraexpo = []			lxOrdpagoBdmodifw = []			lxOrdpagoBdaltafw = []			lxOrdpagoHoraimpo = []			lxOrdpagoEsttrans = []			lxOrdpagoSmodifw = []			lxOrdpagoHmodifw = []			lxOrdpagoVmodifw = []			lxOrdpagoZadsfw = []			lxOrdpagoUmodifw = []			lxOrdpagoValtafw = []			lxOrdpagoSaltafw = []			lxOrdpagoUaltafw = []			lxOrdpagoHaltafw = []			lxOrdpagoFaltafw = ctod( '  /  /    ' )			lxOrdpagoSimbmon = []			lxOrdpagoSignomov = 0			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFacttipo = 0			lxOrdpagoFcompfis = .F.			lxOrdpagoIdvuelto = []			lxOrdpagoMonsis = []			lxOrdpagoFletra = []			lxOrdpagoFptoven = 0			lxOrdpagoImpman = .F.			lxOrdpagoFnumcomp = 0			lxOrdpagoFperson = []			lxOrdpagoFfch = ctod( '  /  /    ' )			lxOrdpagoFven = []			lxOrdpagoCotiz = 0			lxOrdpagoMoneda = []			lxOrdpagoFtotal = 0			lxOrdpagoPtovtacdr = 0			lxOrdpagoNumcdr = 0			lxOrdpagoFobs = []			lxOrdpagoFvuelto = 0			lxOrdpagoAnulado = .F.			lxOrdpagoFproved = []			lxOrdpagoCodigo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ValFacComp where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.OrdPagoDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpODP where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ORDPAGO where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ORDPAGO' + '_' + tcCampo
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
		lcWhere = " Where  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Idcaja" as "Caja", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Signomov" as "Signodemovimiento", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Cotiz" as "Cotizacion", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ORDPAGO', '', tnTope )
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
	Function ObtenerDatosDetalleValoresDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  VALFACCOMP.JJNUM != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio"
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
	Function ObtenerDatosDetalleOrdenDePagoDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ORDPAGODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecha" as "Fecha", "Idcaja" as "Caja", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codcomp" as "Codigocomprobante", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Totcomsi" as "Totalcomprobantesinimpuestos", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Rtipo" as "Tipo", "Lpagoacta" as "Espagoacuenta", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Anotacion" as "Anotacion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOrdenDePagoDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'OrdPagoDet', 'OrdenDePagoDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOrdenDePagoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOrdenDePagoDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleImpuestosComprobante( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPODP.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codigocdr" as "Codigocdr", "Tipoimp" as "Tipoimpuestocdr", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosComprobante( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpODP', 'ImpuestosComprobante', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'IMPUESTOSMANUALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPMAN AS IMPUESTOSMANUALES'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS PROVEEDOR'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'USUARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVEN AS USUARIO'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'PUNTODEVENTACDR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVTACDR AS PUNTODEVENTACDR'
				Case lcAtributo == 'NUMEROCDR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCDR AS NUMEROCDR'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'PROVEEDORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPROVED AS PROVEEDORDESCRIPCION'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJVEN AS VENDEDOR'
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTURNO AS TURNO'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'SIGNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNO'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONDEPAGO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
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
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
				Case lcAtributo == 'PERMITEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERMVUELTO AS PERMITEVUELTO'
				Case lcAtributo == 'NUMEROVALEDECAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALECAMBIO AS NUMEROVALEDECAMBIO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleOrdenDePagoDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPODECOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRAAFEC AS LETRA'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'TOTALCOMPROBANTECONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTCOMCI AS TOTALCOMPROBANTECONIMPUESTOS'
				Case lcAtributo == 'TOTALCOMPROBANTEGRAVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTCOMGRAV AS TOTALCOMPROBANTEGRAVADO'
				Case lcAtributo == 'TOTALCOMPROBANTESINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTCOMSI AS TOTALCOMPROBANTESINIMPUESTOS'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOAFEC AS PUNTODEVENTA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'TOTALCOMPROBANTEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTCOMIVA AS TOTALCOMPROBANTEIVA'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMAFEC AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RTIPO AS TIPO'
				Case lcAtributo == 'ESPAGOACUENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPAGOACTA AS ESPAGOACUENTA'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RVAL AS VALOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'EMISION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEMI AS EMISION'
				Case lcAtributo == 'VENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RFECVEN AS VENCIMIENTO'
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
	Function ObtenerCamposSelectDetalleImpuestosComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGOCDR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOCDR AS CODIGOCDR'
				Case lcAtributo == 'TIPOIMPUESTOCDR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOIMP AS TIPOIMPUESTOCDR'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOSMANUALES'
				lcCampo = 'IMPMAN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIO'
				lcCampo = 'FVEN'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTACDR'
				lcCampo = 'PTOVTACDR'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCDR'
				lcCampo = 'NUMCDR'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORDESCRIPCION'
				lcCampo = 'FPROVED'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'JJVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'NRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'TIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'JJTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
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
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEVUELTO'
				lcCampo = 'PERMVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROVALEDECAMBIO'
				lcCampo = 'VALECAMBIO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleOrdenDePagoDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRAAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCOMPROBANTECONIMPUESTOS'
				lcCampo = 'TOTCOMCI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCOMPROBANTEGRAVADO'
				lcCampo = 'TOTCOMGRAV'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCOMPROBANTESINIMPUESTOS'
				lcCampo = 'TOTCOMSI'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCOMPROBANTEIVA'
				lcCampo = 'TOTCOMIVA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'RTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESPAGOACUENTA'
				lcCampo = 'LPAGOACTA'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'RVAL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'EMISION'
				lcCampo = 'FECEMI'
			Case upper( alltrim( tcAtributo ) ) == 'VENCIMIENTO'
				lcCampo = 'RFECVEN'
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
	Function ObtenerCampoDetalleImpuestosComprobante( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCDR'
				lcCampo = 'CODIGOCDR'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTOCDR'
				lcCampo = 'TIPOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC2'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'VALORESDETALLE'
			lcRetorno = 'VALFACCOMP'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ORDENDEPAGODETALLE'
			lcRetorno = 'ORDPAGODET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPODP'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxOrdpagoFmodifw, lxOrdpagoFecimpo, lxOrdpagoFectrans, lxOrdpagoFecexpo, lxOrdpagoIdcaja, lxOrdpagoHoraexpo, lxOrdpagoBdmodifw, lxOrdpagoBdaltafw, lxOrdpagoHoraimpo, lxOrdpagoEsttrans, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoHaltafw, lxOrdpagoFaltafw, lxOrdpagoSimbmon, lxOrdpagoSignomov, lxOrdpagoTimestamp, lxOrdpagoFacttipo, lxOrdpagoFcompfis, lxOrdpagoIdvuelto, lxOrdpagoMonsis, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoCotiz, lxOrdpagoMoneda, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFmodifw =  .Fechamodificacionfw			lxOrdpagoFecimpo =  .Fechaimpo			lxOrdpagoFectrans =  .Fechatransferencia			lxOrdpagoFecexpo =  .Fechaexpo			lxOrdpagoIdcaja =  .Caja_PK 			lxOrdpagoHoraexpo =  .Horaexpo			lxOrdpagoBdmodifw =  .Basededatosmodificacionfw			lxOrdpagoBdaltafw =  .Basededatosaltafw			lxOrdpagoHoraimpo =  .Horaimpo			lxOrdpagoEsttrans =  .Estadotransferencia			lxOrdpagoSmodifw =  .Seriemodificacionfw			lxOrdpagoHmodifw =  .Horamodificacionfw			lxOrdpagoVmodifw =  .Versionmodificacionfw			lxOrdpagoZadsfw =  .Zadsfw			lxOrdpagoUmodifw =  .Usuariomodificacionfw			lxOrdpagoValtafw =  .Versionaltafw			lxOrdpagoSaltafw =  .Seriealtafw			lxOrdpagoUaltafw =  .Usuarioaltafw			lxOrdpagoHaltafw =  .Horaaltafw			lxOrdpagoFaltafw =  .Fechaaltafw			lxOrdpagoSimbmon =  .Simbolomonetariocomprobante			lxOrdpagoSignomov =  .Signodemovimiento			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFacttipo =  .Tipocomprobante			lxOrdpagoFcompfis =  .Comprobantefiscal			lxOrdpagoIdvuelto =  upper( .IdVuelto_PK ) 			lxOrdpagoMonsis =  upper( .MonedaSistema_PK ) 			lxOrdpagoFletra =  .Letra			lxOrdpagoFptoven =  .Puntodeventa			lxOrdpagoImpman =  .Impuestosmanuales			lxOrdpagoFnumcomp =  .Numero			lxOrdpagoFperson =  upper( .Proveedor_PK ) 			lxOrdpagoFfch =  .Fecha			lxOrdpagoFven =  .Usuario			lxOrdpagoCotiz =  .Cotizacion			lxOrdpagoMoneda =  upper( .MonedaComprobante_PK ) 			lxOrdpagoFtotal =  .Total			lxOrdpagoPtovtacdr =  .Puntodeventacdr			lxOrdpagoNumcdr =  .Numerocdr			lxOrdpagoFobs =  .Obs			lxOrdpagoFvuelto =  .Vuelto			lxOrdpagoAnulado =  .Anulado			lxOrdpagoFproved =  .Proveedordescripcion			lxOrdpagoCodigo =  .Codigo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ORDPAGO ( "Fmodifw","Fecimpo","Fectrans","Fecexpo","Idcaja","Horaexpo","Bdmodifw","Bdaltafw","Horaimpo","Esttrans","Smodifw","Hmodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Saltafw","Ualtafw","Haltafw","Faltafw","Simbmon","Signomov","Timestamp","Facttipo","Fcompfis","Idvuelto","Monsis","Fletra","Fptoven","Impman","Fnumcomp","Fperson","Ffch","Fven","Cotiz","Moneda","Ftotal","Ptovtacdr","Numcdr","Fobs","Fvuelto","Anulado","Fproved","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxOrdpagoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFecexpo ) + "'" >>, <<lxOrdpagoIdcaja >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSimbmon ) + "'" >>, <<lxOrdpagoSignomov >>, <<lxOrdpagoTimestamp >>, <<lxOrdpagoFacttipo >>, <<iif( lxOrdpagoFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOrdpagoIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFletra ) + "'" >>, <<lxOrdpagoFptoven >>, <<iif( lxOrdpagoImpman, 1, 0 ) >>, <<lxOrdpagoFnumcomp >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFven ) + "'" >>, <<lxOrdpagoCotiz >>, <<"'" + this.FormatearTextoSql( lxOrdpagoMoneda ) + "'" >>, <<lxOrdpagoFtotal >>, <<lxOrdpagoPtovtacdr >>, <<lxOrdpagoNumcdr >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFobs ) + "'" >>, <<lxOrdpagoFvuelto >>, <<iif( lxOrdpagoAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFproved ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ORDPAGO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

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
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxTipodocumento = loItem.Tipodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxCotiza = loItem.Cotiza
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
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
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxCotiza>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePagoDetalle
				if this.oEntidad.OrdenDePagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTotalcomprobanteconimpuestos = loItem.Totalcomprobanteconimpuestos
					lxTotalcomprobantegravado = loItem.Totalcomprobantegravado
					lxTotalcomprobantesinimpuestos = loItem.Totalcomprobantesinimpuestos
					lxPuntodeventa = loItem.Puntodeventa
					lxNroitem = lnContadorNroItem
					lxTotalcomprobanteiva = loItem.Totalcomprobanteiva
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxTipo = loItem.Tipo
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OrdPagoDet("Fecha","IdCaja","Tipo","LetraAfec","CodComp","TotComCI","TotComGRAV","TotComSI","PtoAfec","NROITEM","TotComIVA","Numafec","Rtipo","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<lxTotalcomprobanteconimpuestos>>, <<lxTotalcomprobantegravado>>, <<lxTotalcomprobantesinimpuestos>>, <<lxPuntodeventa>>, <<lxNroitem>>, <<lxTotalcomprobanteiva>>, <<lxNumerodecomprobante>>, <<lxTipo>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCodigocdr = loItem.Codigocdr
					lxTipoimpuestocdr = loItem.Tipoimpuestocdr
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpODP("CodigoCDR","TipoImp","NROITEM","Codigo","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuestocdr ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxOrdpagoFmodifw, lxOrdpagoFecimpo, lxOrdpagoFectrans, lxOrdpagoFecexpo, lxOrdpagoIdcaja, lxOrdpagoHoraexpo, lxOrdpagoBdmodifw, lxOrdpagoBdaltafw, lxOrdpagoHoraimpo, lxOrdpagoEsttrans, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoHaltafw, lxOrdpagoFaltafw, lxOrdpagoSimbmon, lxOrdpagoSignomov, lxOrdpagoTimestamp, lxOrdpagoFacttipo, lxOrdpagoFcompfis, lxOrdpagoIdvuelto, lxOrdpagoMonsis, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoCotiz, lxOrdpagoMoneda, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFmodifw =  .Fechamodificacionfw			lxOrdpagoFecimpo =  .Fechaimpo			lxOrdpagoFectrans =  .Fechatransferencia			lxOrdpagoFecexpo =  .Fechaexpo			lxOrdpagoIdcaja =  .Caja_PK 			lxOrdpagoHoraexpo =  .Horaexpo			lxOrdpagoBdmodifw =  .Basededatosmodificacionfw			lxOrdpagoBdaltafw =  .Basededatosaltafw			lxOrdpagoHoraimpo =  .Horaimpo			lxOrdpagoEsttrans =  .Estadotransferencia			lxOrdpagoSmodifw =  .Seriemodificacionfw			lxOrdpagoHmodifw =  .Horamodificacionfw			lxOrdpagoVmodifw =  .Versionmodificacionfw			lxOrdpagoZadsfw =  .Zadsfw			lxOrdpagoUmodifw =  .Usuariomodificacionfw			lxOrdpagoValtafw =  .Versionaltafw			lxOrdpagoSaltafw =  .Seriealtafw			lxOrdpagoUaltafw =  .Usuarioaltafw			lxOrdpagoHaltafw =  .Horaaltafw			lxOrdpagoFaltafw =  .Fechaaltafw			lxOrdpagoSimbmon =  .Simbolomonetariocomprobante			lxOrdpagoSignomov =  .Signodemovimiento			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFacttipo =  .Tipocomprobante			lxOrdpagoFcompfis =  .Comprobantefiscal			lxOrdpagoIdvuelto =  upper( .IdVuelto_PK ) 			lxOrdpagoMonsis =  upper( .MonedaSistema_PK ) 			lxOrdpagoFletra =  .Letra			lxOrdpagoFptoven =  .Puntodeventa			lxOrdpagoImpman =  .Impuestosmanuales			lxOrdpagoFnumcomp =  .Numero			lxOrdpagoFperson =  upper( .Proveedor_PK ) 			lxOrdpagoFfch =  .Fecha			lxOrdpagoFven =  .Usuario			lxOrdpagoCotiz =  .Cotizacion			lxOrdpagoMoneda =  upper( .MonedaComprobante_PK ) 			lxOrdpagoFtotal =  .Total			lxOrdpagoPtovtacdr =  .Puntodeventacdr			lxOrdpagoNumcdr =  .Numerocdr			lxOrdpagoFobs =  .Obs			lxOrdpagoFvuelto =  .Vuelto			lxOrdpagoAnulado =  .Anulado			lxOrdpagoFproved =  .Proveedordescripcion			lxOrdpagoCodigo =  .Codigo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31]
			text to lcSentencia noshow textmerge
				update ZooLogic.ORDPAGO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxOrdpagoFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxOrdpagoFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxOrdpagoFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxOrdpagoFecexpo ) + "'">>, "Idcaja" = <<lxOrdpagoIdcaja>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxOrdpagoHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoBdaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxOrdpagoHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxOrdpagoEsttrans ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxOrdpagoZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoUaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoHaltafw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxOrdpagoFaltafw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxOrdpagoSimbmon ) + "'">>, "Signomov" = <<lxOrdpagoSignomov>>, "Timestamp" = <<lxOrdpagoTimestamp>>, "Facttipo" = <<lxOrdpagoFacttipo>>, "Fcompfis" = <<iif( lxOrdpagoFcompfis, 1, 0 )>>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxOrdpagoIdvuelto ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxOrdpagoMonsis ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxOrdpagoFletra ) + "'">>, "Fptoven" = <<lxOrdpagoFptoven>>, "Impman" = <<iif( lxOrdpagoImpman, 1, 0 )>>, "Fnumcomp" = <<lxOrdpagoFnumcomp>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxOrdpagoFperson ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxOrdpagoFfch ) + "'">>, "Fven" = <<"'" + this.FormatearTextoSql( lxOrdpagoFven ) + "'">>, "Cotiz" = <<lxOrdpagoCotiz>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxOrdpagoMoneda ) + "'">>, "Ftotal" = <<lxOrdpagoFtotal>>, "Ptovtacdr" = <<lxOrdpagoPtovtacdr>>, "Numcdr" = <<lxOrdpagoNumcdr>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxOrdpagoFobs ) + "'">>, "Fvuelto" = <<lxOrdpagoFvuelto>>, "Anulado" = <<iif( lxOrdpagoAnulado, 1, 0 )>>, "Fproved" = <<"'" + this.FormatearTextoSql( lxOrdpagoFproved ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ORDPAGO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ValFacComp where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.OrdPagoDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpODP where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxTipodocumento = loItem.Tipodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxCotiza = loItem.Cotiza
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
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
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxCotiza>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenDePagoDetalle
				if this.oEntidad.OrdenDePagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTotalcomprobanteconimpuestos = loItem.Totalcomprobanteconimpuestos
					lxTotalcomprobantegravado = loItem.Totalcomprobantegravado
					lxTotalcomprobantesinimpuestos = loItem.Totalcomprobantesinimpuestos
					lxPuntodeventa = loItem.Puntodeventa
					lxNroitem = lnContadorNroItem
					lxTotalcomprobanteiva = loItem.Totalcomprobanteiva
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxTipo = loItem.Tipo
					lxEspagoacuenta = loItem.Espagoacuenta
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxAnotacion = loItem.Anotacion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OrdPagoDet("Fecha","IdCaja","Tipo","LetraAfec","CodComp","TotComCI","TotComGRAV","TotComSI","PtoAfec","NROITEM","TotComIVA","Numafec","Rtipo","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<lxTotalcomprobanteconimpuestos>>, <<lxTotalcomprobantegravado>>, <<lxTotalcomprobantesinimpuestos>>, <<lxPuntodeventa>>, <<lxNroitem>>, <<lxTotalcomprobanteiva>>, <<lxNumerodecomprobante>>, <<lxTipo>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCodigocdr = loItem.Codigocdr
					lxTipoimpuestocdr = loItem.Tipoimpuestocdr
					lxNroitem = lnContadorNroItem
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpODP("CodigoCDR","TipoImp","NROITEM","Codigo","CodImp","Descri","Monto" ) values ( <<"'" + this.FormatearTextoSql( lxCodigocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuestocdr ) + "'">>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31]
		loColeccion.Agregar( 'delete from ZooLogic.ORDPAGO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ValFacComp where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.OrdPagoDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpODP where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'ORDPAGO' 
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
			.ValoresDetalle.oItem.oCompCajero.lNuevo = .EsNuevo()
			.ValoresDetalle.oItem.oCompCajero.lEdicion = .EsEdicion()
			.ValoresDetalle.oItem.oCompCajero.lEliminar = .lEliminar
			.ValoresDetalle.oItem.oCompCajero.lAnular = .lAnular
			loColSentencias = .ValoresDetalle.oItem.oCompCajero.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.OrdenDePagoDetalle.oItem.oCompCuentacorrienteordendepagocompras.lNuevo = .EsNuevo()
			.OrdenDePagoDetalle.oItem.oCompCuentacorrienteordendepagocompras.lEdicion = .EsEdicion()
			.OrdenDePagoDetalle.oItem.oCompCuentacorrienteordendepagocompras.lEliminar = .lEliminar
			.OrdenDePagoDetalle.oItem.oCompCuentacorrienteordendepagocompras.lAnular = .lAnular
			loColSentencias = .OrdenDePagoDetalle.oItem.oCompCuentacorrienteordendepagocompras.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.ImpuestosComprobante.oItem.oCompRetenciones.lNuevo = .EsNuevo()
			.ImpuestosComprobante.oItem.oCompRetenciones.lEdicion = .EsEdicion()
			.ImpuestosComprobante.oItem.oCompRetenciones.lEliminar = .lEliminar
			.ImpuestosComprobante.oItem.oCompRetenciones.lAnular = .lAnular
			loColSentencias = .ImpuestosComprobante.oItem.oCompRetenciones.grabar()
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
			lcRetorno = [update ZooLogic.ORDPAGO set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ORDPAGO where  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ORDPAGO where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxOrdPagoFACTTIPO as variant, lxOrdPagoFLETRA as variant, lxOrdPagoFPTOVEN as variant, lxOrdPagoFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPAGO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ORDPAGO Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ), 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.ORDPAGO set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, signomov = ] + transform( &lcCursor..signomov )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, ImpMan = ] + Transform( iif( &lcCursor..ImpMan, 1, 0 ))+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FVEN = ] + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, PtoVtaCDR = ] + transform( &lcCursor..PtoVtaCDR )+ [, NumCDR = ] + transform( &lcCursor..NumCDR )+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, Fproved = ] + "'" + this.FormatearTextoSql( &lcCursor..Fproved ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.ORDPAGO Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FECIMPO, FECTRANS, FECEXPO, IdCaja, HORAEXPO, BDMODIFW, BDALTAFW, HORAIMPO, ESTTRANS, SMODIFW, HMODIFW, VMODIFW, ZADSFW, UMODIFW, VALTAFW, SALTAFW, UALTAFW, HAltaFW, FAltaFW, SimbMon, signomov, TIMESTAMP, FACTTIPO, FCOMPFIS, idVuelto, MonSis, FLETRA, FPTOVEN, ImpMan, FNUMCOMP, FPerson, FFCH, FVEN, Cotiz, Moneda, FTotal, PtoVtaCDR, NumCDR, FObs, FVuelto, Anulado, Fproved, CODIGO
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..IdCaja ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..FPTOVEN )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..ImpMan, 1, 0 )) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + transform( &lcCursor..FTotal )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..PtoVtaCDR ) + ',' + transform( &lcCursor..NumCDR ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + transform( &lcCursor..FVuelto ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Fproved ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.ORDPAGO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPAGO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ValFacComp Where JJNUM] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.OrdPagoDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpODP Where Codigo] + lcIn  )
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALORESCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where JJNUM in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ValFacComp ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJVen      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroDoc     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TIPCOMP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoDoc    ) + "'" + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.JJTurno    ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.PtoVenta   ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + Transform( iif( cDetallesExistentes.PersComp  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CondPago   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJNUM      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.jrecporc   ) + ',' + transform( cDetallesExistentes.jrecmnt    ) + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + transform( cDetallesExistentes.jrecmntsi  ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + transform( cDetallesExistentes.jrrecsperc ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + Transform( iif( cDetallesExistentes.permvuelto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValeCambio ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMORDENDEPAGO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Fecha","IdCaja","Tipo","LetraAfec","CodComp","TotComCI","TotComGRAV","TotComSI","PtoAfec","NROITEM","TotComIVA","Numafec","Rtipo","lPagoACta","RVal","CODIGO","FecEmi","RFecVen","Descrip","anotacion","SaldoAux","RMonto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.OrdPagoDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.Fecha      ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Tipo       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LetraAfec  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodComp    ) + "'" + ',' + transform( cDetallesExistentes.TotComCI   ) + ',' + transform( cDetallesExistentes.TotComGRAV ) + ',' + transform( cDetallesExistentes.TotComSI   ) + ',' + transform( cDetallesExistentes.PtoAfec    ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.TotComIVA  ) + ',' + transform( cDetallesExistentes.Numafec    ) + ',' + transform( cDetallesExistentes.Rtipo      ) + ',' + Transform( iif( cDetallesExistentes.lPagoACta , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.RVal       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FecEmi     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.RFecVen    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.anotacion  ) + "'" + ',' + transform( cDetallesExistentes.SaldoAux   ) + ',' + transform( cDetallesExistentes.RMonto     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOORDENDEPAGO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"CodigoCDR","TipoImp","NROITEM","Codigo","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpODP ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.CodigoCDR  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoImp    ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		this.oEntidad.ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMVALORESCOMPRA',this.oEntidad.cPrefijoRecibir + 'ORDENDEPAGO')
		this.oEntidad.OrdenDePagoDetalle.oItem.oCompCuentacorrienteordendepagocompras.Recibir( this.oEntidad, 'OrdenDePagoDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMORDENDEPAGO',this.oEntidad.cPrefijoRecibir + 'ORDENDEPAGO')
		this.oEntidad.ImpuestosComprobante.oItem.oCompRetenciones.Recibir( this.oEntidad, 'ImpuestosComprobante',this.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOORDENDEPAGO',this.oEntidad.cPrefijoRecibir + 'ORDENDEPAGO')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..FPTOVEN    )
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
			Case  lcAlias == lcPrefijo + 'ORDENDEPAGO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ORDENDEPAGO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ORDENDEPAGO_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALORESCOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMORDENDEPAGO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOORDENDEPAGO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_OrdPago')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ORDENDEPAGO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ORDENDEPAGO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPAGO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 10, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 10, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPAGO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FFCH      
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_OrdPago') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_OrdPago
Create Table ZooLogic.TablaTrabajo_OrdPago ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"idcaja" numeric( 2, 0 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"faltafw" datetime  null, 
"simbmon" char( 3 )  null, 
"signomov" numeric( 2, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"fcompfis" bit  null, 
"idvuelto" char( 5 )  null, 
"monsis" char( 10 )  null, 
"fletra" char( 1 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"impman" bit  null, 
"fnumcomp" numeric( 10, 0 )  null, 
"fperson" char( 10 )  null, 
"ffch" datetime  null, 
"fven" char( 100 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"moneda" char( 10 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"ptovtacdr" numeric( 4, 0 )  null, 
"numcdr" numeric( 10, 0 )  null, 
"fobs" varchar(max)  null, 
"fvuelto" numeric( 15, 2 )  null, 
"anulado" bit  null, 
"fproved" char( 60 )  null, 
"codigo" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_OrdPago' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_OrdPago' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPAGO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('impman','impman')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('fven','fven')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('ptovtacdr','ptovtacdr')
			.AgregarMapeo('numcdr','numcdr')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fproved','fproved')
			.AgregarMapeo('codigo','codigo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_OrdPago'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.IMPMAN = isnull( d.IMPMAN, t.IMPMAN ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FVEN = isnull( d.FVEN, t.FVEN ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.PTOVTACDR = isnull( d.PTOVTACDR, t.PTOVTACDR ),t.NUMCDR = isnull( d.NUMCDR, t.NUMCDR ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FPROVED = isnull( d.FPROVED, t.FPROVED ),t.CODIGO = isnull( d.CODIGO, t.CODIGO )
					from ZooLogic.ORDPAGO t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.ORDPAGO(Fmodifw,Fecimpo,Fectrans,Fecexpo,Idcaja,Horaexpo,Bdmodifw,Bdaltafw,Horaimpo,Esttrans,Smodifw,Hmodifw,Vmodifw,Zadsfw,Umodifw,Valtafw,Saltafw,Ualtafw,Haltafw,Faltafw,Simbmon,Signomov,Timestamp,Facttipo,Fcompfis,Idvuelto,Monsis,Fletra,Fptoven,Impman,Fnumcomp,Fperson,Ffch,Fven,Cotiz,Moneda,Ftotal,Ptovtacdr,Numcdr,Fobs,Fvuelto,Anulado,Fproved,Codigo)
					Select isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.IDCAJA,0),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),convert( char(8), getdate(), 108 ),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.SIMBMON,''),isnull( d.SIGNOMOV,0),isnull( d.TIMESTAMP,0),isnull( d.FACTTIPO,0),isnull( d.FCOMPFIS,0),isnull( d.IDVUELTO,''),isnull( d.MONSIS,''),isnull( d.FLETRA,''),isnull( d.FPTOVEN,0),isnull( d.IMPMAN,0),isnull( d.FNUMCOMP,0),isnull( d.FPERSON,''),isnull( d.FFCH,''),isnull( d.FVEN,''),isnull( d.COTIZ,0),isnull( d.MONEDA,''),isnull( d.FTOTAL,0),isnull( d.PTOVTACDR,0),isnull( d.NUMCDR,0),isnull( d.FOBS,''),isnull( d.FVUELTO,0),isnull( d.ANULADO,0),isnull( d.FPROVED,''),isnull( d.CODIGO,'')
						From deleted d left join ZooLogic.ORDPAGO pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.ORDPAGO cc 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', NÚMERO ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(10) ) + '','La clave principal no es la esperada'
					from ZooLogic.ORDPAGO t inner join deleted d 
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', NÚMERO ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ZooLogic.ORDPAGO t inner join deleted d 
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
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDPAGO_CompAfe
ON ZooLogic.TablaTrabajo_ORDPAGO_CompAfe
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
	function ObtenerTriggerDeleteImportacion_ValFacComp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDPAGO_ValFacComp
ON ZooLogic.TablaTrabajo_ORDPAGO_ValFacComp
AFTER DELETE
As
Begin
Update t Set 
t.FECHCOTI = isnull( d.FECHCOTI, t.FECHCOTI ),
t.JJFECHA = isnull( d.JJFECHA, t.JJFECHA ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.JJVEN = isnull( d.JJVEN, t.JJVEN ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.NRODOC = isnull( d.NRODOC, t.NRODOC ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.TIPODOC = isnull( d.TIPODOC, t.TIPODOC ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.JJTURNO = isnull( d.JJTURNO, t.JJTURNO ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),
t.JJT = isnull( d.JJT, t.JJT ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.PERSCOMP = isnull( d.PERSCOMP, t.PERSCOMP ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.JJNUM = isnull( d.JJNUM, t.JJNUM ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
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
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.PERMVUELTO = isnull( d.PERMVUELTO, t.PERMVUELTO ),
t.VALECAMBIO = isnull( d.VALECAMBIO, t.VALECAMBIO )
from ZooLogic.ValFacComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ValFacComp
( 
"FECHCOTI",
"JJFECHA",
"IDCAJA",
"JJVEN",
"NROTARJETA",
"NRODOC",
"TIPCOMP",
"LETRA",
"TIPODOC",
"COTIZA",
"JJTURNO",
"NROCUPON",
"NROITEM",
"JJCOTIZ",
"NUMCOMPR",
"PESOS",
"PTOVENTA",
"JJT",
"SIGNO",
"PERSCOMP",
"CELECTRO",
"VISUALCAJA",
"CONDPAGO",
"NROCHEQUE",
"NROCHPROP",
"JJNUM",
"JJCO",
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
"GUIDCOMP",
"PERMVUELTO",
"VALECAMBIO"
 )
Select 
d.FECHCOTI,
d.JJFECHA,
d.IDCAJA,
d.JJVEN,
d.NROTARJETA,
d.NRODOC,
d.TIPCOMP,
d.LETRA,
d.TIPODOC,
d.COTIZA,
d.JJTURNO,
d.NROCUPON,
d.NROITEM,
d.JJCOTIZ,
d.NUMCOMPR,
d.PESOS,
d.PTOVENTA,
d.JJT,
d.SIGNO,
d.PERSCOMP,
d.CELECTRO,
d.VISUALCAJA,
d.CONDPAGO,
d.NROCHEQUE,
d.NROCHPROP,
d.JJNUM,
d.JJCO,
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
d.GUIDCOMP,
d.PERMVUELTO,
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
	function ObtenerTriggerDeleteImportacion_OrdPagoDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDPAGO_OrdPagoDet
ON ZooLogic.TablaTrabajo_ORDPAGO_OrdPagoDet
AFTER DELETE
As
Begin
Update t Set 
t.FECHA = isnull( d.FECHA, t.FECHA ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.LETRAAFEC = isnull( d.LETRAAFEC, t.LETRAAFEC ),
t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),
t.TOTCOMCI = isnull( d.TOTCOMCI, t.TOTCOMCI ),
t.TOTCOMGRAV = isnull( d.TOTCOMGRAV, t.TOTCOMGRAV ),
t.TOTCOMSI = isnull( d.TOTCOMSI, t.TOTCOMSI ),
t.PTOAFEC = isnull( d.PTOAFEC, t.PTOAFEC ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.TOTCOMIVA = isnull( d.TOTCOMIVA, t.TOTCOMIVA ),
t.NUMAFEC = isnull( d.NUMAFEC, t.NUMAFEC ),
t.RTIPO = isnull( d.RTIPO, t.RTIPO ),
t.LPAGOACTA = isnull( d.LPAGOACTA, t.LPAGOACTA ),
t.RVAL = isnull( d.RVAL, t.RVAL ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FECEMI = isnull( d.FECEMI, t.FECEMI ),
t.RFECVEN = isnull( d.RFECVEN, t.RFECVEN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.ANOTACION = isnull( d.ANOTACION, t.ANOTACION ),
t.SALDOAUX = isnull( d.SALDOAUX, t.SALDOAUX ),
t.RMONTO = isnull( d.RMONTO, t.RMONTO )
from ZooLogic.OrdPagoDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.OrdPagoDet
( 
"FECHA",
"IDCAJA",
"TIPO",
"LETRAAFEC",
"CODCOMP",
"TOTCOMCI",
"TOTCOMGRAV",
"TOTCOMSI",
"PTOAFEC",
"NROITEM",
"TOTCOMIVA",
"NUMAFEC",
"RTIPO",
"LPAGOACTA",
"RVAL",
"CODIGO",
"FECEMI",
"RFECVEN",
"DESCRIP",
"ANOTACION",
"SALDOAUX",
"RMONTO"
 )
Select 
d.FECHA,
d.IDCAJA,
d.TIPO,
d.LETRAAFEC,
d.CODCOMP,
d.TOTCOMCI,
d.TOTCOMGRAV,
d.TOTCOMSI,
d.PTOAFEC,
d.NROITEM,
d.TOTCOMIVA,
d.NUMAFEC,
d.RTIPO,
d.LPAGOACTA,
d.RVAL,
d.CODIGO,
d.FECEMI,
d.RFECVEN,
d.DESCRIP,
d.ANOTACION,
d.SALDOAUX,
d.RMONTO
From deleted d left join ZooLogic.OrdPagoDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpODP( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDPAGO_ImpODP
ON ZooLogic.TablaTrabajo_ORDPAGO_ImpODP
AFTER DELETE
As
Begin
Update t Set 
t.CODIGOCDR = isnull( d.CODIGOCDR, t.CODIGOCDR ),
t.TIPOIMP = isnull( d.TIPOIMP, t.TIPOIMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.ImpODP t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpODP
( 
"CODIGOCDR",
"TIPOIMP",
"NROITEM",
"CODIGO",
"CODIMP",
"DESCRI",
"MONTO"
 )
Select 
d.CODIGOCDR,
d.TIPOIMP,
d.NROITEM,
d.CODIGO,
d.CODIMP,
d.DESCRI,
d.MONTO
From deleted d left join ZooLogic.ImpODP pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_OrdPago') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_OrdPago
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ORDENDEPAGO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Caja_PK =  nvl( c_ORDENDEPAGO.Caja, 0 )
					.Compafec2.Limpiar()
					.Compafec2.SetearEsNavegacion( .lProcesando )
					.Compafec2.Cargar()
					.Horaexpo = nvl( c_ORDENDEPAGO.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_ORDENDEPAGO.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_ORDENDEPAGO.Basededatosaltafw, [] )
					.Horaimpo = nvl( c_ORDENDEPAGO.Horaimpo, [] )
					.Estadotransferencia = nvl( c_ORDENDEPAGO.Estadotransferencia, [] )
					.Seriemodificacionfw = nvl( c_ORDENDEPAGO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_ORDENDEPAGO.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ORDENDEPAGO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_ORDENDEPAGO.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_ORDENDEPAGO.Versionaltafw, [] )
					.Seriealtafw = nvl( c_ORDENDEPAGO.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_ORDENDEPAGO.Usuarioaltafw, [] )
					.Horaaltafw = nvl( c_ORDENDEPAGO.Horaaltafw, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Simbolomonetariocomprobante = nvl( c_ORDENDEPAGO.Simbolomonetariocomprobante, [] )
					.Signodemovimiento = nvl( c_ORDENDEPAGO.Signodemovimiento, 0 )
					.Timestamp = nvl( c_ORDENDEPAGO.Timestamp, 0 )
					.Tipocomprobante = nvl( c_ORDENDEPAGO.Tipocomprobante, 0 )
					.Comprobantefiscal = nvl( c_ORDENDEPAGO.Comprobantefiscal, .F. )
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Ordendepagodetalle.Limpiar()
					.Ordendepagodetalle.SetearEsNavegacion( .lProcesando )
					.Ordendepagodetalle.Cargar()
					.Idvuelto_PK =  nvl( c_ORDENDEPAGO.Idvuelto, [] )
					.Monedasistema_PK =  nvl( c_ORDENDEPAGO.Monedasistema, [] )
					.Letra = nvl( c_ORDENDEPAGO.Letra, [] )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					.Puntodeventa = nvl( c_ORDENDEPAGO.Puntodeventa, 0 )
					.Impuestosmanuales = nvl( c_ORDENDEPAGO.Impuestosmanuales, .F. )
					.Numero = nvl( c_ORDENDEPAGO.Numero, 0 )
					.Proveedor_PK =  nvl( c_ORDENDEPAGO.Proveedor, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fecha, ctod( '  /  /    ' ) ) )
					.Usuario = nvl( c_ORDENDEPAGO.Usuario, [] )
					.Cotizacion = nvl( c_ORDENDEPAGO.Cotizacion, 0 )
					.Monedacomprobante_PK =  nvl( c_ORDENDEPAGO.Monedacomprobante, [] )
					.Total = nvl( c_ORDENDEPAGO.Total, 0 )
					.Puntodeventacdr = nvl( c_ORDENDEPAGO.Puntodeventacdr, 0 )
					.Numerocdr = nvl( c_ORDENDEPAGO.Numerocdr, 0 )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Vuelto = nvl( c_ORDENDEPAGO.Vuelto, 0 )
					.Anulado = nvl( c_ORDENDEPAGO.Anulado, .F. )
					.Proveedordescripcion = nvl( c_ORDENDEPAGO.Proveedordescripcion, [] )
					.Codigo = nvl( c_ORDENDEPAGO.Codigo, [] )
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
			lxRetorno = c_ORDENDEPAGO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
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

		loDetalle = this.oEntidad.OrdenDePagoDetalle
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
		return c_ORDENDEPAGO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ORDPAGO' )
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
								from ZooLogic.ORDPAGO 
								Where   ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ORDPAGO", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Idcaja" as "Caja", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Signomov" as "Signodemovimiento", "Timestamp" as "Timestamp", "Facttipo" as "Tipocomprobante", "Fcompfis" as "Comprobantefiscal", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Cotiz" as "Cotizacion", "Moneda" as "Monedacomprobante", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ORDPAGO 
								Where   ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31
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
	Tabla = 'ORDPAGO'
	Filtro = " ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31"
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
	<row entidad="ORDENDEPAGO                             " atributo="FECHAMODIFICACIONFW                     " tabla="ORDPAGO        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHAIMPO                               " tabla="ORDPAGO        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHATRANSFERENCIA                      " tabla="ORDPAGO        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHAEXPO                               " tabla="ORDPAGO        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="CAJA                                    " tabla="ORDPAGO        " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                            " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="COMPAFEC2                               " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante                                                                                                                                                     " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="HORAEXPO                                " tabla="ORDPAGO        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ORDPAGO        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="BASEDEDATOSALTAFW                       " tabla="ORDPAGO        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="HORAIMPO                                " tabla="ORDPAGO        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="ESTADOTRANSFERENCIA                     " tabla="ORDPAGO        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="SERIEMODIFICACIONFW                     " tabla="ORDPAGO        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="HORAMODIFICACIONFW                      " tabla="ORDPAGO        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="VERSIONMODIFICACIONFW                   " tabla="ORDPAGO        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="ZADSFW                                  " tabla="ORDPAGO        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="USUARIOMODIFICACIONFW                   " tabla="ORDPAGO        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="VERSIONALTAFW                           " tabla="ORDPAGO        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="SERIEALTAFW                             " tabla="ORDPAGO        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="USUARIOALTAFW                           " tabla="ORDPAGO        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="HORAALTAFW                              " tabla="ORDPAGO        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHAALTAFW                             " tabla="ORDPAGO        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="ORDPAGO        " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="SIGNODEMOVIMIENTO                       " tabla="ORDPAGO        " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="TIMESTAMP                               " tabla="ORDPAGO        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="TIPOCOMPROBANTE                         " tabla="ORDPAGO        " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=31                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="14" etiqueta="Tipo de Comprobante                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="COMPROBANTEFISCAL                       " tabla="ORDPAGO        " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="VALORESDETALLE                          " tabla="VALFACCOMP     " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Valores                                                                                                                                                         " dominio="DETALLEITEMVALORESCOMPRA      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="ORDENDEPAGODETALLE                      " tabla="ORDPAGODET     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMORDENDEPAGO        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="IDVUELTO                                " tabla="ORDPAGO        " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código vuelto                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="MONEDASISTEMA                           " tabla="ORDPAGO        " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Sistema                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="LETRA                                   " tabla="ORDPAGO        " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPODP         " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Impuesto                                                                                                                                                        " dominio="DETALLEITEMIMPUESTOORDENDEPAGO" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="PUNTODEVENTA                            " tabla="ORDPAGO        " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="IMPUESTOSMANUALES                       " tabla="ORDPAGO        " campo="IMPMAN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="NUMERO                                  " tabla="ORDPAGO        " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="PROVEEDOR                               " tabla="ORDPAGO        " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHA                                   " tabla="ORDPAGO        " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=GOLIBRERIAS.OBTENERFECHA()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="12" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="USUARIO                                 " tabla="ORDPAGO        " campo="FVEN      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="406" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="COTIZACION                              " tabla="ORDPAGO        " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="408" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="MONEDACOMPROBANTE                       " tabla="ORDPAGO        " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="=goParametros.Felino.Generales.MonedaSistema                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="410" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="MONTOCONCILIAR                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Monto a conciliar                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999999.99           " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="TOTAL                                   " tabla="ORDPAGO        " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="DEUDA                                   " tabla="ORDPAGO        " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Saldo en cta. cte.                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="PUNTODEVENTACDR                         " tabla="ORDPAGO        " campo="PTOVTACDR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto de venta comprobante retención                                                                                                                            " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999-9999999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="NUMEROCDR                               " tabla="ORDPAGO        " campo="NUMCDR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999-9999999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="OBS                                     " tabla="ORDPAGO        " campo="FOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Obs.                                                                                                                                                            " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="VUELTO                                  " tabla="ORDPAGO        " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="ANULADO                                 " tabla="ORDPAGO        " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="PROVEEDORDESCRIPCION                    " tabla="ORDPAGO        " campo="FPROVED   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="                                                                                                                                                                " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Proveedor.Nombre                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="CODIGO                                  " tabla="ORDPAGO        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="198" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On ORDPAGO.FPERSON = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On ORDPAGO.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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