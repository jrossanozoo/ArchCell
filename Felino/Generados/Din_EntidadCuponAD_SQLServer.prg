
define class Din_EntidadCUPONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CUPON'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( PuntoDeVenta, 4, 0) + str( NumeroInterno, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.PtoVenta, 4, 0) + str( #tabla#.NroInterno, 8, 0)]
	cTagClaveCandidata = '_CUPCC'
	cTagClavePk = '_CUPPK'
	cTablaPrincipal = 'CUPONES'
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
			local  lxCuponesFecexpo, lxCuponesFaltafw, lxCuponesFectrans, lxCuponesFecimpo, lxCuponesFmodifw, lxCuponesNrorefafdo, lxCuponesNroreferen, lxCuponesCotizacion, lxCuponesBdmodifw, lxCuponesBdaltafw, lxCuponesCierrelote, lxCuponesZadsfw, lxCuponesEsttrans, lxCuponesComp, lxCuponesVmodifw, lxCuponesSmodifw, lxCuponesSaltafw, lxCuponesUaltafw, lxCuponesHmodifw, lxCuponesHoraexpo, lxCuponesValtafw, lxCuponesHaltafw, lxCuponesHoraimpo, lxCuponesUmodifw, lxCuponesCodigo, lxCuponesClatar, lxCuponesIdcaja, lxCuponesObs, lxCuponesTxticard, lxCuponesTxtclicard, lxCuponesLetrac, lxCuponesQridtranf, lxCuponesPtoventa, lxCuponesTiponc, lxCuponesTipo, lxCuponesValor, lxCuponesNumafdo, lxCuponesComptipo, lxCuponesPtovenc, lxCuponesLetranc, lxCuponesLetra, lxCuponesNumero, lxCuponesNrointerno, lxCuponesTipotarj, lxCuponesLotafdo, lxCuponesNcanje, lxCuponesPventanc, lxCuponesPtoven, lxCuponesLote, lxCuponesFecafdo, lxCuponesCuotas, lxCuponesFbaja, lxCuponesNumeronc, lxCuponesNumcomp, lxCuponesNrocl, lxCuponesAutorizado, lxCuponesUltdig, lxCuponesFechanc, lxCuponesFechacomp, lxCuponesFecha, lxCuponesHbaja, lxCuponesDesporc, lxCuponesRecporc, lxCuponesQriddeb, lxCuponesNomtitular, lxCuponesMoneda, lxCuponesTipdoctitu, lxCuponesHora, lxCuponesRecmonto, lxCuponesDesmonto, lxCuponesEsretiroef, lxCuponesBasedatos, lxCuponesBasedatosb, lxCuponesAuttel, lxCuponesFcielote, lxCuponesNrodoctitu, lxCuponesSerieb, lxCuponesSerie, lxCuponesAutoffline, lxCuponesHcielote, lxCuponesNrocomerci, lxCuponesTeltitu, lxCuponesCodcli, lxCuponesPos, lxCuponesEntfin, lxCuponesMonto, lxCuponesValidado, lxCuponesCodplan, lxCuponesSerial, lxCuponesIdpago, lxCuponesMovil, lxCuponesIdorden, lxCuponesExtid, lxCuponesRefexterna, lxCuponesIdlapos, lxCuponesIdgocuotas, lxCuponesMailgc
				lxCuponesFecexpo =  .Fechaexpo			lxCuponesFaltafw =  .Fechaaltafw			lxCuponesFectrans =  .Fechatransferencia			lxCuponesFecimpo =  .Fechaimpo			lxCuponesFmodifw =  .Fechamodificacionfw			lxCuponesNrorefafdo =  .Numeroreferenciaafectado			lxCuponesNroreferen =  .Numeroreferencia			lxCuponesCotizacion =  .Cotizacion			lxCuponesBdmodifw =  .Basededatosmodificacionfw			lxCuponesBdaltafw =  .Basededatosaltafw			lxCuponesCierrelote =  .Codigocierredelote			lxCuponesZadsfw =  .Zadsfw			lxCuponesEsttrans =  .Estadotransferencia			lxCuponesComp =  .Comprobante			lxCuponesVmodifw =  .Versionmodificacionfw			lxCuponesSmodifw =  .Seriemodificacionfw			lxCuponesSaltafw =  .Seriealtafw			lxCuponesUaltafw =  .Usuarioaltafw			lxCuponesHmodifw =  .Horamodificacionfw			lxCuponesHoraexpo =  .Horaexpo			lxCuponesValtafw =  .Versionaltafw			lxCuponesHaltafw =  .Horaaltafw			lxCuponesHoraimpo =  .Horaimpo			lxCuponesUmodifw =  .Usuariomodificacionfw			lxCuponesCodigo =  .Codigo			lxCuponesClatar =  upper( .ClaseDeTarjeta_PK ) 			lxCuponesIdcaja =  .Idcaja_PK 			lxCuponesObs =  .Observacion			lxCuponesTxticard =  .Ticketicard			lxCuponesTxtclicard =  .Ticketicardcl			lxCuponesLetrac =  .Letracanje			lxCuponesQridtranf =  .Qrtransactionidposnet			lxCuponesPtoventa =  .Puntodeventa			lxCuponesTiponc =  .Tiponotadecredito			lxCuponesTipo =  .Tipocupon			lxCuponesValor =  upper( .Valor_PK ) 			lxCuponesNumafdo =  .Numerodecuponafectado			lxCuponesComptipo =  .Tipocomprobante			lxCuponesPtovenc =  .Puntodeventacanje			lxCuponesLetranc =  .Letranotadecredito			lxCuponesLetra =  .Letracomprobante			lxCuponesNumero =  .Numerocupon			lxCuponesNrointerno =  .Numerointerno			lxCuponesTipotarj =  .Tipotarjeta			lxCuponesLotafdo =  .Loteafectado			lxCuponesNcanje =  .Numerodecanje			lxCuponesPventanc =  .Puntodeventanotadecredito			lxCuponesPtoven =  .Puntodeventacomprobante			lxCuponesLote =  .Lote			lxCuponesFecafdo =  .Fechadecuponafectado			lxCuponesCuotas =  .Cuotas			lxCuponesFbaja =  .Fechabaja			lxCuponesNumeronc =  .Numeronotadecredito			lxCuponesNumcomp =  .Numerocomprobante			lxCuponesNrocl =  .Numerocierredelote			lxCuponesAutorizado =  .Autorizacionpos			lxCuponesUltdig =  .Ultimosdigitos			lxCuponesFechanc =  .Fechanotadecredito			lxCuponesFechacomp =  .Fechacomprobante			lxCuponesFecha =  .Fechacupon			lxCuponesHbaja =  .Horabaja			lxCuponesDesporc =  .Descuentoporcentaje			lxCuponesRecporc =  .Recargoporcentaje			lxCuponesQriddeb =  .Qrtranfdebinidposnet			lxCuponesNomtitular =  .Nombretitular			lxCuponesMoneda =  upper( .SimboloMonetario_PK ) 			lxCuponesTipdoctitu =  .Tipodocumentotitular			lxCuponesHora =  .Horacupon			lxCuponesRecmonto =  .Recargomonto			lxCuponesDesmonto =  .Descuentomonto			lxCuponesEsretiroef =  .Esretiroefectivo			lxCuponesBasedatos =  .Basededatos			lxCuponesBasedatosb =  .Basededatosbaja			lxCuponesAuttel =  .Autorizaciontelefonica			lxCuponesFcielote =  .Fechacierredelote			lxCuponesNrodoctitu =  .Nrodocumentotitular			lxCuponesSerieb =  .Seriebaja			lxCuponesSerie =  .Serieorigen			lxCuponesAutoffline =  .Autorizaciontelefonicaoffline			lxCuponesHcielote =  .Horacierredelote			lxCuponesNrocomerci =  .Numerocomercio			lxCuponesTeltitu =  .Telefonotitular			lxCuponesCodcli =  upper( .Cliente_PK ) 			lxCuponesPos =  upper( .POS_PK ) 			lxCuponesEntfin =  upper( .EntidadFinanciera_PK ) 			lxCuponesMonto =  .Monto			lxCuponesValidado =  .Validacion			lxCuponesCodplan =  .Codigoplan			lxCuponesSerial =  .Serial			lxCuponesIdpago =  .Idpagoclover			lxCuponesMovil =  .Dispositivomovil			lxCuponesIdorden =  .Idordenclover			lxCuponesExtid =  .Externalidclover			lxCuponesRefexterna =  .Referenciaexterna			lxCuponesIdlapos =  .Idsmartlapos			lxCuponesIdgocuotas =  .Idgocuotas			lxCuponesMailgc =  .Mailgocuotas
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCuponesCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CUPONES ( "Fecexpo","Faltafw","Fectrans","Fecimpo","Fmodifw","Nrorefafdo","Nroreferen","Cotizacion","Bdmodifw","Bdaltafw","Cierrelote","Zadsfw","Esttrans","Comp","Vmodifw","Smodifw","Saltafw","Ualtafw","Hmodifw","Horaexpo","Valtafw","Haltafw","Horaimpo","Umodifw","Codigo","Clatar","Idcaja","Obs","Txticard","Txtclicard","Letrac","Qridtranf","Ptoventa","Tiponc","Tipo","Valor","Numafdo","Comptipo","Ptovenc","Letranc","Letra","Numero","Nrointerno","Tipotarj","Lotafdo","Ncanje","Pventanc","Ptoven","Lote","Fecafdo","Cuotas","Fbaja","Numeronc","Numcomp","Nrocl","Autorizado","Ultdig","Fechanc","Fechacomp","Fecha","Hbaja","Desporc","Recporc","Qriddeb","Nomtitular","Moneda","Tipdoctitu","Hora","Recmonto","Desmonto","Esretiroef","Basedatos","Basedatosb","Auttel","Fcielote","Nrodoctitu","Serieb","Serie","Autoffline","Hcielote","Nrocomerci","Teltitu","Codcli","Pos","Entfin","Monto","Validado","Codplan","Serial","Idpago","Movil","Idorden","Extid","Refexterna","Idlapos","Idgocuotas","Mailgc" ) values ( <<"'" + this.ConvertirDateSql( lxCuponesFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFmodifw ) + "'" >>, <<lxCuponesNrorefafdo >>, <<lxCuponesNroreferen >>, <<lxCuponesCotizacion >>, <<"'" + this.FormatearTextoSql( lxCuponesBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesCierrelote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesComp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesClatar ) + "'" >>, <<lxCuponesIdcaja >>, <<"'" + this.FormatearTextoSql( lxCuponesObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesTxticard ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesTxtclicard ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesLetrac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesQridtranf ) + "'" >>, <<lxCuponesPtoventa >>, <<lxCuponesTiponc >>, <<"'" + this.FormatearTextoSql( lxCuponesTipo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesValor ) + "'" >>, <<lxCuponesNumafdo >>, <<lxCuponesComptipo >>, <<lxCuponesPtovenc >>, <<"'" + this.FormatearTextoSql( lxCuponesLetranc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesLetra ) + "'" >>, <<lxCuponesNumero >>, <<lxCuponesNrointerno >>, <<"'" + this.FormatearTextoSql( lxCuponesTipotarj ) + "'" >>, <<lxCuponesLotafdo >>, <<lxCuponesNcanje >>, <<lxCuponesPventanc >>, <<lxCuponesPtoven >>, <<lxCuponesLote >>, <<"'" + this.ConvertirDateSql( lxCuponesFecafdo ) + "'" >>, <<lxCuponesCuotas >>, <<"'" + this.ConvertirDateSql( lxCuponesFbaja ) + "'" >>, <<lxCuponesNumeronc >>, <<lxCuponesNumcomp >>, <<lxCuponesNrocl >>, <<iif( lxCuponesAutorizado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCuponesUltdig ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFechanc ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFechacomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHbaja ) + "'" >>, <<lxCuponesDesporc >>, <<lxCuponesRecporc >>, <<"'" + this.FormatearTextoSql( lxCuponesQriddeb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesNomtitular ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesTipdoctitu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHora ) + "'" >>, <<lxCuponesRecmonto >>, <<lxCuponesDesmonto >>, <<iif( lxCuponesEsretiroef, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCuponesBasedatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesBasedatosb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesAuttel ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFcielote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesNrodoctitu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSerieb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSerie ) + "'" >>, <<lxCuponesAutoffline >>, <<"'" + this.FormatearTextoSql( lxCuponesHcielote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesNrocomerci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesTeltitu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesCodcli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesPos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesEntfin ) + "'" >>, <<lxCuponesMonto >>, <<iif( lxCuponesValidado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCuponesCodplan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSerial ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesIdpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesMovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesIdorden ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesExtid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesRefexterna ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesIdlapos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesIdgocuotas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesMailgc ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

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
			local  lxCuponesFecexpo, lxCuponesFaltafw, lxCuponesFectrans, lxCuponesFecimpo, lxCuponesFmodifw, lxCuponesNrorefafdo, lxCuponesNroreferen, lxCuponesCotizacion, lxCuponesBdmodifw, lxCuponesBdaltafw, lxCuponesCierrelote, lxCuponesZadsfw, lxCuponesEsttrans, lxCuponesComp, lxCuponesVmodifw, lxCuponesSmodifw, lxCuponesSaltafw, lxCuponesUaltafw, lxCuponesHmodifw, lxCuponesHoraexpo, lxCuponesValtafw, lxCuponesHaltafw, lxCuponesHoraimpo, lxCuponesUmodifw, lxCuponesCodigo, lxCuponesClatar, lxCuponesIdcaja, lxCuponesObs, lxCuponesTxticard, lxCuponesTxtclicard, lxCuponesLetrac, lxCuponesQridtranf, lxCuponesPtoventa, lxCuponesTiponc, lxCuponesTipo, lxCuponesValor, lxCuponesNumafdo, lxCuponesComptipo, lxCuponesPtovenc, lxCuponesLetranc, lxCuponesLetra, lxCuponesNumero, lxCuponesNrointerno, lxCuponesTipotarj, lxCuponesLotafdo, lxCuponesNcanje, lxCuponesPventanc, lxCuponesPtoven, lxCuponesLote, lxCuponesFecafdo, lxCuponesCuotas, lxCuponesFbaja, lxCuponesNumeronc, lxCuponesNumcomp, lxCuponesNrocl, lxCuponesAutorizado, lxCuponesUltdig, lxCuponesFechanc, lxCuponesFechacomp, lxCuponesFecha, lxCuponesHbaja, lxCuponesDesporc, lxCuponesRecporc, lxCuponesQriddeb, lxCuponesNomtitular, lxCuponesMoneda, lxCuponesTipdoctitu, lxCuponesHora, lxCuponesRecmonto, lxCuponesDesmonto, lxCuponesEsretiroef, lxCuponesBasedatos, lxCuponesBasedatosb, lxCuponesAuttel, lxCuponesFcielote, lxCuponesNrodoctitu, lxCuponesSerieb, lxCuponesSerie, lxCuponesAutoffline, lxCuponesHcielote, lxCuponesNrocomerci, lxCuponesTeltitu, lxCuponesCodcli, lxCuponesPos, lxCuponesEntfin, lxCuponesMonto, lxCuponesValidado, lxCuponesCodplan, lxCuponesSerial, lxCuponesIdpago, lxCuponesMovil, lxCuponesIdorden, lxCuponesExtid, lxCuponesRefexterna, lxCuponesIdlapos, lxCuponesIdgocuotas, lxCuponesMailgc
				lxCuponesFecexpo =  .Fechaexpo			lxCuponesFaltafw =  .Fechaaltafw			lxCuponesFectrans =  .Fechatransferencia			lxCuponesFecimpo =  .Fechaimpo			lxCuponesFmodifw =  .Fechamodificacionfw			lxCuponesNrorefafdo =  .Numeroreferenciaafectado			lxCuponesNroreferen =  .Numeroreferencia			lxCuponesCotizacion =  .Cotizacion			lxCuponesBdmodifw =  .Basededatosmodificacionfw			lxCuponesBdaltafw =  .Basededatosaltafw			lxCuponesCierrelote =  .Codigocierredelote			lxCuponesZadsfw =  .Zadsfw			lxCuponesEsttrans =  .Estadotransferencia			lxCuponesComp =  .Comprobante			lxCuponesVmodifw =  .Versionmodificacionfw			lxCuponesSmodifw =  .Seriemodificacionfw			lxCuponesSaltafw =  .Seriealtafw			lxCuponesUaltafw =  .Usuarioaltafw			lxCuponesHmodifw =  .Horamodificacionfw			lxCuponesHoraexpo =  .Horaexpo			lxCuponesValtafw =  .Versionaltafw			lxCuponesHaltafw =  .Horaaltafw			lxCuponesHoraimpo =  .Horaimpo			lxCuponesUmodifw =  .Usuariomodificacionfw			lxCuponesCodigo =  .Codigo			lxCuponesClatar =  upper( .ClaseDeTarjeta_PK ) 			lxCuponesIdcaja =  .Idcaja_PK 			lxCuponesObs =  .Observacion			lxCuponesTxticard =  .Ticketicard			lxCuponesTxtclicard =  .Ticketicardcl			lxCuponesLetrac =  .Letracanje			lxCuponesQridtranf =  .Qrtransactionidposnet			lxCuponesPtoventa =  .Puntodeventa			lxCuponesTiponc =  .Tiponotadecredito			lxCuponesTipo =  .Tipocupon			lxCuponesValor =  upper( .Valor_PK ) 			lxCuponesNumafdo =  .Numerodecuponafectado			lxCuponesComptipo =  .Tipocomprobante			lxCuponesPtovenc =  .Puntodeventacanje			lxCuponesLetranc =  .Letranotadecredito			lxCuponesLetra =  .Letracomprobante			lxCuponesNumero =  .Numerocupon			lxCuponesNrointerno =  .Numerointerno			lxCuponesTipotarj =  .Tipotarjeta			lxCuponesLotafdo =  .Loteafectado			lxCuponesNcanje =  .Numerodecanje			lxCuponesPventanc =  .Puntodeventanotadecredito			lxCuponesPtoven =  .Puntodeventacomprobante			lxCuponesLote =  .Lote			lxCuponesFecafdo =  .Fechadecuponafectado			lxCuponesCuotas =  .Cuotas			lxCuponesFbaja =  .Fechabaja			lxCuponesNumeronc =  .Numeronotadecredito			lxCuponesNumcomp =  .Numerocomprobante			lxCuponesNrocl =  .Numerocierredelote			lxCuponesAutorizado =  .Autorizacionpos			lxCuponesUltdig =  .Ultimosdigitos			lxCuponesFechanc =  .Fechanotadecredito			lxCuponesFechacomp =  .Fechacomprobante			lxCuponesFecha =  .Fechacupon			lxCuponesHbaja =  .Horabaja			lxCuponesDesporc =  .Descuentoporcentaje			lxCuponesRecporc =  .Recargoporcentaje			lxCuponesQriddeb =  .Qrtranfdebinidposnet			lxCuponesNomtitular =  .Nombretitular			lxCuponesMoneda =  upper( .SimboloMonetario_PK ) 			lxCuponesTipdoctitu =  .Tipodocumentotitular			lxCuponesHora =  .Horacupon			lxCuponesRecmonto =  .Recargomonto			lxCuponesDesmonto =  .Descuentomonto			lxCuponesEsretiroef =  .Esretiroefectivo			lxCuponesBasedatos =  .Basededatos			lxCuponesBasedatosb =  .Basededatosbaja			lxCuponesAuttel =  .Autorizaciontelefonica			lxCuponesFcielote =  .Fechacierredelote			lxCuponesNrodoctitu =  .Nrodocumentotitular			lxCuponesSerieb =  .Seriebaja			lxCuponesSerie =  .Serieorigen			lxCuponesAutoffline =  .Autorizaciontelefonicaoffline			lxCuponesHcielote =  .Horacierredelote			lxCuponesNrocomerci =  .Numerocomercio			lxCuponesTeltitu =  .Telefonotitular			lxCuponesCodcli =  upper( .Cliente_PK ) 			lxCuponesPos =  upper( .POS_PK ) 			lxCuponesEntfin =  upper( .EntidadFinanciera_PK ) 			lxCuponesMonto =  .Monto			lxCuponesValidado =  .Validacion			lxCuponesCodplan =  .Codigoplan			lxCuponesSerial =  .Serial			lxCuponesIdpago =  .Idpagoclover			lxCuponesMovil =  .Dispositivomovil			lxCuponesIdorden =  .Idordenclover			lxCuponesExtid =  .Externalidclover			lxCuponesRefexterna =  .Referenciaexterna			lxCuponesIdlapos =  .Idsmartlapos			lxCuponesIdgocuotas =  .Idgocuotas			lxCuponesMailgc =  .Mailgocuotas
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CUPONES set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCuponesFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCuponesFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCuponesFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCuponesFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCuponesFmodifw ) + "'">>,"Nrorefafdo" = <<lxCuponesNrorefafdo>>,"Nroreferen" = <<lxCuponesNroreferen>>,"Cotizacion" = <<lxCuponesCotizacion>>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCuponesBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCuponesBdaltafw ) + "'">>,"Cierrelote" = <<"'" + this.FormatearTextoSql( lxCuponesCierrelote ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCuponesZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCuponesEsttrans ) + "'">>,"Comp" = <<"'" + this.FormatearTextoSql( lxCuponesComp ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCuponesVmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCuponesSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCuponesSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCuponesUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCuponesHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCuponesHoraexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCuponesValtafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCuponesHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCuponesHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCuponesUmodifw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCuponesCodigo ) + "'">>,"Clatar" = <<"'" + this.FormatearTextoSql( lxCuponesClatar ) + "'">>,"Idcaja" = <<lxCuponesIdcaja>>,"Obs" = <<"'" + this.FormatearTextoSql( lxCuponesObs ) + "'">>,"Txticard" = <<"'" + this.FormatearTextoSql( lxCuponesTxticard ) + "'">>,"Txtclicard" = <<"'" + this.FormatearTextoSql( lxCuponesTxtclicard ) + "'">>,"Letrac" = <<"'" + this.FormatearTextoSql( lxCuponesLetrac ) + "'">>,"Qridtranf" = <<"'" + this.FormatearTextoSql( lxCuponesQridtranf ) + "'">>,"Ptoventa" = <<lxCuponesPtoventa>>,"Tiponc" = <<lxCuponesTiponc>>,"Tipo" = <<"'" + this.FormatearTextoSql( lxCuponesTipo ) + "'">>,"Valor" = <<"'" + this.FormatearTextoSql( lxCuponesValor ) + "'">>,"Numafdo" = <<lxCuponesNumafdo>>,"Comptipo" = <<lxCuponesComptipo>>,"Ptovenc" = <<lxCuponesPtovenc>>,"Letranc" = <<"'" + this.FormatearTextoSql( lxCuponesLetranc ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxCuponesLetra ) + "'">>,"Numero" = <<lxCuponesNumero>>,"Nrointerno" = <<lxCuponesNrointerno>>,"Tipotarj" = <<"'" + this.FormatearTextoSql( lxCuponesTipotarj ) + "'">>,"Lotafdo" = <<lxCuponesLotafdo>>,"Ncanje" = <<lxCuponesNcanje>>,"Pventanc" = <<lxCuponesPventanc>>,"Ptoven" = <<lxCuponesPtoven>>,"Lote" = <<lxCuponesLote>>,"Fecafdo" = <<"'" + this.ConvertirDateSql( lxCuponesFecafdo ) + "'">>,"Cuotas" = <<lxCuponesCuotas>>,"Fbaja" = <<"'" + this.ConvertirDateSql( lxCuponesFbaja ) + "'">>,"Numeronc" = <<lxCuponesNumeronc>>,"Numcomp" = <<lxCuponesNumcomp>>,"Nrocl" = <<lxCuponesNrocl>>,"Autorizado" = <<iif( lxCuponesAutorizado, 1, 0 )>>,"Ultdig" = <<"'" + this.FormatearTextoSql( lxCuponesUltdig ) + "'">>,"Fechanc" = <<"'" + this.ConvertirDateSql( lxCuponesFechanc ) + "'">>,"Fechacomp" = <<"'" + this.ConvertirDateSql( lxCuponesFechacomp ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCuponesFecha ) + "'">>,"Hbaja" = <<"'" + this.FormatearTextoSql( lxCuponesHbaja ) + "'">>,"Desporc" = <<lxCuponesDesporc>>,"Recporc" = <<lxCuponesRecporc>>,"Qriddeb" = <<"'" + this.FormatearTextoSql( lxCuponesQriddeb ) + "'">>,"Nomtitular" = <<"'" + this.FormatearTextoSql( lxCuponesNomtitular ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxCuponesMoneda ) + "'">>,"Tipdoctitu" = <<"'" + this.FormatearTextoSql( lxCuponesTipdoctitu ) + "'">>,"Hora" = <<"'" + this.FormatearTextoSql( lxCuponesHora ) + "'">>,"Recmonto" = <<lxCuponesRecmonto>>,"Desmonto" = <<lxCuponesDesmonto>>,"Esretiroef" = <<iif( lxCuponesEsretiroef, 1, 0 )>>,"Basedatos" = <<"'" + this.FormatearTextoSql( lxCuponesBasedatos ) + "'">>,"Basedatosb" = <<"'" + this.FormatearTextoSql( lxCuponesBasedatosb ) + "'">>,"Auttel" = <<"'" + this.FormatearTextoSql( lxCuponesAuttel ) + "'">>,"Fcielote" = <<"'" + this.ConvertirDateSql( lxCuponesFcielote ) + "'">>,"Nrodoctitu" = <<"'" + this.FormatearTextoSql( lxCuponesNrodoctitu ) + "'">>,"Serieb" = <<"'" + this.FormatearTextoSql( lxCuponesSerieb ) + "'">>,"Serie" = <<"'" + this.FormatearTextoSql( lxCuponesSerie ) + "'">>,"Autoffline" = <<lxCuponesAutoffline>>,"Hcielote" = <<"'" + this.FormatearTextoSql( lxCuponesHcielote ) + "'">>,"Nrocomerci" = <<"'" + this.FormatearTextoSql( lxCuponesNrocomerci ) + "'">>,"Teltitu" = <<"'" + this.FormatearTextoSql( lxCuponesTeltitu ) + "'">>,"Codcli" = <<"'" + this.FormatearTextoSql( lxCuponesCodcli ) + "'">>,"Pos" = <<"'" + this.FormatearTextoSql( lxCuponesPos ) + "'">>,"Entfin" = <<"'" + this.FormatearTextoSql( lxCuponesEntfin ) + "'">>,"Monto" = <<lxCuponesMonto>>,"Validado" = <<iif( lxCuponesValidado, 1, 0 )>>,"Codplan" = <<"'" + this.FormatearTextoSql( lxCuponesCodplan ) + "'">>,"Serial" = <<"'" + this.FormatearTextoSql( lxCuponesSerial ) + "'">>,"Idpago" = <<"'" + this.FormatearTextoSql( lxCuponesIdpago ) + "'">>,"Movil" = <<"'" + this.FormatearTextoSql( lxCuponesMovil ) + "'">>,"Idorden" = <<"'" + this.FormatearTextoSql( lxCuponesIdorden ) + "'">>,"Extid" = <<"'" + this.FormatearTextoSql( lxCuponesExtid ) + "'">>,"Refexterna" = <<"'" + this.FormatearTextoSql( lxCuponesRefexterna ) + "'">>,"Idlapos" = <<"'" + this.FormatearTextoSql( lxCuponesIdlapos ) + "'">>,"Idgocuotas" = <<"'" + this.FormatearTextoSql( lxCuponesIdgocuotas ) + "'">>,"Mailgc" = <<"'" + this.FormatearTextoSql( lxCuponesMailgc ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCuponesCodigo ) + "'">> and  CUPONES.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CUPONES where " + this.ConvertirFuncionesSql( " CUPONES.CODIGO != ''" ) )
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
			Local lxCuponesCodigo
			lxCuponesCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Nrorefafdo" as "Numeroreferenciaafectado", "Nroreferen" as "Numeroreferencia", "Cotizacion" as "Cotizacion", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cierrelote" as "Codigocierredelote", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Codigo" as "Codigo", "Clatar" as "Clasedetarjeta", "Idcaja" as "Idcaja", "Obs" as "Observacion", "Txticard" as "Ticketicard", "Txtclicard" as "Ticketicardcl", "Letrac" as "Letracanje", "Qridtranf" as "Qrtransactionidposnet", "Ptoventa" as "Puntodeventa", "Tiponc" as "Tiponotadecredito", "Tipo" as "Tipocupon", "Valor" as "Valor", "Numafdo" as "Numerodecuponafectado", "Comptipo" as "Tipocomprobante", "Ptovenc" as "Puntodeventacanje", "Letranc" as "Letranotadecredito", "Letra" as "Letracomprobante", "Numero" as "Numerocupon", "Nrointerno" as "Numerointerno", "Tipotarj" as "Tipotarjeta", "Lotafdo" as "Loteafectado", "Ncanje" as "Numerodecanje", "Pventanc" as "Puntodeventanotadecredito", "Ptoven" as "Puntodeventacomprobante", "Lote" as "Lote", "Fecafdo" as "Fechadecuponafectado", "Cuotas" as "Cuotas", "Fbaja" as "Fechabaja", "Numeronc" as "Numeronotadecredito", "Numcomp" as "Numerocomprobante", "Nrocl" as "Numerocierredelote", "Autorizado" as "Autorizacionpos", "Ultdig" as "Ultimosdigitos", "Fechanc" as "Fechanotadecredito", "Fechacomp" as "Fechacomprobante", "Fecha" as "Fechacupon", "Hbaja" as "Horabaja", "Desporc" as "Descuentoporcentaje", "Recporc" as "Recargoporcentaje", "Qriddeb" as "Qrtranfdebinidposnet", "Nomtitular" as "Nombretitular", "Moneda" as "Simbolomonetario", "Tipdoctitu" as "Tipodocumentotitular", "Hora" as "Horacupon", "Recmonto" as "Recargomonto", "Desmonto" as "Descuentomonto", "Esretiroef" as "Esretiroefectivo", "Basedatos" as "Basededatos", "Basedatosb" as "Basededatosbaja", "Auttel" as "Autorizaciontelefonica", "Fcielote" as "Fechacierredelote", "Nrodoctitu" as "Nrodocumentotitular", "Serieb" as "Seriebaja", "Serie" as "Serieorigen", "Autoffline" as "Autorizaciontelefonicaoffline", "Hcielote" as "Horacierredelote", "Nrocomerci" as "Numerocomercio", "Teltitu" as "Telefonotitular", "Codcli" as "Cliente", "Pos" as "Pos", "Entfin" as "Entidadfinanciera", "Monto" as "Monto", "Validado" as "Validacion", "Codplan" as "Codigoplan", "Serial" as "Serial", "Idpago" as "Idpagoclover", "Movil" as "Dispositivomovil", "Idorden" as "Idordenclover", "Extid" as "Externalidclover", "Refexterna" as "Referenciaexterna", "Idlapos" as "Idsmartlapos", "Idgocuotas" as "Idgocuotas", "Mailgc" as "Mailgocuotas" from ZooLogic.CUPONES where "Codigo" = <<"'" + this.FormatearTextoSql( lxCuponesCodigo ) + "'">> and  CUPONES.CODIGO != ''
			endtext
			use in select('c_CUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUPON', set( 'Datasession' ) )

			if reccount( 'c_CUPON' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCuponesPtoVenta As Variant, lxCuponesNroInterno As Variant
			lxCuponesPtoVenta = .PuntoDeVenta
			lxCuponesNroInterno = .NumeroInterno
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Nrorefafdo" as "Numeroreferenciaafectado", "Nroreferen" as "Numeroreferencia", "Cotizacion" as "Cotizacion", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cierrelote" as "Codigocierredelote", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Codigo" as "Codigo", "Clatar" as "Clasedetarjeta", "Idcaja" as "Idcaja", "Obs" as "Observacion", "Txticard" as "Ticketicard", "Txtclicard" as "Ticketicardcl", "Letrac" as "Letracanje", "Qridtranf" as "Qrtransactionidposnet", "Ptoventa" as "Puntodeventa", "Tiponc" as "Tiponotadecredito", "Tipo" as "Tipocupon", "Valor" as "Valor", "Numafdo" as "Numerodecuponafectado", "Comptipo" as "Tipocomprobante", "Ptovenc" as "Puntodeventacanje", "Letranc" as "Letranotadecredito", "Letra" as "Letracomprobante", "Numero" as "Numerocupon", "Nrointerno" as "Numerointerno", "Tipotarj" as "Tipotarjeta", "Lotafdo" as "Loteafectado", "Ncanje" as "Numerodecanje", "Pventanc" as "Puntodeventanotadecredito", "Ptoven" as "Puntodeventacomprobante", "Lote" as "Lote", "Fecafdo" as "Fechadecuponafectado", "Cuotas" as "Cuotas", "Fbaja" as "Fechabaja", "Numeronc" as "Numeronotadecredito", "Numcomp" as "Numerocomprobante", "Nrocl" as "Numerocierredelote", "Autorizado" as "Autorizacionpos", "Ultdig" as "Ultimosdigitos", "Fechanc" as "Fechanotadecredito", "Fechacomp" as "Fechacomprobante", "Fecha" as "Fechacupon", "Hbaja" as "Horabaja", "Desporc" as "Descuentoporcentaje", "Recporc" as "Recargoporcentaje", "Qriddeb" as "Qrtranfdebinidposnet", "Nomtitular" as "Nombretitular", "Moneda" as "Simbolomonetario", "Tipdoctitu" as "Tipodocumentotitular", "Hora" as "Horacupon", "Recmonto" as "Recargomonto", "Desmonto" as "Descuentomonto", "Esretiroef" as "Esretiroefectivo", "Basedatos" as "Basededatos", "Basedatosb" as "Basededatosbaja", "Auttel" as "Autorizaciontelefonica", "Fcielote" as "Fechacierredelote", "Nrodoctitu" as "Nrodocumentotitular", "Serieb" as "Seriebaja", "Serie" as "Serieorigen", "Autoffline" as "Autorizaciontelefonicaoffline", "Hcielote" as "Horacierredelote", "Nrocomerci" as "Numerocomercio", "Teltitu" as "Telefonotitular", "Codcli" as "Cliente", "Pos" as "Pos", "Entfin" as "Entidadfinanciera", "Monto" as "Monto", "Validado" as "Validacion", "Codplan" as "Codigoplan", "Serial" as "Serial", "Idpago" as "Idpagoclover", "Movil" as "Dispositivomovil", "Idorden" as "Idordenclover", "Extid" as "Externalidclover", "Refexterna" as "Referenciaexterna", "Idlapos" as "Idsmartlapos", "Idgocuotas" as "Idgocuotas", "Mailgc" as "Mailgocuotas" from ZooLogic.CUPONES where  CUPONES.CODIGO != '' And PtoVenta = <<lxCuponesPtoVenta>> and NroInterno = <<lxCuponesNroInterno>>
			endtext
			use in select('c_CUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUPON', set( 'Datasession' ) )
			if reccount( 'c_CUPON' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCuponesCodigo as Variant
		llRetorno = .t.
		lxCuponesCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CUPONES where "Codigo" = <<"'" + this.FormatearTextoSql( lxCuponesCodigo ) + "'">> and  CUPONES.CODIGO != ''
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .NumeroInterno, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Nrorefafdo" as "Numeroreferenciaafectado", "Nroreferen" as "Numeroreferencia", "Cotizacion" as "Cotizacion", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cierrelote" as "Codigocierredelote", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Codigo" as "Codigo", "Clatar" as "Clasedetarjeta", "Idcaja" as "Idcaja", "Obs" as "Observacion", "Txticard" as "Ticketicard", "Txtclicard" as "Ticketicardcl", "Letrac" as "Letracanje", "Qridtranf" as "Qrtransactionidposnet", "Ptoventa" as "Puntodeventa", "Tiponc" as "Tiponotadecredito", "Tipo" as "Tipocupon", "Valor" as "Valor", "Numafdo" as "Numerodecuponafectado", "Comptipo" as "Tipocomprobante", "Ptovenc" as "Puntodeventacanje", "Letranc" as "Letranotadecredito", "Letra" as "Letracomprobante", "Numero" as "Numerocupon", "Nrointerno" as "Numerointerno", "Tipotarj" as "Tipotarjeta", "Lotafdo" as "Loteafectado", "Ncanje" as "Numerodecanje", "Pventanc" as "Puntodeventanotadecredito", "Ptoven" as "Puntodeventacomprobante", "Lote" as "Lote", "Fecafdo" as "Fechadecuponafectado", "Cuotas" as "Cuotas", "Fbaja" as "Fechabaja", "Numeronc" as "Numeronotadecredito", "Numcomp" as "Numerocomprobante", "Nrocl" as "Numerocierredelote", "Autorizado" as "Autorizacionpos", "Ultdig" as "Ultimosdigitos", "Fechanc" as "Fechanotadecredito", "Fechacomp" as "Fechacomprobante", "Fecha" as "Fechacupon", "Hbaja" as "Horabaja", "Desporc" as "Descuentoporcentaje", "Recporc" as "Recargoporcentaje", "Qriddeb" as "Qrtranfdebinidposnet", "Nomtitular" as "Nombretitular", "Moneda" as "Simbolomonetario", "Tipdoctitu" as "Tipodocumentotitular", "Hora" as "Horacupon", "Recmonto" as "Recargomonto", "Desmonto" as "Descuentomonto", "Esretiroef" as "Esretiroefectivo", "Basedatos" as "Basededatos", "Basedatosb" as "Basededatosbaja", "Auttel" as "Autorizaciontelefonica", "Fcielote" as "Fechacierredelote", "Nrodoctitu" as "Nrodocumentotitular", "Serieb" as "Seriebaja", "Serie" as "Serieorigen", "Autoffline" as "Autorizaciontelefonicaoffline", "Hcielote" as "Horacierredelote", "Nrocomerci" as "Numerocomercio", "Teltitu" as "Telefonotitular", "Codcli" as "Cliente", "Pos" as "Pos", "Entfin" as "Entidadfinanciera", "Monto" as "Monto", "Validado" as "Validacion", "Codplan" as "Codigoplan", "Serial" as "Serial", "Idpago" as "Idpagoclover", "Movil" as "Dispositivomovil", "Idorden" as "Idordenclover", "Extid" as "Externalidclover", "Refexterna" as "Referenciaexterna", "Idlapos" as "Idsmartlapos", "Idgocuotas" as "Idgocuotas", "Mailgc" as "Mailgocuotas" from ZooLogic.CUPONES where  CUPONES.CODIGO != '' order by PtoVenta,NroInterno
			endtext
			use in select('c_CUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUPON', set( 'Datasession' ) )
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .NumeroInterno, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Nrorefafdo" as "Numeroreferenciaafectado", "Nroreferen" as "Numeroreferencia", "Cotizacion" as "Cotizacion", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cierrelote" as "Codigocierredelote", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Codigo" as "Codigo", "Clatar" as "Clasedetarjeta", "Idcaja" as "Idcaja", "Obs" as "Observacion", "Txticard" as "Ticketicard", "Txtclicard" as "Ticketicardcl", "Letrac" as "Letracanje", "Qridtranf" as "Qrtransactionidposnet", "Ptoventa" as "Puntodeventa", "Tiponc" as "Tiponotadecredito", "Tipo" as "Tipocupon", "Valor" as "Valor", "Numafdo" as "Numerodecuponafectado", "Comptipo" as "Tipocomprobante", "Ptovenc" as "Puntodeventacanje", "Letranc" as "Letranotadecredito", "Letra" as "Letracomprobante", "Numero" as "Numerocupon", "Nrointerno" as "Numerointerno", "Tipotarj" as "Tipotarjeta", "Lotafdo" as "Loteafectado", "Ncanje" as "Numerodecanje", "Pventanc" as "Puntodeventanotadecredito", "Ptoven" as "Puntodeventacomprobante", "Lote" as "Lote", "Fecafdo" as "Fechadecuponafectado", "Cuotas" as "Cuotas", "Fbaja" as "Fechabaja", "Numeronc" as "Numeronotadecredito", "Numcomp" as "Numerocomprobante", "Nrocl" as "Numerocierredelote", "Autorizado" as "Autorizacionpos", "Ultdig" as "Ultimosdigitos", "Fechanc" as "Fechanotadecredito", "Fechacomp" as "Fechacomprobante", "Fecha" as "Fechacupon", "Hbaja" as "Horabaja", "Desporc" as "Descuentoporcentaje", "Recporc" as "Recargoporcentaje", "Qriddeb" as "Qrtranfdebinidposnet", "Nomtitular" as "Nombretitular", "Moneda" as "Simbolomonetario", "Tipdoctitu" as "Tipodocumentotitular", "Hora" as "Horacupon", "Recmonto" as "Recargomonto", "Desmonto" as "Descuentomonto", "Esretiroef" as "Esretiroefectivo", "Basedatos" as "Basededatos", "Basedatosb" as "Basededatosbaja", "Auttel" as "Autorizaciontelefonica", "Fcielote" as "Fechacierredelote", "Nrodoctitu" as "Nrodocumentotitular", "Serieb" as "Seriebaja", "Serie" as "Serieorigen", "Autoffline" as "Autorizaciontelefonicaoffline", "Hcielote" as "Horacierredelote", "Nrocomerci" as "Numerocomercio", "Teltitu" as "Telefonotitular", "Codcli" as "Cliente", "Pos" as "Pos", "Entfin" as "Entidadfinanciera", "Monto" as "Monto", "Validado" as "Validacion", "Codplan" as "Codigoplan", "Serial" as "Serial", "Idpago" as "Idpagoclover", "Movil" as "Dispositivomovil", "Idorden" as "Idordenclover", "Extid" as "Externalidclover", "Refexterna" as "Referenciaexterna", "Idlapos" as "Idsmartlapos", "Idgocuotas" as "Idgocuotas", "Mailgc" as "Mailgocuotas" from ZooLogic.CUPONES where  str( PtoVenta, 4, 0) + str( NroInterno, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CUPONES.CODIGO != '' order by PtoVenta,NroInterno
			endtext
			use in select('c_CUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUPON', set( 'Datasession' ) )
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .NumeroInterno, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Nrorefafdo" as "Numeroreferenciaafectado", "Nroreferen" as "Numeroreferencia", "Cotizacion" as "Cotizacion", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cierrelote" as "Codigocierredelote", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Codigo" as "Codigo", "Clatar" as "Clasedetarjeta", "Idcaja" as "Idcaja", "Obs" as "Observacion", "Txticard" as "Ticketicard", "Txtclicard" as "Ticketicardcl", "Letrac" as "Letracanje", "Qridtranf" as "Qrtransactionidposnet", "Ptoventa" as "Puntodeventa", "Tiponc" as "Tiponotadecredito", "Tipo" as "Tipocupon", "Valor" as "Valor", "Numafdo" as "Numerodecuponafectado", "Comptipo" as "Tipocomprobante", "Ptovenc" as "Puntodeventacanje", "Letranc" as "Letranotadecredito", "Letra" as "Letracomprobante", "Numero" as "Numerocupon", "Nrointerno" as "Numerointerno", "Tipotarj" as "Tipotarjeta", "Lotafdo" as "Loteafectado", "Ncanje" as "Numerodecanje", "Pventanc" as "Puntodeventanotadecredito", "Ptoven" as "Puntodeventacomprobante", "Lote" as "Lote", "Fecafdo" as "Fechadecuponafectado", "Cuotas" as "Cuotas", "Fbaja" as "Fechabaja", "Numeronc" as "Numeronotadecredito", "Numcomp" as "Numerocomprobante", "Nrocl" as "Numerocierredelote", "Autorizado" as "Autorizacionpos", "Ultdig" as "Ultimosdigitos", "Fechanc" as "Fechanotadecredito", "Fechacomp" as "Fechacomprobante", "Fecha" as "Fechacupon", "Hbaja" as "Horabaja", "Desporc" as "Descuentoporcentaje", "Recporc" as "Recargoporcentaje", "Qriddeb" as "Qrtranfdebinidposnet", "Nomtitular" as "Nombretitular", "Moneda" as "Simbolomonetario", "Tipdoctitu" as "Tipodocumentotitular", "Hora" as "Horacupon", "Recmonto" as "Recargomonto", "Desmonto" as "Descuentomonto", "Esretiroef" as "Esretiroefectivo", "Basedatos" as "Basededatos", "Basedatosb" as "Basededatosbaja", "Auttel" as "Autorizaciontelefonica", "Fcielote" as "Fechacierredelote", "Nrodoctitu" as "Nrodocumentotitular", "Serieb" as "Seriebaja", "Serie" as "Serieorigen", "Autoffline" as "Autorizaciontelefonicaoffline", "Hcielote" as "Horacierredelote", "Nrocomerci" as "Numerocomercio", "Teltitu" as "Telefonotitular", "Codcli" as "Cliente", "Pos" as "Pos", "Entfin" as "Entidadfinanciera", "Monto" as "Monto", "Validado" as "Validacion", "Codplan" as "Codigoplan", "Serial" as "Serial", "Idpago" as "Idpagoclover", "Movil" as "Dispositivomovil", "Idorden" as "Idordenclover", "Extid" as "Externalidclover", "Refexterna" as "Referenciaexterna", "Idlapos" as "Idsmartlapos", "Idgocuotas" as "Idgocuotas", "Mailgc" as "Mailgocuotas" from ZooLogic.CUPONES where  str( PtoVenta, 4, 0) + str( NroInterno, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CUPONES.CODIGO != '' order by PtoVenta desc,NroInterno desc
			endtext
			use in select('c_CUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUPON', set( 'Datasession' ) )
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .NumeroInterno, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Nrorefafdo" as "Numeroreferenciaafectado", "Nroreferen" as "Numeroreferencia", "Cotizacion" as "Cotizacion", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cierrelote" as "Codigocierredelote", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Codigo" as "Codigo", "Clatar" as "Clasedetarjeta", "Idcaja" as "Idcaja", "Obs" as "Observacion", "Txticard" as "Ticketicard", "Txtclicard" as "Ticketicardcl", "Letrac" as "Letracanje", "Qridtranf" as "Qrtransactionidposnet", "Ptoventa" as "Puntodeventa", "Tiponc" as "Tiponotadecredito", "Tipo" as "Tipocupon", "Valor" as "Valor", "Numafdo" as "Numerodecuponafectado", "Comptipo" as "Tipocomprobante", "Ptovenc" as "Puntodeventacanje", "Letranc" as "Letranotadecredito", "Letra" as "Letracomprobante", "Numero" as "Numerocupon", "Nrointerno" as "Numerointerno", "Tipotarj" as "Tipotarjeta", "Lotafdo" as "Loteafectado", "Ncanje" as "Numerodecanje", "Pventanc" as "Puntodeventanotadecredito", "Ptoven" as "Puntodeventacomprobante", "Lote" as "Lote", "Fecafdo" as "Fechadecuponafectado", "Cuotas" as "Cuotas", "Fbaja" as "Fechabaja", "Numeronc" as "Numeronotadecredito", "Numcomp" as "Numerocomprobante", "Nrocl" as "Numerocierredelote", "Autorizado" as "Autorizacionpos", "Ultdig" as "Ultimosdigitos", "Fechanc" as "Fechanotadecredito", "Fechacomp" as "Fechacomprobante", "Fecha" as "Fechacupon", "Hbaja" as "Horabaja", "Desporc" as "Descuentoporcentaje", "Recporc" as "Recargoporcentaje", "Qriddeb" as "Qrtranfdebinidposnet", "Nomtitular" as "Nombretitular", "Moneda" as "Simbolomonetario", "Tipdoctitu" as "Tipodocumentotitular", "Hora" as "Horacupon", "Recmonto" as "Recargomonto", "Desmonto" as "Descuentomonto", "Esretiroef" as "Esretiroefectivo", "Basedatos" as "Basededatos", "Basedatosb" as "Basededatosbaja", "Auttel" as "Autorizaciontelefonica", "Fcielote" as "Fechacierredelote", "Nrodoctitu" as "Nrodocumentotitular", "Serieb" as "Seriebaja", "Serie" as "Serieorigen", "Autoffline" as "Autorizaciontelefonicaoffline", "Hcielote" as "Horacierredelote", "Nrocomerci" as "Numerocomercio", "Teltitu" as "Telefonotitular", "Codcli" as "Cliente", "Pos" as "Pos", "Entfin" as "Entidadfinanciera", "Monto" as "Monto", "Validado" as "Validacion", "Codplan" as "Codigoplan", "Serial" as "Serial", "Idpago" as "Idpagoclover", "Movil" as "Dispositivomovil", "Idorden" as "Idordenclover", "Extid" as "Externalidclover", "Refexterna" as "Referenciaexterna", "Idlapos" as "Idsmartlapos", "Idgocuotas" as "Idgocuotas", "Mailgc" as "Mailgocuotas" from ZooLogic.CUPONES where  CUPONES.CODIGO != '' order by PtoVenta desc,NroInterno desc
			endtext
			use in select('c_CUPON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CUPON', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fectrans,Fecimpo,Fmodifw,Nrorefafdo,Nroreferen,Cotizacion,Bdmodifw,Bdaltafw," + ;
"Cierrelote,Zadsfw,Esttrans,Comp,Vmodifw,Smodifw,Saltafw,Ualtafw,Hmodifw,Horaexpo,Valtafw,Haltafw,Hor" + ;
"aimpo,Umodifw,Codigo,Clatar,Idcaja,Obs,Txticard,Txtclicard,Letrac,Qridtranf,Ptoventa,Tiponc,Tipo,Val" + ;
"or,Numafdo,Comptipo,Ptovenc,Letranc,Letra,Numero,Nrointerno,Tipotarj,Lotafdo,Ncanje,Pventanc,Ptoven," + ;
"Lote,Fecafdo,Cuotas,Fbaja,Numeronc,Numcomp,Nrocl,Autorizado,Ultdig,Fechanc,Fechacomp,Fecha,Hbaja,Des" + ;
"porc,Recporc,Qriddeb,Nomtitular,Moneda,Tipdoctitu,Hora,Recmonto,Desmonto,Esretiroef,Basedatos,Baseda" + ;
"tosb,Auttel,Fcielote,Nrodoctitu,Serieb,Serie,Autoffline,Hcielote,Nrocomerci,Teltitu,Codcli,Pos,Entfi" + ;
"n,Monto,Validado,Codplan,Serial,Idpago,Movil,Idorden,Extid,Refexterna,Idlapos,Idgocuotas,Mailgc" + ;
" from ZooLogic.CUPONES where  CUPONES.CODIGO != '' and " + lcFiltro )
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
			local  lxCuponesFecexpo, lxCuponesFaltafw, lxCuponesFectrans, lxCuponesFecimpo, lxCuponesFmodifw, lxCuponesNrorefafdo, lxCuponesNroreferen, lxCuponesCotizacion, lxCuponesBdmodifw, lxCuponesBdaltafw, lxCuponesCierrelote, lxCuponesZadsfw, lxCuponesEsttrans, lxCuponesComp, lxCuponesVmodifw, lxCuponesSmodifw, lxCuponesSaltafw, lxCuponesUaltafw, lxCuponesHmodifw, lxCuponesHoraexpo, lxCuponesValtafw, lxCuponesHaltafw, lxCuponesHoraimpo, lxCuponesUmodifw, lxCuponesCodigo, lxCuponesClatar, lxCuponesIdcaja, lxCuponesObs, lxCuponesTxticard, lxCuponesTxtclicard, lxCuponesLetrac, lxCuponesQridtranf, lxCuponesPtoventa, lxCuponesTiponc, lxCuponesTipo, lxCuponesValor, lxCuponesNumafdo, lxCuponesComptipo, lxCuponesPtovenc, lxCuponesLetranc, lxCuponesLetra, lxCuponesNumero, lxCuponesNrointerno, lxCuponesTipotarj, lxCuponesLotafdo, lxCuponesNcanje, lxCuponesPventanc, lxCuponesPtoven, lxCuponesLote, lxCuponesFecafdo, lxCuponesCuotas, lxCuponesFbaja, lxCuponesNumeronc, lxCuponesNumcomp, lxCuponesNrocl, lxCuponesAutorizado, lxCuponesUltdig, lxCuponesFechanc, lxCuponesFechacomp, lxCuponesFecha, lxCuponesHbaja, lxCuponesDesporc, lxCuponesRecporc, lxCuponesQriddeb, lxCuponesNomtitular, lxCuponesMoneda, lxCuponesTipdoctitu, lxCuponesHora, lxCuponesRecmonto, lxCuponesDesmonto, lxCuponesEsretiroef, lxCuponesBasedatos, lxCuponesBasedatosb, lxCuponesAuttel, lxCuponesFcielote, lxCuponesNrodoctitu, lxCuponesSerieb, lxCuponesSerie, lxCuponesAutoffline, lxCuponesHcielote, lxCuponesNrocomerci, lxCuponesTeltitu, lxCuponesCodcli, lxCuponesPos, lxCuponesEntfin, lxCuponesMonto, lxCuponesValidado, lxCuponesCodplan, lxCuponesSerial, lxCuponesIdpago, lxCuponesMovil, lxCuponesIdorden, lxCuponesExtid, lxCuponesRefexterna, lxCuponesIdlapos, lxCuponesIdgocuotas, lxCuponesMailgc
				lxCuponesFecexpo = ctod( '  /  /    ' )			lxCuponesFaltafw = ctod( '  /  /    ' )			lxCuponesFectrans = ctod( '  /  /    ' )			lxCuponesFecimpo = ctod( '  /  /    ' )			lxCuponesFmodifw = ctod( '  /  /    ' )			lxCuponesNrorefafdo = 0			lxCuponesNroreferen = 0			lxCuponesCotizacion = 0			lxCuponesBdmodifw = []			lxCuponesBdaltafw = []			lxCuponesCierrelote = []			lxCuponesZadsfw = []			lxCuponesEsttrans = []			lxCuponesComp = []			lxCuponesVmodifw = []			lxCuponesSmodifw = []			lxCuponesSaltafw = []			lxCuponesUaltafw = []			lxCuponesHmodifw = []			lxCuponesHoraexpo = []			lxCuponesValtafw = []			lxCuponesHaltafw = []			lxCuponesHoraimpo = []			lxCuponesUmodifw = []			lxCuponesCodigo = []			lxCuponesClatar = []			lxCuponesIdcaja = 0			lxCuponesObs = []			lxCuponesTxticard = []			lxCuponesTxtclicard = []			lxCuponesLetrac = []			lxCuponesQridtranf = []			lxCuponesPtoventa = 0			lxCuponesTiponc = 0			lxCuponesTipo = []			lxCuponesValor = []			lxCuponesNumafdo = 0			lxCuponesComptipo = 0			lxCuponesPtovenc = 0			lxCuponesLetranc = []			lxCuponesLetra = []			lxCuponesNumero = 0			lxCuponesNrointerno = 0			lxCuponesTipotarj = []			lxCuponesLotafdo = 0			lxCuponesNcanje = 0			lxCuponesPventanc = 0			lxCuponesPtoven = 0			lxCuponesLote = 0			lxCuponesFecafdo = ctod( '  /  /    ' )			lxCuponesCuotas = 0			lxCuponesFbaja = ctod( '  /  /    ' )			lxCuponesNumeronc = 0			lxCuponesNumcomp = 0			lxCuponesNrocl = 0			lxCuponesAutorizado = .F.			lxCuponesUltdig = []			lxCuponesFechanc = ctod( '  /  /    ' )			lxCuponesFechacomp = ctod( '  /  /    ' )			lxCuponesFecha = ctod( '  /  /    ' )			lxCuponesHbaja = []			lxCuponesDesporc = 0			lxCuponesRecporc = 0			lxCuponesQriddeb = []			lxCuponesNomtitular = []			lxCuponesMoneda = []			lxCuponesTipdoctitu = []			lxCuponesHora = []			lxCuponesRecmonto = 0			lxCuponesDesmonto = 0			lxCuponesEsretiroef = .F.			lxCuponesBasedatos = []			lxCuponesBasedatosb = []			lxCuponesAuttel = []			lxCuponesFcielote = ctod( '  /  /    ' )			lxCuponesNrodoctitu = []			lxCuponesSerieb = []			lxCuponesSerie = []			lxCuponesAutoffline = 0			lxCuponesHcielote = []			lxCuponesNrocomerci = []			lxCuponesTeltitu = []			lxCuponesCodcli = []			lxCuponesPos = []			lxCuponesEntfin = []			lxCuponesMonto = 0			lxCuponesValidado = .F.			lxCuponesCodplan = []			lxCuponesSerial = []			lxCuponesIdpago = []			lxCuponesMovil = []			lxCuponesIdorden = []			lxCuponesExtid = []			lxCuponesRefexterna = []			lxCuponesIdlapos = []			lxCuponesIdgocuotas = []			lxCuponesMailgc = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CUPONES where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CUPONES' + '_' + tcCampo
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
		lcWhere = " Where  CUPONES.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Nrorefafdo" as "Numeroreferenciaafectado", "Nroreferen" as "Numeroreferencia", "Cotizacion" as "Cotizacion", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cierrelote" as "Codigocierredelote", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Codigo" as "Codigo", "Clatar" as "Clasedetarjeta", "Idcaja" as "Idcaja", "Obs" as "Observacion", "Txticard" as "Ticketicard", "Txtclicard" as "Ticketicardcl", "Letrac" as "Letracanje", "Qridtranf" as "Qrtransactionidposnet", "Ptoventa" as "Puntodeventa", "Tiponc" as "Tiponotadecredito", "Tipo" as "Tipocupon", "Valor" as "Valor", "Numafdo" as "Numerodecuponafectado", "Comptipo" as "Tipocomprobante", "Ptovenc" as "Puntodeventacanje", "Letranc" as "Letranotadecredito", "Letra" as "Letracomprobante", "Numero" as "Numerocupon", "Nrointerno" as "Numerointerno", "Tipotarj" as "Tipotarjeta", "Lotafdo" as "Loteafectado", "Ncanje" as "Numerodecanje", "Pventanc" as "Puntodeventanotadecredito", "Ptoven" as "Puntodeventacomprobante", "Lote" as "Lote", "Fecafdo" as "Fechadecuponafectado", "Cuotas" as "Cuotas", "Fbaja" as "Fechabaja", "Numeronc" as "Numeronotadecredito", "Numcomp" as "Numerocomprobante", "Nrocl" as "Numerocierredelote", "Autorizado" as "Autorizacionpos", "Ultdig" as "Ultimosdigitos", "Fechanc" as "Fechanotadecredito", "Fechacomp" as "Fechacomprobante", "Fecha" as "Fechacupon", "Hbaja" as "Horabaja", "Desporc" as "Descuentoporcentaje", "Recporc" as "Recargoporcentaje", "Qriddeb" as "Qrtranfdebinidposnet", "Nomtitular" as "Nombretitular", "Moneda" as "Simbolomonetario", "Tipdoctitu" as "Tipodocumentotitular", "Hora" as "Horacupon", "Recmonto" as "Recargomonto", "Desmonto" as "Descuentomonto", "Esretiroef" as "Esretiroefectivo", "Basedatos" as "Basededatos", "Basedatosb" as "Basededatosbaja", "Auttel" as "Autorizaciontelefonica", "Fcielote" as "Fechacierredelote", "Nrodoctitu" as "Nrodocumentotitular", "Serieb" as "Seriebaja", "Serie" as "Serieorigen", "Autoffline" as "Autorizaciontelefonicaoffline", "Hcielote" as "Horacierredelote", "Nrocomerci" as "Numerocomercio", "Teltitu" as "Telefonotitular", "Codcli" as "Cliente", "Pos" as "Pos", "Entfin" as "Entidadfinanciera", "Monto" as "Monto", "Validado" as "Validacion", "Codplan" as "Codigoplan", "Serial" as "Serial", "Idpago" as "Idpagoclover", "Movil" as "Dispositivomovil", "Idorden" as "Idordenclover", "Extid" as "Externalidclover", "Refexterna" as "Referenciaexterna", "Idlapos" as "Idsmartlapos", "Idgocuotas" as "Idgocuotas", "Mailgc" as "Mailgocuotas"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CUPONES', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'NUMEROREFERENCIAAFECTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREFAFDO AS NUMEROREFERENCIAAFECTADO'
				Case lcAtributo == 'NUMEROREFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREFEREN AS NUMEROREFERENCIA'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZACION AS COTIZACION'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGOCIERREDELOTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIERRELOTE AS CODIGOCIERREDELOTE'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPROBANTE'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CLASEDETARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLATAR AS CLASEDETARJETA'
				Case lcAtributo == 'IDCAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS IDCAJA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'TICKETICARD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TXTICARD AS TICKETICARD'
				Case lcAtributo == 'TICKETICARDCL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TXTCLICARD AS TICKETICARDCL'
				Case lcAtributo == 'LETRACANJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRAC AS LETRACANJE'
				Case lcAtributo == 'QRTRANSACTIONIDPOSNET'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'QRIDTRANF AS QRTRANSACTIONIDPOSNET'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'TIPONOTADECREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPONC AS TIPONOTADECREDITO'
				Case lcAtributo == 'TIPOCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPOCUPON'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'NUMERODECUPONAFECTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMAFDO AS NUMERODECUPONAFECTADO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'PUNTODEVENTACANJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENC AS PUNTODEVENTACANJE'
				Case lcAtributo == 'LETRANOTADECREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRANC AS LETRANOTADECREDITO'
				Case lcAtributo == 'LETRACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRACOMPROBANTE'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMEROCUPON'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROINTERNO AS NUMEROINTERNO'
				Case lcAtributo == 'TIPOTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOTARJ AS TIPOTARJETA'
				Case lcAtributo == 'LOTEAFECTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LOTAFDO AS LOTEAFECTADO'
				Case lcAtributo == 'NUMERODECANJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCANJE AS NUMERODECANJE'
				Case lcAtributo == 'PUNTODEVENTANOTADECREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PVENTANC AS PUNTODEVENTANOTADECREDITO'
				Case lcAtributo == 'PUNTODEVENTACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVEN AS PUNTODEVENTACOMPROBANTE'
				Case lcAtributo == 'LOTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LOTE AS LOTE'
				Case lcAtributo == 'FECHADECUPONAFECTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECAFDO AS FECHADECUPONAFECTADO'
				Case lcAtributo == 'CUOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUOTAS AS CUOTAS'
				Case lcAtributo == 'FECHABAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBAJA AS FECHABAJA'
				Case lcAtributo == 'NUMERONOTADECREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERONC AS NUMERONOTADECREDITO'
				Case lcAtributo == 'NUMEROCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMP AS NUMEROCOMPROBANTE'
				Case lcAtributo == 'NUMEROCIERREDELOTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCL AS NUMEROCIERREDELOTE'
				Case lcAtributo == 'AUTORIZACIONPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTORIZADO AS AUTORIZACIONPOS'
				Case lcAtributo == 'ULTIMOSDIGITOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ULTDIG AS ULTIMOSDIGITOS'
				Case lcAtributo == 'FECHANOTADECREDITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHANC AS FECHANOTADECREDITO'
				Case lcAtributo == 'FECHACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACOMP AS FECHACOMPROBANTE'
				Case lcAtributo == 'FECHACUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHACUPON'
				Case lcAtributo == 'HORABAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HBAJA AS HORABAJA'
				Case lcAtributo == 'DESCUENTOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESPORC AS DESCUENTOPORCENTAJE'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPORC AS RECARGOPORCENTAJE'
				Case lcAtributo == 'QRTRANFDEBINIDPOSNET'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'QRIDDEB AS QRTRANFDEBINIDPOSNET'
				Case lcAtributo == 'NOMBRETITULAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMTITULAR AS NOMBRETITULAR'
				Case lcAtributo == 'SIMBOLOMONETARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS SIMBOLOMONETARIO'
				Case lcAtributo == 'TIPODOCUMENTOTITULAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPDOCTITU AS TIPODOCUMENTOTITULAR'
				Case lcAtributo == 'HORACUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORACUPON'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO AS RECARGOMONTO'
				Case lcAtributo == 'DESCUENTOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMONTO AS DESCUENTOMONTO'
				Case lcAtributo == 'ESRETIROEFECTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESRETIROEF AS ESRETIROEFECTIVO'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDATOS AS BASEDEDATOS'
				Case lcAtributo == 'BASEDEDATOSBAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDATOSB AS BASEDEDATOSBAJA'
				Case lcAtributo == 'AUTORIZACIONTELEFONICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTTEL AS AUTORIZACIONTELEFONICA'
				Case lcAtributo == 'FECHACIERREDELOTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCIELOTE AS FECHACIERREDELOTE'
				Case lcAtributo == 'NRODOCUMENTOTITULAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOCTITU AS NRODOCUMENTOTITULAR'
				Case lcAtributo == 'SERIEBAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIEB AS SERIEBAJA'
				Case lcAtributo == 'SERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS SERIEORIGEN'
				Case lcAtributo == 'AUTORIZACIONTELEFONICAOFFLINE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTOFFLINE AS AUTORIZACIONTELEFONICAOFFLINE'
				Case lcAtributo == 'HORACIERREDELOTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HCIELOTE AS HORACIERREDELOTE'
				Case lcAtributo == 'NUMEROCOMERCIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCOMERCI AS NUMEROCOMERCIO'
				Case lcAtributo == 'TELEFONOTITULAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TELTITU AS TELEFONOTITULAR'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCLI AS CLIENTE'
				Case lcAtributo == 'POS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'POS AS POS'
				Case lcAtributo == 'ENTIDADFINANCIERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTFIN AS ENTIDADFINANCIERA'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'VALIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALIDADO AS VALIDACION'
				Case lcAtributo == 'CODIGOPLAN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODPLAN AS CODIGOPLAN'
				Case lcAtributo == 'SERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIAL AS SERIAL'
				Case lcAtributo == 'IDPAGOCLOVER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDPAGO AS IDPAGOCLOVER'
				Case lcAtributo == 'DISPOSITIVOMOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOVIL AS DISPOSITIVOMOVIL'
				Case lcAtributo == 'IDORDENCLOVER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDORDEN AS IDORDENCLOVER'
				Case lcAtributo == 'EXTERNALIDCLOVER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXTID AS EXTERNALIDCLOVER'
				Case lcAtributo == 'REFERENCIAEXTERNA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REFEXTERNA AS REFERENCIAEXTERNA'
				Case lcAtributo == 'IDSMARTLAPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDLAPOS AS IDSMARTLAPOS'
				Case lcAtributo == 'IDGOCUOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDGOCUOTAS AS IDGOCUOTAS'
				Case lcAtributo == 'MAILGOCUOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAILGC AS MAILGOCUOTAS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROREFERENCIAAFECTADO'
				lcCampo = 'NROREFAFDO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROREFERENCIA'
				lcCampo = 'NROREFEREN'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZACION'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCIERREDELOTE'
				lcCampo = 'CIERRELOTE'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CLASEDETARJETA'
				lcCampo = 'CLATAR'
			Case upper( alltrim( tcAtributo ) ) == 'IDCAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'TICKETICARD'
				lcCampo = 'TXTICARD'
			Case upper( alltrim( tcAtributo ) ) == 'TICKETICARDCL'
				lcCampo = 'TXTCLICARD'
			Case upper( alltrim( tcAtributo ) ) == 'LETRACANJE'
				lcCampo = 'LETRAC'
			Case upper( alltrim( tcAtributo ) ) == 'QRTRANSACTIONIDPOSNET'
				lcCampo = 'QRIDTRANF'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPONOTADECREDITO'
				lcCampo = 'TIPONC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCUPON'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECUPONAFECTADO'
				lcCampo = 'NUMAFDO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'COMPTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTACANJE'
				lcCampo = 'PTOVENC'
			Case upper( alltrim( tcAtributo ) ) == 'LETRANOTADECREDITO'
				lcCampo = 'LETRANC'
			Case upper( alltrim( tcAtributo ) ) == 'LETRACOMPROBANTE'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NROINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOTARJETA'
				lcCampo = 'TIPOTARJ'
			Case upper( alltrim( tcAtributo ) ) == 'LOTEAFECTADO'
				lcCampo = 'LOTAFDO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECANJE'
				lcCampo = 'NCANJE'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTANOTADECREDITO'
				lcCampo = 'PVENTANC'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTACOMPROBANTE'
				lcCampo = 'PTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'LOTE'
				lcCampo = 'LOTE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADECUPONAFECTADO'
				lcCampo = 'FECAFDO'
			Case upper( alltrim( tcAtributo ) ) == 'CUOTAS'
				lcCampo = 'CUOTAS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHABAJA'
				lcCampo = 'FBAJA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERONOTADECREDITO'
				lcCampo = 'NUMERONC'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMPROBANTE'
				lcCampo = 'NUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCIERREDELOTE'
				lcCampo = 'NROCL'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONPOS'
				lcCampo = 'AUTORIZADO'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMOSDIGITOS'
				lcCampo = 'ULTDIG'
			Case upper( alltrim( tcAtributo ) ) == 'FECHANOTADECREDITO'
				lcCampo = 'FECHANC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTE'
				lcCampo = 'FECHACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACUPON'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'HORABAJA'
				lcCampo = 'HBAJA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPORCENTAJE'
				lcCampo = 'DESPORC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPORC'
			Case upper( alltrim( tcAtributo ) ) == 'QRTRANFDEBINIDPOSNET'
				lcCampo = 'QRIDDEB'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRETITULAR'
				lcCampo = 'NOMTITULAR'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIO'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTOTITULAR'
				lcCampo = 'TIPDOCTITU'
			Case upper( alltrim( tcAtributo ) ) == 'HORACUPON'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'RECMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOMONTO'
				lcCampo = 'DESMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'ESRETIROEFECTIVO'
				lcCampo = 'ESRETIROEF'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASEDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSBAJA'
				lcCampo = 'BASEDATOSB'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONTELEFONICA'
				lcCampo = 'AUTTEL'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACIERREDELOTE'
				lcCampo = 'FCIELOTE'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTOTITULAR'
				lcCampo = 'NRODOCTITU'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEBAJA'
				lcCampo = 'SERIEB'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEORIGEN'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONTELEFONICAOFFLINE'
				lcCampo = 'AUTOFFLINE'
			Case upper( alltrim( tcAtributo ) ) == 'HORACIERREDELOTE'
				lcCampo = 'HCIELOTE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMERCIO'
				lcCampo = 'NROCOMERCI'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONOTITULAR'
				lcCampo = 'TELTITU'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CODCLI'
			Case upper( alltrim( tcAtributo ) ) == 'POS'
				lcCampo = 'POS'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADFINANCIERA'
				lcCampo = 'ENTFIN'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'VALIDACION'
				lcCampo = 'VALIDADO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPLAN'
				lcCampo = 'CODPLAN'
			Case upper( alltrim( tcAtributo ) ) == 'SERIAL'
				lcCampo = 'SERIAL'
			Case upper( alltrim( tcAtributo ) ) == 'IDPAGOCLOVER'
				lcCampo = 'IDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'DISPOSITIVOMOVIL'
				lcCampo = 'MOVIL'
			Case upper( alltrim( tcAtributo ) ) == 'IDORDENCLOVER'
				lcCampo = 'IDORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'EXTERNALIDCLOVER'
				lcCampo = 'EXTID'
			Case upper( alltrim( tcAtributo ) ) == 'REFERENCIAEXTERNA'
				lcCampo = 'REFEXTERNA'
			Case upper( alltrim( tcAtributo ) ) == 'IDSMARTLAPOS'
				lcCampo = 'IDLAPOS'
			Case upper( alltrim( tcAtributo ) ) == 'IDGOCUOTAS'
				lcCampo = 'IDGOCUOTAS'
			Case upper( alltrim( tcAtributo ) ) == 'MAILGOCUOTAS'
				lcCampo = 'MAILGC'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCuponesFecexpo, lxCuponesFaltafw, lxCuponesFectrans, lxCuponesFecimpo, lxCuponesFmodifw, lxCuponesNrorefafdo, lxCuponesNroreferen, lxCuponesCotizacion, lxCuponesBdmodifw, lxCuponesBdaltafw, lxCuponesCierrelote, lxCuponesZadsfw, lxCuponesEsttrans, lxCuponesComp, lxCuponesVmodifw, lxCuponesSmodifw, lxCuponesSaltafw, lxCuponesUaltafw, lxCuponesHmodifw, lxCuponesHoraexpo, lxCuponesValtafw, lxCuponesHaltafw, lxCuponesHoraimpo, lxCuponesUmodifw, lxCuponesCodigo, lxCuponesClatar, lxCuponesIdcaja, lxCuponesObs, lxCuponesTxticard, lxCuponesTxtclicard, lxCuponesLetrac, lxCuponesQridtranf, lxCuponesPtoventa, lxCuponesTiponc, lxCuponesTipo, lxCuponesValor, lxCuponesNumafdo, lxCuponesComptipo, lxCuponesPtovenc, lxCuponesLetranc, lxCuponesLetra, lxCuponesNumero, lxCuponesNrointerno, lxCuponesTipotarj, lxCuponesLotafdo, lxCuponesNcanje, lxCuponesPventanc, lxCuponesPtoven, lxCuponesLote, lxCuponesFecafdo, lxCuponesCuotas, lxCuponesFbaja, lxCuponesNumeronc, lxCuponesNumcomp, lxCuponesNrocl, lxCuponesAutorizado, lxCuponesUltdig, lxCuponesFechanc, lxCuponesFechacomp, lxCuponesFecha, lxCuponesHbaja, lxCuponesDesporc, lxCuponesRecporc, lxCuponesQriddeb, lxCuponesNomtitular, lxCuponesMoneda, lxCuponesTipdoctitu, lxCuponesHora, lxCuponesRecmonto, lxCuponesDesmonto, lxCuponesEsretiroef, lxCuponesBasedatos, lxCuponesBasedatosb, lxCuponesAuttel, lxCuponesFcielote, lxCuponesNrodoctitu, lxCuponesSerieb, lxCuponesSerie, lxCuponesAutoffline, lxCuponesHcielote, lxCuponesNrocomerci, lxCuponesTeltitu, lxCuponesCodcli, lxCuponesPos, lxCuponesEntfin, lxCuponesMonto, lxCuponesValidado, lxCuponesCodplan, lxCuponesSerial, lxCuponesIdpago, lxCuponesMovil, lxCuponesIdorden, lxCuponesExtid, lxCuponesRefexterna, lxCuponesIdlapos, lxCuponesIdgocuotas, lxCuponesMailgc
				lxCuponesFecexpo =  .Fechaexpo			lxCuponesFaltafw =  .Fechaaltafw			lxCuponesFectrans =  .Fechatransferencia			lxCuponesFecimpo =  .Fechaimpo			lxCuponesFmodifw =  .Fechamodificacionfw			lxCuponesNrorefafdo =  .Numeroreferenciaafectado			lxCuponesNroreferen =  .Numeroreferencia			lxCuponesCotizacion =  .Cotizacion			lxCuponesBdmodifw =  .Basededatosmodificacionfw			lxCuponesBdaltafw =  .Basededatosaltafw			lxCuponesCierrelote =  .Codigocierredelote			lxCuponesZadsfw =  .Zadsfw			lxCuponesEsttrans =  .Estadotransferencia			lxCuponesComp =  .Comprobante			lxCuponesVmodifw =  .Versionmodificacionfw			lxCuponesSmodifw =  .Seriemodificacionfw			lxCuponesSaltafw =  .Seriealtafw			lxCuponesUaltafw =  .Usuarioaltafw			lxCuponesHmodifw =  .Horamodificacionfw			lxCuponesHoraexpo =  .Horaexpo			lxCuponesValtafw =  .Versionaltafw			lxCuponesHaltafw =  .Horaaltafw			lxCuponesHoraimpo =  .Horaimpo			lxCuponesUmodifw =  .Usuariomodificacionfw			lxCuponesCodigo =  .Codigo			lxCuponesClatar =  upper( .ClaseDeTarjeta_PK ) 			lxCuponesIdcaja =  .Idcaja_PK 			lxCuponesObs =  .Observacion			lxCuponesTxticard =  .Ticketicard			lxCuponesTxtclicard =  .Ticketicardcl			lxCuponesLetrac =  .Letracanje			lxCuponesQridtranf =  .Qrtransactionidposnet			lxCuponesPtoventa =  .Puntodeventa			lxCuponesTiponc =  .Tiponotadecredito			lxCuponesTipo =  .Tipocupon			lxCuponesValor =  upper( .Valor_PK ) 			lxCuponesNumafdo =  .Numerodecuponafectado			lxCuponesComptipo =  .Tipocomprobante			lxCuponesPtovenc =  .Puntodeventacanje			lxCuponesLetranc =  .Letranotadecredito			lxCuponesLetra =  .Letracomprobante			lxCuponesNumero =  .Numerocupon			lxCuponesNrointerno =  .Numerointerno			lxCuponesTipotarj =  .Tipotarjeta			lxCuponesLotafdo =  .Loteafectado			lxCuponesNcanje =  .Numerodecanje			lxCuponesPventanc =  .Puntodeventanotadecredito			lxCuponesPtoven =  .Puntodeventacomprobante			lxCuponesLote =  .Lote			lxCuponesFecafdo =  .Fechadecuponafectado			lxCuponesCuotas =  .Cuotas			lxCuponesFbaja =  .Fechabaja			lxCuponesNumeronc =  .Numeronotadecredito			lxCuponesNumcomp =  .Numerocomprobante			lxCuponesNrocl =  .Numerocierredelote			lxCuponesAutorizado =  .Autorizacionpos			lxCuponesUltdig =  .Ultimosdigitos			lxCuponesFechanc =  .Fechanotadecredito			lxCuponesFechacomp =  .Fechacomprobante			lxCuponesFecha =  .Fechacupon			lxCuponesHbaja =  .Horabaja			lxCuponesDesporc =  .Descuentoporcentaje			lxCuponesRecporc =  .Recargoporcentaje			lxCuponesQriddeb =  .Qrtranfdebinidposnet			lxCuponesNomtitular =  .Nombretitular			lxCuponesMoneda =  upper( .SimboloMonetario_PK ) 			lxCuponesTipdoctitu =  .Tipodocumentotitular			lxCuponesHora =  .Horacupon			lxCuponesRecmonto =  .Recargomonto			lxCuponesDesmonto =  .Descuentomonto			lxCuponesEsretiroef =  .Esretiroefectivo			lxCuponesBasedatos =  .Basededatos			lxCuponesBasedatosb =  .Basededatosbaja			lxCuponesAuttel =  .Autorizaciontelefonica			lxCuponesFcielote =  .Fechacierredelote			lxCuponesNrodoctitu =  .Nrodocumentotitular			lxCuponesSerieb =  .Seriebaja			lxCuponesSerie =  .Serieorigen			lxCuponesAutoffline =  .Autorizaciontelefonicaoffline			lxCuponesHcielote =  .Horacierredelote			lxCuponesNrocomerci =  .Numerocomercio			lxCuponesTeltitu =  .Telefonotitular			lxCuponesCodcli =  upper( .Cliente_PK ) 			lxCuponesPos =  upper( .POS_PK ) 			lxCuponesEntfin =  upper( .EntidadFinanciera_PK ) 			lxCuponesMonto =  .Monto			lxCuponesValidado =  .Validacion			lxCuponesCodplan =  .Codigoplan			lxCuponesSerial =  .Serial			lxCuponesIdpago =  .Idpagoclover			lxCuponesMovil =  .Dispositivomovil			lxCuponesIdorden =  .Idordenclover			lxCuponesExtid =  .Externalidclover			lxCuponesRefexterna =  .Referenciaexterna			lxCuponesIdlapos =  .Idsmartlapos			lxCuponesIdgocuotas =  .Idgocuotas			lxCuponesMailgc =  .Mailgocuotas
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CUPONES ( "Fecexpo","Faltafw","Fectrans","Fecimpo","Fmodifw","Nrorefafdo","Nroreferen","Cotizacion","Bdmodifw","Bdaltafw","Cierrelote","Zadsfw","Esttrans","Comp","Vmodifw","Smodifw","Saltafw","Ualtafw","Hmodifw","Horaexpo","Valtafw","Haltafw","Horaimpo","Umodifw","Codigo","Clatar","Idcaja","Obs","Txticard","Txtclicard","Letrac","Qridtranf","Ptoventa","Tiponc","Tipo","Valor","Numafdo","Comptipo","Ptovenc","Letranc","Letra","Numero","Nrointerno","Tipotarj","Lotafdo","Ncanje","Pventanc","Ptoven","Lote","Fecafdo","Cuotas","Fbaja","Numeronc","Numcomp","Nrocl","Autorizado","Ultdig","Fechanc","Fechacomp","Fecha","Hbaja","Desporc","Recporc","Qriddeb","Nomtitular","Moneda","Tipdoctitu","Hora","Recmonto","Desmonto","Esretiroef","Basedatos","Basedatosb","Auttel","Fcielote","Nrodoctitu","Serieb","Serie","Autoffline","Hcielote","Nrocomerci","Teltitu","Codcli","Pos","Entfin","Monto","Validado","Codplan","Serial","Idpago","Movil","Idorden","Extid","Refexterna","Idlapos","Idgocuotas","Mailgc" ) values ( <<"'" + this.ConvertirDateSql( lxCuponesFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFmodifw ) + "'" >>, <<lxCuponesNrorefafdo >>, <<lxCuponesNroreferen >>, <<lxCuponesCotizacion >>, <<"'" + this.FormatearTextoSql( lxCuponesBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesCierrelote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesComp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesClatar ) + "'" >>, <<lxCuponesIdcaja >>, <<"'" + this.FormatearTextoSql( lxCuponesObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesTxticard ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesTxtclicard ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesLetrac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesQridtranf ) + "'" >>, <<lxCuponesPtoventa >>, <<lxCuponesTiponc >>, <<"'" + this.FormatearTextoSql( lxCuponesTipo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesValor ) + "'" >>, <<lxCuponesNumafdo >>, <<lxCuponesComptipo >>, <<lxCuponesPtovenc >>, <<"'" + this.FormatearTextoSql( lxCuponesLetranc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesLetra ) + "'" >>, <<lxCuponesNumero >>, <<lxCuponesNrointerno >>, <<"'" + this.FormatearTextoSql( lxCuponesTipotarj ) + "'" >>, <<lxCuponesLotafdo >>, <<lxCuponesNcanje >>, <<lxCuponesPventanc >>, <<lxCuponesPtoven >>, <<lxCuponesLote >>, <<"'" + this.ConvertirDateSql( lxCuponesFecafdo ) + "'" >>, <<lxCuponesCuotas >>, <<"'" + this.ConvertirDateSql( lxCuponesFbaja ) + "'" >>, <<lxCuponesNumeronc >>, <<lxCuponesNumcomp >>, <<lxCuponesNrocl >>, <<iif( lxCuponesAutorizado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCuponesUltdig ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFechanc ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFechacomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHbaja ) + "'" >>, <<lxCuponesDesporc >>, <<lxCuponesRecporc >>, <<"'" + this.FormatearTextoSql( lxCuponesQriddeb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesNomtitular ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesTipdoctitu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesHora ) + "'" >>, <<lxCuponesRecmonto >>, <<lxCuponesDesmonto >>, <<iif( lxCuponesEsretiroef, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCuponesBasedatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesBasedatosb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesAuttel ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCuponesFcielote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesNrodoctitu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSerieb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSerie ) + "'" >>, <<lxCuponesAutoffline >>, <<"'" + this.FormatearTextoSql( lxCuponesHcielote ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesNrocomerci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesTeltitu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesCodcli ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesPos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesEntfin ) + "'" >>, <<lxCuponesMonto >>, <<iif( lxCuponesValidado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCuponesCodplan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesSerial ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesIdpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesMovil ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesIdorden ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesExtid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesRefexterna ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesIdlapos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesIdgocuotas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCuponesMailgc ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CUPONES' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCuponesFecexpo, lxCuponesFaltafw, lxCuponesFectrans, lxCuponesFecimpo, lxCuponesFmodifw, lxCuponesNrorefafdo, lxCuponesNroreferen, lxCuponesCotizacion, lxCuponesBdmodifw, lxCuponesBdaltafw, lxCuponesCierrelote, lxCuponesZadsfw, lxCuponesEsttrans, lxCuponesComp, lxCuponesVmodifw, lxCuponesSmodifw, lxCuponesSaltafw, lxCuponesUaltafw, lxCuponesHmodifw, lxCuponesHoraexpo, lxCuponesValtafw, lxCuponesHaltafw, lxCuponesHoraimpo, lxCuponesUmodifw, lxCuponesCodigo, lxCuponesClatar, lxCuponesIdcaja, lxCuponesObs, lxCuponesTxticard, lxCuponesTxtclicard, lxCuponesLetrac, lxCuponesQridtranf, lxCuponesPtoventa, lxCuponesTiponc, lxCuponesTipo, lxCuponesValor, lxCuponesNumafdo, lxCuponesComptipo, lxCuponesPtovenc, lxCuponesLetranc, lxCuponesLetra, lxCuponesNumero, lxCuponesNrointerno, lxCuponesTipotarj, lxCuponesLotafdo, lxCuponesNcanje, lxCuponesPventanc, lxCuponesPtoven, lxCuponesLote, lxCuponesFecafdo, lxCuponesCuotas, lxCuponesFbaja, lxCuponesNumeronc, lxCuponesNumcomp, lxCuponesNrocl, lxCuponesAutorizado, lxCuponesUltdig, lxCuponesFechanc, lxCuponesFechacomp, lxCuponesFecha, lxCuponesHbaja, lxCuponesDesporc, lxCuponesRecporc, lxCuponesQriddeb, lxCuponesNomtitular, lxCuponesMoneda, lxCuponesTipdoctitu, lxCuponesHora, lxCuponesRecmonto, lxCuponesDesmonto, lxCuponesEsretiroef, lxCuponesBasedatos, lxCuponesBasedatosb, lxCuponesAuttel, lxCuponesFcielote, lxCuponesNrodoctitu, lxCuponesSerieb, lxCuponesSerie, lxCuponesAutoffline, lxCuponesHcielote, lxCuponesNrocomerci, lxCuponesTeltitu, lxCuponesCodcli, lxCuponesPos, lxCuponesEntfin, lxCuponesMonto, lxCuponesValidado, lxCuponesCodplan, lxCuponesSerial, lxCuponesIdpago, lxCuponesMovil, lxCuponesIdorden, lxCuponesExtid, lxCuponesRefexterna, lxCuponesIdlapos, lxCuponesIdgocuotas, lxCuponesMailgc
				lxCuponesFecexpo =  .Fechaexpo			lxCuponesFaltafw =  .Fechaaltafw			lxCuponesFectrans =  .Fechatransferencia			lxCuponesFecimpo =  .Fechaimpo			lxCuponesFmodifw =  .Fechamodificacionfw			lxCuponesNrorefafdo =  .Numeroreferenciaafectado			lxCuponesNroreferen =  .Numeroreferencia			lxCuponesCotizacion =  .Cotizacion			lxCuponesBdmodifw =  .Basededatosmodificacionfw			lxCuponesBdaltafw =  .Basededatosaltafw			lxCuponesCierrelote =  .Codigocierredelote			lxCuponesZadsfw =  .Zadsfw			lxCuponesEsttrans =  .Estadotransferencia			lxCuponesComp =  .Comprobante			lxCuponesVmodifw =  .Versionmodificacionfw			lxCuponesSmodifw =  .Seriemodificacionfw			lxCuponesSaltafw =  .Seriealtafw			lxCuponesUaltafw =  .Usuarioaltafw			lxCuponesHmodifw =  .Horamodificacionfw			lxCuponesHoraexpo =  .Horaexpo			lxCuponesValtafw =  .Versionaltafw			lxCuponesHaltafw =  .Horaaltafw			lxCuponesHoraimpo =  .Horaimpo			lxCuponesUmodifw =  .Usuariomodificacionfw			lxCuponesCodigo =  .Codigo			lxCuponesClatar =  upper( .ClaseDeTarjeta_PK ) 			lxCuponesIdcaja =  .Idcaja_PK 			lxCuponesObs =  .Observacion			lxCuponesTxticard =  .Ticketicard			lxCuponesTxtclicard =  .Ticketicardcl			lxCuponesLetrac =  .Letracanje			lxCuponesQridtranf =  .Qrtransactionidposnet			lxCuponesPtoventa =  .Puntodeventa			lxCuponesTiponc =  .Tiponotadecredito			lxCuponesTipo =  .Tipocupon			lxCuponesValor =  upper( .Valor_PK ) 			lxCuponesNumafdo =  .Numerodecuponafectado			lxCuponesComptipo =  .Tipocomprobante			lxCuponesPtovenc =  .Puntodeventacanje			lxCuponesLetranc =  .Letranotadecredito			lxCuponesLetra =  .Letracomprobante			lxCuponesNumero =  .Numerocupon			lxCuponesNrointerno =  .Numerointerno			lxCuponesTipotarj =  .Tipotarjeta			lxCuponesLotafdo =  .Loteafectado			lxCuponesNcanje =  .Numerodecanje			lxCuponesPventanc =  .Puntodeventanotadecredito			lxCuponesPtoven =  .Puntodeventacomprobante			lxCuponesLote =  .Lote			lxCuponesFecafdo =  .Fechadecuponafectado			lxCuponesCuotas =  .Cuotas			lxCuponesFbaja =  .Fechabaja			lxCuponesNumeronc =  .Numeronotadecredito			lxCuponesNumcomp =  .Numerocomprobante			lxCuponesNrocl =  .Numerocierredelote			lxCuponesAutorizado =  .Autorizacionpos			lxCuponesUltdig =  .Ultimosdigitos			lxCuponesFechanc =  .Fechanotadecredito			lxCuponesFechacomp =  .Fechacomprobante			lxCuponesFecha =  .Fechacupon			lxCuponesHbaja =  .Horabaja			lxCuponesDesporc =  .Descuentoporcentaje			lxCuponesRecporc =  .Recargoporcentaje			lxCuponesQriddeb =  .Qrtranfdebinidposnet			lxCuponesNomtitular =  .Nombretitular			lxCuponesMoneda =  upper( .SimboloMonetario_PK ) 			lxCuponesTipdoctitu =  .Tipodocumentotitular			lxCuponesHora =  .Horacupon			lxCuponesRecmonto =  .Recargomonto			lxCuponesDesmonto =  .Descuentomonto			lxCuponesEsretiroef =  .Esretiroefectivo			lxCuponesBasedatos =  .Basededatos			lxCuponesBasedatosb =  .Basededatosbaja			lxCuponesAuttel =  .Autorizaciontelefonica			lxCuponesFcielote =  .Fechacierredelote			lxCuponesNrodoctitu =  .Nrodocumentotitular			lxCuponesSerieb =  .Seriebaja			lxCuponesSerie =  .Serieorigen			lxCuponesAutoffline =  .Autorizaciontelefonicaoffline			lxCuponesHcielote =  .Horacierredelote			lxCuponesNrocomerci =  .Numerocomercio			lxCuponesTeltitu =  .Telefonotitular			lxCuponesCodcli =  upper( .Cliente_PK ) 			lxCuponesPos =  upper( .POS_PK ) 			lxCuponesEntfin =  upper( .EntidadFinanciera_PK ) 			lxCuponesMonto =  .Monto			lxCuponesValidado =  .Validacion			lxCuponesCodplan =  .Codigoplan			lxCuponesSerial =  .Serial			lxCuponesIdpago =  .Idpagoclover			lxCuponesMovil =  .Dispositivomovil			lxCuponesIdorden =  .Idordenclover			lxCuponesExtid =  .Externalidclover			lxCuponesRefexterna =  .Referenciaexterna			lxCuponesIdlapos =  .Idsmartlapos			lxCuponesIdgocuotas =  .Idgocuotas			lxCuponesMailgc =  .Mailgocuotas
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CUPONES.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CUPONES set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCuponesFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCuponesFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCuponesFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCuponesFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCuponesFmodifw ) + "'">>, "Nrorefafdo" = <<lxCuponesNrorefafdo>>, "Nroreferen" = <<lxCuponesNroreferen>>, "Cotizacion" = <<lxCuponesCotizacion>>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCuponesBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCuponesBdaltafw ) + "'">>, "Cierrelote" = <<"'" + this.FormatearTextoSql( lxCuponesCierrelote ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCuponesZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCuponesEsttrans ) + "'">>, "Comp" = <<"'" + this.FormatearTextoSql( lxCuponesComp ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCuponesVmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCuponesSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCuponesSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCuponesUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCuponesHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCuponesHoraexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCuponesValtafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCuponesHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCuponesHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCuponesUmodifw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCuponesCodigo ) + "'">>, "Clatar" = <<"'" + this.FormatearTextoSql( lxCuponesClatar ) + "'">>, "Idcaja" = <<lxCuponesIdcaja>>, "Obs" = <<"'" + this.FormatearTextoSql( lxCuponesObs ) + "'">>, "Txticard" = <<"'" + this.FormatearTextoSql( lxCuponesTxticard ) + "'">>, "Txtclicard" = <<"'" + this.FormatearTextoSql( lxCuponesTxtclicard ) + "'">>, "Letrac" = <<"'" + this.FormatearTextoSql( lxCuponesLetrac ) + "'">>, "Qridtranf" = <<"'" + this.FormatearTextoSql( lxCuponesQridtranf ) + "'">>, "Ptoventa" = <<lxCuponesPtoventa>>, "Tiponc" = <<lxCuponesTiponc>>, "Tipo" = <<"'" + this.FormatearTextoSql( lxCuponesTipo ) + "'">>, "Valor" = <<"'" + this.FormatearTextoSql( lxCuponesValor ) + "'">>, "Numafdo" = <<lxCuponesNumafdo>>, "Comptipo" = <<lxCuponesComptipo>>, "Ptovenc" = <<lxCuponesPtovenc>>, "Letranc" = <<"'" + this.FormatearTextoSql( lxCuponesLetranc ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxCuponesLetra ) + "'">>, "Numero" = <<lxCuponesNumero>>, "Nrointerno" = <<lxCuponesNrointerno>>, "Tipotarj" = <<"'" + this.FormatearTextoSql( lxCuponesTipotarj ) + "'">>, "Lotafdo" = <<lxCuponesLotafdo>>, "Ncanje" = <<lxCuponesNcanje>>, "Pventanc" = <<lxCuponesPventanc>>, "Ptoven" = <<lxCuponesPtoven>>, "Lote" = <<lxCuponesLote>>, "Fecafdo" = <<"'" + this.ConvertirDateSql( lxCuponesFecafdo ) + "'">>, "Cuotas" = <<lxCuponesCuotas>>, "Fbaja" = <<"'" + this.ConvertirDateSql( lxCuponesFbaja ) + "'">>, "Numeronc" = <<lxCuponesNumeronc>>, "Numcomp" = <<lxCuponesNumcomp>>, "Nrocl" = <<lxCuponesNrocl>>, "Autorizado" = <<iif( lxCuponesAutorizado, 1, 0 )>>, "Ultdig" = <<"'" + this.FormatearTextoSql( lxCuponesUltdig ) + "'">>, "Fechanc" = <<"'" + this.ConvertirDateSql( lxCuponesFechanc ) + "'">>, "Fechacomp" = <<"'" + this.ConvertirDateSql( lxCuponesFechacomp ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCuponesFecha ) + "'">>, "Hbaja" = <<"'" + this.FormatearTextoSql( lxCuponesHbaja ) + "'">>, "Desporc" = <<lxCuponesDesporc>>, "Recporc" = <<lxCuponesRecporc>>, "Qriddeb" = <<"'" + this.FormatearTextoSql( lxCuponesQriddeb ) + "'">>, "Nomtitular" = <<"'" + this.FormatearTextoSql( lxCuponesNomtitular ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxCuponesMoneda ) + "'">>, "Tipdoctitu" = <<"'" + this.FormatearTextoSql( lxCuponesTipdoctitu ) + "'">>, "Hora" = <<"'" + this.FormatearTextoSql( lxCuponesHora ) + "'">>, "Recmonto" = <<lxCuponesRecmonto>>, "Desmonto" = <<lxCuponesDesmonto>>, "Esretiroef" = <<iif( lxCuponesEsretiroef, 1, 0 )>>, "Basedatos" = <<"'" + this.FormatearTextoSql( lxCuponesBasedatos ) + "'">>, "Basedatosb" = <<"'" + this.FormatearTextoSql( lxCuponesBasedatosb ) + "'">>, "Auttel" = <<"'" + this.FormatearTextoSql( lxCuponesAuttel ) + "'">>, "Fcielote" = <<"'" + this.ConvertirDateSql( lxCuponesFcielote ) + "'">>, "Nrodoctitu" = <<"'" + this.FormatearTextoSql( lxCuponesNrodoctitu ) + "'">>, "Serieb" = <<"'" + this.FormatearTextoSql( lxCuponesSerieb ) + "'">>, "Serie" = <<"'" + this.FormatearTextoSql( lxCuponesSerie ) + "'">>, "Autoffline" = <<lxCuponesAutoffline>>, "Hcielote" = <<"'" + this.FormatearTextoSql( lxCuponesHcielote ) + "'">>, "Nrocomerci" = <<"'" + this.FormatearTextoSql( lxCuponesNrocomerci ) + "'">>, "Teltitu" = <<"'" + this.FormatearTextoSql( lxCuponesTeltitu ) + "'">>, "Codcli" = <<"'" + this.FormatearTextoSql( lxCuponesCodcli ) + "'">>, "Pos" = <<"'" + this.FormatearTextoSql( lxCuponesPos ) + "'">>, "Entfin" = <<"'" + this.FormatearTextoSql( lxCuponesEntfin ) + "'">>, "Monto" = <<lxCuponesMonto>>, "Validado" = <<iif( lxCuponesValidado, 1, 0 )>>, "Codplan" = <<"'" + this.FormatearTextoSql( lxCuponesCodplan ) + "'">>, "Serial" = <<"'" + this.FormatearTextoSql( lxCuponesSerial ) + "'">>, "Idpago" = <<"'" + this.FormatearTextoSql( lxCuponesIdpago ) + "'">>, "Movil" = <<"'" + this.FormatearTextoSql( lxCuponesMovil ) + "'">>, "Idorden" = <<"'" + this.FormatearTextoSql( lxCuponesIdorden ) + "'">>, "Extid" = <<"'" + this.FormatearTextoSql( lxCuponesExtid ) + "'">>, "Refexterna" = <<"'" + this.FormatearTextoSql( lxCuponesRefexterna ) + "'">>, "Idlapos" = <<"'" + this.FormatearTextoSql( lxCuponesIdlapos ) + "'">>, "Idgocuotas" = <<"'" + this.FormatearTextoSql( lxCuponesIdgocuotas ) + "'">>, "Mailgc" = <<"'" + this.FormatearTextoSql( lxCuponesMailgc ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CUPONES' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CUPONES.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CUPONES where ' + lcFiltro )
			loColeccion.cTabla = 'CUPONES' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CUPONES where  CUPONES.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CUPONES where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CUPONES.CODIGO != ''" )
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
					if empty( .oNumeraciones.ObtenerServicio('NUMEROINTERNO') ) and iif( type( '.NUMEROINTERNO' ) = 'C', int( val( .NUMEROINTERNO ) ),.NUMEROINTERNO ) = .oNumeraciones.UltimoNumero( 'NUMEROINTERNO' )
						.oNumeraciones.Actualizar( 'NUMEROINTERNO' )
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
					.NUMEROINTERNO = .oNumeraciones.grabar( 'NUMEROINTERNO' )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCuponesPtoVenta as variant, lxCuponesNroInterno as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CUPON'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CUPONES Where  PtoVenta = ] + transform( &lcCursor..PtoVenta   ) + [ and NroInterno = ] + transform( &lcCursor..NroInterno ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.CUPONES set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, nrorefafdo = ] + transform( &lcCursor..nrorefafdo )+ [, nroreferen = ] + transform( &lcCursor..nroreferen )+ [, Cotizacion = ] + transform( &lcCursor..Cotizacion )+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CierreLote = ] + "'" + this.FormatearTextoSql( &lcCursor..CierreLote ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..Comp ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, ClaTar = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaTar ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, txticard = ] + "'" + this.FormatearTextoSql( &lcCursor..txticard ) + "'"+ [, txtclicard = ] + "'" + this.FormatearTextoSql( &lcCursor..txtclicard ) + "'"+ [, LetraC = ] + "'" + this.FormatearTextoSql( &lcCursor..LetraC ) + "'"+ [, QRIDTranf = ] + "'" + this.FormatearTextoSql( &lcCursor..QRIDTranf ) + "'"+ [, PtoVenta = ] + transform( &lcCursor..PtoVenta )+ [, TipoNC = ] + transform( &lcCursor..TipoNC )+ [, tipo = ] + "'" + this.FormatearTextoSql( &lcCursor..tipo ) + "'"+ [, Valor = ] + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'"+ [, numafdo = ] + transform( &lcCursor..numafdo )+ [, CompTipo = ] + transform( &lcCursor..CompTipo )+ [, PtoVenC = ] + transform( &lcCursor..PtoVenC )+ [, LetraNC = ] + "'" + this.FormatearTextoSql( &lcCursor..LetraNC ) + "'"+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, NroInterno = ] + transform( &lcCursor..NroInterno )+ [, tipotarj = ] + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'"+ [, lotafdo = ] + transform( &lcCursor..lotafdo )+ [, ncanje = ] + transform( &lcCursor..ncanje )+ [, PVentaNC = ] + transform( &lcCursor..PVentaNC )+ [, PtoVen = ] + transform( &lcCursor..PtoVen )+ [, Lote = ] + transform( &lcCursor..Lote )+ [, fecafdo = ] + "'" + this.ConvertirDateSql( &lcCursor..fecafdo ) + "'"+ [, Cuotas = ] + transform( &lcCursor..Cuotas )+ [, fbaja = ] + "'" + this.ConvertirDateSql( &lcCursor..fbaja ) + "'"+ [, NumeroNC = ] + transform( &lcCursor..NumeroNC )+ [, NumComp = ] + transform( &lcCursor..NumComp )+ [, NroCL = ] + transform( &lcCursor..NroCL )+ [, Autorizado = ] + Transform( iif( &lcCursor..Autorizado, 1, 0 ))+ [, UltDig = ] + "'" + this.FormatearTextoSql( &lcCursor..UltDig ) + "'"+ [, FechaNC = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaNC ) + "'"+ [, FechaComp = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaComp ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Hbaja = ] + "'" + this.FormatearTextoSql( &lcCursor..Hbaja ) + "'"+ [, desporc = ] + transform( &lcCursor..desporc )+ [, recporc = ] + transform( &lcCursor..recporc )+ [, QRIDDeb = ] + "'" + this.FormatearTextoSql( &lcCursor..QRIDDeb ) + "'"+ [, NomTitular = ] + "'" + this.FormatearTextoSql( &lcCursor..NomTitular ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, TipDocTitu = ] + "'" + this.FormatearTextoSql( &lcCursor..TipDocTitu ) + "'"+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, recmonto = ] + transform( &lcCursor..recmonto )+ [, desmonto = ] + transform( &lcCursor..desmonto )+ [, EsRetiroEf = ] + Transform( iif( &lcCursor..EsRetiroEf, 1, 0 ))+ [, BaseDatos = ] + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'"+ [, BaseDatosB = ] + "'" + this.FormatearTextoSql( &lcCursor..BaseDatosB ) + "'"+ [, AutTel = ] + "'" + this.FormatearTextoSql( &lcCursor..AutTel ) + "'"+ [, FCieLote = ] + "'" + this.ConvertirDateSql( &lcCursor..FCieLote ) + "'"+ [, NroDocTitu = ] + "'" + this.FormatearTextoSql( &lcCursor..NroDocTitu ) + "'"+ [, SerieB = ] + "'" + this.FormatearTextoSql( &lcCursor..SerieB ) + "'"+ [, Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'"+ [, AutOffLine = ] + transform( &lcCursor..AutOffLine )+ [, HCieLote = ] + "'" + this.FormatearTextoSql( &lcCursor..HCieLote ) + "'"+ [, NroComerci = ] + "'" + this.FormatearTextoSql( &lcCursor..NroComerci ) + "'"+ [, TelTitu = ] + "'" + this.FormatearTextoSql( &lcCursor..TelTitu ) + "'"+ [, codcli = ] + "'" + this.FormatearTextoSql( &lcCursor..codcli ) + "'"+ [, POS = ] + "'" + this.FormatearTextoSql( &lcCursor..POS ) + "'"+ [, EntFin = ] + "'" + this.FormatearTextoSql( &lcCursor..EntFin ) + "'"+ [, Monto = ] + transform( &lcCursor..Monto )+ [, Validado = ] + Transform( iif( &lcCursor..Validado, 1, 0 ))+ [, codplan = ] + "'" + this.FormatearTextoSql( &lcCursor..codplan ) + "'"+ [, Serial = ] + "'" + this.FormatearTextoSql( &lcCursor..Serial ) + "'"+ [, IdPago = ] + "'" + this.FormatearTextoSql( &lcCursor..IdPago ) + "'"+ [, Movil = ] + "'" + this.FormatearTextoSql( &lcCursor..Movil ) + "'"+ [, IdOrden = ] + "'" + this.FormatearTextoSql( &lcCursor..IdOrden ) + "'"+ [, extId = ] + "'" + this.FormatearTextoSql( &lcCursor..extId ) + "'"+ [, RefExterna = ] + "'" + this.FormatearTextoSql( &lcCursor..RefExterna ) + "'"+ [, IdLaPos = ] + "'" + this.FormatearTextoSql( &lcCursor..IdLaPos ) + "'"+ [, IdGoCuotas = ] + "'" + this.FormatearTextoSql( &lcCursor..IdGoCuotas ) + "'"+ [, mailGC = ] + "'" + this.FormatearTextoSql( &lcCursor..mailGC ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CUPONES Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FALTAFW, FECTRANS, FECIMPO, FMODIFW, nrorefafdo, nroreferen, Cotizacion, BDMODIFW, BDALTAFW, CierreLote, ZADSFW, ESTTRANS, Comp, VMODIFW, SMODIFW, SALTAFW, UALTAFW, HMODIFW, HORAEXPO, VALTAFW, HALTAFW, HORAIMPO, UMODIFW, Codigo, ClaTar, IdCaja, Obs, txticard, txtclicard, LetraC, QRIDTranf, PtoVenta, TipoNC, tipo, Valor, numafdo, CompTipo, PtoVenC, LetraNC, Letra, Numero, NroInterno, tipotarj, lotafdo, ncanje, PVentaNC, PtoVen, Lote, fecafdo, Cuotas, fbaja, NumeroNC, NumComp, NroCL, Autorizado, UltDig, FechaNC, FechaComp, Fecha, Hbaja, desporc, recporc, QRIDDeb, NomTitular, Moneda, TipDocTitu, Hora, recmonto, desmonto, EsRetiroEf, BaseDatos, BaseDatosB, AutTel, FCieLote, NroDocTitu, SerieB, Serie, AutOffLine, HCieLote, NroComerci, TelTitu, codcli, POS, EntFin, Monto, Validado, codplan, Serial, IdPago, Movil, IdOrden, extId, RefExterna, IdLaPos, IdGoCuotas, mailGC
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..nrorefafdo ) + ',' + transform( &lcCursor..nroreferen )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Cotizacion ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CierreLote ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comp ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaTar ) + "'" + ',' + transform( &lcCursor..IdCaja ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..txticard ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..txtclicard ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LetraC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..QRIDTranf ) + "'" + ',' + transform( &lcCursor..PtoVenta ) + ',' + transform( &lcCursor..TipoNC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'" + ',' + transform( &lcCursor..numafdo ) + ',' + transform( &lcCursor..CompTipo ) + ',' + transform( &lcCursor..PtoVenC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..LetraNC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + transform( &lcCursor..NroInterno ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..lotafdo ) + ',' + transform( &lcCursor..ncanje ) + ',' + transform( &lcCursor..PVentaNC ) + ',' + transform( &lcCursor..PtoVen ) + ',' + transform( &lcCursor..Lote ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..fecafdo ) + "'" + ',' + transform( &lcCursor..Cuotas ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..fbaja ) + "'" + ',' + transform( &lcCursor..NumeroNC )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NumComp ) + ',' + transform( &lcCursor..NroCL ) + ',' + Transform( iif( &lcCursor..Autorizado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UltDig ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaNC ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaComp ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hbaja ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..desporc ) + ',' + transform( &lcCursor..recporc ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..QRIDDeb ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NomTitular ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipDocTitu ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..recmonto ) + ',' + transform( &lcCursor..desmonto ) + ',' + Transform( iif( &lcCursor..EsRetiroEf, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BaseDatosB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AutTel ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FCieLote ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..NroDocTitu ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SerieB ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'" + ',' + transform( &lcCursor..AutOffLine ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HCieLote ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NroComerci ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TelTitu ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..codcli ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..POS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EntFin ) + "'" + ',' + transform( &lcCursor..Monto ) + ',' + Transform( iif( &lcCursor..Validado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..codplan ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Serial ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdPago ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Movil ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdOrden ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..extId ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RefExterna ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdLaPos ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdGoCuotas ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..mailGC ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CUPONES ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CUPON'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Punto de venta: ' + transform( &tcCursor..PtoVenta   )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..NroInterno )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CUPON'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CUPON_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CUPON_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CUPON_TXTICARD'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CUPON_TXTCLICARD'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_Cupones')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CUPON'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..PtoVenta ) or isnull( &lcCursor..NroInterno )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CUPON. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CUPON'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( PtoVenta, 4, 0) + str( NroInterno, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( PtoVenta, 4, 0) + str( NroInterno, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CUPON'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  fecafdo   
		* Validar ANTERIORES A 1/1/1753  fbaja     
		* Validar ANTERIORES A 1/1/1753  FechaNC   
		* Validar ANTERIORES A 1/1/1753  FechaComp 
		* Validar ANTERIORES A 1/1/1753  Fecha     
		* Validar ANTERIORES A 1/1/1753  FCieLote  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Cupones') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Cupones
