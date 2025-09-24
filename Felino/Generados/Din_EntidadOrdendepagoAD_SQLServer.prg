
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
			local  lxOrdpagoFecimpo, lxOrdpagoFaltafw, lxOrdpagoFecexpo, lxOrdpagoFmodifw, lxOrdpagoFectrans, lxOrdpagoIdcaja, lxOrdpagoSignomov, lxOrdpagoFacttipo, lxOrdpagoTimestamp, lxOrdpagoFcompfis, lxOrdpagoHoraimpo, lxOrdpagoHaltafw, lxOrdpagoHoraexpo, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoBdmodifw, lxOrdpagoSimbmon, lxOrdpagoBdaltafw, lxOrdpagoEsttrans, lxOrdpagoMonsis, lxOrdpagoIdvuelto, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoMoneda, lxOrdpagoCotiz, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFecimpo =  .Fechaimpo			lxOrdpagoFaltafw =  .Fechaaltafw			lxOrdpagoFecexpo =  .Fechaexpo			lxOrdpagoFmodifw =  .Fechamodificacionfw			lxOrdpagoFectrans =  .Fechatransferencia			lxOrdpagoIdcaja =  .Caja_PK 			lxOrdpagoSignomov =  .Signodemovimiento			lxOrdpagoFacttipo =  .Tipocomprobante			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFcompfis =  .Comprobantefiscal			lxOrdpagoHoraimpo =  .Horaimpo			lxOrdpagoHaltafw =  .Horaaltafw			lxOrdpagoHoraexpo =  .Horaexpo			lxOrdpagoSmodifw =  .Seriemodificacionfw			lxOrdpagoHmodifw =  .Horamodificacionfw			lxOrdpagoVmodifw =  .Versionmodificacionfw			lxOrdpagoZadsfw =  .Zadsfw			lxOrdpagoUmodifw =  .Usuariomodificacionfw			lxOrdpagoValtafw =  .Versionaltafw			lxOrdpagoSaltafw =  .Seriealtafw			lxOrdpagoUaltafw =  .Usuarioaltafw			lxOrdpagoBdmodifw =  .Basededatosmodificacionfw			lxOrdpagoSimbmon =  .Simbolomonetariocomprobante			lxOrdpagoBdaltafw =  .Basededatosaltafw			lxOrdpagoEsttrans =  .Estadotransferencia			lxOrdpagoMonsis =  upper( .MonedaSistema_PK ) 			lxOrdpagoIdvuelto =  upper( .IdVuelto_PK ) 			lxOrdpagoFletra =  .Letra			lxOrdpagoFptoven =  .Puntodeventa			lxOrdpagoImpman =  .Impuestosmanuales			lxOrdpagoFnumcomp =  .Numero			lxOrdpagoFperson =  upper( .Proveedor_PK ) 			lxOrdpagoFfch =  .Fecha			lxOrdpagoFven =  .Usuario			lxOrdpagoMoneda =  upper( .MonedaComprobante_PK ) 			lxOrdpagoCotiz =  .Cotizacion			lxOrdpagoFtotal =  .Total			lxOrdpagoPtovtacdr =  .Puntodeventacdr			lxOrdpagoNumcdr =  .Numerocdr			lxOrdpagoFobs =  .Obs			lxOrdpagoFvuelto =  .Vuelto			lxOrdpagoAnulado =  .Anulado			lxOrdpagoFproved =  .Proveedordescripcion			lxOrdpagoCodigo =  .Codigo
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
				insert into ZooLogic.ORDPAGO ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Fectrans","Idcaja","Signomov","Facttipo","Timestamp","Fcompfis","Horaimpo","Haltafw","Horaexpo","Smodifw","Hmodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Saltafw","Ualtafw","Bdmodifw","Simbmon","Bdaltafw","Esttrans","Monsis","Idvuelto","Fletra","Fptoven","Impman","Fnumcomp","Fperson","Ffch","Fven","Moneda","Cotiz","Ftotal","Ptovtacdr","Numcdr","Fobs","Fvuelto","Anulado","Fproved","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxOrdpagoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFectrans ) + "'" >>, <<lxOrdpagoIdcaja >>, <<lxOrdpagoSignomov >>, <<lxOrdpagoFacttipo >>, <<lxOrdpagoTimestamp >>, <<iif( lxOrdpagoFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFletra ) + "'" >>, <<lxOrdpagoFptoven >>, <<iif( lxOrdpagoImpman, 1, 0 ) >>, <<lxOrdpagoFnumcomp >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFven ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoMoneda ) + "'" >>, <<lxOrdpagoCotiz >>, <<lxOrdpagoFtotal >>, <<lxOrdpagoPtovtacdr >>, <<lxOrdpagoNumcdr >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFobs ) + "'" >>, <<lxOrdpagoFvuelto >>, <<iif( lxOrdpagoAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFproved ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'" >> )
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
			for each loItem in this.oEntidad.OrdenDePagoDetalle
				if this.oEntidad.OrdenDePagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxTipo = loItem.Tipo
					lxTotalcomprobantesinimpuestos = loItem.Totalcomprobantesinimpuestos
					lxTotalcomprobanteconimpuestos = loItem.Totalcomprobanteconimpuestos
					lxTotalcomprobantegravado = loItem.Totalcomprobantegravado
					lxPuntodeventa = loItem.Puntodeventa
					lxNroitem = lnContadorNroItem
					lxTotalcomprobanteiva = loItem.Totalcomprobanteiva
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxEspagoacuenta = loItem.Espagoacuenta
					lxLetra = loItem.Letra
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxCodigocomprobante = loItem.Codigocomprobante
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					lxAnotacion = loItem.Anotacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OrdPagoDet("Fecha","IdCaja","Rtipo","TotComSI","TotComCI","TotComGRAV","PtoAfec","NROITEM","TotComIVA","Numafec","lPagoACta","LetraAfec","Tipo","CodComp","RVal","CODIGO","FecEmi","RFecVen","Descrip","SaldoAux","RMonto","anotacion" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxTotalcomprobantesinimpuestos>>, <<lxTotalcomprobanteconimpuestos>>, <<lxTotalcomprobantegravado>>, <<lxPuntodeventa>>, <<lxNroitem>>, <<lxTotalcomprobanteiva>>, <<lxNumerodecomprobante>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">> ) 
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
					
					lxNroitem = lnContadorNroItem
					lxTipoimpuestocdr = loItem.Tipoimpuestocdr
					lxCodigocdr = loItem.Codigocdr
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpODP("NROITEM","TipoImp","CodigoCDR","Codigo","CodImp","Descri","Monto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxTipoimpuestocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxOrdpagoFecimpo, lxOrdpagoFaltafw, lxOrdpagoFecexpo, lxOrdpagoFmodifw, lxOrdpagoFectrans, lxOrdpagoIdcaja, lxOrdpagoSignomov, lxOrdpagoFacttipo, lxOrdpagoTimestamp, lxOrdpagoFcompfis, lxOrdpagoHoraimpo, lxOrdpagoHaltafw, lxOrdpagoHoraexpo, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoBdmodifw, lxOrdpagoSimbmon, lxOrdpagoBdaltafw, lxOrdpagoEsttrans, lxOrdpagoMonsis, lxOrdpagoIdvuelto, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoMoneda, lxOrdpagoCotiz, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFecimpo =  .Fechaimpo			lxOrdpagoFaltafw =  .Fechaaltafw			lxOrdpagoFecexpo =  .Fechaexpo			lxOrdpagoFmodifw =  .Fechamodificacionfw			lxOrdpagoFectrans =  .Fechatransferencia			lxOrdpagoIdcaja =  .Caja_PK 			lxOrdpagoSignomov =  .Signodemovimiento			lxOrdpagoFacttipo =  .Tipocomprobante			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFcompfis =  .Comprobantefiscal			lxOrdpagoHoraimpo =  .Horaimpo			lxOrdpagoHaltafw =  .Horaaltafw			lxOrdpagoHoraexpo =  .Horaexpo			lxOrdpagoSmodifw =  .Seriemodificacionfw			lxOrdpagoHmodifw =  .Horamodificacionfw			lxOrdpagoVmodifw =  .Versionmodificacionfw			lxOrdpagoZadsfw =  .Zadsfw			lxOrdpagoUmodifw =  .Usuariomodificacionfw			lxOrdpagoValtafw =  .Versionaltafw			lxOrdpagoSaltafw =  .Seriealtafw			lxOrdpagoUaltafw =  .Usuarioaltafw			lxOrdpagoBdmodifw =  .Basededatosmodificacionfw			lxOrdpagoSimbmon =  .Simbolomonetariocomprobante			lxOrdpagoBdaltafw =  .Basededatosaltafw			lxOrdpagoEsttrans =  .Estadotransferencia			lxOrdpagoMonsis =  upper( .MonedaSistema_PK ) 			lxOrdpagoIdvuelto =  upper( .IdVuelto_PK ) 			lxOrdpagoFletra =  .Letra			lxOrdpagoFptoven =  .Puntodeventa			lxOrdpagoImpman =  .Impuestosmanuales			lxOrdpagoFnumcomp =  .Numero			lxOrdpagoFperson =  upper( .Proveedor_PK ) 			lxOrdpagoFfch =  .Fecha			lxOrdpagoFven =  .Usuario			lxOrdpagoMoneda =  upper( .MonedaComprobante_PK ) 			lxOrdpagoCotiz =  .Cotizacion			lxOrdpagoFtotal =  .Total			lxOrdpagoPtovtacdr =  .Puntodeventacdr			lxOrdpagoNumcdr =  .Numerocdr			lxOrdpagoFobs =  .Obs			lxOrdpagoFvuelto =  .Vuelto			lxOrdpagoAnulado =  .Anulado			lxOrdpagoFproved =  .Proveedordescripcion			lxOrdpagoCodigo =  .Codigo
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
				update ZooLogic.ORDPAGO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxOrdpagoFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxOrdpagoFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxOrdpagoFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxOrdpagoFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxOrdpagoFectrans ) + "'">>,"Idcaja" = <<lxOrdpagoIdcaja>>,"Signomov" = <<lxOrdpagoSignomov>>,"Facttipo" = <<lxOrdpagoFacttipo>>,"Timestamp" = <<lxOrdpagoTimestamp>>,"Fcompfis" = <<iif( lxOrdpagoFcompfis, 1, 0 )>>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxOrdpagoHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxOrdpagoHoraexpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxOrdpagoZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoValtafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoUaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoBdmodifw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxOrdpagoSimbmon ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxOrdpagoEsttrans ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxOrdpagoMonsis ) + "'">>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxOrdpagoIdvuelto ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxOrdpagoFletra ) + "'">>,"Fptoven" = <<lxOrdpagoFptoven>>,"Impman" = <<iif( lxOrdpagoImpman, 1, 0 )>>,"Fnumcomp" = <<lxOrdpagoFnumcomp>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxOrdpagoFperson ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxOrdpagoFfch ) + "'">>,"Fven" = <<"'" + this.FormatearTextoSql( lxOrdpagoFven ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxOrdpagoMoneda ) + "'">>,"Cotiz" = <<lxOrdpagoCotiz>>,"Ftotal" = <<lxOrdpagoFtotal>>,"Ptovtacdr" = <<lxOrdpagoPtovtacdr>>,"Numcdr" = <<lxOrdpagoNumcdr>>,"Fobs" = <<"'" + this.FormatearTextoSql( lxOrdpagoFobs ) + "'">>,"Fvuelto" = <<lxOrdpagoFvuelto>>,"Anulado" = <<iif( lxOrdpagoAnulado, 1, 0 )>>,"Fproved" = <<"'" + this.FormatearTextoSql( lxOrdpagoFproved ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'">> and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			for each loItem in this.oEntidad.OrdenDePagoDetalle
				if this.oEntidad.OrdenDePagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxTipo = loItem.Tipo
					lxTotalcomprobantesinimpuestos = loItem.Totalcomprobantesinimpuestos
					lxTotalcomprobanteconimpuestos = loItem.Totalcomprobanteconimpuestos
					lxTotalcomprobantegravado = loItem.Totalcomprobantegravado
					lxPuntodeventa = loItem.Puntodeventa
					lxNroitem = lnContadorNroItem
					lxTotalcomprobanteiva = loItem.Totalcomprobanteiva
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxEspagoacuenta = loItem.Espagoacuenta
					lxLetra = loItem.Letra
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxCodigocomprobante = loItem.Codigocomprobante
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					lxAnotacion = loItem.Anotacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OrdPagoDet("Fecha","IdCaja","Rtipo","TotComSI","TotComCI","TotComGRAV","PtoAfec","NROITEM","TotComIVA","Numafec","lPagoACta","LetraAfec","Tipo","CodComp","RVal","CODIGO","FecEmi","RFecVen","Descrip","SaldoAux","RMonto","anotacion" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxTotalcomprobantesinimpuestos>>, <<lxTotalcomprobanteconimpuestos>>, <<lxTotalcomprobantegravado>>, <<lxPuntodeventa>>, <<lxNroitem>>, <<lxTotalcomprobanteiva>>, <<lxNumerodecomprobante>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">> ) 
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
					
					lxNroitem = lnContadorNroItem
					lxTipoimpuestocdr = loItem.Tipoimpuestocdr
					lxCodigocdr = loItem.Codigocdr
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpODP("NROITEM","TipoImp","CodigoCDR","Codigo","CodImp","Descri","Monto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxTipoimpuestocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Fcompfis" as "Comprobantefiscal", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Moneda" as "Monedacomprobante", "Cotiz" as "Cotizacion", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'">> and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )

			if reccount( 'c_ORDENDEPAGO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Rtipo" as "Tipo", "Totcomsi" as "Totalcomprobantesinimpuestos", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Letraafec" as "Letra", "Tipo" as "Tipodecomprobante", "Codcomp" as "Codigocomprobante", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto", "Anotacion" as "Anotacion" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Tipoimp" as "Tipoimpuestocdr", "Codigocdr" as "Codigocdr", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Fcompfis" as "Comprobantefiscal", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Moneda" as "Monedacomprobante", "Cotiz" as "Cotizacion", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 And FACTTIPO = <<lxOrdPagoFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxOrdPagoFLETRA ) + "'">> and FPTOVEN = <<lxOrdPagoFPTOVEN>> and FNUMCOMP = <<lxOrdPagoFNUMCOMP>>
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			if reccount( 'c_ORDENDEPAGO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Rtipo" as "Tipo", "Totcomsi" as "Totalcomprobantesinimpuestos", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Letraafec" as "Letra", "Tipo" as "Tipodecomprobante", "Codcomp" as "Codigocomprobante", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto", "Anotacion" as "Anotacion" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Tipoimp" as "Tipoimpuestocdr", "Codigocdr" as "Codigocdr", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Fcompfis" as "Comprobantefiscal", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Moneda" as "Monedacomprobante", "Cotiz" as "Cotizacion", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Rtipo" as "Tipo", "Totcomsi" as "Totalcomprobantesinimpuestos", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Letraafec" as "Letra", "Tipo" as "Tipodecomprobante", "Codcomp" as "Codigocomprobante", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto", "Anotacion" as "Anotacion" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Tipoimp" as "Tipoimpuestocdr", "Codigocdr" as "Codigocdr", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Fcompfis" as "Comprobantefiscal", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Moneda" as "Monedacomprobante", "Cotiz" as "Cotizacion", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 10, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Rtipo" as "Tipo", "Totcomsi" as "Totalcomprobantesinimpuestos", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Letraafec" as "Letra", "Tipo" as "Tipodecomprobante", "Codcomp" as "Codigocomprobante", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto", "Anotacion" as "Anotacion" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Tipoimp" as "Tipoimpuestocdr", "Codigocdr" as "Codigocdr", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Fcompfis" as "Comprobantefiscal", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Moneda" as "Monedacomprobante", "Cotiz" as "Cotizacion", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 10, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Rtipo" as "Tipo", "Totcomsi" as "Totalcomprobantesinimpuestos", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Letraafec" as "Letra", "Tipo" as "Tipodecomprobante", "Codcomp" as "Codigocomprobante", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto", "Anotacion" as "Anotacion" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Tipoimp" as "Tipoimpuestocdr", "Codigocdr" as "Codigocdr", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Fcompfis" as "Comprobantefiscal", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Moneda" as "Monedacomprobante", "Cotiz" as "Cotizacion", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo" from ZooLogic.ORDPAGO where  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc
			endtext
			use in select('c_ORDENDEPAGO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPAGO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_CompAfec2')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CompAfec2', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CompAfec2
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjt" as "Tipo", "Jjturno" as "Turno", "Cotiza" as "Ultimacotizacion", "Signo" as "Signo", "Ptoventa" as "Puntodeventa", "Pesos" as "Pesosalcambio", "Jjcotiz" as "Cotiza", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Letra" as "Letra", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Jjven" as "Vendedor", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Condpago" as "Condiciondepago", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecha" as "Fecha", "Idcaja" as "Caja", "Rtipo" as "Tipo", "Totcomsi" as "Totalcomprobantesinimpuestos", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Letraafec" as "Letra", "Tipo" as "Tipodecomprobante", "Codcomp" as "Codigocomprobante", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto", "Anotacion" as "Anotacion" from ZooLogic.OrdPagoDet where CODIGO = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenDePagoDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenDePagoDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenDePagoDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Tipoimp" as "Tipoimpuestocdr", "Codigocdr" as "Codigocdr", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto" from ZooLogic.ImpODP where Codigo = <<"'" + this.FormatearTextoSql( c_ORDENDEPAGO.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Faltafw,Fecexpo,Fmodifw,Fectrans,Idcaja,Signomov,Facttipo,Timestamp,Fcompfis,Horaimp" + ;
"o,Haltafw,Horaexpo,Smodifw,Hmodifw,Vmodifw,Zadsfw,Umodifw,Valtafw,Saltafw,Ualtafw,Bdmodifw,Simbmon,B" + ;
"daltafw,Esttrans,Monsis,Idvuelto,Fletra,Fptoven,Impman,Fnumcomp,Fperson,Ffch,Fven,Moneda,Cotiz,Ftota" + ;
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
			local  lxOrdpagoFecimpo, lxOrdpagoFaltafw, lxOrdpagoFecexpo, lxOrdpagoFmodifw, lxOrdpagoFectrans, lxOrdpagoIdcaja, lxOrdpagoSignomov, lxOrdpagoFacttipo, lxOrdpagoTimestamp, lxOrdpagoFcompfis, lxOrdpagoHoraimpo, lxOrdpagoHaltafw, lxOrdpagoHoraexpo, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoBdmodifw, lxOrdpagoSimbmon, lxOrdpagoBdaltafw, lxOrdpagoEsttrans, lxOrdpagoMonsis, lxOrdpagoIdvuelto, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoMoneda, lxOrdpagoCotiz, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFecimpo = ctod( '  /  /    ' )			lxOrdpagoFaltafw = ctod( '  /  /    ' )			lxOrdpagoFecexpo = ctod( '  /  /    ' )			lxOrdpagoFmodifw = ctod( '  /  /    ' )			lxOrdpagoFectrans = ctod( '  /  /    ' )			lxOrdpagoIdcaja = 0			lxOrdpagoSignomov = 0			lxOrdpagoFacttipo = 0			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFcompfis = .F.			lxOrdpagoHoraimpo = []			lxOrdpagoHaltafw = []			lxOrdpagoHoraexpo = []			lxOrdpagoSmodifw = []			lxOrdpagoHmodifw = []			lxOrdpagoVmodifw = []			lxOrdpagoZadsfw = []			lxOrdpagoUmodifw = []			lxOrdpagoValtafw = []			lxOrdpagoSaltafw = []			lxOrdpagoUaltafw = []			lxOrdpagoBdmodifw = []			lxOrdpagoSimbmon = []			lxOrdpagoBdaltafw = []			lxOrdpagoEsttrans = []			lxOrdpagoMonsis = []			lxOrdpagoIdvuelto = []			lxOrdpagoFletra = []			lxOrdpagoFptoven = 0			lxOrdpagoImpman = .F.			lxOrdpagoFnumcomp = 0			lxOrdpagoFperson = []			lxOrdpagoFfch = ctod( '  /  /    ' )			lxOrdpagoFven = []			lxOrdpagoMoneda = []			lxOrdpagoCotiz = 0			lxOrdpagoFtotal = 0			lxOrdpagoPtovtacdr = 0			lxOrdpagoNumcdr = 0			lxOrdpagoFobs = []			lxOrdpagoFvuelto = 0			lxOrdpagoAnulado = .F.			lxOrdpagoFproved = []			lxOrdpagoCodigo = []
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
					"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Fcompfis" as "Comprobantefiscal", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Moneda" as "Monedacomprobante", "Cotiz" as "Cotizacion", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo"
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
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
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
	Function ObtenerDatosDetalleOrdenDePagoDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ORDPAGODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecha" as "Fecha", "Idcaja" as "Caja", "Rtipo" as "Tipo", "Totcomsi" as "Totalcomprobantesinimpuestos", "Totcomci" as "Totalcomprobanteconimpuestos", "Totcomgrav" as "Totalcomprobantegravado", "Ptoafec" as "Puntodeventa", "Nroitem" as "Nroitem", "Totcomiva" as "Totalcomprobanteiva", "Numafec" as "Numerodecomprobante", "Lpagoacta" as "Espagoacuenta", "Letraafec" as "Letra", "Tipo" as "Tipodecomprobante", "Codcomp" as "Codigocomprobante", "Rval" as "Valor", "Codigo" as "Codigo", "Fecemi" as "Emision", "Rfecven" as "Vencimiento", "Descrip" as "Descripcion", "Saldoaux" as "Saldoaux", "Rmonto" as "Monto", "Anotacion" as "Anotacion"
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
					"Nroitem" as "Nroitem", "Tipoimp" as "Tipoimpuestocdr", "Codigocdr" as "Codigocdr", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto"
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
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
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
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
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
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
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RTIPO AS TIPO'
				Case lcAtributo == 'TOTALCOMPROBANTESINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTCOMSI AS TOTALCOMPROBANTESINIMPUESTOS'
				Case lcAtributo == 'TOTALCOMPROBANTECONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTCOMCI AS TOTALCOMPROBANTECONIMPUESTOS'
				Case lcAtributo == 'TOTALCOMPROBANTEGRAVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTCOMGRAV AS TOTALCOMPROBANTEGRAVADO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOAFEC AS PUNTODEVENTA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'TOTALCOMPROBANTEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTCOMIVA AS TOTALCOMPROBANTEIVA'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMAFEC AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'ESPAGOACUENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPAGOACTA AS ESPAGOACUENTA'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRAAFEC AS LETRA'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPODECOMPROBANTE'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTE'
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
				Case lcAtributo == 'SALDOAUX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALDOAUX AS SALDOAUX'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RMONTO AS MONTO'
				Case lcAtributo == 'ANOTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANOTACION AS ANOTACION'
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
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'TIPOIMPUESTOCDR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOIMP AS TIPOIMPUESTOCDR'
				Case lcAtributo == 'CODIGOCDR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOCDR AS CODIGOCDR'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
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
	Function ObtenerCampoDetalleOrdenDePagoDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'RTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCOMPROBANTESINIMPUESTOS'
				lcCampo = 'TOTCOMSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCOMPROBANTECONIMPUESTOS'
				lcCampo = 'TOTCOMCI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCOMPROBANTEGRAVADO'
				lcCampo = 'TOTCOMGRAV'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCOMPROBANTEIVA'
				lcCampo = 'TOTCOMIVA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'ESPAGOACUENTA'
				lcCampo = 'LPAGOACTA'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRAAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODCOMP'
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
			Case upper( alltrim( tcAtributo ) ) == 'SALDOAUX'
				lcCampo = 'SALDOAUX'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'RMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'ANOTACION'
				lcCampo = 'ANOTACION'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleImpuestosComprobante( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTOCDR'
				lcCampo = 'TIPOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCDR'
				lcCampo = 'CODIGOCDR'
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
			local  lxOrdpagoFecimpo, lxOrdpagoFaltafw, lxOrdpagoFecexpo, lxOrdpagoFmodifw, lxOrdpagoFectrans, lxOrdpagoIdcaja, lxOrdpagoSignomov, lxOrdpagoFacttipo, lxOrdpagoTimestamp, lxOrdpagoFcompfis, lxOrdpagoHoraimpo, lxOrdpagoHaltafw, lxOrdpagoHoraexpo, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoBdmodifw, lxOrdpagoSimbmon, lxOrdpagoBdaltafw, lxOrdpagoEsttrans, lxOrdpagoMonsis, lxOrdpagoIdvuelto, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoMoneda, lxOrdpagoCotiz, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFecimpo =  .Fechaimpo			lxOrdpagoFaltafw =  .Fechaaltafw			lxOrdpagoFecexpo =  .Fechaexpo			lxOrdpagoFmodifw =  .Fechamodificacionfw			lxOrdpagoFectrans =  .Fechatransferencia			lxOrdpagoIdcaja =  .Caja_PK 			lxOrdpagoSignomov =  .Signodemovimiento			lxOrdpagoFacttipo =  .Tipocomprobante			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFcompfis =  .Comprobantefiscal			lxOrdpagoHoraimpo =  .Horaimpo			lxOrdpagoHaltafw =  .Horaaltafw			lxOrdpagoHoraexpo =  .Horaexpo			lxOrdpagoSmodifw =  .Seriemodificacionfw			lxOrdpagoHmodifw =  .Horamodificacionfw			lxOrdpagoVmodifw =  .Versionmodificacionfw			lxOrdpagoZadsfw =  .Zadsfw			lxOrdpagoUmodifw =  .Usuariomodificacionfw			lxOrdpagoValtafw =  .Versionaltafw			lxOrdpagoSaltafw =  .Seriealtafw			lxOrdpagoUaltafw =  .Usuarioaltafw			lxOrdpagoBdmodifw =  .Basededatosmodificacionfw			lxOrdpagoSimbmon =  .Simbolomonetariocomprobante			lxOrdpagoBdaltafw =  .Basededatosaltafw			lxOrdpagoEsttrans =  .Estadotransferencia			lxOrdpagoMonsis =  upper( .MonedaSistema_PK ) 			lxOrdpagoIdvuelto =  upper( .IdVuelto_PK ) 			lxOrdpagoFletra =  .Letra			lxOrdpagoFptoven =  .Puntodeventa			lxOrdpagoImpman =  .Impuestosmanuales			lxOrdpagoFnumcomp =  .Numero			lxOrdpagoFperson =  upper( .Proveedor_PK ) 			lxOrdpagoFfch =  .Fecha			lxOrdpagoFven =  .Usuario			lxOrdpagoMoneda =  upper( .MonedaComprobante_PK ) 			lxOrdpagoCotiz =  .Cotizacion			lxOrdpagoFtotal =  .Total			lxOrdpagoPtovtacdr =  .Puntodeventacdr			lxOrdpagoNumcdr =  .Numerocdr			lxOrdpagoFobs =  .Obs			lxOrdpagoFvuelto =  .Vuelto			lxOrdpagoAnulado =  .Anulado			lxOrdpagoFproved =  .Proveedordescripcion			lxOrdpagoCodigo =  .Codigo
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ORDPAGO ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Fectrans","Idcaja","Signomov","Facttipo","Timestamp","Fcompfis","Horaimpo","Haltafw","Horaexpo","Smodifw","Hmodifw","Vmodifw","Zadsfw","Umodifw","Valtafw","Saltafw","Ualtafw","Bdmodifw","Simbmon","Bdaltafw","Esttrans","Monsis","Idvuelto","Fletra","Fptoven","Impman","Fnumcomp","Fperson","Ffch","Fven","Moneda","Cotiz","Ftotal","Ptovtacdr","Numcdr","Fobs","Fvuelto","Anulado","Fproved","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxOrdpagoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFectrans ) + "'" >>, <<lxOrdpagoIdcaja >>, <<lxOrdpagoSignomov >>, <<lxOrdpagoFacttipo >>, <<lxOrdpagoTimestamp >>, <<iif( lxOrdpagoFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFletra ) + "'" >>, <<lxOrdpagoFptoven >>, <<iif( lxOrdpagoImpman, 1, 0 ) >>, <<lxOrdpagoFnumcomp >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFperson ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdpagoFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFven ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoMoneda ) + "'" >>, <<lxOrdpagoCotiz >>, <<lxOrdpagoFtotal >>, <<lxOrdpagoPtovtacdr >>, <<lxOrdpagoNumcdr >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFobs ) + "'" >>, <<lxOrdpagoFvuelto >>, <<iif( lxOrdpagoAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxOrdpagoFproved ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'" >> )
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
			for each loItem in this.oEntidad.OrdenDePagoDetalle
				if this.oEntidad.OrdenDePagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxTipo = loItem.Tipo
					lxTotalcomprobantesinimpuestos = loItem.Totalcomprobantesinimpuestos
					lxTotalcomprobanteconimpuestos = loItem.Totalcomprobanteconimpuestos
					lxTotalcomprobantegravado = loItem.Totalcomprobantegravado
					lxPuntodeventa = loItem.Puntodeventa
					lxNroitem = lnContadorNroItem
					lxTotalcomprobanteiva = loItem.Totalcomprobanteiva
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxEspagoacuenta = loItem.Espagoacuenta
					lxLetra = loItem.Letra
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxCodigocomprobante = loItem.Codigocomprobante
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					lxAnotacion = loItem.Anotacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OrdPagoDet("Fecha","IdCaja","Rtipo","TotComSI","TotComCI","TotComGRAV","PtoAfec","NROITEM","TotComIVA","Numafec","lPagoACta","LetraAfec","Tipo","CodComp","RVal","CODIGO","FecEmi","RFecVen","Descrip","SaldoAux","RMonto","anotacion" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxTotalcomprobantesinimpuestos>>, <<lxTotalcomprobanteconimpuestos>>, <<lxTotalcomprobantegravado>>, <<lxPuntodeventa>>, <<lxNroitem>>, <<lxTotalcomprobanteiva>>, <<lxNumerodecomprobante>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipoimpuestocdr = loItem.Tipoimpuestocdr
					lxCodigocdr = loItem.Codigocdr
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpODP("NROITEM","TipoImp","CodigoCDR","Codigo","CodImp","Descri","Monto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxTipoimpuestocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocdr ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxOrdpagoFecimpo, lxOrdpagoFaltafw, lxOrdpagoFecexpo, lxOrdpagoFmodifw, lxOrdpagoFectrans, lxOrdpagoIdcaja, lxOrdpagoSignomov, lxOrdpagoFacttipo, lxOrdpagoTimestamp, lxOrdpagoFcompfis, lxOrdpagoHoraimpo, lxOrdpagoHaltafw, lxOrdpagoHoraexpo, lxOrdpagoSmodifw, lxOrdpagoHmodifw, lxOrdpagoVmodifw, lxOrdpagoZadsfw, lxOrdpagoUmodifw, lxOrdpagoValtafw, lxOrdpagoSaltafw, lxOrdpagoUaltafw, lxOrdpagoBdmodifw, lxOrdpagoSimbmon, lxOrdpagoBdaltafw, lxOrdpagoEsttrans, lxOrdpagoMonsis, lxOrdpagoIdvuelto, lxOrdpagoFletra, lxOrdpagoFptoven, lxOrdpagoImpman, lxOrdpagoFnumcomp, lxOrdpagoFperson, lxOrdpagoFfch, lxOrdpagoFven, lxOrdpagoMoneda, lxOrdpagoCotiz, lxOrdpagoFtotal, lxOrdpagoPtovtacdr, lxOrdpagoNumcdr, lxOrdpagoFobs, lxOrdpagoFvuelto, lxOrdpagoAnulado, lxOrdpagoFproved, lxOrdpagoCodigo
				lxOrdpagoFecimpo =  .Fechaimpo			lxOrdpagoFaltafw =  .Fechaaltafw			lxOrdpagoFecexpo =  .Fechaexpo			lxOrdpagoFmodifw =  .Fechamodificacionfw			lxOrdpagoFectrans =  .Fechatransferencia			lxOrdpagoIdcaja =  .Caja_PK 			lxOrdpagoSignomov =  .Signodemovimiento			lxOrdpagoFacttipo =  .Tipocomprobante			lxOrdpagoTimestamp = goLibrerias.ObtenerTimestamp()			lxOrdpagoFcompfis =  .Comprobantefiscal			lxOrdpagoHoraimpo =  .Horaimpo			lxOrdpagoHaltafw =  .Horaaltafw			lxOrdpagoHoraexpo =  .Horaexpo			lxOrdpagoSmodifw =  .Seriemodificacionfw			lxOrdpagoHmodifw =  .Horamodificacionfw			lxOrdpagoVmodifw =  .Versionmodificacionfw			lxOrdpagoZadsfw =  .Zadsfw			lxOrdpagoUmodifw =  .Usuariomodificacionfw			lxOrdpagoValtafw =  .Versionaltafw			lxOrdpagoSaltafw =  .Seriealtafw			lxOrdpagoUaltafw =  .Usuarioaltafw			lxOrdpagoBdmodifw =  .Basededatosmodificacionfw			lxOrdpagoSimbmon =  .Simbolomonetariocomprobante			lxOrdpagoBdaltafw =  .Basededatosaltafw			lxOrdpagoEsttrans =  .Estadotransferencia			lxOrdpagoMonsis =  upper( .MonedaSistema_PK ) 			lxOrdpagoIdvuelto =  upper( .IdVuelto_PK ) 			lxOrdpagoFletra =  .Letra			lxOrdpagoFptoven =  .Puntodeventa			lxOrdpagoImpman =  .Impuestosmanuales			lxOrdpagoFnumcomp =  .Numero			lxOrdpagoFperson =  upper( .Proveedor_PK ) 			lxOrdpagoFfch =  .Fecha			lxOrdpagoFven =  .Usuario			lxOrdpagoMoneda =  upper( .MonedaComprobante_PK ) 			lxOrdpagoCotiz =  .Cotizacion			lxOrdpagoFtotal =  .Total			lxOrdpagoPtovtacdr =  .Puntodeventacdr			lxOrdpagoNumcdr =  .Numerocdr			lxOrdpagoFobs =  .Obs			lxOrdpagoFvuelto =  .Vuelto			lxOrdpagoAnulado =  .Anulado			lxOrdpagoFproved =  .Proveedordescripcion			lxOrdpagoCodigo =  .Codigo
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ORDPAGO.CODIGO != '' AND ORDPAGO.FACTTIPO = 31]
			text to lcSentencia noshow textmerge
				update ZooLogic.ORDPAGO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxOrdpagoFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxOrdpagoFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxOrdpagoFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxOrdpagoFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxOrdpagoFectrans ) + "'">>, "Idcaja" = <<lxOrdpagoIdcaja>>, "Signomov" = <<lxOrdpagoSignomov>>, "Facttipo" = <<lxOrdpagoFacttipo>>, "Timestamp" = <<lxOrdpagoTimestamp>>, "Fcompfis" = <<iif( lxOrdpagoFcompfis, 1, 0 )>>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxOrdpagoHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxOrdpagoHoraexpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxOrdpagoZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoValtafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoUaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOrdpagoBdmodifw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxOrdpagoSimbmon ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOrdpagoBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxOrdpagoEsttrans ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxOrdpagoMonsis ) + "'">>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxOrdpagoIdvuelto ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxOrdpagoFletra ) + "'">>, "Fptoven" = <<lxOrdpagoFptoven>>, "Impman" = <<iif( lxOrdpagoImpman, 1, 0 )>>, "Fnumcomp" = <<lxOrdpagoFnumcomp>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxOrdpagoFperson ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxOrdpagoFfch ) + "'">>, "Fven" = <<"'" + this.FormatearTextoSql( lxOrdpagoFven ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxOrdpagoMoneda ) + "'">>, "Cotiz" = <<lxOrdpagoCotiz>>, "Ftotal" = <<lxOrdpagoFtotal>>, "Ptovtacdr" = <<lxOrdpagoPtovtacdr>>, "Numcdr" = <<lxOrdpagoNumcdr>>, "Fobs" = <<"'" + this.FormatearTextoSql( lxOrdpagoFobs ) + "'">>, "Fvuelto" = <<lxOrdpagoFvuelto>>, "Anulado" = <<iif( lxOrdpagoAnulado, 1, 0 )>>, "Fproved" = <<"'" + this.FormatearTextoSql( lxOrdpagoFproved ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdpagoCodigo ) + "'">> where << lcFiltro >>
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
			for each loItem in this.oEntidad.OrdenDePagoDetalle
				if this.oEntidad.OrdenDePagoDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFecha = loItem.Fecha
					lxCaja_PK = loItem.Caja_PK
					lxTipo = loItem.Tipo
					lxTotalcomprobantesinimpuestos = loItem.Totalcomprobantesinimpuestos
					lxTotalcomprobanteconimpuestos = loItem.Totalcomprobanteconimpuestos
					lxTotalcomprobantegravado = loItem.Totalcomprobantegravado
					lxPuntodeventa = loItem.Puntodeventa
					lxNroitem = lnContadorNroItem
					lxTotalcomprobanteiva = loItem.Totalcomprobanteiva
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxEspagoacuenta = loItem.Espagoacuenta
					lxLetra = loItem.Letra
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxCodigocomprobante = loItem.Codigocomprobante
					lxValor_PK = loItem.Valor_PK
					lxEmision = loItem.Emision
					lxVencimiento = loItem.Vencimiento
					lxDescripcion = loItem.Descripcion
					lxSaldoaux = loItem.Saldoaux
					lxMonto = loItem.Monto
					lxAnotacion = loItem.Anotacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.OrdPagoDet("Fecha","IdCaja","Rtipo","TotComSI","TotComCI","TotComGRAV","PtoAfec","NROITEM","TotComIVA","Numafec","lPagoACta","LetraAfec","Tipo","CodComp","RVal","CODIGO","FecEmi","RFecVen","Descrip","SaldoAux","RMonto","anotacion" ) values ( <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxCaja_PK>>, <<lxTipo>>, <<lxTotalcomprobantesinimpuestos>>, <<lxTotalcomprobanteconimpuestos>>, <<lxTotalcomprobantegravado>>, <<lxPuntodeventa>>, <<lxNroitem>>, <<lxTotalcomprobanteiva>>, <<lxNumerodecomprobante>>, <<iif( lxEspagoacuenta, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxEmision ) + "'">>, <<"'" + this.ConvertirDateSql( lxVencimiento ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<lxSaldoaux>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxAnotacion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipoimpuestocdr = loItem.Tipoimpuestocdr
					lxCodigocdr = loItem.Codigocdr
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpODP("NROITEM","TipoImp","CodigoCDR","Codigo","CodImp","Descri","Monto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxTipoimpuestocdr ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocdr ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>> ) 
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.ORDPAGO set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, ImpMan = ] + Transform( iif( &lcCursor..ImpMan, 1, 0 ))+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FVEN = ] + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, PtoVtaCDR = ] + transform( &lcCursor..PtoVtaCDR )+ [, NumCDR = ] + transform( &lcCursor..NumCDR )+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, Fproved = ] + "'" + this.FormatearTextoSql( &lcCursor..Fproved ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
						 FECIMPO, FALTAFW, FECEXPO, FMODIFW, FECTRANS, IdCaja, signomov, FACTTIPO, TIMESTAMP, FCOMPFIS, HORAIMPO, HALTAFW, HORAEXPO, SMODIFW, HMODIFW, VMODIFW, ZADSFW, UMODIFW, VALTAFW, SALTAFW, UALTAFW, BDMODIFW, SimbMon, BDALTAFW, ESTTRANS, MonSis, idVuelto, FLETRA, FPTOVEN, ImpMan, FNUMCOMP, FPerson, FFCH, FVEN, Moneda, Cotiz, FTotal, PtoVtaCDR, NumCDR, FObs, FVuelto, Anulado, Fproved, CODIGO
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..signomov )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..FPTOVEN )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..ImpMan, 1, 0 )) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..FTotal )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..PtoVtaCDR ) + ',' + transform( &lcCursor..NumCDR ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + transform( &lcCursor..FVuelto ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Fproved ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.ORDPAGO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
			"NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMORDENDEPAGO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Fecha","IdCaja","Rtipo","TotComSI","TotComCI","TotComGRAV","PtoAfec","NROITEM","TotComIVA","Numafec","lPagoACta","LetraAfec","Tipo","CodComp","RVal","CODIGO","FecEmi","RFecVen","Descrip","SaldoAux","RMonto","anotacion"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.OrdPagoDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.Fecha      ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + transform( cDetallesExistentes.Rtipo      ) + ',' + transform( cDetallesExistentes.TotComSI   ) + ',' + transform( cDetallesExistentes.TotComCI   ) + ',' + transform( cDetallesExistentes.TotComGRAV ) + ',' + transform( cDetallesExistentes.PtoAfec    ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.TotComIVA  ) + ',' + transform( cDetallesExistentes.Numafec    ) + ',' + Transform( iif( cDetallesExistentes.lPagoACta , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LetraAfec  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Tipo       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodComp    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.RVal       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FecEmi     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.RFecVen    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + transform( cDetallesExistentes.SaldoAux   ) + ',' + transform( cDetallesExistentes.RMonto     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.anotacion  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOORDENDEPAGO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","TipoImp","CodigoCDR","Codigo","CodImp","Descri","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpODP ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoImp    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodigoCDR  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
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
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"idcaja" numeric( 2, 0 )  null, 
"signomov" numeric( 2, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"fcompfis" bit  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"simbmon" char( 3 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"monsis" char( 10 )  null, 
"idvuelto" char( 5 )  null, 
"fletra" char( 1 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"impman" bit  null, 
"fnumcomp" numeric( 10, 0 )  null, 
"fperson" char( 5 )  null, 
"ffch" datetime  null, 
"fven" char( 100 )  null, 
"moneda" char( 10 )  null, 
"cotiz" numeric( 15, 5 )  null, 
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('impman','impman')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('fven','fven')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('cotiz','cotiz')
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.IMPMAN = isnull( d.IMPMAN, t.IMPMAN ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FVEN = isnull( d.FVEN, t.FVEN ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.PTOVTACDR = isnull( d.PTOVTACDR, t.PTOVTACDR ),t.NUMCDR = isnull( d.NUMCDR, t.NUMCDR ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FPROVED = isnull( d.FPROVED, t.FPROVED ),t.CODIGO = isnull( d.CODIGO, t.CODIGO )
					from ZooLogic.ORDPAGO t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
				-- Fin Updates
				insert into ZooLogic.ORDPAGO(Fecimpo,Faltafw,Fecexpo,Fmodifw,Fectrans,Idcaja,Signomov,Facttipo,Timestamp,Fcompfis,Horaimpo,Haltafw,Horaexpo,Smodifw,Hmodifw,Vmodifw,Zadsfw,Umodifw,Valtafw,Saltafw,Ualtafw,Bdmodifw,Simbmon,Bdaltafw,Esttrans,Monsis,Idvuelto,Fletra,Fptoven,Impman,Fnumcomp,Fperson,Ffch,Fven,Moneda,Cotiz,Ftotal,Ptovtacdr,Numcdr,Fobs,Fvuelto,Anulado,Fproved,Codigo)
					Select isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.IDCAJA,0),isnull( d.SIGNOMOV,0),isnull( d.FACTTIPO,0),isnull( d.TIMESTAMP,0),isnull( d.FCOMPFIS,0),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.SIMBMON,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.MONSIS,''),isnull( d.IDVUELTO,''),isnull( d.FLETRA,''),isnull( d.FPTOVEN,0),isnull( d.IMPMAN,0),isnull( d.FNUMCOMP,0),isnull( d.FPERSON,''),isnull( d.FFCH,''),isnull( d.FVEN,''),isnull( d.MONEDA,''),isnull( d.COTIZ,0),isnull( d.FTOTAL,0),isnull( d.PTOVTACDR,0),isnull( d.NUMCDR,0),isnull( d.FOBS,''),isnull( d.FVUELTO,0),isnull( d.ANULADO,0),isnull( d.FPROVED,''),isnull( d.CODIGO,'')
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', NÚMERO ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(10) ) + '','La clave principal no es la esperada'
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', NÚMERO ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(10) ) + '','La clave principal a importar ya existe'
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
t.RTIPO = isnull( d.RTIPO, t.RTIPO ),
t.TOTCOMSI = isnull( d.TOTCOMSI, t.TOTCOMSI ),
t.TOTCOMCI = isnull( d.TOTCOMCI, t.TOTCOMCI ),
t.TOTCOMGRAV = isnull( d.TOTCOMGRAV, t.TOTCOMGRAV ),
t.PTOAFEC = isnull( d.PTOAFEC, t.PTOAFEC ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.TOTCOMIVA = isnull( d.TOTCOMIVA, t.TOTCOMIVA ),
t.NUMAFEC = isnull( d.NUMAFEC, t.NUMAFEC ),
t.LPAGOACTA = isnull( d.LPAGOACTA, t.LPAGOACTA ),
t.LETRAAFEC = isnull( d.LETRAAFEC, t.LETRAAFEC ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),
t.RVAL = isnull( d.RVAL, t.RVAL ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FECEMI = isnull( d.FECEMI, t.FECEMI ),
t.RFECVEN = isnull( d.RFECVEN, t.RFECVEN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.SALDOAUX = isnull( d.SALDOAUX, t.SALDOAUX ),
t.RMONTO = isnull( d.RMONTO, t.RMONTO ),
t.ANOTACION = isnull( d.ANOTACION, t.ANOTACION )
from ZooLogic.OrdPagoDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.OrdPagoDet
( 
"FECHA",
"IDCAJA",
"RTIPO",
"TOTCOMSI",
"TOTCOMCI",
"TOTCOMGRAV",
"PTOAFEC",
"NROITEM",
"TOTCOMIVA",
"NUMAFEC",
"LPAGOACTA",
"LETRAAFEC",
"TIPO",
"CODCOMP",
"RVAL",
"CODIGO",
"FECEMI",
"RFECVEN",
"DESCRIP",
"SALDOAUX",
"RMONTO",
"ANOTACION"
 )
Select 
d.FECHA,
d.IDCAJA,
d.RTIPO,
d.TOTCOMSI,
d.TOTCOMCI,
d.TOTCOMGRAV,
d.PTOAFEC,
d.NROITEM,
d.TOTCOMIVA,
d.NUMAFEC,
d.LPAGOACTA,
d.LETRAAFEC,
d.TIPO,
d.CODCOMP,
d.RVAL,
d.CODIGO,
d.FECEMI,
d.RFECVEN,
d.DESCRIP,
d.SALDOAUX,
d.RMONTO,
d.ANOTACION
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
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.TIPOIMP = isnull( d.TIPOIMP, t.TIPOIMP ),
t.CODIGOCDR = isnull( d.CODIGOCDR, t.CODIGOCDR ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.ImpODP t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpODP
( 
"NROITEM",
"TIPOIMP",
"CODIGOCDR",
"CODIGO",
"CODIMP",
"DESCRI",
"MONTO"
 )
Select 
d.NROITEM,
d.TIPOIMP,
d.CODIGOCDR,
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
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPAGO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Caja_PK =  nvl( c_ORDENDEPAGO.Caja, 0 )
					.Compafec2.Limpiar()
					.Compafec2.SetearEsNavegacion( .lProcesando )
					.Compafec2.Cargar()
					.Signodemovimiento = nvl( c_ORDENDEPAGO.Signodemovimiento, 0 )
					.Tipocomprobante = nvl( c_ORDENDEPAGO.Tipocomprobante, 0 )
					.Timestamp = nvl( c_ORDENDEPAGO.Timestamp, 0 )
					.Comprobantefiscal = nvl( c_ORDENDEPAGO.Comprobantefiscal, .F. )
					.Horaimpo = nvl( c_ORDENDEPAGO.Horaimpo, [] )
					.Horaaltafw = nvl( c_ORDENDEPAGO.Horaaltafw, [] )
					.Horaexpo = nvl( c_ORDENDEPAGO.Horaexpo, [] )
					.Seriemodificacionfw = nvl( c_ORDENDEPAGO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_ORDENDEPAGO.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ORDENDEPAGO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_ORDENDEPAGO.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_ORDENDEPAGO.Versionaltafw, [] )
					.Seriealtafw = nvl( c_ORDENDEPAGO.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_ORDENDEPAGO.Usuarioaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ORDENDEPAGO.Basededatosmodificacionfw, [] )
					.Simbolomonetariocomprobante = nvl( c_ORDENDEPAGO.Simbolomonetariocomprobante, [] )
					.Basededatosaltafw = nvl( c_ORDENDEPAGO.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_ORDENDEPAGO.Estadotransferencia, [] )
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Ordendepagodetalle.Limpiar()
					.Ordendepagodetalle.SetearEsNavegacion( .lProcesando )
					.Ordendepagodetalle.Cargar()
					.Monedasistema_PK =  nvl( c_ORDENDEPAGO.Monedasistema, [] )
					.Idvuelto_PK =  nvl( c_ORDENDEPAGO.Idvuelto, [] )
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
					.Monedacomprobante_PK =  nvl( c_ORDENDEPAGO.Monedacomprobante, [] )
					.Cotizacion = nvl( c_ORDENDEPAGO.Cotizacion, 0 )
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
			"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Idcaja" as "Caja", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Fcompfis" as "Comprobantefiscal", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fletra" as "Letra", "Fptoven" as "Puntodeventa", "Impman" as "Impuestosmanuales", "Fnumcomp" as "Numero", "Fperson" as "Proveedor", "Ffch" as "Fecha", "Fven" as "Usuario", "Moneda" as "Monedacomprobante", "Cotiz" as "Cotizacion", "Ftotal" as "Total", "Ptovtacdr" as "Puntodeventacdr", "Numcdr" as "Numerocdr", "Fobs" as "Obs", "Fvuelto" as "Vuelto", "Anulado" as "Anulado", "Fproved" as "Proveedordescripcion", "Codigo" as "Codigo"
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
	<row entidad="ORDENDEPAGO                             " atributo="FECHAIMPO                               " tabla="ORDPAGO        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHAALTAFW                             " tabla="ORDPAGO        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHAEXPO                               " tabla="ORDPAGO        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHAMODIFICACIONFW                     " tabla="ORDPAGO        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHATRANSFERENCIA                      " tabla="ORDPAGO        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="CAJA                                    " tabla="ORDPAGO        " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="COMPAFEC2                               " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="SIGNODEMOVIMIENTO                       " tabla="ORDPAGO        " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="TIPOCOMPROBANTE                         " tabla="ORDPAGO        " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=31                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="TIMESTAMP                               " tabla="ORDPAGO        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="COMPROBANTEFISCAL                       " tabla="ORDPAGO        " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="HORAIMPO                                " tabla="ORDPAGO        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="HORAALTAFW                              " tabla="ORDPAGO        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="HORAEXPO                                " tabla="ORDPAGO        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="SERIEMODIFICACIONFW                     " tabla="ORDPAGO        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="HORAMODIFICACIONFW                      " tabla="ORDPAGO        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="VERSIONMODIFICACIONFW                   " tabla="ORDPAGO        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="ZADSFW                                  " tabla="ORDPAGO        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="USUARIOMODIFICACIONFW                   " tabla="ORDPAGO        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="VERSIONALTAFW                           " tabla="ORDPAGO        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="SERIEALTAFW                             " tabla="ORDPAGO        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="USUARIOALTAFW                           " tabla="ORDPAGO        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ORDPAGO        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="ORDPAGO        " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="BASEDEDATOSALTAFW                       " tabla="ORDPAGO        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="ESTADOTRANSFERENCIA                     " tabla="ORDPAGO        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="VALORESDETALLE                          " tabla="VALFACCOMP     " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMVALORESCOMPRA      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="ORDENDEPAGODETALLE                      " tabla="ORDPAGODET     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMORDENDEPAGO        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="MONEDASISTEMA                           " tabla="ORDPAGO        " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="IDVUELTO                                " tabla="ORDPAGO        " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="LETRA                                   " tabla="ORDPAGO        " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="2" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPODP         " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOORDENDEPAGO" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="PUNTODEVENTA                            " tabla="ORDPAGO        " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="IMPUESTOSMANUALES                       " tabla="ORDPAGO        " campo="IMPMAN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="NUMERO                                  " tabla="ORDPAGO        " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="PROVEEDOR                               " tabla="ORDPAGO        " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="406" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="FECHA                                   " tabla="ORDPAGO        " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=GOLIBRERIAS.OBTENERFECHA()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="USUARIO                                 " tabla="ORDPAGO        " campo="FVEN      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="408" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="MONEDACOMPROBANTE                       " tabla="ORDPAGO        " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="=goParametros.Felino.Generales.MonedaSistema                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="410" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="MONTOCONCILIAR                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Monto a conciliar                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999999.99           " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="COTIZACION                              " tabla="ORDPAGO        " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="414" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="TOTAL                                   " tabla="ORDPAGO        " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="DEUDA                                   " tabla="ORDPAGO        " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Saldo en cta. cte.                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="PUNTODEVENTACDR                         " tabla="ORDPAGO        " campo="PTOVTACDR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Retención                                                                                                                                                       " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999-9999999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="NUMEROCDR                               " tabla="ORDPAGO        " campo="NUMCDR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Retención                                                                                                                                                       " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999-9999999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="OBS                                     " tabla="ORDPAGO        " campo="FOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Obs.                                                                                                                                                            " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="VUELTO                                  " tabla="ORDPAGO        " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="ANULADO                                 " tabla="ORDPAGO        " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="PROVEEDORDESCRIPCION                    " tabla="ORDPAGO        " campo="FPROVED   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="                                                                                                                                                                " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Proveedor.Nombre                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPAGO                             " atributo="CODIGO                                  " tabla="ORDPAGO        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On ORDPAGO.FPERSON = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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