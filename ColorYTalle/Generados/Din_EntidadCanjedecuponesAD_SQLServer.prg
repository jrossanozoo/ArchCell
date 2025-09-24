
define class Din_EntidadCANJEDECUPONESAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CANJEDECUPONES'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 12, 0)]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.Numero, 12, 0)]
	cTagClaveCandidata = '_CDVCC'
	cTagClavePk = '_CDVPK'
	cTablaPrincipal = 'CANJECUPONES'
	cCampoCodigoWH = 'Codigo'
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
			local  lxCanjecuponesFmodifw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesHoraexpo, lxCanjecuponesFaltafw, lxCanjecuponesHoraimpo, lxCanjecuponesValordet, lxCanjecuponesHaltafw, lxCanjecuponesBdaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesHmodifw, lxCanjecuponesSaltafw, lxCanjecuponesSmodifw, lxCanjecuponesUaltafw, lxCanjecuponesValtafw, lxCanjecuponesVmodifw, lxCanjecuponesDescfw, lxCanjecuponesZadsfw, lxCanjecuponesUmodifw, lxCanjecuponesSigno, lxCanjecuponesValtip, lxCanjecuponesFacttipo, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFmodifw =  .Fechamodificacionfw			lxCanjecuponesFectrans =  .Fechatransferencia			lxCanjecuponesFecexpo =  .Fechaexpo			lxCanjecuponesFecimpo =  .Fechaimpo			lxCanjecuponesHoraexpo =  .Horaexpo			lxCanjecuponesFaltafw =  .Fechaaltafw			lxCanjecuponesHoraimpo =  .Horaimpo			lxCanjecuponesValordet =  .Cuponvalordetalle			lxCanjecuponesHaltafw =  .Horaaltafw			lxCanjecuponesBdaltafw =  .Basededatosaltafw			lxCanjecuponesEsttrans =  .Estadotransferencia			lxCanjecuponesBdmodifw =  .Basededatosmodificacionfw			lxCanjecuponesHmodifw =  .Horamodificacionfw			lxCanjecuponesSaltafw =  .Seriealtafw			lxCanjecuponesSmodifw =  .Seriemodificacionfw			lxCanjecuponesUaltafw =  .Usuarioaltafw			lxCanjecuponesValtafw =  .Versionaltafw			lxCanjecuponesVmodifw =  .Versionmodificacionfw			lxCanjecuponesDescfw =  .Descripcionfw			lxCanjecuponesZadsfw =  .Zadsfw			lxCanjecuponesUmodifw =  .Usuariomodificacionfw			lxCanjecuponesSigno =  .Signodemovimiento			lxCanjecuponesValtip =  .Cuponvalortipo			lxCanjecuponesFacttipo =  .Tipocomprobante			lxCanjecuponesCupon =  upper( .Cupon_PK ) 			lxCanjecuponesIdcaja =  .Cuponidcaja_PK 			lxCanjecuponesCodigo =  .Codigo			lxCanjecuponesMoneda =  upper( .MonedaComprobante_PK ) 			lxCanjecuponesValor =  upper( .CuponValor_PK ) 			lxCanjecuponesFletra =  .Letra			lxCanjecuponesComptipo =  .Cupontipocomprobante			lxCanjecuponesCliente =  upper( .Cliente_PK ) 			lxCanjecuponesObs =  .Obs			lxCanjecuponesFptoven =  .Puntodeventa			lxCanjecuponesLetra =  .Cuponletracomprobante			lxCanjecuponesProveedor =  upper( .Proveedor_PK ) 			lxCanjecuponesNumero =  .Numero			lxCanjecuponesFecha =  .Fecha			lxCanjecuponesPtoven =  .Cuponpuntodeventacomprobante			lxCanjecuponesTipo =  .Cupontipo			lxCanjecuponesConcepto =  upper( .Concepto_PK ) 			lxCanjecuponesNumcomp =  .Cuponnumerocomprobante			lxCanjecuponesNumerocup =  .Cuponnumerocupon			lxCanjecuponesVendedor =  upper( .Vendedor_PK ) 			lxCanjecuponesFechacomp =  .Cuponfechacomprobante			lxCanjecuponesFechacup =  .Cuponfecha			lxCanjecuponesBasedatos =  .Cuponbasededatos			lxCanjecuponesFtotal =  .Total			lxCanjecuponesHora =  .Cuponhora			lxCanjecuponesSerie =  .Cuponserieorigen			lxCanjecuponesMonto =  .Cuponmonto			lxCanjecuponesAnulado =  .Anulado
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCanjecuponesCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CANJECUPONES ( "Fmodifw","Fectrans","Fecexpo","Fecimpo","Horaexpo","Faltafw","Horaimpo","Valordet","Haltafw","Bdaltafw","Esttrans","Bdmodifw","Hmodifw","Saltafw","Smodifw","Ualtafw","Valtafw","Vmodifw","Descfw","Zadsfw","Umodifw","Signo","Valtip","Facttipo","Cupon","Idcaja","Codigo","Moneda","Valor","Fletra","Comptipo","Cliente","Obs","Fptoven","Letra","Proveedor","Numero","Fecha","Ptoven","Tipo","Concepto","Numcomp","Numerocup","Vendedor","Fechacomp","Fechacup","Basedatos","Ftotal","Hora","Serie","Monto","Anulado" ) values ( <<"'" + this.ConvertirDateSql( lxCanjecuponesFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValordet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesUmodifw ) + "'" >>, <<lxCanjecuponesSigno >>, <<lxCanjecuponesValtip >>, <<lxCanjecuponesFacttipo >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCupon ) + "'" >>, <<lxCanjecuponesIdcaja >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesFletra ) + "'" >>, <<lxCanjecuponesComptipo >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesObs ) + "'" >>, <<lxCanjecuponesFptoven >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesProveedor ) + "'" >>, <<lxCanjecuponesNumero >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecha ) + "'" >>, <<lxCanjecuponesPtoven >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesTipo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesConcepto ) + "'" >>, <<lxCanjecuponesNumcomp >>, <<lxCanjecuponesNumerocup >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesVendedor ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBasedatos ) + "'" >>, <<lxCanjecuponesFtotal >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSerie ) + "'" >>, <<lxCanjecuponesMonto >>, <<iif( lxCanjecuponesAnulado, 1, 0 ) >> )
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
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodocumento = loItem.Tipodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNrodocumento = loItem.Nrodocumento
					lxVendedor = loItem.Vendedor
					lxLetra = loItem.Letra
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxAutorizacionpos = loItem.Autorizacionpos
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesDet("FechCoti","JJfecha","IdCaja","NroTarjeta","TipoDoc","TIPCOMP","NroDoc","JJVen","Letra","Cotiza","JJTurno","NroCupon","NumCompr","JJCotiz","NroItem","PtoVenta","JJT","Signo","Autorizado","VisualCaja","CElectro","PersComp","JJNUM","NroCheque","JJCO","NroChProp","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","Montosiste","jrecmntsi","jrrecsperc","guidComp","guidCupon","permvuelto","ValeCambio","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<lxCotiza>>, <<lxNroitem>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxRecargomontosinimpuestos>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresAEnt
				if this.oEntidad.ValoresAEnt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxNumerotarjeta = loItem.Numerotarjeta
					lxCotiza = loItem.Cotiza
					lxSignodemovimiento = loItem.Signodemovimiento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTipo = loItem.Tipo
					lxNroitem = lnContadorNroItem
					lxNumerocupon = loItem.Numerocupon
					lxAutorizacionpos = loItem.Autorizacionpos
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxValor_PK = loItem.Valor_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxLetracomprobante = loItem.Letracomprobante
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxPuntodeventacomprobante = loItem.Puntodeventacomprobante
					lxNrocomprobante = loItem.Nrocomprobante
					lxNumerointerno = loItem.Numerointerno
					lxCupontipo = loItem.Cupontipo
					lxFechacomprobante = loItem.Fechacomprobante
					lxTipocomprobante = loItem.Tipocomprobante
					lxBasededatosorigen = loItem.Basededatosorigen
					lxHora = loItem.Hora
					lxSerieorigen = loItem.Serieorigen
					lxTotal = loItem.Total
					lxMonto = loItem.Monto
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontocupon = loItem.Montocupon
					lxCodigodecupon = loItem.Codigodecupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesEnt("FechCoti","JJfecha","IdCaja","NroTarjeta","JJCotiz","Signo","Cotiza","JJT","NROITEM","NroCupon","Autorizado","CElectro","VisualCaja","JJCO","NroCheque","NroChProp","Codigo","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","Serie","JJTotFac","JJM","Pesos","Montosiste","MonCupon","guidCupon","guidComp","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<lxCotiza>>, <<lxSignodemovimiento>>, <<lxUltimacotizacion>>, <<lxTipo>>, <<lxNroitem>>, <<lxNumerocupon>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetracomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxPuntodeventacomprobante>>, <<lxNrocomprobante>>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupontipo ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerieorigen ) + "'">>, <<lxTotal>>, <<lxMonto>>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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
			local  lxCanjecuponesFmodifw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesHoraexpo, lxCanjecuponesFaltafw, lxCanjecuponesHoraimpo, lxCanjecuponesValordet, lxCanjecuponesHaltafw, lxCanjecuponesBdaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesHmodifw, lxCanjecuponesSaltafw, lxCanjecuponesSmodifw, lxCanjecuponesUaltafw, lxCanjecuponesValtafw, lxCanjecuponesVmodifw, lxCanjecuponesDescfw, lxCanjecuponesZadsfw, lxCanjecuponesUmodifw, lxCanjecuponesSigno, lxCanjecuponesValtip, lxCanjecuponesFacttipo, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFmodifw =  .Fechamodificacionfw			lxCanjecuponesFectrans =  .Fechatransferencia			lxCanjecuponesFecexpo =  .Fechaexpo			lxCanjecuponesFecimpo =  .Fechaimpo			lxCanjecuponesHoraexpo =  .Horaexpo			lxCanjecuponesFaltafw =  .Fechaaltafw			lxCanjecuponesHoraimpo =  .Horaimpo			lxCanjecuponesValordet =  .Cuponvalordetalle			lxCanjecuponesHaltafw =  .Horaaltafw			lxCanjecuponesBdaltafw =  .Basededatosaltafw			lxCanjecuponesEsttrans =  .Estadotransferencia			lxCanjecuponesBdmodifw =  .Basededatosmodificacionfw			lxCanjecuponesHmodifw =  .Horamodificacionfw			lxCanjecuponesSaltafw =  .Seriealtafw			lxCanjecuponesSmodifw =  .Seriemodificacionfw			lxCanjecuponesUaltafw =  .Usuarioaltafw			lxCanjecuponesValtafw =  .Versionaltafw			lxCanjecuponesVmodifw =  .Versionmodificacionfw			lxCanjecuponesDescfw =  .Descripcionfw			lxCanjecuponesZadsfw =  .Zadsfw			lxCanjecuponesUmodifw =  .Usuariomodificacionfw			lxCanjecuponesSigno =  .Signodemovimiento			lxCanjecuponesValtip =  .Cuponvalortipo			lxCanjecuponesFacttipo =  .Tipocomprobante			lxCanjecuponesCupon =  upper( .Cupon_PK ) 			lxCanjecuponesIdcaja =  .Cuponidcaja_PK 			lxCanjecuponesCodigo =  .Codigo			lxCanjecuponesMoneda =  upper( .MonedaComprobante_PK ) 			lxCanjecuponesValor =  upper( .CuponValor_PK ) 			lxCanjecuponesFletra =  .Letra			lxCanjecuponesComptipo =  .Cupontipocomprobante			lxCanjecuponesCliente =  upper( .Cliente_PK ) 			lxCanjecuponesObs =  .Obs			lxCanjecuponesFptoven =  .Puntodeventa			lxCanjecuponesLetra =  .Cuponletracomprobante			lxCanjecuponesProveedor =  upper( .Proveedor_PK ) 			lxCanjecuponesNumero =  .Numero			lxCanjecuponesFecha =  .Fecha			lxCanjecuponesPtoven =  .Cuponpuntodeventacomprobante			lxCanjecuponesTipo =  .Cupontipo			lxCanjecuponesConcepto =  upper( .Concepto_PK ) 			lxCanjecuponesNumcomp =  .Cuponnumerocomprobante			lxCanjecuponesNumerocup =  .Cuponnumerocupon			lxCanjecuponesVendedor =  upper( .Vendedor_PK ) 			lxCanjecuponesFechacomp =  .Cuponfechacomprobante			lxCanjecuponesFechacup =  .Cuponfecha			lxCanjecuponesBasedatos =  .Cuponbasededatos			lxCanjecuponesFtotal =  .Total			lxCanjecuponesHora =  .Cuponhora			lxCanjecuponesSerie =  .Cuponserieorigen			lxCanjecuponesMonto =  .Cuponmonto			lxCanjecuponesAnulado =  .Anulado
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CANJECUPONES set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraimpo ) + "'">>,"Valordet" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValordet ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCanjecuponesEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBdmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesVmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesDescfw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesUmodifw ) + "'">>,"Signo" = <<lxCanjecuponesSigno>>,"Valtip" = <<lxCanjecuponesValtip>>,"Facttipo" = <<lxCanjecuponesFacttipo>>,"Cupon" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCupon ) + "'">>,"Idcaja" = <<lxCanjecuponesIdcaja>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxCanjecuponesMoneda ) + "'">>,"Valor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValor ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxCanjecuponesFletra ) + "'">>,"Comptipo" = <<lxCanjecuponesComptipo>>,"Cliente" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCliente ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCanjecuponesObs ) + "'">>,"Fptoven" = <<lxCanjecuponesFptoven>>,"Letra" = <<"'" + this.FormatearTextoSql( lxCanjecuponesLetra ) + "'">>,"Proveedor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesProveedor ) + "'">>,"Numero" = <<lxCanjecuponesNumero>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecha ) + "'">>,"Ptoven" = <<lxCanjecuponesPtoven>>,"Tipo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesTipo ) + "'">>,"Concepto" = <<"'" + this.FormatearTextoSql( lxCanjecuponesConcepto ) + "'">>,"Numcomp" = <<lxCanjecuponesNumcomp>>,"Numerocup" = <<lxCanjecuponesNumerocup>>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesVendedor ) + "'">>,"Fechacomp" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacomp ) + "'">>,"Fechacup" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacup ) + "'">>,"Basedatos" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBasedatos ) + "'">>,"Ftotal" = <<lxCanjecuponesFtotal>>,"Hora" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHora ) + "'">>,"Serie" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSerie ) + "'">>,"Monto" = <<lxCanjecuponesMonto>>,"Anulado" = <<iif( lxCanjecuponesAnulado, 1, 0 )>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">> and  CANJECUPONES.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CanjeCuponesDet where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CanjeCuponesEnt where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodocumento = loItem.Tipodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNrodocumento = loItem.Nrodocumento
					lxVendedor = loItem.Vendedor
					lxLetra = loItem.Letra
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxAutorizacionpos = loItem.Autorizacionpos
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesDet("FechCoti","JJfecha","IdCaja","NroTarjeta","TipoDoc","TIPCOMP","NroDoc","JJVen","Letra","Cotiza","JJTurno","NroCupon","NumCompr","JJCotiz","NroItem","PtoVenta","JJT","Signo","Autorizado","VisualCaja","CElectro","PersComp","JJNUM","NroCheque","JJCO","NroChProp","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","Montosiste","jrecmntsi","jrrecsperc","guidComp","guidCupon","permvuelto","ValeCambio","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<lxCotiza>>, <<lxNroitem>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxRecargomontosinimpuestos>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresAEnt
				if this.oEntidad.ValoresAEnt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxNumerotarjeta = loItem.Numerotarjeta
					lxCotiza = loItem.Cotiza
					lxSignodemovimiento = loItem.Signodemovimiento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTipo = loItem.Tipo
					lxNroitem = lnContadorNroItem
					lxNumerocupon = loItem.Numerocupon
					lxAutorizacionpos = loItem.Autorizacionpos
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxValor_PK = loItem.Valor_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxLetracomprobante = loItem.Letracomprobante
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxPuntodeventacomprobante = loItem.Puntodeventacomprobante
					lxNrocomprobante = loItem.Nrocomprobante
					lxNumerointerno = loItem.Numerointerno
					lxCupontipo = loItem.Cupontipo
					lxFechacomprobante = loItem.Fechacomprobante
					lxTipocomprobante = loItem.Tipocomprobante
					lxBasededatosorigen = loItem.Basededatosorigen
					lxHora = loItem.Hora
					lxSerieorigen = loItem.Serieorigen
					lxTotal = loItem.Total
					lxMonto = loItem.Monto
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontocupon = loItem.Montocupon
					lxCodigodecupon = loItem.Codigodecupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesEnt("FechCoti","JJfecha","IdCaja","NroTarjeta","JJCotiz","Signo","Cotiza","JJT","NROITEM","NroCupon","Autorizado","CElectro","VisualCaja","JJCO","NroCheque","NroChProp","Codigo","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","Serie","JJTotFac","JJM","Pesos","Montosiste","MonCupon","guidCupon","guidComp","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<lxCotiza>>, <<lxSignodemovimiento>>, <<lxUltimacotizacion>>, <<lxTipo>>, <<lxNroitem>>, <<lxNumerocupon>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetracomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxPuntodeventacomprobante>>, <<lxNrocomprobante>>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupontipo ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerieorigen ) + "'">>, <<lxTotal>>, <<lxMonto>>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CANJECUPONES where " + this.ConvertirFuncionesSql( " CANJECUPONES.CODIGO != ''" ) )
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
			Local lxCanjecuponesCodigo
			lxCanjecuponesCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Valordet" as "Cuponvalordetalle", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Signo" as "Signodemovimiento", "Valtip" as "Cuponvalortipo", "Facttipo" as "Tipocomprobante", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where "Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">> and  CANJECUPONES.CODIGO != ''
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )

			if reccount( 'c_CANJEDECUPONES' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrodoc" as "Nrodocumento", "Jjven" as "Vendedor", "Letra" as "Letra", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Autorizado" as "Autorizacionpos", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Jjcotiz" as "Cotiza", "Signo" as "Signodemovimiento", "Cotiza" as "Ultimacotizacion", "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Jjco" as "Valor", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Codigo" as "Codigo", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Serie" as "Serieorigen", "Jjtotfac" as "Total", "Jjm" as "Monto", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcupon" as "Codigodecupon", "Guidcomp" as "Iditemcomponente", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCanjeCuponesFACTTIPO As Variant, lxCanjeCuponesFLETRA As Variant, lxCanjeCuponesFPTOVEN As Variant, lxCanjeCuponesNumero As Variant
			lxCanjeCuponesFACTTIPO = .TipoComprobante
			lxCanjeCuponesFLETRA = .Letra
			lxCanjeCuponesFPTOVEN = .PuntoDeVenta
			lxCanjeCuponesNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Valordet" as "Cuponvalordetalle", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Signo" as "Signodemovimiento", "Valtip" as "Cuponvalortipo", "Facttipo" as "Tipocomprobante", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != '' And FACTTIPO = <<lxCanjeCuponesFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxCanjeCuponesFLETRA ) + "'">> and FPTOVEN = <<lxCanjeCuponesFPTOVEN>> and Numero = <<lxCanjeCuponesNumero>>
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			if reccount( 'c_CANJEDECUPONES' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrodoc" as "Nrodocumento", "Jjven" as "Vendedor", "Letra" as "Letra", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Autorizado" as "Autorizacionpos", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Jjcotiz" as "Cotiza", "Signo" as "Signodemovimiento", "Cotiza" as "Ultimacotizacion", "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Jjco" as "Valor", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Codigo" as "Codigo", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Serie" as "Serieorigen", "Jjtotfac" as "Total", "Jjm" as "Monto", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcupon" as "Codigodecupon", "Guidcomp" as "Iditemcomponente", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCanjecuponesCodigo as Variant
		llRetorno = .t.
		lxCanjecuponesCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CANJECUPONES where "Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">> and  CANJECUPONES.CODIGO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Valordet" as "Cuponvalordetalle", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Signo" as "Signodemovimiento", "Valtip" as "Cuponvalortipo", "Facttipo" as "Tipocomprobante", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != '' order by FAltaFW,HAltaFW,Codigo
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrodoc" as "Nrodocumento", "Jjven" as "Vendedor", "Letra" as "Letra", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Autorizado" as "Autorizacionpos", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Jjcotiz" as "Cotiza", "Signo" as "Signodemovimiento", "Cotiza" as "Ultimacotizacion", "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Jjco" as "Valor", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Codigo" as "Codigo", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Serie" as "Serieorigen", "Jjtotfac" as "Total", "Jjm" as "Monto", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcupon" as "Codigodecupon", "Guidcomp" as "Iditemcomponente", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Valordet" as "Cuponvalordetalle", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Signo" as "Signodemovimiento", "Valtip" as "Cuponvalortipo", "Facttipo" as "Tipocomprobante", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CANJECUPONES.CODIGO != '' order by FAltaFW,HAltaFW,Codigo
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrodoc" as "Nrodocumento", "Jjven" as "Vendedor", "Letra" as "Letra", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Autorizado" as "Autorizacionpos", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Jjcotiz" as "Cotiza", "Signo" as "Signodemovimiento", "Cotiza" as "Ultimacotizacion", "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Jjco" as "Valor", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Codigo" as "Codigo", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Serie" as "Serieorigen", "Jjtotfac" as "Total", "Jjm" as "Monto", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcupon" as "Codigodecupon", "Guidcomp" as "Iditemcomponente", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Valordet" as "Cuponvalordetalle", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Signo" as "Signodemovimiento", "Valtip" as "Cuponvalortipo", "Facttipo" as "Tipocomprobante", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CANJECUPONES.CODIGO != '' order by FAltaFW desc,HAltaFW desc,Codigo desc
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrodoc" as "Nrodocumento", "Jjven" as "Vendedor", "Letra" as "Letra", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Autorizado" as "Autorizacionpos", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Jjcotiz" as "Cotiza", "Signo" as "Signodemovimiento", "Cotiza" as "Ultimacotizacion", "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Jjco" as "Valor", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Codigo" as "Codigo", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Serie" as "Serieorigen", "Jjtotfac" as "Total", "Jjm" as "Monto", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcupon" as "Codigodecupon", "Guidcomp" as "Iditemcomponente", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Valordet" as "Cuponvalordetalle", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Signo" as "Signodemovimiento", "Valtip" as "Cuponvalortipo", "Facttipo" as "Tipocomprobante", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado" from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != '' order by FAltaFW desc,HAltaFW desc,Codigo desc
			endtext
			use in select('c_CANJEDECUPONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CANJEDECUPONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrodoc" as "Nrodocumento", "Jjven" as "Vendedor", "Letra" as "Letra", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Autorizado" as "Autorizacionpos", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesDet where JJNUM = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Jjcotiz" as "Cotiza", "Signo" as "Signodemovimiento", "Cotiza" as "Ultimacotizacion", "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Jjco" as "Valor", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Codigo" as "Codigo", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Serie" as "Serieorigen", "Jjtotfac" as "Total", "Jjm" as "Monto", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcupon" as "Codigodecupon", "Guidcomp" as "Iditemcomponente", "Cupon" as "Cupon" from ZooLogic.CanjeCuponesEnt where Codigo = <<"'" + this.FormatearTextoSql( c_CANJEDECUPONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresAEnt')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresAEnt', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresAEnt
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecexpo,Fecimpo,Horaexpo,Faltafw,Horaimpo,Valordet,Haltafw,Bdaltafw,Esttran" + ;
"s,Bdmodifw,Hmodifw,Saltafw,Smodifw,Ualtafw,Valtafw,Vmodifw,Descfw,Zadsfw,Umodifw,Signo,Valtip,Factti" + ;
"po,Cupon,Idcaja,Codigo,Moneda,Valor,Fletra,Comptipo,Cliente,Obs,Fptoven,Letra,Proveedor,Numero,Fecha" + ;
",Ptoven,Tipo,Concepto,Numcomp,Numerocup,Vendedor,Fechacomp,Fechacup,Basedatos,Ftotal,Hora,Serie,Mont" + ;
"o,Anulado" + ;
" from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != '' and " + lcFiltro )
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
			local  lxCanjecuponesFmodifw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesHoraexpo, lxCanjecuponesFaltafw, lxCanjecuponesHoraimpo, lxCanjecuponesValordet, lxCanjecuponesHaltafw, lxCanjecuponesBdaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesHmodifw, lxCanjecuponesSaltafw, lxCanjecuponesSmodifw, lxCanjecuponesUaltafw, lxCanjecuponesValtafw, lxCanjecuponesVmodifw, lxCanjecuponesDescfw, lxCanjecuponesZadsfw, lxCanjecuponesUmodifw, lxCanjecuponesSigno, lxCanjecuponesValtip, lxCanjecuponesFacttipo, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFmodifw = ctod( '  /  /    ' )			lxCanjecuponesFectrans = ctod( '  /  /    ' )			lxCanjecuponesFecexpo = ctod( '  /  /    ' )			lxCanjecuponesFecimpo = ctod( '  /  /    ' )			lxCanjecuponesHoraexpo = []			lxCanjecuponesFaltafw = ctod( '  /  /    ' )			lxCanjecuponesHoraimpo = []			lxCanjecuponesValordet = []			lxCanjecuponesHaltafw = []			lxCanjecuponesBdaltafw = []			lxCanjecuponesEsttrans = []			lxCanjecuponesBdmodifw = []			lxCanjecuponesHmodifw = []			lxCanjecuponesSaltafw = []			lxCanjecuponesSmodifw = []			lxCanjecuponesUaltafw = []			lxCanjecuponesValtafw = []			lxCanjecuponesVmodifw = []			lxCanjecuponesDescfw = []			lxCanjecuponesZadsfw = []			lxCanjecuponesUmodifw = []			lxCanjecuponesSigno = 0			lxCanjecuponesValtip = 0			lxCanjecuponesFacttipo = 0			lxCanjecuponesCupon = []			lxCanjecuponesIdcaja = 0			lxCanjecuponesCodigo = []			lxCanjecuponesMoneda = []			lxCanjecuponesValor = []			lxCanjecuponesFletra = []			lxCanjecuponesComptipo = 0			lxCanjecuponesCliente = []			lxCanjecuponesObs = []			lxCanjecuponesFptoven = 0			lxCanjecuponesLetra = []			lxCanjecuponesProveedor = []			lxCanjecuponesNumero = 0			lxCanjecuponesFecha = ctod( '  /  /    ' )			lxCanjecuponesPtoven = 0			lxCanjecuponesTipo = []			lxCanjecuponesConcepto = []			lxCanjecuponesNumcomp = 0			lxCanjecuponesNumerocup = 0			lxCanjecuponesVendedor = []			lxCanjecuponesFechacomp = ctod( '  /  /    ' )			lxCanjecuponesFechacup = ctod( '  /  /    ' )			lxCanjecuponesBasedatos = []			lxCanjecuponesFtotal = 0			lxCanjecuponesHora = []			lxCanjecuponesSerie = []			lxCanjecuponesMonto = 0			lxCanjecuponesAnulado = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CanjeCuponesDet where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CanjeCuponesEnt where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CANJECUPONES where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CANJECUPONES' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CANJECUPONES.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Valordet" as "Cuponvalordetalle", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Signo" as "Signodemovimiento", "Valtip" as "Cuponvalortipo", "Facttipo" as "Tipocomprobante", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CANJECUPONES', '', tnTope )
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
		lcWhere = " Where  CANJECUPONESDET.JJNUM != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrodoc" as "Nrodocumento", "Jjven" as "Vendedor", "Letra" as "Letra", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Autorizado" as "Autorizacionpos", "Visualcaja" as "Visualizarenestadodecaja", "Celectro" as "Chequeelectronico", "Perscomp" as "Personalizarcomprobante", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Jjco" as "Valor", "Nrochprop" as "Numerochequepropio", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Jrecmntsi" as "Recargomontosinimpuestos", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleValoresDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CanjeCuponesDet', 'ValoresDetalle', tnTope )
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
	Function ObtenerDatosDetalleValoresAEnt( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CANJECUPONESENT.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Nrotarjeta" as "Numerotarjeta", "Jjcotiz" as "Cotiza", "Signo" as "Signodemovimiento", "Cotiza" as "Ultimacotizacion", "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Nrocupon" as "Numerocupon", "Autorizado" as "Autorizacionpos", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Jjco" as "Valor", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Codigo" as "Codigo", "Letra" as "Letracomprobante", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Ptoven" as "Puntodeventacomprobante", "Numcompr" as "Nrocomprobante", "Nrointerno" as "Numerointerno", "Tipo" as "Cupontipo", "Fechacomp" as "Fechacomprobante", "Tipcomp" as "Tipocomprobante", "Basedatos" as "Basededatosorigen", "Hora" as "Hora", "Serie" as "Serieorigen", "Jjtotfac" as "Total", "Jjm" as "Monto", "Pesos" as "Pesosalcambio", "Montosiste" as "Montoamonedasistema", "Moncupon" as "Montocupon", "Guidcupon" as "Codigodecupon", "Guidcomp" as "Iditemcomponente", "Cupon" as "Cupon"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleValoresAEnt( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CanjeCuponesEnt', 'ValoresAEnt', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleValoresAEnt( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleValoresAEnt( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'CUPONVALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORDET AS CUPONVALORDETALLE'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'CUPONVALORTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTIP AS CUPONVALORTIPO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'CUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUPON AS CUPON'
				Case lcAtributo == 'CUPONIDCAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CUPONIDCAJA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'CUPONVALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS CUPONVALOR'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'CUPONTIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPTIPO AS CUPONTIPOCOMPROBANTE'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'CUPONLETRACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS CUPONLETRACOMPROBANTE'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDOR AS PROVEEDOR'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'CUPONPUNTODEVENTACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVEN AS CUPONPUNTODEVENTACOMPROBANTE'
				Case lcAtributo == 'CUPONTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS CUPONTIPO'
				Case lcAtributo == 'CONCEPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTO AS CONCEPTO'
				Case lcAtributo == 'CUPONNUMEROCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMP AS CUPONNUMEROCOMPROBANTE'
				Case lcAtributo == 'CUPONNUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMEROCUP AS CUPONNUMEROCUPON'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'CUPONFECHACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACOMP AS CUPONFECHACOMPROBANTE'
				Case lcAtributo == 'CUPONFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACUP AS CUPONFECHA'
				Case lcAtributo == 'CUPONBASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDATOS AS CUPONBASEDEDATOS'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'CUPONHORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS CUPONHORA'
				Case lcAtributo == 'CUPONSERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS CUPONSERIEORIGEN'
				Case lcAtributo == 'CUPONMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS CUPONMONTO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
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
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJVEN AS VENDEDOR'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTURNO AS TURNO'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'SIGNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNO'
				Case lcAtributo == 'AUTORIZACIONPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTORIZADO AS AUTORIZACIONPOS'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJNUM AS CODIGO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCO AS VALOR'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
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
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'MONTOAMONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOSISTE AS MONTOAMONEDASISTEMA'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECMNTSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOSINPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRRECSPERC AS RECARGOSINPERCEPCIONES'
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
	Function ObtenerCamposSelectDetalleValoresAEnt( tcCampos As String ) As String
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
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'AUTORIZACIONPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTORIZADO AS AUTORIZACIONPOS'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCO AS VALOR'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'LETRACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRACOMPROBANTE'
				Case lcAtributo == 'VALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJDE AS VALORDETALLE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJFE AS FECHA'
				Case lcAtributo == 'PUNTODEVENTACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVEN AS PUNTODEVENTACOMPROBANTE'
				Case lcAtributo == 'NROCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NROCOMPROBANTE'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROINTERNO AS NUMEROINTERNO'
				Case lcAtributo == 'CUPONTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS CUPONTIPO'
				Case lcAtributo == 'FECHACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACOMP AS FECHACOMPROBANTE'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'BASEDEDATOSORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDATOS AS BASEDEDATOSORIGEN'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'SERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS SERIEORIGEN'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTOTFAC AS TOTAL'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJM AS MONTO'
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'MONTOAMONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOSISTE AS MONTOAMONEDASISTEMA'
				Case lcAtributo == 'MONTOCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONCUPON AS MONTOCUPON'
				Case lcAtributo == 'CODIGODECUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCUPON AS CODIGODECUPON'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
				Case lcAtributo == 'CUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUPON AS CUPON'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONVALORDETALLE'
				lcCampo = 'VALORDET'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONVALORTIPO'
				lcCampo = 'VALTIP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CUPON'
				lcCampo = 'CUPON'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONIDCAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONVALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONTIPOCOMPROBANTE'
				lcCampo = 'COMPTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONLETRACOMPROBANTE'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROVEEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONPUNTODEVENTACOMPROBANTE'
				lcCampo = 'PTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONTIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTO'
				lcCampo = 'CONCEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONNUMEROCOMPROBANTE'
				lcCampo = 'NUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONNUMEROCUPON'
				lcCampo = 'NUMEROCUP'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONFECHACOMPROBANTE'
				lcCampo = 'FECHACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONFECHA'
				lcCampo = 'FECHACUP'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONBASEDEDATOS'
				lcCampo = 'BASEDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONHORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONSERIEORIGEN'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONMONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'TIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'NRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'JJVEN'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'JJTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONPOS'
				lcCampo = 'AUTORIZADO'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'JJNUM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'JJCO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
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
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOAMONEDASISTEMA'
				lcCampo = 'MONTOSISTE'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'JRECMNTSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOSINPERCEPCIONES'
				lcCampo = 'JRRECSPERC'
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
	Function ObtenerCampoDetalleValoresAEnt( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTCOTIZACION'
				lcCampo = 'FECHCOTI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMP'
				lcCampo = 'JJFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONPOS'
				lcCampo = 'AUTORIZADO'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'JJCO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRACOMPROBANTE'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDETALLE'
				lcCampo = 'JJDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'JJFE'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTACOMPROBANTE'
				lcCampo = 'PTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NROCOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NROINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'CUPONTIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTE'
				lcCampo = 'FECHACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSORIGEN'
				lcCampo = 'BASEDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEORIGEN'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'JJTOTFAC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'JJM'
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOAMONEDASISTEMA'
				lcCampo = 'MONTOSISTE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCUPON'
				lcCampo = 'MONCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGODECUPON'
				lcCampo = 'GUIDCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CUPON'
				lcCampo = 'CUPON'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'VALORESDETALLE'
			lcRetorno = 'CANJECUPONESDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'VALORESAENT'
			lcRetorno = 'CANJECUPONESENT'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCanjecuponesFmodifw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesHoraexpo, lxCanjecuponesFaltafw, lxCanjecuponesHoraimpo, lxCanjecuponesValordet, lxCanjecuponesHaltafw, lxCanjecuponesBdaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesHmodifw, lxCanjecuponesSaltafw, lxCanjecuponesSmodifw, lxCanjecuponesUaltafw, lxCanjecuponesValtafw, lxCanjecuponesVmodifw, lxCanjecuponesDescfw, lxCanjecuponesZadsfw, lxCanjecuponesUmodifw, lxCanjecuponesSigno, lxCanjecuponesValtip, lxCanjecuponesFacttipo, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFmodifw =  .Fechamodificacionfw			lxCanjecuponesFectrans =  .Fechatransferencia			lxCanjecuponesFecexpo =  .Fechaexpo			lxCanjecuponesFecimpo =  .Fechaimpo			lxCanjecuponesHoraexpo =  .Horaexpo			lxCanjecuponesFaltafw =  .Fechaaltafw			lxCanjecuponesHoraimpo =  .Horaimpo			lxCanjecuponesValordet =  .Cuponvalordetalle			lxCanjecuponesHaltafw =  .Horaaltafw			lxCanjecuponesBdaltafw =  .Basededatosaltafw			lxCanjecuponesEsttrans =  .Estadotransferencia			lxCanjecuponesBdmodifw =  .Basededatosmodificacionfw			lxCanjecuponesHmodifw =  .Horamodificacionfw			lxCanjecuponesSaltafw =  .Seriealtafw			lxCanjecuponesSmodifw =  .Seriemodificacionfw			lxCanjecuponesUaltafw =  .Usuarioaltafw			lxCanjecuponesValtafw =  .Versionaltafw			lxCanjecuponesVmodifw =  .Versionmodificacionfw			lxCanjecuponesDescfw =  .Descripcionfw			lxCanjecuponesZadsfw =  .Zadsfw			lxCanjecuponesUmodifw =  .Usuariomodificacionfw			lxCanjecuponesSigno =  .Signodemovimiento			lxCanjecuponesValtip =  .Cuponvalortipo			lxCanjecuponesFacttipo =  .Tipocomprobante			lxCanjecuponesCupon =  upper( .Cupon_PK ) 			lxCanjecuponesIdcaja =  .Cuponidcaja_PK 			lxCanjecuponesCodigo =  .Codigo			lxCanjecuponesMoneda =  upper( .MonedaComprobante_PK ) 			lxCanjecuponesValor =  upper( .CuponValor_PK ) 			lxCanjecuponesFletra =  .Letra			lxCanjecuponesComptipo =  .Cupontipocomprobante			lxCanjecuponesCliente =  upper( .Cliente_PK ) 			lxCanjecuponesObs =  .Obs			lxCanjecuponesFptoven =  .Puntodeventa			lxCanjecuponesLetra =  .Cuponletracomprobante			lxCanjecuponesProveedor =  upper( .Proveedor_PK ) 			lxCanjecuponesNumero =  .Numero			lxCanjecuponesFecha =  .Fecha			lxCanjecuponesPtoven =  .Cuponpuntodeventacomprobante			lxCanjecuponesTipo =  .Cupontipo			lxCanjecuponesConcepto =  upper( .Concepto_PK ) 			lxCanjecuponesNumcomp =  .Cuponnumerocomprobante			lxCanjecuponesNumerocup =  .Cuponnumerocupon			lxCanjecuponesVendedor =  upper( .Vendedor_PK ) 			lxCanjecuponesFechacomp =  .Cuponfechacomprobante			lxCanjecuponesFechacup =  .Cuponfecha			lxCanjecuponesBasedatos =  .Cuponbasededatos			lxCanjecuponesFtotal =  .Total			lxCanjecuponesHora =  .Cuponhora			lxCanjecuponesSerie =  .Cuponserieorigen			lxCanjecuponesMonto =  .Cuponmonto			lxCanjecuponesAnulado =  .Anulado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CANJECUPONES ( "Fmodifw","Fectrans","Fecexpo","Fecimpo","Horaexpo","Faltafw","Horaimpo","Valordet","Haltafw","Bdaltafw","Esttrans","Bdmodifw","Hmodifw","Saltafw","Smodifw","Ualtafw","Valtafw","Vmodifw","Descfw","Zadsfw","Umodifw","Signo","Valtip","Facttipo","Cupon","Idcaja","Codigo","Moneda","Valor","Fletra","Comptipo","Cliente","Obs","Fptoven","Letra","Proveedor","Numero","Fecha","Ptoven","Tipo","Concepto","Numcomp","Numerocup","Vendedor","Fechacomp","Fechacup","Basedatos","Ftotal","Hora","Serie","Monto","Anulado" ) values ( <<"'" + this.ConvertirDateSql( lxCanjecuponesFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValordet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesUmodifw ) + "'" >>, <<lxCanjecuponesSigno >>, <<lxCanjecuponesValtip >>, <<lxCanjecuponesFacttipo >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCupon ) + "'" >>, <<lxCanjecuponesIdcaja >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesValor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesFletra ) + "'" >>, <<lxCanjecuponesComptipo >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesObs ) + "'" >>, <<lxCanjecuponesFptoven >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesProveedor ) + "'" >>, <<lxCanjecuponesNumero >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFecha ) + "'" >>, <<lxCanjecuponesPtoven >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesTipo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesConcepto ) + "'" >>, <<lxCanjecuponesNumcomp >>, <<lxCanjecuponesNumerocup >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesVendedor ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesBasedatos ) + "'" >>, <<lxCanjecuponesFtotal >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCanjecuponesSerie ) + "'" >>, <<lxCanjecuponesMonto >>, <<iif( lxCanjecuponesAnulado, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'CANJECUPONES' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodocumento = loItem.Tipodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNrodocumento = loItem.Nrodocumento
					lxVendedor = loItem.Vendedor
					lxLetra = loItem.Letra
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxAutorizacionpos = loItem.Autorizacionpos
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesDet("FechCoti","JJfecha","IdCaja","NroTarjeta","TipoDoc","TIPCOMP","NroDoc","JJVen","Letra","Cotiza","JJTurno","NroCupon","NumCompr","JJCotiz","NroItem","PtoVenta","JJT","Signo","Autorizado","VisualCaja","CElectro","PersComp","JJNUM","NroCheque","JJCO","NroChProp","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","Montosiste","jrecmntsi","jrrecsperc","guidComp","guidCupon","permvuelto","ValeCambio","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<lxCotiza>>, <<lxNroitem>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxRecargomontosinimpuestos>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresAEnt
				if this.oEntidad.ValoresAEnt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxNumerotarjeta = loItem.Numerotarjeta
					lxCotiza = loItem.Cotiza
					lxSignodemovimiento = loItem.Signodemovimiento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTipo = loItem.Tipo
					lxNroitem = lnContadorNroItem
					lxNumerocupon = loItem.Numerocupon
					lxAutorizacionpos = loItem.Autorizacionpos
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxValor_PK = loItem.Valor_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxLetracomprobante = loItem.Letracomprobante
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxPuntodeventacomprobante = loItem.Puntodeventacomprobante
					lxNrocomprobante = loItem.Nrocomprobante
					lxNumerointerno = loItem.Numerointerno
					lxCupontipo = loItem.Cupontipo
					lxFechacomprobante = loItem.Fechacomprobante
					lxTipocomprobante = loItem.Tipocomprobante
					lxBasededatosorigen = loItem.Basededatosorigen
					lxHora = loItem.Hora
					lxSerieorigen = loItem.Serieorigen
					lxTotal = loItem.Total
					lxMonto = loItem.Monto
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontocupon = loItem.Montocupon
					lxCodigodecupon = loItem.Codigodecupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesEnt("FechCoti","JJfecha","IdCaja","NroTarjeta","JJCotiz","Signo","Cotiza","JJT","NROITEM","NroCupon","Autorizado","CElectro","VisualCaja","JJCO","NroCheque","NroChProp","Codigo","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","Serie","JJTotFac","JJM","Pesos","Montosiste","MonCupon","guidCupon","guidComp","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<lxCotiza>>, <<lxSignodemovimiento>>, <<lxUltimacotizacion>>, <<lxTipo>>, <<lxNroitem>>, <<lxNumerocupon>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxLetracomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxPuntodeventacomprobante>>, <<lxNrocomprobante>>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupontipo ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerieorigen ) + "'">>, <<lxTotal>>, <<lxMonto>>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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
			local  lxCanjecuponesFmodifw, lxCanjecuponesFectrans, lxCanjecuponesFecexpo, lxCanjecuponesFecimpo, lxCanjecuponesHoraexpo, lxCanjecuponesFaltafw, lxCanjecuponesHoraimpo, lxCanjecuponesValordet, lxCanjecuponesHaltafw, lxCanjecuponesBdaltafw, lxCanjecuponesEsttrans, lxCanjecuponesBdmodifw, lxCanjecuponesHmodifw, lxCanjecuponesSaltafw, lxCanjecuponesSmodifw, lxCanjecuponesUaltafw, lxCanjecuponesValtafw, lxCanjecuponesVmodifw, lxCanjecuponesDescfw, lxCanjecuponesZadsfw, lxCanjecuponesUmodifw, lxCanjecuponesSigno, lxCanjecuponesValtip, lxCanjecuponesFacttipo, lxCanjecuponesCupon, lxCanjecuponesIdcaja, lxCanjecuponesCodigo, lxCanjecuponesMoneda, lxCanjecuponesValor, lxCanjecuponesFletra, lxCanjecuponesComptipo, lxCanjecuponesCliente, lxCanjecuponesObs, lxCanjecuponesFptoven, lxCanjecuponesLetra, lxCanjecuponesProveedor, lxCanjecuponesNumero, lxCanjecuponesFecha, lxCanjecuponesPtoven, lxCanjecuponesTipo, lxCanjecuponesConcepto, lxCanjecuponesNumcomp, lxCanjecuponesNumerocup, lxCanjecuponesVendedor, lxCanjecuponesFechacomp, lxCanjecuponesFechacup, lxCanjecuponesBasedatos, lxCanjecuponesFtotal, lxCanjecuponesHora, lxCanjecuponesSerie, lxCanjecuponesMonto, lxCanjecuponesAnulado
				lxCanjecuponesFmodifw =  .Fechamodificacionfw			lxCanjecuponesFectrans =  .Fechatransferencia			lxCanjecuponesFecexpo =  .Fechaexpo			lxCanjecuponesFecimpo =  .Fechaimpo			lxCanjecuponesHoraexpo =  .Horaexpo			lxCanjecuponesFaltafw =  .Fechaaltafw			lxCanjecuponesHoraimpo =  .Horaimpo			lxCanjecuponesValordet =  .Cuponvalordetalle			lxCanjecuponesHaltafw =  .Horaaltafw			lxCanjecuponesBdaltafw =  .Basededatosaltafw			lxCanjecuponesEsttrans =  .Estadotransferencia			lxCanjecuponesBdmodifw =  .Basededatosmodificacionfw			lxCanjecuponesHmodifw =  .Horamodificacionfw			lxCanjecuponesSaltafw =  .Seriealtafw			lxCanjecuponesSmodifw =  .Seriemodificacionfw			lxCanjecuponesUaltafw =  .Usuarioaltafw			lxCanjecuponesValtafw =  .Versionaltafw			lxCanjecuponesVmodifw =  .Versionmodificacionfw			lxCanjecuponesDescfw =  .Descripcionfw			lxCanjecuponesZadsfw =  .Zadsfw			lxCanjecuponesUmodifw =  .Usuariomodificacionfw			lxCanjecuponesSigno =  .Signodemovimiento			lxCanjecuponesValtip =  .Cuponvalortipo			lxCanjecuponesFacttipo =  .Tipocomprobante			lxCanjecuponesCupon =  upper( .Cupon_PK ) 			lxCanjecuponesIdcaja =  .Cuponidcaja_PK 			lxCanjecuponesCodigo =  .Codigo			lxCanjecuponesMoneda =  upper( .MonedaComprobante_PK ) 			lxCanjecuponesValor =  upper( .CuponValor_PK ) 			lxCanjecuponesFletra =  .Letra			lxCanjecuponesComptipo =  .Cupontipocomprobante			lxCanjecuponesCliente =  upper( .Cliente_PK ) 			lxCanjecuponesObs =  .Obs			lxCanjecuponesFptoven =  .Puntodeventa			lxCanjecuponesLetra =  .Cuponletracomprobante			lxCanjecuponesProveedor =  upper( .Proveedor_PK ) 			lxCanjecuponesNumero =  .Numero			lxCanjecuponesFecha =  .Fecha			lxCanjecuponesPtoven =  .Cuponpuntodeventacomprobante			lxCanjecuponesTipo =  .Cupontipo			lxCanjecuponesConcepto =  upper( .Concepto_PK ) 			lxCanjecuponesNumcomp =  .Cuponnumerocomprobante			lxCanjecuponesNumerocup =  .Cuponnumerocupon			lxCanjecuponesVendedor =  upper( .Vendedor_PK ) 			lxCanjecuponesFechacomp =  .Cuponfechacomprobante			lxCanjecuponesFechacup =  .Cuponfecha			lxCanjecuponesBasedatos =  .Cuponbasededatos			lxCanjecuponesFtotal =  .Total			lxCanjecuponesHora =  .Cuponhora			lxCanjecuponesSerie =  .Cuponserieorigen			lxCanjecuponesMonto =  .Cuponmonto			lxCanjecuponesAnulado =  .Anulado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CANJECUPONES.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CANJECUPONES set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHoraimpo ) + "'">>, "Valordet" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValordet ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCanjecuponesEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBdmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesVmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesDescfw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCanjecuponesUmodifw ) + "'">>, "Signo" = <<lxCanjecuponesSigno>>, "Valtip" = <<lxCanjecuponesValtip>>, "Facttipo" = <<lxCanjecuponesFacttipo>>, "Cupon" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCupon ) + "'">>, "Idcaja" = <<lxCanjecuponesIdcaja>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCodigo ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxCanjecuponesMoneda ) + "'">>, "Valor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesValor ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxCanjecuponesFletra ) + "'">>, "Comptipo" = <<lxCanjecuponesComptipo>>, "Cliente" = <<"'" + this.FormatearTextoSql( lxCanjecuponesCliente ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCanjecuponesObs ) + "'">>, "Fptoven" = <<lxCanjecuponesFptoven>>, "Letra" = <<"'" + this.FormatearTextoSql( lxCanjecuponesLetra ) + "'">>, "Proveedor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesProveedor ) + "'">>, "Numero" = <<lxCanjecuponesNumero>>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFecha ) + "'">>, "Ptoven" = <<lxCanjecuponesPtoven>>, "Tipo" = <<"'" + this.FormatearTextoSql( lxCanjecuponesTipo ) + "'">>, "Concepto" = <<"'" + this.FormatearTextoSql( lxCanjecuponesConcepto ) + "'">>, "Numcomp" = <<lxCanjecuponesNumcomp>>, "Numerocup" = <<lxCanjecuponesNumerocup>>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxCanjecuponesVendedor ) + "'">>, "Fechacomp" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacomp ) + "'">>, "Fechacup" = <<"'" + this.ConvertirDateSql( lxCanjecuponesFechacup ) + "'">>, "Basedatos" = <<"'" + this.FormatearTextoSql( lxCanjecuponesBasedatos ) + "'">>, "Ftotal" = <<lxCanjecuponesFtotal>>, "Hora" = <<"'" + this.FormatearTextoSql( lxCanjecuponesHora ) + "'">>, "Serie" = <<"'" + this.FormatearTextoSql( lxCanjecuponesSerie ) + "'">>, "Monto" = <<lxCanjecuponesMonto>>, "Anulado" = <<iif( lxCanjecuponesAnulado, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CANJECUPONES' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CanjeCuponesDet where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CanjeCuponesEnt where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxNumerotarjeta = loItem.Numerotarjeta
					lxTipodocumento = loItem.Tipodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNrodocumento = loItem.Nrodocumento
					lxVendedor = loItem.Vendedor
					lxLetra = loItem.Letra
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxAutorizacionpos = loItem.Autorizacionpos
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxChequeelectronico = loItem.Chequeelectronico
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesDet("FechCoti","JJfecha","IdCaja","NroTarjeta","TipoDoc","TIPCOMP","NroDoc","JJVen","Letra","Cotiza","JJTurno","NroCupon","NumCompr","JJCotiz","NroItem","PtoVenta","JJT","Signo","Autorizado","VisualCaja","CElectro","PersComp","JJNUM","NroCheque","JJCO","NroChProp","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","Montosiste","jrecmntsi","jrrecsperc","guidComp","guidCupon","permvuelto","ValeCambio","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<lxCotiza>>, <<lxNroitem>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxRecargomontosinimpuestos>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresAEnt
				if this.oEntidad.ValoresAEnt.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxNumerotarjeta = loItem.Numerotarjeta
					lxCotiza = loItem.Cotiza
					lxSignodemovimiento = loItem.Signodemovimiento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTipo = loItem.Tipo
					lxNroitem = lnContadorNroItem
					lxNumerocupon = loItem.Numerocupon
					lxAutorizacionpos = loItem.Autorizacionpos
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxValor_PK = loItem.Valor_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxLetracomprobante = loItem.Letracomprobante
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxPuntodeventacomprobante = loItem.Puntodeventacomprobante
					lxNrocomprobante = loItem.Nrocomprobante
					lxNumerointerno = loItem.Numerointerno
					lxCupontipo = loItem.Cupontipo
					lxFechacomprobante = loItem.Fechacomprobante
					lxTipocomprobante = loItem.Tipocomprobante
					lxBasededatosorigen = loItem.Basededatosorigen
					lxHora = loItem.Hora
					lxSerieorigen = loItem.Serieorigen
					lxTotal = loItem.Total
					lxMonto = loItem.Monto
					lxPesosalcambio = loItem.Pesosalcambio
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontocupon = loItem.Montocupon
					lxCodigodecupon = loItem.Codigodecupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CanjeCuponesEnt("FechCoti","JJfecha","IdCaja","NroTarjeta","JJCotiz","Signo","Cotiza","JJT","NROITEM","NroCupon","Autorizado","CElectro","VisualCaja","JJCO","NroCheque","NroChProp","Codigo","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","Serie","JJTotFac","JJM","Pesos","Montosiste","MonCupon","guidCupon","guidComp","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<lxCotiza>>, <<lxSignodemovimiento>>, <<lxUltimacotizacion>>, <<lxTipo>>, <<lxNroitem>>, <<lxNumerocupon>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxLetracomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxPuntodeventacomprobante>>, <<lxNrocomprobante>>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupontipo ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatosorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerieorigen ) + "'">>, <<lxTotal>>, <<lxMonto>>, <<lxPesosalcambio>>, <<lxMontoamonedasistema>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CANJECUPONES.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CANJECUPONES where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CanjeCuponesDet where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CanjeCuponesEnt where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CANJECUPONES' 
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
		
			.oCompCanjedecupones.lNuevo = .EsNuevo()
			.oCompCanjedecupones.lEdicion = .EsEdicion()
			.oCompCanjedecupones.lEliminar = .lEliminar
			.oCompCanjedecupones.lAnular = .lAnular
			loColSentencias = .oCompCanjedecupones.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
		with this.oEntidad
			.ValoresDetalle.oItem.oCompCajero.lNuevo = .EsNuevo()
			.ValoresDetalle.oItem.oCompCajero.lEdicion = .EsEdicion()
			.ValoresDetalle.oItem.oCompCajero.lEliminar = .lEliminar
			.ValoresDetalle.oItem.oCompCajero.lAnular = .lAnular
			loColSentencias = .ValoresDetalle.oItem.oCompCajero.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.ValoresAEnt.oItem.oCompCajero.lNuevo = .EsNuevo()
			.ValoresAEnt.oItem.oCompCajero.lEdicion = .EsEdicion()
			.ValoresAEnt.oItem.oCompCajero.lEliminar = .lEliminar
			.ValoresAEnt.oItem.oCompCajero.lAnular = .lAnular
			loColSentencias = .ValoresAEnt.oItem.oCompCajero.grabar()
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
			lcRetorno = [update ZooLogic.CANJECUPONES set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where Codigo = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  CANJECUPONES.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CANJECUPONES where  CANJECUPONES.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CANJECUPONES where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CANJECUPONES.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCanjeCuponesFACTTIPO as variant, lxCanjeCuponesFLETRA as variant, lxCanjeCuponesFPTOVEN as variant, lxCanjeCuponesNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CANJECUPONES Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						if this.oEntidad.cContexto == 'C'
							if curSeek.ANULADO
								Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.CANJECUPONES set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ValorDet = ] + "'" + this.FormatearTextoSql( &lcCursor..ValorDet ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, Signo = ] + transform( &lcCursor..Signo )+ [, ValTip = ] + transform( &lcCursor..ValTip )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, Cupon = ] + "'" + this.FormatearTextoSql( &lcCursor..Cupon ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, Valor = ] + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, CompTipo = ] + transform( &lcCursor..CompTipo )+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, Proveedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, PtoVen = ] + transform( &lcCursor..PtoVen )+ [, tipo = ] + "'" + this.FormatearTextoSql( &lcCursor..tipo ) + "'"+ [, Concepto = ] + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'"+ [, NumComp = ] + transform( &lcCursor..NumComp )+ [, NumeroCup = ] + transform( &lcCursor..NumeroCup )+ [, Vendedor = ] + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"+ [, FechaComp = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaComp ) + "'"+ [, FechaCup = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaCup ) + "'"+ [, BaseDatos = ] + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'"+ [, Monto = ] + transform( &lcCursor..Monto )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 )) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CANJECUPONES Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FECTRANS, FECEXPO, FECIMPO, HORAEXPO, FAltaFW, HORAIMPO, ValorDet, HAltaFW, BDALTAFW, ESTTRANS, BDMODIFW, HMODIFW, SALTAFW, SMODIFW, UALTAFW, VALTAFW, VMODIFW, DescFW, ZADSFW, UMODIFW, Signo, ValTip, FACTTIPO, Cupon, IdCaja, Codigo, Moneda, Valor, FLETRA, CompTipo, Cliente, Obs, FPTOVEN, Letra, Proveedor, Numero, Fecha, PtoVen, tipo, Concepto, NumComp, NumeroCup, Vendedor, FechaComp, FechaCup, BaseDatos, FTotal, Hora, Serie, Monto, Anulado
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValorDet ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Signo ) + ',' + transform( &lcCursor..ValTip ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cupon ) + "'" + ',' + transform( &lcCursor..IdCaja ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..CompTipo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Proveedor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + transform( &lcCursor..PtoVen ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Concepto ) + "'" + ',' + transform( &lcCursor..NumComp ) + ',' + transform( &lcCursor..NumeroCup ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Vendedor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaComp ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaCup ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'" + ',' + transform( &lcCursor..Monto ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CANJECUPONES ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CanjeCuponesDet Where JJNUM] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CanjeCuponesEnt Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCANJECUPONES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where JJNUM in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"FechCoti","JJfecha","IdCaja","NroTarjeta","TipoDoc","TIPCOMP","NroDoc","JJVen","Letra","Cotiza","JJTurno","NroCupon","NumCompr","JJCotiz","NroItem","PtoVenta","JJT","Signo","Autorizado","VisualCaja","CElectro","PersComp","JJNUM","NroCheque","JJCO","NroChProp","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","Pesos","Montosiste","jrecmntsi","jrrecsperc","guidComp","guidCupon","permvuelto","ValeCambio","Cupon"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CanjeCuponesDet ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoDoc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TIPCOMP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroDoc     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJVen      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.JJTurno    ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.PtoVenta   ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + Transform( iif( cDetallesExistentes.Autorizado, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.PersComp  , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJNUM      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.jrecporc   ) + ',' + transform( cDetallesExistentes.jrecmnt    ) + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + transform( cDetallesExistentes.jrecmntsi  ) + ',' + transform( cDetallesExistentes.jrrecsperc ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidCupon  ) + "'" + ',' + Transform( iif( cDetallesExistentes.permvuelto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValeCambio ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cupon      ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALORESAENT'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"FechCoti","JJfecha","IdCaja","NroTarjeta","JJCotiz","Signo","Cotiza","JJT","NROITEM","NroCupon","Autorizado","CElectro","VisualCaja","JJCO","NroCheque","NroChProp","Codigo","Letra","JJDE","JJFE","PtoVen","NumCompr","NroInterno","tipo","FechaComp","TipComp","BaseDatos","Hora","Serie","JJTotFac","JJM","Pesos","Montosiste","MonCupon","guidCupon","guidComp","Cupon"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CanjeCuponesEnt ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + Transform( iif( cDetallesExistentes.Autorizado, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + transform( cDetallesExistentes.PtoVen     ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.tipo       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechaComp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipComp    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.BaseDatos  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Hora       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Serie      ) + "'" + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + transform( cDetallesExistentes.MonCupon   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidCupon  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cupon      ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		this.oEntidad.ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMCANJECUPONES',this.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES')
		this.oEntidad.ValoresAEnt.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresAEnt',this.oEntidad.cPrefijoRecibir + 'ITEMVALORESAENT',this.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Pto. venta: ' + transform( &tcCursor..FPTOVEN    )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Numero     )
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
			Case  lcAlias == lcPrefijo + 'CANJEDECUPONES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CANJEDECUPONES_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CANJEDECUPONES_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCANJECUPONES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALORESAENT'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CanjeCupones')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CANJEDECUPONES'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CANJEDECUPONES. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( Numero, 12, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( Numero, 12, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  Fecha     
		* Validar ANTERIORES A 1/1/1753  FechaComp 
		* Validar ANTERIORES A 1/1/1753  FechaCup  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CanjeCupones') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CanjeCupones
Create Table ZooLogic.TablaTrabajo_CanjeCupones ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"faltafw" datetime  null, 
"horaimpo" char( 8 )  null, 
"valordet" char( 40 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"signo" numeric( 2, 0 )  null, 
"valtip" numeric( 2, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"cupon" char( 38 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"codigo" char( 38 )  null, 
"moneda" char( 10 )  null, 
"valor" char( 5 )  null, 
"fletra" char( 1 )  null, 
"comptipo" numeric( 2, 0 )  null, 
"cliente" char( 10 )  null, 
"obs" varchar(max)  null, 
"fptoven" numeric( 4, 0 )  null, 
"letra" char( 1 )  null, 
"proveedor" char( 10 )  null, 
"numero" numeric( 12, 0 )  null, 
"fecha" datetime  null, 
"ptoven" numeric( 4, 0 )  null, 
"tipo" char( 2 )  null, 
"concepto" char( 10 )  null, 
"numcomp" numeric( 8, 0 )  null, 
"numerocup" numeric( 12, 0 )  null, 
"vendedor" char( 10 )  null, 
"fechacomp" datetime  null, 
"fechacup" datetime  null, 
"basedatos" char( 8 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"hora" char( 5 )  null, 
"serie" char( 10 )  null, 
"monto" numeric( 15, 2 )  null, 
"anulado" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CanjeCupones' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CanjeCupones' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CANJEDECUPONES'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('valordet','valordet')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('signo','signo')
			.AgregarMapeo('valtip','valtip')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('cupon','cupon')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('valor','valor')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('comptipo','comptipo')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('proveedor','proveedor')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('ptoven','ptoven')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('concepto','concepto')
			.AgregarMapeo('numcomp','numcomp')
			.AgregarMapeo('numerocup','numerocup')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('fechacomp','fechacomp')
			.AgregarMapeo('fechacup','fechacup')
			.AgregarMapeo('basedatos','basedatos')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('anulado','anulado')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CanjeCupones'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VALORDET = isnull( d.VALORDET, t.VALORDET ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SIGNO = isnull( d.SIGNO, t.SIGNO ),t.VALTIP = isnull( d.VALTIP, t.VALTIP ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.CUPON = isnull( d.CUPON, t.CUPON ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.VALOR = isnull( d.VALOR, t.VALOR ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.COMPTIPO = isnull( d.COMPTIPO, t.COMPTIPO ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.OBS = isnull( d.OBS, t.OBS ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PROVEEDOR = isnull( d.PROVEEDOR, t.PROVEEDOR ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.PTOVEN = isnull( d.PTOVEN, t.PTOVEN ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.CONCEPTO = isnull( d.CONCEPTO, t.CONCEPTO ),t.NUMCOMP = isnull( d.NUMCOMP, t.NUMCOMP ),t.NUMEROCUP = isnull( d.NUMEROCUP, t.NUMEROCUP ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.FECHACOMP = isnull( d.FECHACOMP, t.FECHACOMP ),t.FECHACUP = isnull( d.FECHACUP, t.FECHACUP ),t.BASEDATOS = isnull( d.BASEDATOS, t.BASEDATOS ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.HORA = isnull( d.HORA, t.HORA ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.ANULADO = isnull( d.ANULADO, t.ANULADO )
					from ZooLogic.CANJECUPONES t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.CANJECUPONES(Fmodifw,Fectrans,Fecexpo,Fecimpo,Horaexpo,Faltafw,Horaimpo,Valordet,Haltafw,Bdaltafw,Esttrans,Bdmodifw,Hmodifw,Saltafw,Smodifw,Ualtafw,Valtafw,Vmodifw,Descfw,Zadsfw,Umodifw,Signo,Valtip,Facttipo,Cupon,Idcaja,Codigo,Moneda,Valor,Fletra,Comptipo,Cliente,Obs,Fptoven,Letra,Proveedor,Numero,Fecha,Ptoven,Tipo,Concepto,Numcomp,Numerocup,Vendedor,Fechacomp,Fechacup,Basedatos,Ftotal,Hora,Serie,Monto,Anulado)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.HORAEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.HORAIMPO,''),isnull( d.VALORDET,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.DESCFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.SIGNO,0),isnull( d.VALTIP,0),isnull( d.FACTTIPO,0),isnull( d.CUPON,''),isnull( d.IDCAJA,0),isnull( d.CODIGO,''),isnull( d.MONEDA,''),isnull( d.VALOR,''),isnull( d.FLETRA,''),isnull( d.COMPTIPO,0),isnull( d.CLIENTE,''),isnull( d.OBS,''),isnull( d.FPTOVEN,0),isnull( d.LETRA,''),isnull( d.PROVEEDOR,''),isnull( d.NUMERO,0),isnull( d.FECHA,''),isnull( d.PTOVEN,0),isnull( d.TIPO,''),isnull( d.CONCEPTO,''),isnull( d.NUMCOMP,0),isnull( d.NUMEROCUP,0),isnull( d.VENDEDOR,''),isnull( d.FECHACOMP,''),isnull( d.FECHACUP,''),isnull( d.BASEDATOS,''),isnull( d.FTOTAL,0),isnull( d.HORA,''),isnull( d.SERIE,''),isnull( d.MONTO,0),isnull( d.ANULADO,0)
						From deleted d left join ZooLogic.CANJECUPONES pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.CANJECUPONES cc 
							 on  d.FACTTIPO = cc.FACTTIPO
							 and  d.FLETRA = cc.FLETRA
							 and  d.FPTOVEN = cc.FPTOVEN
							 and  d.Numero = cc.Numero
						Where pk.Codigo Is Null 
							 and cc.FACTTIPO Is Null 
							 and cc.FLETRA Is Null 
							 and cc.FPTOVEN Is Null 
							 and cc.Numero Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.Numero as Varchar(12) ) + '','La clave principal no es la esperada'
					from ZooLogic.CANJECUPONES t inner join deleted d 
							on   t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.Numero = d.Numero
						left join deleted h 
							 on t.Codigo = h.Codigo
							 where h.Codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.Numero as Varchar(12) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CANJECUPONES t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.FACTTIPO = h.FACTTIPO
							 and   t.FLETRA = h.FLETRA
							 and   t.FPTOVEN = h.FPTOVEN
							 and   t.Numero = h.Numero
							where   h.FACTTIPO is null 
							 and   h.FLETRA is null 
							 and   h.FPTOVEN is null 
							 and   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CanjeCuponesDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CANJECUPONES_CanjeCuponesDet
ON ZooLogic.TablaTrabajo_CANJECUPONES_CanjeCuponesDet
AFTER DELETE
As
Begin
Update t Set 
t.FECHCOTI = isnull( d.FECHCOTI, t.FECHCOTI ),
t.JJFECHA = isnull( d.JJFECHA, t.JJFECHA ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.TIPODOC = isnull( d.TIPODOC, t.TIPODOC ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.NRODOC = isnull( d.NRODOC, t.NRODOC ),
t.JJVEN = isnull( d.JJVEN, t.JJVEN ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.JJTURNO = isnull( d.JJTURNO, t.JJTURNO ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),
t.JJT = isnull( d.JJT, t.JJT ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.AUTORIZADO = isnull( d.AUTORIZADO, t.AUTORIZADO ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.PERSCOMP = isnull( d.PERSCOMP, t.PERSCOMP ),
t.JJNUM = isnull( d.JJNUM, t.JJNUM ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.JJDE = isnull( d.JJDE, t.JJDE ),
t.JJFE = isnull( d.JJFE, t.JJFE ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.JJM = isnull( d.JJM, t.JJM ),
t.JRECPORC = isnull( d.JRECPORC, t.JRECPORC ),
t.JRECMNT = isnull( d.JRECMNT, t.JRECMNT ),
t.JJTOTFAC = isnull( d.JJTOTFAC, t.JJTOTFAC ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.MONTOSISTE = isnull( d.MONTOSISTE, t.MONTOSISTE ),
t.JRECMNTSI = isnull( d.JRECMNTSI, t.JRECMNTSI ),
t.JRRECSPERC = isnull( d.JRRECSPERC, t.JRRECSPERC ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.GUIDCUPON = isnull( d.GUIDCUPON, t.GUIDCUPON ),
t.PERMVUELTO = isnull( d.PERMVUELTO, t.PERMVUELTO ),
t.VALECAMBIO = isnull( d.VALECAMBIO, t.VALECAMBIO ),
t.CUPON = isnull( d.CUPON, t.CUPON )
from ZooLogic.CanjeCuponesDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CanjeCuponesDet
( 
"FECHCOTI",
"JJFECHA",
"IDCAJA",
"NROTARJETA",
"TIPODOC",
"TIPCOMP",
"NRODOC",
"JJVEN",
"LETRA",
"COTIZA",
"JJTURNO",
"NROCUPON",
"NUMCOMPR",
"JJCOTIZ",
"NROITEM",
"PTOVENTA",
"JJT",
"SIGNO",
"AUTORIZADO",
"VISUALCAJA",
"CELECTRO",
"PERSCOMP",
"JJNUM",
"NROCHEQUE",
"JJCO",
"NROCHPROP",
"JJDE",
"JJFE",
"NROINTERNO",
"JJM",
"JRECPORC",
"JRECMNT",
"JJTOTFAC",
"PESOS",
"MONTOSISTE",
"JRECMNTSI",
"JRRECSPERC",
"GUIDCOMP",
"GUIDCUPON",
"PERMVUELTO",
"VALECAMBIO",
"CUPON"
 )
Select 
d.FECHCOTI,
d.JJFECHA,
d.IDCAJA,
d.NROTARJETA,
d.TIPODOC,
d.TIPCOMP,
d.NRODOC,
d.JJVEN,
d.LETRA,
d.COTIZA,
d.JJTURNO,
d.NROCUPON,
d.NUMCOMPR,
d.JJCOTIZ,
d.NROITEM,
d.PTOVENTA,
d.JJT,
d.SIGNO,
d.AUTORIZADO,
d.VISUALCAJA,
d.CELECTRO,
d.PERSCOMP,
d.JJNUM,
d.NROCHEQUE,
d.JJCO,
d.NROCHPROP,
d.JJDE,
d.JJFE,
d.NROINTERNO,
d.JJM,
d.JRECPORC,
d.JRECMNT,
d.JJTOTFAC,
d.PESOS,
d.MONTOSISTE,
d.JRECMNTSI,
d.JRRECSPERC,
d.GUIDCOMP,
d.GUIDCUPON,
d.PERMVUELTO,
d.VALECAMBIO,
d.CUPON
From deleted d left join ZooLogic.CanjeCuponesDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CanjeCuponesEnt( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CANJECUPONES_CanjeCuponesEnt
ON ZooLogic.TablaTrabajo_CANJECUPONES_CanjeCuponesEnt
AFTER DELETE
As
Begin
Update t Set 
t.FECHCOTI = isnull( d.FECHCOTI, t.FECHCOTI ),
t.JJFECHA = isnull( d.JJFECHA, t.JJFECHA ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.JJT = isnull( d.JJT, t.JJT ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.AUTORIZADO = isnull( d.AUTORIZADO, t.AUTORIZADO ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.JJDE = isnull( d.JJDE, t.JJDE ),
t.JJFE = isnull( d.JJFE, t.JJFE ),
t.PTOVEN = isnull( d.PTOVEN, t.PTOVEN ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.FECHACOMP = isnull( d.FECHACOMP, t.FECHACOMP ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.BASEDATOS = isnull( d.BASEDATOS, t.BASEDATOS ),
t.HORA = isnull( d.HORA, t.HORA ),
t.SERIE = isnull( d.SERIE, t.SERIE ),
t.JJTOTFAC = isnull( d.JJTOTFAC, t.JJTOTFAC ),
t.JJM = isnull( d.JJM, t.JJM ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.MONTOSISTE = isnull( d.MONTOSISTE, t.MONTOSISTE ),
t.MONCUPON = isnull( d.MONCUPON, t.MONCUPON ),
t.GUIDCUPON = isnull( d.GUIDCUPON, t.GUIDCUPON ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.CUPON = isnull( d.CUPON, t.CUPON )
from ZooLogic.CanjeCuponesEnt t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CanjeCuponesEnt
( 
"FECHCOTI",
"JJFECHA",
"IDCAJA",
"NROTARJETA",
"JJCOTIZ",
"SIGNO",
"COTIZA",
"JJT",
"NROITEM",
"NROCUPON",
"AUTORIZADO",
"CELECTRO",
"VISUALCAJA",
"JJCO",
"NROCHEQUE",
"NROCHPROP",
"CODIGO",
"LETRA",
"JJDE",
"JJFE",
"PTOVEN",
"NUMCOMPR",
"NROINTERNO",
"TIPO",
"FECHACOMP",
"TIPCOMP",
"BASEDATOS",
"HORA",
"SERIE",
"JJTOTFAC",
"JJM",
"PESOS",
"MONTOSISTE",
"MONCUPON",
"GUIDCUPON",
"GUIDCOMP",
"CUPON"
 )
Select 
d.FECHCOTI,
d.JJFECHA,
d.IDCAJA,
d.NROTARJETA,
d.JJCOTIZ,
d.SIGNO,
d.COTIZA,
d.JJT,
d.NROITEM,
d.NROCUPON,
d.AUTORIZADO,
d.CELECTRO,
d.VISUALCAJA,
d.JJCO,
d.NROCHEQUE,
d.NROCHPROP,
d.CODIGO,
d.LETRA,
d.JJDE,
d.JJFE,
d.PTOVEN,
d.NUMCOMPR,
d.NROINTERNO,
d.TIPO,
d.FECHACOMP,
d.TIPCOMP,
d.BASEDATOS,
d.HORA,
d.SERIE,
d.JJTOTFAC,
d.JJM,
d.PESOS,
d.MONTOSISTE,
d.MONCUPON,
d.GUIDCUPON,
d.GUIDCOMP,
d.CUPON
From deleted d left join ZooLogic.CanjeCuponesEnt pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CanjeCupones') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CanjeCupones
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CANJEDECUPONES' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_CANJEDECUPONES.Horaexpo, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaimpo = nvl( c_CANJEDECUPONES.Horaimpo, [] )
					.Cuponvalordetalle = nvl( c_CANJEDECUPONES.Cuponvalordetalle, [] )
					.Horaaltafw = nvl( c_CANJEDECUPONES.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_CANJEDECUPONES.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_CANJEDECUPONES.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_CANJEDECUPONES.Basededatosmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_CANJEDECUPONES.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_CANJEDECUPONES.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_CANJEDECUPONES.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CANJEDECUPONES.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_CANJEDECUPONES.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_CANJEDECUPONES.Versionmodificacionfw, [] )
					.Descripcionfw = nvl( c_CANJEDECUPONES.Descripcionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_CANJEDECUPONES.Usuariomodificacionfw, [] )
					.Signodemovimiento = nvl( c_CANJEDECUPONES.Signodemovimiento, 0 )
					.Cuponvalortipo = nvl( c_CANJEDECUPONES.Cuponvalortipo, 0 )
					.Tipocomprobante = nvl( c_CANJEDECUPONES.Tipocomprobante, 0 )
					.Cupon_PK =  nvl( c_CANJEDECUPONES.Cupon, [] )
					.Cuponidcaja_PK =  nvl( c_CANJEDECUPONES.Cuponidcaja, 0 )
					.Codigo = nvl( c_CANJEDECUPONES.Codigo, [] )
					.Monedacomprobante_PK =  nvl( c_CANJEDECUPONES.Monedacomprobante, [] )
					.Cuponvalor_PK =  nvl( c_CANJEDECUPONES.Cuponvalor, [] )
					.Letra = nvl( c_CANJEDECUPONES.Letra, [] )
					.Cupontipocomprobante = nvl( c_CANJEDECUPONES.Cupontipocomprobante, 0 )
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Cliente_PK =  nvl( c_CANJEDECUPONES.Cliente, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Valoresaent.Limpiar()
					.Valoresaent.SetearEsNavegacion( .lProcesando )
					.Valoresaent.Cargar()
					.Puntodeventa = nvl( c_CANJEDECUPONES.Puntodeventa, 0 )
					.Cuponletracomprobante = nvl( c_CANJEDECUPONES.Cuponletracomprobante, [] )
					.Proveedor_PK =  nvl( c_CANJEDECUPONES.Proveedor, [] )
					.Numero = nvl( c_CANJEDECUPONES.Numero, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Fecha, ctod( '  /  /    ' ) ) )
					.Cuponpuntodeventacomprobante = nvl( c_CANJEDECUPONES.Cuponpuntodeventacomprobante, 0 )
					.Cupontipo = nvl( c_CANJEDECUPONES.Cupontipo, [] )
					.Concepto_PK =  nvl( c_CANJEDECUPONES.Concepto, [] )
					.Cuponnumerocomprobante = nvl( c_CANJEDECUPONES.Cuponnumerocomprobante, 0 )
					.Cuponnumerocupon = nvl( c_CANJEDECUPONES.Cuponnumerocupon, 0 )
					.Vendedor_PK =  nvl( c_CANJEDECUPONES.Vendedor, [] )
					.Cuponfechacomprobante = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Cuponfechacomprobante, ctod( '  /  /    ' ) ) )
					.Cuponfecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CANJEDECUPONES.Cuponfecha, ctod( '  /  /    ' ) ) )
					.Cuponbasededatos = nvl( c_CANJEDECUPONES.Cuponbasededatos, [] )
					.Total = nvl( c_CANJEDECUPONES.Total, 0 )
					.Cuponhora = nvl( c_CANJEDECUPONES.Cuponhora, [] )
					.Cuponserieorigen = nvl( c_CANJEDECUPONES.Cuponserieorigen, [] )
					.Cuponmonto = nvl( c_CANJEDECUPONES.Cuponmonto, 0 )
					.Anulado = nvl( c_CANJEDECUPONES.Anulado, .F. )
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
			lxRetorno = c_CANJEDECUPONES.CODIGO
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

		loDetalle = this.oEntidad.ValoresAEnt
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
		return c_CANJEDECUPONES.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CANJECUPONES' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Codigo from (
							select * 
								from ZooLogic.CANJECUPONES 
								Where   CANJECUPONES.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CANJECUPONES", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Valordet" as "Cuponvalordetalle", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Signo" as "Signodemovimiento", "Valtip" as "Cuponvalortipo", "Facttipo" as "Tipocomprobante", "Cupon" as "Cupon", "Idcaja" as "Cuponidcaja", "Codigo" as "Codigo", "Moneda" as "Monedacomprobante", "Valor" as "Cuponvalor", "Fletra" as "Letra", "Comptipo" as "Cupontipocomprobante", "Cliente" as "Cliente", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Letra" as "Cuponletracomprobante", "Proveedor" as "Proveedor", "Numero" as "Numero", "Fecha" as "Fecha", "Ptoven" as "Cuponpuntodeventacomprobante", "Tipo" as "Cupontipo", "Concepto" as "Concepto", "Numcomp" as "Cuponnumerocomprobante", "Numerocup" as "Cuponnumerocupon", "Vendedor" as "Vendedor", "Fechacomp" as "Cuponfechacomprobante", "Fechacup" as "Cuponfecha", "Basedatos" as "Cuponbasededatos", "Ftotal" as "Total", "Hora" as "Cuponhora", "Serie" as "Cuponserieorigen", "Monto" as "Cuponmonto", "Anulado" as "Anulado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CANJECUPONES 
								Where   CANJECUPONES.CODIGO != ''
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
	Tabla = 'CANJECUPONES'
	Filtro = " CANJECUPONES.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CANJECUPONES.CODIGO != ''"
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
										<xsd:maxLength value="250"/>
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
	<row entidad="CANJEDECUPONES                          " atributo="FECHAMODIFICACIONFW                     " tabla="CANJECUPONES   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHATRANSFERENCIA                      " tabla="CANJECUPONES   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHAEXPO                               " tabla="CANJECUPONES   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHAIMPO                               " tabla="CANJECUPONES   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="HORAEXPO                                " tabla="CANJECUPONES   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHAALTAFW                             " tabla="CANJECUPONES   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="HORAIMPO                                " tabla="CANJECUPONES   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONVALORDETALLE                       " tabla="CANJECUPONES   " campo="VALORDET  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="Cupon.Valor.Descripcion                                                                                                                                                                                                                                       " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="HORAALTAFW                              " tabla="CANJECUPONES   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="BASEDEDATOSALTAFW                       " tabla="CANJECUPONES   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="ESTADOTRANSFERENCIA                     " tabla="CANJECUPONES   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CANJECUPONES   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="HORAMODIFICACIONFW                      " tabla="CANJECUPONES   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="SERIEALTAFW                             " tabla="CANJECUPONES   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="SERIEMODIFICACIONFW                     " tabla="CANJECUPONES   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="USUARIOALTAFW                           " tabla="CANJECUPONES   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VERSIONALTAFW                           " tabla="CANJECUPONES   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VERSIONMODIFICACIONFW                   " tabla="CANJECUPONES   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="DESCRIPCIONFW                           " tabla="CANJECUPONES   " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="ZADSFW                                  " tabla="CANJECUPONES   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="USUARIOMODIFICACIONFW                   " tabla="CANJECUPONES   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="SIGNODEMOVIMIENTO                       " tabla="CANJECUPONES   " campo="SIGNO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONVALORTIPO                          " tabla="CANJECUPONES   " campo="VALTIP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="Cupon.Valor.Tipo                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="TIPOCOMPROBANTE                         " tabla="CANJECUPONES   " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=32                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPON                                   " tabla="CANJECUPONES   " campo="CUPON     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUPON                                   " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número interno                                                                                                                                                                                                                                            " dominio="CODIGOSINALTA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONIDCAJA                             " tabla="CANJECUPONES   " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cupon Caja                                                                                                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="Cupon.IdCaja                                                                                                                                                                                                                                                  " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CODIGO                                  " tabla="CANJECUPONES   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="MONEDACOMPROBANTE                       " tabla="CANJECUPONES   " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Comprobante                                                                                                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="Cupon.SimboloMonetario                                                                                                                                                                                                                                        " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONVALOR                              " tabla="CANJECUPONES   " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cupon Valor                                                                                                                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="Cupon.Valor                                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="LETRA                                   " tabla="CANJECUPONES   " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Letra                                                                                                                                                                                                                                                     " dominio="NUMEROCOMPROBANTELIMITADO     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONTIPOCOMPROBANTE                    " tabla="CANJECUPONES   " campo="COMPTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de comprobante                                                                                                                                                                                                                                       " dominio="COMBOTIPOCOMPROBANTE          " detalle="false" tipo="E" atributoforaneo="Cupon.TipoComprobante                                                                                                                                                                                                                                         " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VALORESDETALLE                          " tabla="CANJECUPONESDET" campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Valores a recibir                                                                                                                                                                                                                                         " dominio="DETALLEITEMCANJECUPONES       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CLIENTE                                 " tabla="CANJECUPONES   " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Cliente                                                                                                                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="OBS                                     " tabla="CANJECUPONES   " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Observación                                                                                                                                                                                                                                               " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VALORESAENT                             " tabla="CANJECUPONESENT" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Valores a entregar                                                                                                                                                                                                                                        " dominio="DETALLEITEMVALORESAENT        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="PUNTODEVENTA                            " tabla="CANJECUPONES   " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Pto. venta                                                                                                                                                                                                                                                " dominio="NUMEROCOMPROBANTELIMITADO     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONLETRACOMPROBANTE                   " tabla="CANJECUPONES   " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="LetraComprobante                                                                                                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="Cupon.LetraComprobante                                                                                                                                                                                                                                        " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="DIFERENCIA                              " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Dif.                                                                                                                                                                                                                                                      " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="PROVEEDOR                               " tabla="CANJECUPONES   " campo="PROVEEDOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Proveedor                                                                                                                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="NUMERO                                  " tabla="CANJECUPONES   " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Número interno                                                                                                                                                                                                                                            " dominio="NUMEROCOMPROBANTELIMITADO     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="FECHA                                   " tabla="CANJECUPONES   " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="412" etiqueta="Fecha                                                                                                                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONPUNTODEVENTACOMPROBANTE            " tabla="CANJECUPONES   " campo="PTOVEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto de venta                                                                                                                                                                                                                                            " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="Cupon.PuntoDeVentaComprobante                                                                                                                                                                                                                                 " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONTIPO                               " tabla="CANJECUPONES   " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo                                                                                                                                                                                                                                                      " dominio="COMBOTIPOCUPON                " detalle="false" tipo="E" atributoforaneo="Cupon.TipoCupon                                                                                                                                                                                                                                               " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CONCEPTO                                " tabla="CANJECUPONES   " campo="CONCEPTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOCAJA                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Concepto                                                                                                                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot;CONCECAJA.CtaBanc = ''&quot;                                                                                                                                                                                " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONNUMEROCOMPROBANTE                  " tabla="CANJECUPONES   " campo="NUMCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número comprobante                                                                                                                                                                                                                                        " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="Cupon.NumeroComprobante                                                                                                                                                                                                                                       " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONNUMEROCUPON                        " tabla="CANJECUPONES   " campo="NUMEROCUP " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número cupón                                                                                                                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="Cupon.NumeroCupon                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="VENDEDOR                                " tabla="CANJECUPONES   " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Vendedor                                                                                                                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONFECHACOMPROBANTE                   " tabla="CANJECUPONES   " campo="FECHACOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha comprobante                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="Cupon.FechaComprobante                                                                                                                                                                                                                                        " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONFECHA                              " tabla="CANJECUPONES   " campo="FECHACUP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de emisión del cupón                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="Cupon.FechaCupon                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONBASEDEDATOS                        " tabla="CANJECUPONES   " campo="BASEDATOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos                                                                                                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="Cupon.BaseDeDatos                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="TOTAL                                   " tabla="CANJECUPONES   " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total                                                                                                                                                                                                                                                     " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONHORA                               " tabla="CANJECUPONES   " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora                                                                                                                                                                                                                                                      " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="Cupon.HoraCupon                                                                                                                                                                                                                                               " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONSERIEORIGEN                        " tabla="CANJECUPONES   " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie                                                                                                                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="Cupon.SerieOrigen                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="CUPONMONTO                              " tabla="CANJECUPONES   " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto                                                                                                                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="Cupon.Monto                                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CANJEDECUPONES                          " atributo="ANULADO                                 " tabla="CANJECUPONES   " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="403" etiqueta="Detalle Cli.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On CANJECUPONES.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Pro.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On CANJECUPONES.PROVEEDOR = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONCEPTOCAJA                            " atributo="DESCRIPCION                             " tabla="CONCECAJA      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Con.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONCECAJA On CANJECUPONES.CONCEPTO = CONCECAJA.Codigo And  CONCECAJA.CODIGO != ''                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Ven.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On CANJECUPONES.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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