Create Table ZooLogic.TablaTrabajo_Cupones ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"nrorefafdo" numeric( 12, 0 )  null, 
"nroreferen" numeric( 12, 0 )  null, 
"cotizacion" numeric( 15, 5 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"cierrelote" char( 38 )  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"comp" char( 38 )  null, 
"vmodifw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"codigo" char( 38 )  null, 
"clatar" char( 5 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"obs" varchar(max)  null, 
"txticard" varchar(max)  null, 
"txtclicard" varchar(max)  null, 
"letrac" char( 1 )  null, 
"qridtranf" char( 50 )  null, 
"ptoventa" numeric( 4, 0 )  null, 
"tiponc" numeric( 2, 0 )  null, 
"tipo" char( 2 )  null, 
"valor" char( 5 )  null, 
"numafdo" numeric( 12, 0 )  null, 
"comptipo" numeric( 2, 0 )  null, 
"ptovenc" numeric( 4, 0 )  null, 
"letranc" char( 1 )  null, 
"letra" char( 1 )  null, 
"numero" numeric( 12, 0 )  null, 
"nrointerno" numeric( 8, 0 )  null, 
"tipotarj" char( 1 )  null, 
"lotafdo" numeric( 8, 0 )  null, 
"ncanje" numeric( 6, 0 )  null, 
"pventanc" numeric( 4, 0 )  null, 
"ptoven" numeric( 4, 0 )  null, 
"lote" numeric( 8, 0 )  null, 
"fecafdo" datetime  null, 
"cuotas" numeric( 3, 0 )  null, 
"fbaja" datetime  null, 
"numeronc" numeric( 8, 0 )  null, 
"numcomp" numeric( 8, 0 )  null, 
"nrocl" numeric( 8, 0 )  null, 
"autorizado" bit  null, 
"ultdig" char( 20 )  null, 
"fechanc" datetime  null, 
"fechacomp" datetime  null, 
"fecha" datetime  null, 
"hbaja" char( 5 )  null, 
"desporc" numeric( 6, 2 )  null, 
"recporc" numeric( 6, 2 )  null, 
"qriddeb" char( 50 )  null, 
"nomtitular" char( 180 )  null, 
"moneda" char( 10 )  null, 
"tipdoctitu" char( 2 )  null, 
"hora" char( 5 )  null, 
"recmonto" numeric( 12, 2 )  null, 
"desmonto" numeric( 12, 2 )  null, 
"esretiroef" bit  null, 
"basedatos" char( 8 )  null, 
"basedatosb" char( 8 )  null, 
"auttel" char( 6 )  null, 
"fcielote" datetime  null, 
"nrodoctitu" char( 10 )  null, 
"serieb" char( 10 )  null, 
"serie" char( 10 )  null, 
"autoffline" numeric( 1, 0 )  null, 
"hcielote" char( 5 )  null, 
"nrocomerci" char( 15 )  null, 
"teltitu" char( 30 )  null, 
"codcli" char( 5 )  null, 
"pos" char( 10 )  null, 
"entfin" char( 5 )  null, 
"monto" numeric( 17, 2 )  null, 
"validado" bit  null, 
"codplan" char( 10 )  null, 
"serial" char( 20 )  null, 
"idpago" char( 18 )  null, 
"movil" char( 40 )  null, 
"idorden" char( 18 )  null, 
"extid" char( 18 )  null, 
"refexterna" char( 90 )  null, 
"idlapos" char( 50 )  null, 
"idgocuotas" char( 50 )  null, 
"mailgc" char( 80 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_Cupones' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_Cupones' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CUPON'
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
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('nrorefafdo','nrorefafdo')
			.AgregarMapeo('nroreferen','nroreferen')
			.AgregarMapeo('cotizacion','cotizacion')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('cierrelote','cierrelote')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('clatar','clatar')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('txticard','txticard')
			.AgregarMapeo('txtclicard','txtclicard')
			.AgregarMapeo('letrac','letrac')
			.AgregarMapeo('qridtranf','qridtranf')
			.AgregarMapeo('ptoventa','ptoventa')
			.AgregarMapeo('tiponc','tiponc')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('valor','valor')
			.AgregarMapeo('numafdo','numafdo')
			.AgregarMapeo('comptipo','comptipo')
			.AgregarMapeo('ptovenc','ptovenc')
			.AgregarMapeo('letranc','letranc')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('nrointerno','nrointerno')
			.AgregarMapeo('tipotarj','tipotarj')
			.AgregarMapeo('lotafdo','lotafdo')
			.AgregarMapeo('ncanje','ncanje')
			.AgregarMapeo('pventanc','pventanc')
			.AgregarMapeo('ptoven','ptoven')
			.AgregarMapeo('lote','lote')
			.AgregarMapeo('fecafdo','fecafdo')
			.AgregarMapeo('cuotas','cuotas')
			.AgregarMapeo('fbaja','fbaja')
			.AgregarMapeo('numeronc','numeronc')
			.AgregarMapeo('numcomp','numcomp')
			.AgregarMapeo('nrocl','nrocl')
			.AgregarMapeo('autorizado','autorizado')
			.AgregarMapeo('ultdig','ultdig')
			.AgregarMapeo('fechanc','fechanc')
			.AgregarMapeo('fechacomp','fechacomp')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('hbaja','hbaja')
			.AgregarMapeo('desporc','desporc')
			.AgregarMapeo('recporc','recporc')
			.AgregarMapeo('qriddeb','qriddeb')
			.AgregarMapeo('nomtitular','nomtitular')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('tipdoctitu','tipdoctitu')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('recmonto','recmonto')
			.AgregarMapeo('desmonto','desmonto')
			.AgregarMapeo('esretiroef','esretiroef')
			.AgregarMapeo('basedatos','basedatos')
			.AgregarMapeo('basedatosb','basedatosb')
			.AgregarMapeo('auttel','auttel')
			.AgregarMapeo('fcielote','fcielote')
			.AgregarMapeo('nrodoctitu','nrodoctitu')
			.AgregarMapeo('serieb','serieb')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('autoffline','autoffline')
			.AgregarMapeo('hcielote','hcielote')
			.AgregarMapeo('nrocomerci','nrocomerci')
			.AgregarMapeo('teltitu','teltitu')
			.AgregarMapeo('codcli','codcli')
			.AgregarMapeo('pos','pos')
			.AgregarMapeo('entfin','entfin')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('validado','validado')
			.AgregarMapeo('codplan','codplan')
			.AgregarMapeo('serial','serial')
			.AgregarMapeo('idpago','idpago')
			.AgregarMapeo('movil','movil')
			.AgregarMapeo('idorden','idorden')
			.AgregarMapeo('extid','extid')
			.AgregarMapeo('refexterna','refexterna')
			.AgregarMapeo('idlapos','idlapos')
			.AgregarMapeo('idgocuotas','idgocuotas')
			.AgregarMapeo('mailgc','mailgc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_Cupones'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.NROREFAFDO = isnull( d.NROREFAFDO, t.NROREFAFDO ),t.NROREFEREN = isnull( d.NROREFEREN, t.NROREFEREN ),t.COTIZACION = isnull( d.COTIZACION, t.COTIZACION ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CIERRELOTE = isnull( d.CIERRELOTE, t.CIERRELOTE ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.COMP = isnull( d.COMP, t.COMP ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CLATAR = isnull( d.CLATAR, t.CLATAR ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.OBS = isnull( d.OBS, t.OBS ),t.TXTICARD = isnull( d.TXTICARD, t.TXTICARD ),t.TXTCLICARD = isnull( d.TXTCLICARD, t.TXTCLICARD ),t.LETRAC = isnull( d.LETRAC, t.LETRAC ),t.QRIDTRANF = isnull( d.QRIDTRANF, t.QRIDTRANF ),t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),t.TIPONC = isnull( d.TIPONC, t.TIPONC ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.VALOR = isnull( d.VALOR, t.VALOR ),t.NUMAFDO = isnull( d.NUMAFDO, t.NUMAFDO ),t.COMPTIPO = isnull( d.COMPTIPO, t.COMPTIPO ),t.PTOVENC = isnull( d.PTOVENC, t.PTOVENC ),t.LETRANC = isnull( d.LETRANC, t.LETRANC ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),t.TIPOTARJ = isnull( d.TIPOTARJ, t.TIPOTARJ ),t.LOTAFDO = isnull( d.LOTAFDO, t.LOTAFDO ),t.NCANJE = isnull( d.NCANJE, t.NCANJE ),t.PVENTANC = isnull( d.PVENTANC, t.PVENTANC ),t.PTOVEN = isnull( d.PTOVEN, t.PTOVEN ),t.LOTE = isnull( d.LOTE, t.LOTE ),t.FECAFDO = isnull( d.FECAFDO, t.FECAFDO ),t.CUOTAS = isnull( d.CUOTAS, t.CUOTAS ),t.FBAJA = isnull( d.FBAJA, t.FBAJA ),t.NUMERONC = isnull( d.NUMERONC, t.NUMERONC ),t.NUMCOMP = isnull( d.NUMCOMP, t.NUMCOMP ),t.NROCL = isnull( d.NROCL, t.NROCL ),t.AUTORIZADO = isnull( d.AUTORIZADO, t.AUTORIZADO ),t.ULTDIG = isnull( d.ULTDIG, t.ULTDIG ),t.FECHANC = isnull( d.FECHANC, t.FECHANC ),t.FECHACOMP = isnull( d.FECHACOMP, t.FECHACOMP ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.HBAJA = isnull( d.HBAJA, t.HBAJA ),t.DESPORC = isnull( d.DESPORC, t.DESPORC ),t.RECPORC = isnull( d.RECPORC, t.RECPORC ),t.QRIDDEB = isnull( d.QRIDDEB, t.QRIDDEB ),t.NOMTITULAR = isnull( d.NOMTITULAR, t.NOMTITULAR ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.TIPDOCTITU = isnull( d.TIPDOCTITU, t.TIPDOCTITU ),t.HORA = isnull( d.HORA, t.HORA ),t.RECMONTO = isnull( d.RECMONTO, t.RECMONTO ),t.DESMONTO = isnull( d.DESMONTO, t.DESMONTO ),t.ESRETIROEF = isnull( d.ESRETIROEF, t.ESRETIROEF ),t.BASEDATOS = isnull( d.BASEDATOS, t.BASEDATOS ),t.BASEDATOSB = isnull( d.BASEDATOSB, t.BASEDATOSB ),t.AUTTEL = isnull( d.AUTTEL, t.AUTTEL ),t.FCIELOTE = isnull( d.FCIELOTE, t.FCIELOTE ),t.NRODOCTITU = isnull( d.NRODOCTITU, t.NRODOCTITU ),t.SERIEB = isnull( d.SERIEB, t.SERIEB ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.AUTOFFLINE = isnull( d.AUTOFFLINE, t.AUTOFFLINE ),t.HCIELOTE = isnull( d.HCIELOTE, t.HCIELOTE ),t.NROCOMERCI = isnull( d.NROCOMERCI, t.NROCOMERCI ),t.TELTITU = isnull( d.TELTITU, t.TELTITU ),t.CODCLI = isnull( d.CODCLI, t.CODCLI ),t.POS = isnull( d.POS, t.POS ),t.ENTFIN = isnull( d.ENTFIN, t.ENTFIN ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.VALIDADO = isnull( d.VALIDADO, t.VALIDADO ),t.CODPLAN = isnull( d.CODPLAN, t.CODPLAN ),t.SERIAL = isnull( d.SERIAL, t.SERIAL ),t.IDPAGO = isnull( d.IDPAGO, t.IDPAGO ),t.MOVIL = isnull( d.MOVIL, t.MOVIL ),t.IDORDEN = isnull( d.IDORDEN, t.IDORDEN ),t.EXTID = isnull( d.EXTID, t.EXTID ),t.REFEXTERNA = isnull( d.REFEXTERNA, t.REFEXTERNA ),t.IDLAPOS = isnull( d.IDLAPOS, t.IDLAPOS ),t.IDGOCUOTAS = isnull( d.IDGOCUOTAS, t.IDGOCUOTAS ),t.MAILGC = isnull( d.MAILGC, t.MAILGC )
					from ZooLogic.CUPONES t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.PtoVenta = d.PtoVenta
							 and  t.NroInterno = d.NroInterno
				-- Fin Updates
				insert into ZooLogic.CUPONES(Fecexpo,Faltafw,Fectrans,Fecimpo,Fmodifw,Nrorefafdo,Nroreferen,Cotizacion,Bdmodifw,Bdaltafw,Cierrelote,Zadsfw,Esttrans,Comp,Vmodifw,Smodifw,Saltafw,Ualtafw,Hmodifw,Horaexpo,Valtafw,Haltafw,Horaimpo,Umodifw,Codigo,Clatar,Idcaja,Obs,Txticard,Txtclicard,Letrac,Qridtranf,Ptoventa,Tiponc,Tipo,Valor,Numafdo,Comptipo,Ptovenc,Letranc,Letra,Numero,Nrointerno,Tipotarj,Lotafdo,Ncanje,Pventanc,Ptoven,Lote,Fecafdo,Cuotas,Fbaja,Numeronc,Numcomp,Nrocl,Autorizado,Ultdig,Fechanc,Fechacomp,Fecha,Hbaja,Desporc,Recporc,Qriddeb,Nomtitular,Moneda,Tipdoctitu,Hora,Recmonto,Desmonto,Esretiroef,Basedatos,Basedatosb,Auttel,Fcielote,Nrodoctitu,Serieb,Serie,Autoffline,Hcielote,Nrocomerci,Teltitu,Codcli,Pos,Entfin,Monto,Validado,Codplan,Serial,Idpago,Movil,Idorden,Extid,Refexterna,Idlapos,Idgocuotas,Mailgc)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.NROREFAFDO,0),isnull( d.NROREFEREN,0),isnull( d.COTIZACION,0),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.CIERRELOTE,''),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.COMP,''),isnull( d.VMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.VALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.CODIGO,''),isnull( d.CLATAR,''),isnull( d.IDCAJA,0),isnull( d.OBS,''),isnull( d.TXTICARD,''),isnull( d.TXTCLICARD,''),isnull( d.LETRAC,''),isnull( d.QRIDTRANF,''),isnull( d.PTOVENTA,0),isnull( d.TIPONC,0),isnull( d.TIPO,''),isnull( d.VALOR,''),isnull( d.NUMAFDO,0),isnull( d.COMPTIPO,0),isnull( d.PTOVENC,0),isnull( d.LETRANC,''),isnull( d.LETRA,''),isnull( d.NUMERO,0),isnull( d.NROINTERNO,0),isnull( d.TIPOTARJ,''),isnull( d.LOTAFDO,0),isnull( d.NCANJE,0),isnull( d.PVENTANC,0),isnull( d.PTOVEN,0),isnull( d.LOTE,0),isnull( d.FECAFDO,''),isnull( d.CUOTAS,0),isnull( d.FBAJA,''),isnull( d.NUMERONC,0),isnull( d.NUMCOMP,0),isnull( d.NROCL,0),isnull( d.AUTORIZADO,0),isnull( d.ULTDIG,''),isnull( d.FECHANC,''),isnull( d.FECHACOMP,''),isnull( d.FECHA,''),isnull( d.HBAJA,''),isnull( d.DESPORC,0),isnull( d.RECPORC,0),isnull( d.QRIDDEB,''),isnull( d.NOMTITULAR,''),isnull( d.MONEDA,''),isnull( d.TIPDOCTITU,''),isnull( d.HORA,''),isnull( d.RECMONTO,0),isnull( d.DESMONTO,0),isnull( d.ESRETIROEF,0),isnull( d.BASEDATOS,''),isnull( d.BASEDATOSB,''),isnull( d.AUTTEL,''),isnull( d.FCIELOTE,''),isnull( d.NRODOCTITU,''),isnull( d.SERIEB,''),isnull( d.SERIE,''),isnull( d.AUTOFFLINE,0),isnull( d.HCIELOTE,''),isnull( d.NROCOMERCI,''),isnull( d.TELTITU,''),isnull( d.CODCLI,''),isnull( d.POS,''),isnull( d.ENTFIN,''),isnull( d.MONTO,0),isnull( d.VALIDADO,0),isnull( d.CODPLAN,''),isnull( d.SERIAL,''),isnull( d.IDPAGO,''),isnull( d.MOVIL,''),isnull( d.IDORDEN,''),isnull( d.EXTID,''),isnull( d.REFEXTERNA,''),isnull( d.IDLAPOS,''),isnull( d.IDGOCUOTAS,''),isnull( d.MAILGC,'')
						From deleted d left join ZooLogic.CUPONES pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.CUPONES cc 
							 on  d.PtoVenta = cc.PtoVenta
							 and  d.NroInterno = cc.NroInterno
						Where pk.Codigo Is Null 
							 and cc.PtoVenta Is Null 
							 and cc.NroInterno Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: PUNTO DE VENTA ' + cast( d.PtoVenta as Varchar(4) ) + ', NÚMERO ' + cast( d.NroInterno as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.CUPONES t inner join deleted d 
							on   t.PtoVenta = d.PtoVenta
							 and  t.NroInterno = d.NroInterno
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: PUNTO DE VENTA ' + cast( d.PtoVenta as Varchar(4) ) + ', NÚMERO ' + cast( d.NroInterno as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CUPONES t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.PtoVenta = h.PtoVenta
							 and   t.NroInterno = h.NroInterno
							where   h.PtoVenta is null 
							 and   h.NroInterno is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Cupones') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Cupones
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CUPON' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Numeroreferenciaafectado = nvl( c_CUPON.Numeroreferenciaafectado, 0 )
					.Numeroreferencia = nvl( c_CUPON.Numeroreferencia, 0 )
					.Cotizacion = nvl( c_CUPON.Cotizacion, 0 )
					.Basededatosmodificacionfw = nvl( c_CUPON.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CUPON.Basededatosaltafw, [] )
					.Codigocierredelote = nvl( c_CUPON.Codigocierredelote, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_CUPON.Estadotransferencia, [] )
					.Comprobante = nvl( c_CUPON.Comprobante, [] )
					.Versionmodificacionfw = nvl( c_CUPON.Versionmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_CUPON.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_CUPON.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_CUPON.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_CUPON.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_CUPON.Horaexpo, [] )
					.Versionaltafw = nvl( c_CUPON.Versionaltafw, [] )
					.Horaaltafw = nvl( c_CUPON.Horaaltafw, [] )
					.Horaimpo = nvl( c_CUPON.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_CUPON.Usuariomodificacionfw, [] )
					.Codigo = nvl( c_CUPON.Codigo, [] )
					.Clasedetarjeta_PK =  nvl( c_CUPON.Clasedetarjeta, [] )
					.Idcaja_PK =  nvl( c_CUPON.Idcaja, 0 )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					lcValor = This.ObtenerMemo( 'c_Ticketicard')
					.Ticketicard = lcValor 
					lcValor = This.ObtenerMemo( 'c_Ticketicardcl')
					.Ticketicardcl = lcValor 
					.Letracanje = nvl( c_CUPON.Letracanje, [] )
					.Qrtransactionidposnet = nvl( c_CUPON.Qrtransactionidposnet, [] )
					.Puntodeventa = nvl( c_CUPON.Puntodeventa, 0 )
					.Tiponotadecredito = nvl( c_CUPON.Tiponotadecredito, 0 )
					.Tipocupon = nvl( c_CUPON.Tipocupon, [] )
					.Valor_PK =  nvl( c_CUPON.Valor, [] )
					.Numerodecuponafectado = nvl( c_CUPON.Numerodecuponafectado, 0 )
					.Tipocomprobante = nvl( c_CUPON.Tipocomprobante, 0 )
					.Puntodeventacanje = nvl( c_CUPON.Puntodeventacanje, 0 )
					.Letranotadecredito = nvl( c_CUPON.Letranotadecredito, [] )
					.Letracomprobante = nvl( c_CUPON.Letracomprobante, [] )
					.Numerocupon = nvl( c_CUPON.Numerocupon, 0 )
					.Numerointerno = nvl( c_CUPON.Numerointerno, 0 )
					.Tipotarjeta = nvl( c_CUPON.Tipotarjeta, [] )
					.Loteafectado = nvl( c_CUPON.Loteafectado, 0 )
					.Numerodecanje = nvl( c_CUPON.Numerodecanje, 0 )
					.Puntodeventanotadecredito = nvl( c_CUPON.Puntodeventanotadecredito, 0 )
					.Puntodeventacomprobante = nvl( c_CUPON.Puntodeventacomprobante, 0 )
					.Lote = nvl( c_CUPON.Lote, 0 )
					.Fechadecuponafectado = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechadecuponafectado, ctod( '  /  /    ' ) ) )
					.Cuotas = nvl( c_CUPON.Cuotas, 0 )
					.Fechabaja = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechabaja, ctod( '  /  /    ' ) ) )
					.Numeronotadecredito = nvl( c_CUPON.Numeronotadecredito, 0 )
					.Numerocomprobante = nvl( c_CUPON.Numerocomprobante, 0 )
					.Numerocierredelote = nvl( c_CUPON.Numerocierredelote, 0 )
					.Autorizacionpos = nvl( c_CUPON.Autorizacionpos, .F. )
					.Ultimosdigitos = nvl( c_CUPON.Ultimosdigitos, [] )
					.Fechanotadecredito = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechanotadecredito, ctod( '  /  /    ' ) ) )
					.Fechacomprobante = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechacomprobante, ctod( '  /  /    ' ) ) )
					.Fechacupon = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechacupon, ctod( '  /  /    ' ) ) )
					.Horabaja = nvl( c_CUPON.Horabaja, [] )
					.Descuentoporcentaje = nvl( c_CUPON.Descuentoporcentaje, 0 )
					.Recargoporcentaje = nvl( c_CUPON.Recargoporcentaje, 0 )
					.Qrtranfdebinidposnet = nvl( c_CUPON.Qrtranfdebinidposnet, [] )
					.Nombretitular = nvl( c_CUPON.Nombretitular, [] )
					.Simbolomonetario_PK =  nvl( c_CUPON.Simbolomonetario, [] )
					.Tipodocumentotitular = nvl( c_CUPON.Tipodocumentotitular, [] )
					.Horacupon = nvl( c_CUPON.Horacupon, [] )
					.Recargomonto = nvl( c_CUPON.Recargomonto, 0 )
					.Descuentomonto = nvl( c_CUPON.Descuentomonto, 0 )
					.Esretiroefectivo = nvl( c_CUPON.Esretiroefectivo, .F. )
					.Basededatos = nvl( c_CUPON.Basededatos, [] )
					.Basededatosbaja = nvl( c_CUPON.Basededatosbaja, [] )
					.Autorizaciontelefonica = nvl( c_CUPON.Autorizaciontelefonica, [] )
					.Fechacierredelote = GoLibrerias.ObtenerFechaFormateada( nvl( c_CUPON.Fechacierredelote, ctod( '  /  /    ' ) ) )
					.Nrodocumentotitular = nvl( c_CUPON.Nrodocumentotitular, [] )
					.Seriebaja = nvl( c_CUPON.Seriebaja, [] )
					.Serieorigen = nvl( c_CUPON.Serieorigen, [] )
					.Autorizaciontelefonicaoffline = nvl( c_CUPON.Autorizaciontelefonicaoffline, 0 )
					.Horacierredelote = nvl( c_CUPON.Horacierredelote, [] )
					.Numerocomercio = nvl( c_CUPON.Numerocomercio, [] )
					.Telefonotitular = nvl( c_CUPON.Telefonotitular, [] )
					.Cliente_PK =  nvl( c_CUPON.Cliente, [] )
					.Pos_PK =  nvl( c_CUPON.Pos, [] )
					.Entidadfinanciera_PK =  nvl( c_CUPON.Entidadfinanciera, [] )
					.Monto = nvl( c_CUPON.Monto, 0 )
					.Validacion = nvl( c_CUPON.Validacion, .F. )
					.Codigoplan = nvl( c_CUPON.Codigoplan, [] )
					.Serial = nvl( c_CUPON.Serial, [] )
					.Idpagoclover = nvl( c_CUPON.Idpagoclover, [] )
					.Dispositivomovil = nvl( c_CUPON.Dispositivomovil, [] )
					.Idordenclover = nvl( c_CUPON.Idordenclover, [] )
					.Externalidclover = nvl( c_CUPON.Externalidclover, [] )
					.Referenciaexterna = nvl( c_CUPON.Referenciaexterna, [] )
					.Idsmartlapos = nvl( c_CUPON.Idsmartlapos, [] )
					.Idgocuotas = nvl( c_CUPON.Idgocuotas, [] )
					.Mailgocuotas = nvl( c_CUPON.Mailgocuotas, [] )
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
			lxRetorno = c_CUPON.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_CUPON.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CUPONES' )
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
								from ZooLogic.CUPONES 
								Where   CUPONES.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CUPONES", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Nrorefafdo" as "Numeroreferenciaafectado", "Nroreferen" as "Numeroreferencia", "Cotizacion" as "Cotizacion", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Cierrelote" as "Codigocierredelote", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Comp" as "Comprobante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Codigo" as "Codigo", "Clatar" as "Clasedetarjeta", "Idcaja" as "Idcaja", "Obs" as "Observacion", "Txticard" as "Ticketicard", "Txtclicard" as "Ticketicardcl", "Letrac" as "Letracanje", "Qridtranf" as "Qrtransactionidposnet", "Ptoventa" as "Puntodeventa", "Tiponc" as "Tiponotadecredito", "Tipo" as "Tipocupon", "Valor" as "Valor", "Numafdo" as "Numerodecuponafectado", "Comptipo" as "Tipocomprobante", "Ptovenc" as "Puntodeventacanje", "Letranc" as "Letranotadecredito", "Letra" as "Letracomprobante", "Numero" as "Numerocupon", "Nrointerno" as "Numerointerno", "Tipotarj" as "Tipotarjeta", "Lotafdo" as "Loteafectado", "Ncanje" as "Numerodecanje", "Pventanc" as "Puntodeventanotadecredito", "Ptoven" as "Puntodeventacomprobante", "Lote" as "Lote", "Fecafdo" as "Fechadecuponafectado", "Cuotas" as "Cuotas", "Fbaja" as "Fechabaja", "Numeronc" as "Numeronotadecredito", "Numcomp" as "Numerocomprobante", "Nrocl" as "Numerocierredelote", "Autorizado" as "Autorizacionpos", "Ultdig" as "Ultimosdigitos", "Fechanc" as "Fechanotadecredito", "Fechacomp" as "Fechacomprobante", "Fecha" as "Fechacupon", "Hbaja" as "Horabaja", "Desporc" as "Descuentoporcentaje", "Recporc" as "Recargoporcentaje", "Qriddeb" as "Qrtranfdebinidposnet", "Nomtitular" as "Nombretitular", "Moneda" as "Simbolomonetario", "Tipdoctitu" as "Tipodocumentotitular", "Hora" as "Horacupon", "Recmonto" as "Recargomonto", "Desmonto" as "Descuentomonto", "Esretiroef" as "Esretiroefectivo", "Basedatos" as "Basededatos", "Basedatosb" as "Basededatosbaja", "Auttel" as "Autorizaciontelefonica", "Fcielote" as "Fechacierredelote", "Nrodoctitu" as "Nrodocumentotitular", "Serieb" as "Seriebaja", "Serie" as "Serieorigen", "Autoffline" as "Autorizaciontelefonicaoffline", "Hcielote" as "Horacierredelote", "Nrocomerci" as "Numerocomercio", "Teltitu" as "Telefonotitular", "Codcli" as "Cliente", "Pos" as "Pos", "Entfin" as "Entidadfinanciera", "Monto" as "Monto", "Validado" as "Validacion", "Codplan" as "Codigoplan", "Serial" as "Serial", "Idpago" as "Idpagoclover", "Movil" as "Dispositivomovil", "Idorden" as "Idordenclover", "Extid" as "Externalidclover", "Refexterna" as "Referenciaexterna", "Idlapos" as "Idsmartlapos", "Idgocuotas" as "Idgocuotas", "Mailgc" as "Mailgocuotas"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CUPONES 
								Where   CUPONES.CODIGO != ''
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
	Tabla = 'CUPONES'
	Filtro = " CUPONES.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CUPONES.CODIGO != ''"
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
	<row entidad="CUPON                                   " atributo="FECHAEXPO                               " tabla="CUPONES        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHAALTAFW                             " tabla="CUPONES        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHATRANSFERENCIA                      " tabla="CUPONES        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHAIMPO                               " tabla="CUPONES        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHAMODIFICACIONFW                     " tabla="CUPONES        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMEROREFERENCIAAFECTADO                " tabla="CUPONES        " campo="NROREFAFDO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMEROREFERENCIA                        " tabla="CUPONES        " campo="NROREFEREN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="COTIZACION                              " tabla="CUPONES        " campo="COTIZACION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CUPONES        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="BASEDEDATOSALTAFW                       " tabla="CUPONES        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="CODIGOCIERREDELOTE                      " tabla="CUPONES        " campo="CIERRELOTE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="ZADSFW                                  " tabla="CUPONES        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="ESTADOTRANSFERENCIA                     " tabla="CUPONES        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="COMPROBANTE                             " tabla="CUPONES        " campo="COMP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="VERSIONMODIFICACIONFW                   " tabla="CUPONES        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="SERIEMODIFICACIONFW                     " tabla="CUPONES        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="SERIEALTAFW                             " tabla="CUPONES        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="USUARIOALTAFW                           " tabla="CUPONES        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="HORAMODIFICACIONFW                      " tabla="CUPONES        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="HORAEXPO                                " tabla="CUPONES        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="VERSIONALTAFW                           " tabla="CUPONES        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="HORAALTAFW                              " tabla="CUPONES        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="HORAIMPO                                " tabla="CUPONES        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="USUARIOMODIFICACIONFW                   " tabla="CUPONES        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="CODIGO                                  " tabla="CUPONES        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="CLASEDETARJETA                          " tabla="CUPONES        " campo="CLATAR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASEDETARJETA                          " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="26" etiqueta="grupo, subgrupo, tiposubgrupo, descripciongrupo, descripcionsubgrupo, genhabilitar, tabla, campo, etiquetacorta width 10 normal for alta and upper( entidad ) = " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="IDCAJA                                  " tabla="CUPONES        " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="OBSERVACION                             " tabla="CUPONES        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="TICKETICARD                             " tabla="CUPONES        " campo="TXTICARD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Cupón I-Card                                                                                                                                                    " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="TICKETICARDCL                           " tabla="CUPONES        " campo="TXTCLICARD" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cupón I-Card para cliente                                                                                                                                       " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="LETRACANJE                              " tabla="CUPONES        " campo="LETRAC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Comprobante                                                                                                                                                     " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="QRTRANSACTIONIDPOSNET                   " tabla="CUPONES        " campo="QRIDTRANF " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="ID pago QR Posnet                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="PUNTODEVENTA                            " tabla="CUPONES        " campo="PTOVENTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goParametros.Felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="TIPONOTADECREDITO                       " tabla="CUPONES        " campo="TIPONC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Tipo de nota de crédito                                                                                                                                         " dominio="COMBOTIPOCOMPROBANTE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="TIPOCUPON                               " tabla="CUPONES        " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="408" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOTIPOCUPON                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="VALOR                                   " tabla="CUPONES        " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="410" etiqueta="Valor                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMERODECUPONAFECTADO                   " tabla="CUPONES        " campo="NUMAFDO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Número                                                                                                                                                          " dominio="ETIQUETADATOFECHA             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="TIPOCOMPROBANTE                         " tabla="CUPONES        " campo="COMPTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="COMBOTIPOCOMPROBANTEMASRECIBO " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="PUNTODEVENTACANJE                       " tabla="CUPONES        " campo="PTOVENC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Pto. venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="LETRANOTADECREDITO                      " tabla="CUPONES        " campo="LETRANC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="LETRACOMPROBANTE                        " tabla="CUPONES        " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Comprobante                                                                                                                                                     " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMEROCUPON                             " tabla="CUPONES        " campo="NUMERO    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMEROINTERNO                           " tabla="CUPONES        " campo="NROINTERNO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Número                                                                                                                                                          " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="TIPOTARJETA                             " tabla="CUPONES        " campo="TIPOTARJ  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOTIPOTARJETA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="LOTEAFECTADO                            " tabla="CUPONES        " campo="LOTAFDO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Lote cupón afectado                                                                                                                                             " dominio="ETIQUETADATOFECHA             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMERODECANJE                           " tabla="CUPONES        " campo="NCANJE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Número de canje                                                                                                                                                 " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="PUNTODEVENTANOTADECREDITO               " tabla="CUPONES        " campo="PVENTANC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Pto. venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="PUNTODEVENTACOMPROBANTE                 " tabla="CUPONES        " campo="PTOVEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Pto. venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="LOTE                                    " tabla="CUPONES        " campo="LOTE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Número lote                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHADECUPONAFECTADO                    " tabla="CUPONES        " campo="FECAFDO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Fecha                                                                                                                                                           " dominio="ETIQUETADATOFECHA             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="CUOTAS                                  " tabla="CUPONES        " campo="CUOTAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Cuotas                                                                                                                                                          " dominio="PLANSEGUNCUOTAS               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHABAJA                               " tabla="CUPONES        " campo="FBAJA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMERONOTADECREDITO                     " tabla="CUPONES        " campo="NUMERONC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMEROCOMPROBANTE                       " tabla="CUPONES        " campo="NUMCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Número comprobante                                                                                                                                              " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMEROCIERREDELOTE                      " tabla="CUPONES        " campo="NROCL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Número interno                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="AUTORIZACIONPOS                         " tabla="CUPONES        " campo="AUTORIZADO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Integrado                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="ULTIMOSDIGITOS                          " tabla="CUPONES        " campo="ULTDIG    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Últimos 4 dígitos                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHANOTADECREDITO                      " tabla="CUPONES        " campo="FECHANC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHACOMPROBANTE                        " tabla="CUPONES        " campo="FECHACOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHACUPON                              " tabla="CUPONES        " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="HORABAJA                                " tabla="CUPONES        " campo="HBAJA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Hora                                                                                                                                                            " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="DESCUENTOPORCENTAJE                     " tabla="CUPONES        " campo="DESPORC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% Descuento                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="RECARGOPORCENTAJE                       " tabla="CUPONES        " campo="RECPORC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% Recargo                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="QRTRANFDEBINIDPOSNET                    " tabla="CUPONES        " campo="QRIDDEB   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="ID pago QR transf. Posnet                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NOMBRETITULAR                           " tabla="CUPONES        " campo="NOMTITULAR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Nombre                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="SIMBOLOMONETARIO                        " tabla="CUPONES        " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="TIPODOCUMENTOTITULAR                    " tabla="CUPONES        " campo="TIPDOCTITU" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Tipo / número documento                                                                                                                                         " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="HORACUPON                               " tabla="CUPONES        " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Hora                                                                                                                                                            " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="RECARGOMONTO                            " tabla="CUPONES        " campo="RECMONTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="DESCUENTOMONTO                          " tabla="CUPONES        " campo="DESMONTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="ESRETIROEFECTIVO                        " tabla="CUPONES        " campo="ESRETIROEF" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="454" etiqueta="Retiro efectivo                                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="BASEDEDATOS                             " tabla="CUPONES        " campo="BASEDATOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="456" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="BASEDEDATOSBAJA                         " tabla="CUPONES        " campo="BASEDATOSB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="AUTORIZACIONTELEFONICA                  " tabla="CUPONES        " campo="AUTTEL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Autorización telefónica                                                                                                                                         " dominio="AUTORIZACIONTELEFONICA        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="FECHACIERREDELOTE                       " tabla="CUPONES        " campo="FCIELOTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NRODOCUMENTOTITULAR                     " tabla="CUPONES        " campo="NRODOCTITU" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Tipo / número documento                                                                                                                                         " dominio="DOCUMENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="SERIEBAJA                               " tabla="CUPONES        " campo="SERIEB    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="SERIEORIGEN                             " tabla="CUPONES        " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=_screen.zoo.app.cSerie                                                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="20" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="AUTORIZACIONTELEFONICAOFFLINE           " tabla="CUPONES        " campo="AUTOFFLINE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="466" etiqueta="Autorización telefónica                                                                                                                                         " dominio="AUTORIZACIONTELEFONICA        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="HORACIERREDELOTE                        " tabla="CUPONES        " campo="HCIELOTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="468" etiqueta="Hora                                                                                                                                                            " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="NUMEROCOMERCIO                          " tabla="CUPONES        " campo="NROCOMERCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Nro. comercio                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="TELEFONOTITULAR                         " tabla="CUPONES        " campo="TELTITU   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="470" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="CLIENTE                                 " tabla="CUPONES        " campo="CODCLI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="472" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="POS                                     " tabla="CUPONES        " campo="POS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="POS                                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="@ObtenerPosDefault()                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="474" etiqueta="Dispositivo POS                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="ENTIDADFINANCIERA                       " tabla="CUPONES        " campo="ENTFIN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Entidad financiera                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="MONTO                                   " tabla="CUPONES        " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="VALIDACION                              " tabla="CUPONES        " campo="VALIDADO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Validado                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="CODIGOPLAN                              " tabla="CUPONES        " campo="CODPLAN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="476" etiqueta="Plan                                                                                                                                                            " dominio="PLANSEGUNCUOTAS               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="SERIAL                                  " tabla="CUPONES        " campo="SERIAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="478" etiqueta="Serial                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="IDPAGOCLOVER                            " tabla="CUPONES        " campo="IDPAGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="18" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="480" etiqueta="Id de pago Clover                                                                                                                                               " dominio="CAMPOSID                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="DISPOSITIVOMOVIL                        " tabla="CUPONES        " campo="MOVIL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="482" etiqueta="Móvil                                                                                                                                                           " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="IDORDENCLOVER                           " tabla="CUPONES        " campo="IDORDEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="18" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="484" etiqueta="Id de orden Clover                                                                                                                                              " dominio="CAMPOSID                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="EXTERNALIDCLOVER                        " tabla="CUPONES        " campo="EXTID     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="18" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="486" etiqueta="Id externo Clover                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="REFERENCIAEXTERNA                       " tabla="CUPONES        " campo="REFEXTERNA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="90" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="488" etiqueta="Referencia externa                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="18" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="IDSMARTLAPOS                            " tabla="CUPONES        " campo="IDLAPOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="490" etiqueta="Id de pago smart LaPos                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="19" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="IDGOCUOTAS                              " tabla="CUPONES        " campo="IDGOCUOTAS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id de pago Go Cuotas                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUPON                                   " atributo="MAILGOCUOTAS                            " tabla="CUPONES        " campo="MAILGC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="492" etiqueta="Email                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASEDETARJETA                          " atributo="DESCRIPCION                             " tabla="CLATARJ        " campo="CDTDESC   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="27" etiqueta="Detalle gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLATARJ On CUPONES.CLATAR = CLATARJ.CdtCodigo And  CLATARJ.CDTCODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVALORES       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVALORES On CUPONES.VALOR = XVALORES.CLCOD And  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="449" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On CUPONES.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="473" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On CUPONES.CODCLI = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="DESCRIPCION                             " tabla="POS            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="475" etiqueta="Detalle Dis.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join POS On CUPONES.POS = POS.Codigo And  POS.CODIGO != ''                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADFINANCIERA                       " atributo="DESCRIPCION                             " tabla="ENTFIN         " campo="EFDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="25" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTFIN On CUPONES.ENTFIN = ENTFIN.EfCod And  ENTFIN.EFCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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