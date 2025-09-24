
define class Din_EntidadECOMMERCEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ECOMMERCE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_ECOPK'
	cTablaPrincipal = 'ECOM'
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

		with this.oEntidad
			local  lxEcomFecimpo, lxEcomFectrans, lxEcomFmodifw, lxEcomFecexpo, lxEcomFaltafw, lxEcomHaltafw, lxEcomBdaltafw, lxEcomEsttrans, lxEcomHoraexpo, lxEcomBdmodifw, lxEcomValtafw, lxEcomVmodifw, lxEcomUmodifw, lxEcomZadsfw, lxEcomUaltafw, lxEcomSmodifw, lxEcomHoraimpo, lxEcomHmodifw, lxEcomSaltafw, lxEcomCodigo, lxEcomCuenta, lxEcomCodlista, lxEcomAccion, lxEcomCuentacom, lxEcomVendedor, lxEcomBuzon, lxEcomTipoecom, lxEcomTranspor, lxEcomBasededato, lxEcomIdvinc, lxEcomMotivo, lxEcomUltorder, lxEcomDtosenvio, lxEcomGeneracan, lxEcomVacio, lxEcomPago, lxEcomValctacte, lxEcomCondpago, lxEcomCliedef, lxEcomTelenvio, lxEcomDescartar, lxEcomUsaotrabd, lxEcomValecamb, lxEcomConvenv, lxEcomConccolor, lxEcomConctalle, lxEcomConcart, lxEcomCargaautov, lxEcomUsaequival, lxEcomDtospago, lxEcomPedido, lxEcomFactsinper, lxEcomOrigenst, lxEcomPercctacte, lxEcomFecnov, lxEcomNumero, lxEcomRemito, lxEcomAccionfe, lxEcomAplicenvio, lxEcomNrocarrito, lxEcomFactmanual, lxEcomBuzonfe, lxEcomPefactman, lxEcomFactmcep, lxEcomPefactmcep, lxEcomEnlaceop, lxEcomFactmvc, lxEcomBdfe, lxEcomFactelec, lxEcomPefactelec, lxEcomDatosret, lxEcomFactecep, lxEcomPefactecep, lxEcomFactevc, lxEcomObserva, lxEcomFactfiscal, lxEcomPefactfisc, lxEcomFactfcep, lxEcomPefactfcep, lxEcomPagado, lxEcomFactfvc, lxEcomPromos, lxEcomObs
				lxEcomFecimpo =  .Fechaimpo			lxEcomFectrans =  .Fechatransferencia			lxEcomFmodifw =  .Fechamodificacionfw			lxEcomFecexpo =  .Fechaexpo			lxEcomFaltafw =  .Fechaaltafw			lxEcomHaltafw =  .Horaaltafw			lxEcomBdaltafw =  .Basededatosaltafw			lxEcomEsttrans =  .Estadotransferencia			lxEcomHoraexpo =  .Horaexpo			lxEcomBdmodifw =  .Basededatosmodificacionfw			lxEcomValtafw =  .Versionaltafw			lxEcomVmodifw =  .Versionmodificacionfw			lxEcomUmodifw =  .Usuariomodificacionfw			lxEcomZadsfw =  .Zadsfw			lxEcomUaltafw =  .Usuarioaltafw			lxEcomSmodifw =  .Seriemodificacionfw			lxEcomHoraimpo =  .Horaimpo			lxEcomHmodifw =  .Horamodificacionfw			lxEcomSaltafw =  .Seriealtafw			lxEcomCodigo =  .Codigo			lxEcomCuenta =  .Descripcion			lxEcomCodlista =  upper( .ListaDePrecios_PK ) 			lxEcomAccion =  .Accion			lxEcomCuentacom =  .Cuenta			lxEcomVendedor =  upper( .Vendedor_PK ) 			lxEcomBuzon =  .Buzon			lxEcomTipoecom =  .Tipoecommerce			lxEcomTranspor =  upper( .Transportista_PK ) 			lxEcomBasededato =  .Basededatos			lxEcomIdvinc =  .Idvinculacion			lxEcomMotivo =  upper( .Motivo_PK ) 			lxEcomUltorder =  .Ultimaorder			lxEcomDtosenvio =  .Datosdeenvio			lxEcomGeneracan =  .Generacancelacion			lxEcomVacio =  .Vacio			lxEcomPago =  upper( .Pago_PK ) 			lxEcomValctacte =  upper( .ValorCtaCte_PK ) 			lxEcomCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxEcomCliedef =  upper( .ClienteDefault_PK ) 			lxEcomTelenvio =  .Telefonodeenvio			lxEcomDescartar =  .Descartar			lxEcomUsaotrabd =  .Utilizastockotrabase			lxEcomValecamb =  .Usavalecambio			lxEcomConvenv =  upper( .Concenvio_PK ) 			lxEcomConccolor =  upper( .ConcColor_PK ) 			lxEcomConctalle =  upper( .ConcTalle_PK ) 			lxEcomConcart =  upper( .ConcArticulo_PK ) 			lxEcomCargaautov =  .Cargaautomaticavalores			lxEcomUsaequival =  .Usaequivalores			lxEcomDtospago =  .Datosdepago			lxEcomPedido =  .Pedido			lxEcomFactsinper =  .Facturarsinpersonalizar			lxEcomOrigenst =  .Bdorigenstock			lxEcomPercctacte =  .Percepcionesactacte			lxEcomFecnov =  .Fechanovedades			lxEcomNumero =  .Numero			lxEcomRemito =  .Remito			lxEcomAccionfe =  .Accionfullenv			lxEcomAplicenvio =  .Aplicarcostoenvio			lxEcomNrocarrito =  .Numerodecarrito			lxEcomFactmanual =  .Facturamanual			lxEcomBuzonfe =  .Buzonfullenv			lxEcomPefactman =  .Pedidofacturamanual			lxEcomFactmcep =  .Facturamanualconentregaposterior			lxEcomPefactmcep =  .Pedidofacturamanualconentregapos			lxEcomEnlaceop =  .Enlacedelaoperacion			lxEcomFactmvc =  .Facturamanualconvtacont			lxEcomBdfe =  .Basededatosfullenv			lxEcomFactelec =  .Facturaelectronica			lxEcomPefactelec =  .Pedidofacturaelectronica			lxEcomDatosret =  .Datosderetiro			lxEcomFactecep =  .Facturaelectronicaconentregaposterior			lxEcomPefactecep =  .Pedidofacturaelectronicaconentregapos			lxEcomFactevc =  .Facturaelectronicaconvtacont			lxEcomObserva =  .Observaciones			lxEcomFactfiscal =  .Facturafiscal			lxEcomPefactfisc =  .Pedidofacturafiscal			lxEcomFactfcep =  .Facturafiscalconentregaposterior			lxEcomPefactfcep =  .Pedidofacturafiscalconentregapos			lxEcomPagado =  .Pagado			lxEcomFactfvc =  .Facturafiscalconvtacont			lxEcomPromos =  .Aplicarpromocionesautomaticas			lxEcomObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxEcomCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ECOM ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Bdaltafw","Esttrans","Horaexpo","Bdmodifw","Valtafw","Vmodifw","Umodifw","Zadsfw","Ualtafw","Smodifw","Horaimpo","Hmodifw","Saltafw","Codigo","Cuenta","Codlista","Accion","Cuentacom","Vendedor","Buzon","Tipoecom","Transpor","Basededato","Idvinc","Motivo","Ultorder","Dtosenvio","Generacan","Vacio","Pago","Valctacte","Condpago","Cliedef","Telenvio","Descartar","Usaotrabd","Valecamb","Convenv","Conccolor","Conctalle","Concart","Cargaautov","Usaequival","Dtospago","Pedido","Factsinper","Origenst","Percctacte","Fecnov","Numero","Remito","Accionfe","Aplicenvio","Nrocarrito","Factmanual","Buzonfe","Pefactman","Factmcep","Pefactmcep","Enlaceop","Factmvc","Bdfe","Factelec","Pefactelec","Datosret","Factecep","Pefactecep","Factevc","Observa","Factfiscal","Pefactfisc","Factfcep","Pefactfcep","Pagado","Factfvc","Promos","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxEcomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEcomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEcomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEcomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEcomFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCuenta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomAccion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCuentacom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomBuzon ) + "'" >>, <<lxEcomTipoecom >>, <<"'" + this.FormatearTextoSql( lxEcomTranspor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomBasededato ) + "'" >>, <<lxEcomIdvinc >>, <<"'" + this.FormatearTextoSql( lxEcomMotivo ) + "'" >>, <<lxEcomUltorder >>, <<iif( lxEcomDtosenvio, 1, 0 ) >>, <<iif( lxEcomGeneracan, 1, 0 ) >>, <<iif( lxEcomVacio, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomPago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomValctacte ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCondpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCliedef ) + "'" >>, <<iif( lxEcomTelenvio, 1, 0 ) >>, <<iif( lxEcomDescartar, 1, 0 ) >>, <<iif( lxEcomUsaotrabd, 1, 0 ) >>, <<iif( lxEcomValecamb, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomConvenv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomConccolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomConctalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomConcart ) + "'" >>, <<iif( lxEcomCargaautov, 1, 0 ) >>, <<iif( lxEcomUsaequival, 1, 0 ) >>, <<iif( lxEcomDtospago, 1, 0 ) >>, <<iif( lxEcomPedido, 1, 0 ) >>, <<iif( lxEcomFactsinper, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomOrigenst ) + "'" >>, <<iif( lxEcomPercctacte, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxEcomFecnov ) + "'" >>, <<iif( lxEcomNumero, 1, 0 ) >>, <<iif( lxEcomRemito, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomAccionfe ) + "'" >>, <<lxEcomAplicenvio >>, <<iif( lxEcomNrocarrito, 1, 0 ) >>, <<iif( lxEcomFactmanual, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomBuzonfe ) + "'" >>, <<iif( lxEcomPefactman, 1, 0 ) >>, <<iif( lxEcomFactmcep, 1, 0 ) >>, <<iif( lxEcomPefactmcep, 1, 0 ) >>, <<iif( lxEcomEnlaceop, 1, 0 ) >>, <<iif( lxEcomFactmvc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomBdfe ) + "'" >>, <<iif( lxEcomFactelec, 1, 0 ) >>, <<iif( lxEcomPefactelec, 1, 0 ) >>, <<iif( lxEcomDatosret, 1, 0 ) >>, <<iif( lxEcomFactecep, 1, 0 ) >>, <<iif( lxEcomPefactecep, 1, 0 ) >>, <<iif( lxEcomFactevc, 1, 0 ) >>, <<iif( lxEcomObserva, 1, 0 ) >>, <<iif( lxEcomFactfiscal, 1, 0 ) >>, <<iif( lxEcomPefactfisc, 1, 0 ) >>, <<iif( lxEcomFactfcep, 1, 0 ) >>, <<iif( lxEcomPefactfcep, 1, 0 ) >>, <<iif( lxEcomPagado, 1, 0 ) >>, <<iif( lxEcomFactfvc, 1, 0 ) >>, <<iif( lxEcomPromos, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Errores
				if this.oEntidad.Errores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxOpeerror = loItem.Opeerror
					lxStoreorderid = loItem.Storeorderid
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETERROR("NROITEM","Codigo","OpeError","STOREORDER" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxOpeerror>>, <<"'" + this.FormatearTextoSql( lxStoreorderid ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EquiValoresDetalle
				if this.oEntidad.EquiValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValorecommerce = loItem.Valorecommerce
					lxTipovalorecommerce = loItem.Tipovalorecommerce
					lxValordragonfish_PK = loItem.Valordragonfish_PK
					lxValordescripcion = loItem.Valordescripcion
					lxTipovalordragon = loItem.Tipovalordragon
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ECOMEQUIVAL("NROITEM","Codigo","ValEcom","TipoValEco","ValDragon","ValDesc","TipoValDf" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorecommerce ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipovalorecommerce ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordragonfish_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipovalordragon ) + "'">> ) 
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
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
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
			local  lxEcomFecimpo, lxEcomFectrans, lxEcomFmodifw, lxEcomFecexpo, lxEcomFaltafw, lxEcomHaltafw, lxEcomBdaltafw, lxEcomEsttrans, lxEcomHoraexpo, lxEcomBdmodifw, lxEcomValtafw, lxEcomVmodifw, lxEcomUmodifw, lxEcomZadsfw, lxEcomUaltafw, lxEcomSmodifw, lxEcomHoraimpo, lxEcomHmodifw, lxEcomSaltafw, lxEcomCodigo, lxEcomCuenta, lxEcomCodlista, lxEcomAccion, lxEcomCuentacom, lxEcomVendedor, lxEcomBuzon, lxEcomTipoecom, lxEcomTranspor, lxEcomBasededato, lxEcomIdvinc, lxEcomMotivo, lxEcomUltorder, lxEcomDtosenvio, lxEcomGeneracan, lxEcomVacio, lxEcomPago, lxEcomValctacte, lxEcomCondpago, lxEcomCliedef, lxEcomTelenvio, lxEcomDescartar, lxEcomUsaotrabd, lxEcomValecamb, lxEcomConvenv, lxEcomConccolor, lxEcomConctalle, lxEcomConcart, lxEcomCargaautov, lxEcomUsaequival, lxEcomDtospago, lxEcomPedido, lxEcomFactsinper, lxEcomOrigenst, lxEcomPercctacte, lxEcomFecnov, lxEcomNumero, lxEcomRemito, lxEcomAccionfe, lxEcomAplicenvio, lxEcomNrocarrito, lxEcomFactmanual, lxEcomBuzonfe, lxEcomPefactman, lxEcomFactmcep, lxEcomPefactmcep, lxEcomEnlaceop, lxEcomFactmvc, lxEcomBdfe, lxEcomFactelec, lxEcomPefactelec, lxEcomDatosret, lxEcomFactecep, lxEcomPefactecep, lxEcomFactevc, lxEcomObserva, lxEcomFactfiscal, lxEcomPefactfisc, lxEcomFactfcep, lxEcomPefactfcep, lxEcomPagado, lxEcomFactfvc, lxEcomPromos, lxEcomObs
				lxEcomFecimpo =  .Fechaimpo			lxEcomFectrans =  .Fechatransferencia			lxEcomFmodifw =  .Fechamodificacionfw			lxEcomFecexpo =  .Fechaexpo			lxEcomFaltafw =  .Fechaaltafw			lxEcomHaltafw =  .Horaaltafw			lxEcomBdaltafw =  .Basededatosaltafw			lxEcomEsttrans =  .Estadotransferencia			lxEcomHoraexpo =  .Horaexpo			lxEcomBdmodifw =  .Basededatosmodificacionfw			lxEcomValtafw =  .Versionaltafw			lxEcomVmodifw =  .Versionmodificacionfw			lxEcomUmodifw =  .Usuariomodificacionfw			lxEcomZadsfw =  .Zadsfw			lxEcomUaltafw =  .Usuarioaltafw			lxEcomSmodifw =  .Seriemodificacionfw			lxEcomHoraimpo =  .Horaimpo			lxEcomHmodifw =  .Horamodificacionfw			lxEcomSaltafw =  .Seriealtafw			lxEcomCodigo =  .Codigo			lxEcomCuenta =  .Descripcion			lxEcomCodlista =  upper( .ListaDePrecios_PK ) 			lxEcomAccion =  .Accion			lxEcomCuentacom =  .Cuenta			lxEcomVendedor =  upper( .Vendedor_PK ) 			lxEcomBuzon =  .Buzon			lxEcomTipoecom =  .Tipoecommerce			lxEcomTranspor =  upper( .Transportista_PK ) 			lxEcomBasededato =  .Basededatos			lxEcomIdvinc =  .Idvinculacion			lxEcomMotivo =  upper( .Motivo_PK ) 			lxEcomUltorder =  .Ultimaorder			lxEcomDtosenvio =  .Datosdeenvio			lxEcomGeneracan =  .Generacancelacion			lxEcomVacio =  .Vacio			lxEcomPago =  upper( .Pago_PK ) 			lxEcomValctacte =  upper( .ValorCtaCte_PK ) 			lxEcomCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxEcomCliedef =  upper( .ClienteDefault_PK ) 			lxEcomTelenvio =  .Telefonodeenvio			lxEcomDescartar =  .Descartar			lxEcomUsaotrabd =  .Utilizastockotrabase			lxEcomValecamb =  .Usavalecambio			lxEcomConvenv =  upper( .Concenvio_PK ) 			lxEcomConccolor =  upper( .ConcColor_PK ) 			lxEcomConctalle =  upper( .ConcTalle_PK ) 			lxEcomConcart =  upper( .ConcArticulo_PK ) 			lxEcomCargaautov =  .Cargaautomaticavalores			lxEcomUsaequival =  .Usaequivalores			lxEcomDtospago =  .Datosdepago			lxEcomPedido =  .Pedido			lxEcomFactsinper =  .Facturarsinpersonalizar			lxEcomOrigenst =  .Bdorigenstock			lxEcomPercctacte =  .Percepcionesactacte			lxEcomFecnov =  .Fechanovedades			lxEcomNumero =  .Numero			lxEcomRemito =  .Remito			lxEcomAccionfe =  .Accionfullenv			lxEcomAplicenvio =  .Aplicarcostoenvio			lxEcomNrocarrito =  .Numerodecarrito			lxEcomFactmanual =  .Facturamanual			lxEcomBuzonfe =  .Buzonfullenv			lxEcomPefactman =  .Pedidofacturamanual			lxEcomFactmcep =  .Facturamanualconentregaposterior			lxEcomPefactmcep =  .Pedidofacturamanualconentregapos			lxEcomEnlaceop =  .Enlacedelaoperacion			lxEcomFactmvc =  .Facturamanualconvtacont			lxEcomBdfe =  .Basededatosfullenv			lxEcomFactelec =  .Facturaelectronica			lxEcomPefactelec =  .Pedidofacturaelectronica			lxEcomDatosret =  .Datosderetiro			lxEcomFactecep =  .Facturaelectronicaconentregaposterior			lxEcomPefactecep =  .Pedidofacturaelectronicaconentregapos			lxEcomFactevc =  .Facturaelectronicaconvtacont			lxEcomObserva =  .Observaciones			lxEcomFactfiscal =  .Facturafiscal			lxEcomPefactfisc =  .Pedidofacturafiscal			lxEcomFactfcep =  .Facturafiscalconentregaposterior			lxEcomPefactfcep =  .Pedidofacturafiscalconentregapos			lxEcomPagado =  .Pagado			lxEcomFactfvc =  .Facturafiscalconvtacont			lxEcomPromos =  .Aplicarpromocionesautomaticas			lxEcomObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ECOM set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxEcomFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxEcomFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxEcomFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxEcomFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxEcomFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxEcomHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEcomBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxEcomEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxEcomHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEcomBdmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxEcomValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxEcomVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxEcomUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxEcomZadsfw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxEcomUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxEcomSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxEcomHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxEcomHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxEcomSaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxEcomCodigo ) + "'">>,"Cuenta" = <<"'" + this.FormatearTextoSql( lxEcomCuenta ) + "'">>,"Codlista" = <<"'" + this.FormatearTextoSql( lxEcomCodlista ) + "'">>,"Accion" = <<"'" + this.FormatearTextoSql( lxEcomAccion ) + "'">>,"Cuentacom" = <<"'" + this.FormatearTextoSql( lxEcomCuentacom ) + "'">>,"Vendedor" = <<"'" + this.FormatearTextoSql( lxEcomVendedor ) + "'">>,"Buzon" = <<"'" + this.FormatearTextoSql( lxEcomBuzon ) + "'">>,"Tipoecom" = <<lxEcomTipoecom>>,"Transpor" = <<"'" + this.FormatearTextoSql( lxEcomTranspor ) + "'">>,"Basededato" = <<"'" + this.FormatearTextoSql( lxEcomBasededato ) + "'">>,"Idvinc" = <<lxEcomIdvinc>>,"Motivo" = <<"'" + this.FormatearTextoSql( lxEcomMotivo ) + "'">>,"Ultorder" = <<lxEcomUltorder>>,"Dtosenvio" = <<iif( lxEcomDtosenvio, 1, 0 )>>,"Generacan" = <<iif( lxEcomGeneracan, 1, 0 )>>,"Vacio" = <<iif( lxEcomVacio, 1, 0 )>>,"Pago" = <<"'" + this.FormatearTextoSql( lxEcomPago ) + "'">>,"Valctacte" = <<"'" + this.FormatearTextoSql( lxEcomValctacte ) + "'">>,"Condpago" = <<"'" + this.FormatearTextoSql( lxEcomCondpago ) + "'">>,"Cliedef" = <<"'" + this.FormatearTextoSql( lxEcomCliedef ) + "'">>,"Telenvio" = <<iif( lxEcomTelenvio, 1, 0 )>>,"Descartar" = <<iif( lxEcomDescartar, 1, 0 )>>,"Usaotrabd" = <<iif( lxEcomUsaotrabd, 1, 0 )>>,"Valecamb" = <<iif( lxEcomValecamb, 1, 0 )>>,"Convenv" = <<"'" + this.FormatearTextoSql( lxEcomConvenv ) + "'">>,"Conccolor" = <<"'" + this.FormatearTextoSql( lxEcomConccolor ) + "'">>,"Conctalle" = <<"'" + this.FormatearTextoSql( lxEcomConctalle ) + "'">>,"Concart" = <<"'" + this.FormatearTextoSql( lxEcomConcart ) + "'">>,"Cargaautov" = <<iif( lxEcomCargaautov, 1, 0 )>>,"Usaequival" = <<iif( lxEcomUsaequival, 1, 0 )>>,"Dtospago" = <<iif( lxEcomDtospago, 1, 0 )>>,"Pedido" = <<iif( lxEcomPedido, 1, 0 )>>,"Factsinper" = <<iif( lxEcomFactsinper, 1, 0 )>>,"Origenst" = <<"'" + this.FormatearTextoSql( lxEcomOrigenst ) + "'">>,"Percctacte" = <<iif( lxEcomPercctacte, 1, 0 )>>,"Fecnov" = <<"'" + this.ConvertirDateSql( lxEcomFecnov ) + "'">>,"Numero" = <<iif( lxEcomNumero, 1, 0 )>>,"Remito" = <<iif( lxEcomRemito, 1, 0 )>>,"Accionfe" = <<"'" + this.FormatearTextoSql( lxEcomAccionfe ) + "'">>,"Aplicenvio" = <<lxEcomAplicenvio>>,"Nrocarrito" = <<iif( lxEcomNrocarrito, 1, 0 )>>,"Factmanual" = <<iif( lxEcomFactmanual, 1, 0 )>>,"Buzonfe" = <<"'" + this.FormatearTextoSql( lxEcomBuzonfe ) + "'">>,"Pefactman" = <<iif( lxEcomPefactman, 1, 0 )>>,"Factmcep" = <<iif( lxEcomFactmcep, 1, 0 )>>,"Pefactmcep" = <<iif( lxEcomPefactmcep, 1, 0 )>>,"Enlaceop" = <<iif( lxEcomEnlaceop, 1, 0 )>>,"Factmvc" = <<iif( lxEcomFactmvc, 1, 0 )>>,"Bdfe" = <<"'" + this.FormatearTextoSql( lxEcomBdfe ) + "'">>,"Factelec" = <<iif( lxEcomFactelec, 1, 0 )>>,"Pefactelec" = <<iif( lxEcomPefactelec, 1, 0 )>>,"Datosret" = <<iif( lxEcomDatosret, 1, 0 )>>,"Factecep" = <<iif( lxEcomFactecep, 1, 0 )>>,"Pefactecep" = <<iif( lxEcomPefactecep, 1, 0 )>>,"Factevc" = <<iif( lxEcomFactevc, 1, 0 )>>,"Observa" = <<iif( lxEcomObserva, 1, 0 )>>,"Factfiscal" = <<iif( lxEcomFactfiscal, 1, 0 )>>,"Pefactfisc" = <<iif( lxEcomPefactfisc, 1, 0 )>>,"Factfcep" = <<iif( lxEcomFactfcep, 1, 0 )>>,"Pefactfcep" = <<iif( lxEcomPefactfcep, 1, 0 )>>,"Pagado" = <<iif( lxEcomPagado, 1, 0 )>>,"Factfvc" = <<iif( lxEcomFactfvc, 1, 0 )>>,"Promos" = <<iif( lxEcomPromos, 1, 0 )>>,"Obs" = <<"'" + this.FormatearTextoSql( lxEcomObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxEcomCodigo ) + "'">> and  ECOM.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETERROR where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ECOMEQUIVAL where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Errores
				if this.oEntidad.Errores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxOpeerror = loItem.Opeerror
					lxStoreorderid = loItem.Storeorderid
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETERROR("NROITEM","Codigo","OpeError","STOREORDER" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxOpeerror>>, <<"'" + this.FormatearTextoSql( lxStoreorderid ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EquiValoresDetalle
				if this.oEntidad.EquiValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValorecommerce = loItem.Valorecommerce
					lxTipovalorecommerce = loItem.Tipovalorecommerce
					lxValordragonfish_PK = loItem.Valordragonfish_PK
					lxValordescripcion = loItem.Valordescripcion
					lxTipovalordragon = loItem.Tipovalordragon
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ECOMEQUIVAL("NROITEM","Codigo","ValEcom","TipoValEco","ValDragon","ValDesc","TipoValDf" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorecommerce ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipovalorecommerce ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordragonfish_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipovalordragon ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.ECOM where " + this.ConvertirFuncionesSql( " ECOM.CODIGO != ''" ) )
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
			Local lxEcomCodigo
			lxEcomCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Cuenta" as "Descripcion", "Codlista" as "Listadeprecios", "Accion" as "Accion", "Cuentacom" as "Cuenta", "Vendedor" as "Vendedor", "Buzon" as "Buzon", "Tipoecom" as "Tipoecommerce", "Transpor" as "Transportista", "Basededato" as "Basededatos", "Idvinc" as "Idvinculacion", "Motivo" as "Motivo", "Ultorder" as "Ultimaorder", "Dtosenvio" as "Datosdeenvio", "Generacan" as "Generacancelacion", "Vacio" as "Vacio", "Pago" as "Pago", "Valctacte" as "Valorctacte", "Condpago" as "Condicionpagopreferente", "Cliedef" as "Clientedefault", "Telenvio" as "Telefonodeenvio", "Descartar" as "Descartar", "Usaotrabd" as "Utilizastockotrabase", "Valecamb" as "Usavalecambio", "Convenv" as "Concenvio", "Conccolor" as "Conccolor", "Conctalle" as "Conctalle", "Concart" as "Concarticulo", "Cargaautov" as "Cargaautomaticavalores", "Usaequival" as "Usaequivalores", "Dtospago" as "Datosdepago", "Pedido" as "Pedido", "Factsinper" as "Facturarsinpersonalizar", "Origenst" as "Bdorigenstock", "Percctacte" as "Percepcionesactacte", "Fecnov" as "Fechanovedades", "Numero" as "Numero", "Remito" as "Remito", "Accionfe" as "Accionfullenv", "Aplicenvio" as "Aplicarcostoenvio", "Nrocarrito" as "Numerodecarrito", "Factmanual" as "Facturamanual", "Buzonfe" as "Buzonfullenv", "Pefactman" as "Pedidofacturamanual", "Factmcep" as "Facturamanualconentregaposterior", "Pefactmcep" as "Pedidofacturamanualconentregapos", "Enlaceop" as "Enlacedelaoperacion", "Factmvc" as "Facturamanualconvtacont", "Bdfe" as "Basededatosfullenv", "Factelec" as "Facturaelectronica", "Pefactelec" as "Pedidofacturaelectronica", "Datosret" as "Datosderetiro", "Factecep" as "Facturaelectronicaconentregaposterior", "Pefactecep" as "Pedidofacturaelectronicaconentregapos", "Factevc" as "Facturaelectronicaconvtacont", "Observa" as "Observaciones", "Factfiscal" as "Facturafiscal", "Pefactfisc" as "Pedidofacturafiscal", "Factfcep" as "Facturafiscalconentregaposterior", "Pefactfcep" as "Pedidofacturafiscalconentregapos", "Pagado" as "Pagado", "Factfvc" as "Facturafiscalconvtacont", "Promos" as "Aplicarpromocionesautomaticas", "Obs" as "Observacion" from ZooLogic.ECOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxEcomCodigo ) + "'">> and  ECOM.CODIGO != ''
			endtext
			use in select('c_ECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ECOMMERCE', set( 'Datasession' ) )

			if reccount( 'c_ECOMMERCE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Opeerror" as "Opeerror", "Storeorder" as "Storeorderid" from ZooLogic.DETERROR where CODIGO = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Errores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Errores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Errores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valecom" as "Valorecommerce", "Tipovaleco" as "Tipovalorecommerce", "Valdragon" as "Valordragonfish", "Valdesc" as "Valordescripcion", "Tipovaldf" as "Tipovalordragon" from ZooLogic.ECOMEQUIVAL where Codigo = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EquiValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EquiValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EquiValoresDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxEcomCodigo as Variant
		llRetorno = .t.
		lxEcomCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ECOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxEcomCodigo ) + "'">> and  ECOM.CODIGO != ''
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Cuenta" as "Descripcion", "Codlista" as "Listadeprecios", "Accion" as "Accion", "Cuentacom" as "Cuenta", "Vendedor" as "Vendedor", "Buzon" as "Buzon", "Tipoecom" as "Tipoecommerce", "Transpor" as "Transportista", "Basededato" as "Basededatos", "Idvinc" as "Idvinculacion", "Motivo" as "Motivo", "Ultorder" as "Ultimaorder", "Dtosenvio" as "Datosdeenvio", "Generacan" as "Generacancelacion", "Vacio" as "Vacio", "Pago" as "Pago", "Valctacte" as "Valorctacte", "Condpago" as "Condicionpagopreferente", "Cliedef" as "Clientedefault", "Telenvio" as "Telefonodeenvio", "Descartar" as "Descartar", "Usaotrabd" as "Utilizastockotrabase", "Valecamb" as "Usavalecambio", "Convenv" as "Concenvio", "Conccolor" as "Conccolor", "Conctalle" as "Conctalle", "Concart" as "Concarticulo", "Cargaautov" as "Cargaautomaticavalores", "Usaequival" as "Usaequivalores", "Dtospago" as "Datosdepago", "Pedido" as "Pedido", "Factsinper" as "Facturarsinpersonalizar", "Origenst" as "Bdorigenstock", "Percctacte" as "Percepcionesactacte", "Fecnov" as "Fechanovedades", "Numero" as "Numero", "Remito" as "Remito", "Accionfe" as "Accionfullenv", "Aplicenvio" as "Aplicarcostoenvio", "Nrocarrito" as "Numerodecarrito", "Factmanual" as "Facturamanual", "Buzonfe" as "Buzonfullenv", "Pefactman" as "Pedidofacturamanual", "Factmcep" as "Facturamanualconentregaposterior", "Pefactmcep" as "Pedidofacturamanualconentregapos", "Enlaceop" as "Enlacedelaoperacion", "Factmvc" as "Facturamanualconvtacont", "Bdfe" as "Basededatosfullenv", "Factelec" as "Facturaelectronica", "Pefactelec" as "Pedidofacturaelectronica", "Datosret" as "Datosderetiro", "Factecep" as "Facturaelectronicaconentregaposterior", "Pefactecep" as "Pedidofacturaelectronicaconentregapos", "Factevc" as "Facturaelectronicaconvtacont", "Observa" as "Observaciones", "Factfiscal" as "Facturafiscal", "Pefactfisc" as "Pedidofacturafiscal", "Factfcep" as "Facturafiscalconentregaposterior", "Pefactfcep" as "Pedidofacturafiscalconentregapos", "Pagado" as "Pagado", "Factfvc" as "Facturafiscalconvtacont", "Promos" as "Aplicarpromocionesautomaticas", "Obs" as "Observacion" from ZooLogic.ECOM where  ECOM.CODIGO != '' order by CODIGO
			endtext
			use in select('c_ECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Opeerror" as "Opeerror", "Storeorder" as "Storeorderid" from ZooLogic.DETERROR where CODIGO = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Errores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Errores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Errores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valecom" as "Valorecommerce", "Tipovaleco" as "Tipovalorecommerce", "Valdragon" as "Valordragonfish", "Valdesc" as "Valordescripcion", "Tipovaldf" as "Tipovalordragon" from ZooLogic.ECOMEQUIVAL where Codigo = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EquiValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EquiValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EquiValoresDetalle
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Cuenta" as "Descripcion", "Codlista" as "Listadeprecios", "Accion" as "Accion", "Cuentacom" as "Cuenta", "Vendedor" as "Vendedor", "Buzon" as "Buzon", "Tipoecom" as "Tipoecommerce", "Transpor" as "Transportista", "Basededato" as "Basededatos", "Idvinc" as "Idvinculacion", "Motivo" as "Motivo", "Ultorder" as "Ultimaorder", "Dtosenvio" as "Datosdeenvio", "Generacan" as "Generacancelacion", "Vacio" as "Vacio", "Pago" as "Pago", "Valctacte" as "Valorctacte", "Condpago" as "Condicionpagopreferente", "Cliedef" as "Clientedefault", "Telenvio" as "Telefonodeenvio", "Descartar" as "Descartar", "Usaotrabd" as "Utilizastockotrabase", "Valecamb" as "Usavalecambio", "Convenv" as "Concenvio", "Conccolor" as "Conccolor", "Conctalle" as "Conctalle", "Concart" as "Concarticulo", "Cargaautov" as "Cargaautomaticavalores", "Usaequival" as "Usaequivalores", "Dtospago" as "Datosdepago", "Pedido" as "Pedido", "Factsinper" as "Facturarsinpersonalizar", "Origenst" as "Bdorigenstock", "Percctacte" as "Percepcionesactacte", "Fecnov" as "Fechanovedades", "Numero" as "Numero", "Remito" as "Remito", "Accionfe" as "Accionfullenv", "Aplicenvio" as "Aplicarcostoenvio", "Nrocarrito" as "Numerodecarrito", "Factmanual" as "Facturamanual", "Buzonfe" as "Buzonfullenv", "Pefactman" as "Pedidofacturamanual", "Factmcep" as "Facturamanualconentregaposterior", "Pefactmcep" as "Pedidofacturamanualconentregapos", "Enlaceop" as "Enlacedelaoperacion", "Factmvc" as "Facturamanualconvtacont", "Bdfe" as "Basededatosfullenv", "Factelec" as "Facturaelectronica", "Pefactelec" as "Pedidofacturaelectronica", "Datosret" as "Datosderetiro", "Factecep" as "Facturaelectronicaconentregaposterior", "Pefactecep" as "Pedidofacturaelectronicaconentregapos", "Factevc" as "Facturaelectronicaconvtacont", "Observa" as "Observaciones", "Factfiscal" as "Facturafiscal", "Pefactfisc" as "Pedidofacturafiscal", "Factfcep" as "Facturafiscalconentregaposterior", "Pefactfcep" as "Pedidofacturafiscalconentregapos", "Pagado" as "Pagado", "Factfvc" as "Facturafiscalconvtacont", "Promos" as "Aplicarpromocionesautomaticas", "Obs" as "Observacion" from ZooLogic.ECOM where  funciones.padr( CODIGO, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ECOM.CODIGO != '' order by CODIGO
			endtext
			use in select('c_ECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Opeerror" as "Opeerror", "Storeorder" as "Storeorderid" from ZooLogic.DETERROR where CODIGO = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Errores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Errores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Errores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valecom" as "Valorecommerce", "Tipovaleco" as "Tipovalorecommerce", "Valdragon" as "Valordragonfish", "Valdesc" as "Valordescripcion", "Tipovaldf" as "Tipovalordragon" from ZooLogic.ECOMEQUIVAL where Codigo = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EquiValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EquiValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EquiValoresDetalle
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Cuenta" as "Descripcion", "Codlista" as "Listadeprecios", "Accion" as "Accion", "Cuentacom" as "Cuenta", "Vendedor" as "Vendedor", "Buzon" as "Buzon", "Tipoecom" as "Tipoecommerce", "Transpor" as "Transportista", "Basededato" as "Basededatos", "Idvinc" as "Idvinculacion", "Motivo" as "Motivo", "Ultorder" as "Ultimaorder", "Dtosenvio" as "Datosdeenvio", "Generacan" as "Generacancelacion", "Vacio" as "Vacio", "Pago" as "Pago", "Valctacte" as "Valorctacte", "Condpago" as "Condicionpagopreferente", "Cliedef" as "Clientedefault", "Telenvio" as "Telefonodeenvio", "Descartar" as "Descartar", "Usaotrabd" as "Utilizastockotrabase", "Valecamb" as "Usavalecambio", "Convenv" as "Concenvio", "Conccolor" as "Conccolor", "Conctalle" as "Conctalle", "Concart" as "Concarticulo", "Cargaautov" as "Cargaautomaticavalores", "Usaequival" as "Usaequivalores", "Dtospago" as "Datosdepago", "Pedido" as "Pedido", "Factsinper" as "Facturarsinpersonalizar", "Origenst" as "Bdorigenstock", "Percctacte" as "Percepcionesactacte", "Fecnov" as "Fechanovedades", "Numero" as "Numero", "Remito" as "Remito", "Accionfe" as "Accionfullenv", "Aplicenvio" as "Aplicarcostoenvio", "Nrocarrito" as "Numerodecarrito", "Factmanual" as "Facturamanual", "Buzonfe" as "Buzonfullenv", "Pefactman" as "Pedidofacturamanual", "Factmcep" as "Facturamanualconentregaposterior", "Pefactmcep" as "Pedidofacturamanualconentregapos", "Enlaceop" as "Enlacedelaoperacion", "Factmvc" as "Facturamanualconvtacont", "Bdfe" as "Basededatosfullenv", "Factelec" as "Facturaelectronica", "Pefactelec" as "Pedidofacturaelectronica", "Datosret" as "Datosderetiro", "Factecep" as "Facturaelectronicaconentregaposterior", "Pefactecep" as "Pedidofacturaelectronicaconentregapos", "Factevc" as "Facturaelectronicaconvtacont", "Observa" as "Observaciones", "Factfiscal" as "Facturafiscal", "Pefactfisc" as "Pedidofacturafiscal", "Factfcep" as "Facturafiscalconentregaposterior", "Pefactfcep" as "Pedidofacturafiscalconentregapos", "Pagado" as "Pagado", "Factfvc" as "Facturafiscalconvtacont", "Promos" as "Aplicarpromocionesautomaticas", "Obs" as "Observacion" from ZooLogic.ECOM where  funciones.padr( CODIGO, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ECOM.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_ECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Opeerror" as "Opeerror", "Storeorder" as "Storeorderid" from ZooLogic.DETERROR where CODIGO = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Errores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Errores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Errores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valecom" as "Valorecommerce", "Tipovaleco" as "Tipovalorecommerce", "Valdragon" as "Valordragonfish", "Valdesc" as "Valordescripcion", "Tipovaldf" as "Tipovalordragon" from ZooLogic.ECOMEQUIVAL where Codigo = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EquiValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EquiValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EquiValoresDetalle
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Cuenta" as "Descripcion", "Codlista" as "Listadeprecios", "Accion" as "Accion", "Cuentacom" as "Cuenta", "Vendedor" as "Vendedor", "Buzon" as "Buzon", "Tipoecom" as "Tipoecommerce", "Transpor" as "Transportista", "Basededato" as "Basededatos", "Idvinc" as "Idvinculacion", "Motivo" as "Motivo", "Ultorder" as "Ultimaorder", "Dtosenvio" as "Datosdeenvio", "Generacan" as "Generacancelacion", "Vacio" as "Vacio", "Pago" as "Pago", "Valctacte" as "Valorctacte", "Condpago" as "Condicionpagopreferente", "Cliedef" as "Clientedefault", "Telenvio" as "Telefonodeenvio", "Descartar" as "Descartar", "Usaotrabd" as "Utilizastockotrabase", "Valecamb" as "Usavalecambio", "Convenv" as "Concenvio", "Conccolor" as "Conccolor", "Conctalle" as "Conctalle", "Concart" as "Concarticulo", "Cargaautov" as "Cargaautomaticavalores", "Usaequival" as "Usaequivalores", "Dtospago" as "Datosdepago", "Pedido" as "Pedido", "Factsinper" as "Facturarsinpersonalizar", "Origenst" as "Bdorigenstock", "Percctacte" as "Percepcionesactacte", "Fecnov" as "Fechanovedades", "Numero" as "Numero", "Remito" as "Remito", "Accionfe" as "Accionfullenv", "Aplicenvio" as "Aplicarcostoenvio", "Nrocarrito" as "Numerodecarrito", "Factmanual" as "Facturamanual", "Buzonfe" as "Buzonfullenv", "Pefactman" as "Pedidofacturamanual", "Factmcep" as "Facturamanualconentregaposterior", "Pefactmcep" as "Pedidofacturamanualconentregapos", "Enlaceop" as "Enlacedelaoperacion", "Factmvc" as "Facturamanualconvtacont", "Bdfe" as "Basededatosfullenv", "Factelec" as "Facturaelectronica", "Pefactelec" as "Pedidofacturaelectronica", "Datosret" as "Datosderetiro", "Factecep" as "Facturaelectronicaconentregaposterior", "Pefactecep" as "Pedidofacturaelectronicaconentregapos", "Factevc" as "Facturaelectronicaconvtacont", "Observa" as "Observaciones", "Factfiscal" as "Facturafiscal", "Pefactfisc" as "Pedidofacturafiscal", "Factfcep" as "Facturafiscalconentregaposterior", "Pefactfcep" as "Pedidofacturafiscalconentregapos", "Pagado" as "Pagado", "Factfvc" as "Facturafiscalconvtacont", "Promos" as "Aplicarpromocionesautomaticas", "Obs" as "Observacion" from ZooLogic.ECOM where  ECOM.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_ECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Opeerror" as "Opeerror", "Storeorder" as "Storeorderid" from ZooLogic.DETERROR where CODIGO = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Errores')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Errores', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Errores
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valecom" as "Valorecommerce", "Tipovaleco" as "Tipovalorecommerce", "Valdragon" as "Valordragonfish", "Valdesc" as "Valordescripcion", "Tipovaldf" as "Tipovalordragon" from ZooLogic.ECOMEQUIVAL where Codigo = <<"'" + this.FormatearTextoSql( c_ECOMMERCE.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_EquiValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EquiValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EquiValoresDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Bdaltafw,Esttrans,Horaexpo,Bdmodifw,Valtafw" + ;
",Vmodifw,Umodifw,Zadsfw,Ualtafw,Smodifw,Horaimpo,Hmodifw,Saltafw,Codigo,Cuenta,Codlista,Accion,Cuent" + ;
"acom,Vendedor,Buzon,Tipoecom,Transpor,Basededato,Idvinc,Motivo,Ultorder,Dtosenvio,Generacan,Vacio,Pa" + ;
"go,Valctacte,Condpago,Cliedef,Telenvio,Descartar,Usaotrabd,Valecamb,Convenv,Conccolor,Conctalle,Conc" + ;
"art,Cargaautov,Usaequival,Dtospago,Pedido,Factsinper,Origenst,Percctacte,Fecnov,Numero,Remito,Accion" + ;
"fe,Aplicenvio,Nrocarrito,Factmanual,Buzonfe,Pefactman,Factmcep,Pefactmcep,Enlaceop,Factmvc,Bdfe,Fact" + ;
"elec,Pefactelec,Datosret,Factecep,Pefactecep,Factevc,Observa,Factfiscal,Pefactfisc,Factfcep,Pefactfc" + ;
"ep,Pagado,Factfvc,Promos,Obs" + ;
" from ZooLogic.ECOM where  ECOM.CODIGO != '' and " + lcFiltro )
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
			local  lxEcomFecimpo, lxEcomFectrans, lxEcomFmodifw, lxEcomFecexpo, lxEcomFaltafw, lxEcomHaltafw, lxEcomBdaltafw, lxEcomEsttrans, lxEcomHoraexpo, lxEcomBdmodifw, lxEcomValtafw, lxEcomVmodifw, lxEcomUmodifw, lxEcomZadsfw, lxEcomUaltafw, lxEcomSmodifw, lxEcomHoraimpo, lxEcomHmodifw, lxEcomSaltafw, lxEcomCodigo, lxEcomCuenta, lxEcomCodlista, lxEcomAccion, lxEcomCuentacom, lxEcomVendedor, lxEcomBuzon, lxEcomTipoecom, lxEcomTranspor, lxEcomBasededato, lxEcomIdvinc, lxEcomMotivo, lxEcomUltorder, lxEcomDtosenvio, lxEcomGeneracan, lxEcomVacio, lxEcomPago, lxEcomValctacte, lxEcomCondpago, lxEcomCliedef, lxEcomTelenvio, lxEcomDescartar, lxEcomUsaotrabd, lxEcomValecamb, lxEcomConvenv, lxEcomConccolor, lxEcomConctalle, lxEcomConcart, lxEcomCargaautov, lxEcomUsaequival, lxEcomDtospago, lxEcomPedido, lxEcomFactsinper, lxEcomOrigenst, lxEcomPercctacte, lxEcomFecnov, lxEcomNumero, lxEcomRemito, lxEcomAccionfe, lxEcomAplicenvio, lxEcomNrocarrito, lxEcomFactmanual, lxEcomBuzonfe, lxEcomPefactman, lxEcomFactmcep, lxEcomPefactmcep, lxEcomEnlaceop, lxEcomFactmvc, lxEcomBdfe, lxEcomFactelec, lxEcomPefactelec, lxEcomDatosret, lxEcomFactecep, lxEcomPefactecep, lxEcomFactevc, lxEcomObserva, lxEcomFactfiscal, lxEcomPefactfisc, lxEcomFactfcep, lxEcomPefactfcep, lxEcomPagado, lxEcomFactfvc, lxEcomPromos, lxEcomObs
				lxEcomFecimpo = ctod( '  /  /    ' )			lxEcomFectrans = ctod( '  /  /    ' )			lxEcomFmodifw = ctod( '  /  /    ' )			lxEcomFecexpo = ctod( '  /  /    ' )			lxEcomFaltafw = ctod( '  /  /    ' )			lxEcomHaltafw = []			lxEcomBdaltafw = []			lxEcomEsttrans = []			lxEcomHoraexpo = []			lxEcomBdmodifw = []			lxEcomValtafw = []			lxEcomVmodifw = []			lxEcomUmodifw = []			lxEcomZadsfw = []			lxEcomUaltafw = []			lxEcomSmodifw = []			lxEcomHoraimpo = []			lxEcomHmodifw = []			lxEcomSaltafw = []			lxEcomCodigo = []			lxEcomCuenta = []			lxEcomCodlista = []			lxEcomAccion = []			lxEcomCuentacom = []			lxEcomVendedor = []			lxEcomBuzon = []			lxEcomTipoecom = 0			lxEcomTranspor = []			lxEcomBasededato = []			lxEcomIdvinc = 0			lxEcomMotivo = []			lxEcomUltorder = 0			lxEcomDtosenvio = .F.			lxEcomGeneracan = .F.			lxEcomVacio = .F.			lxEcomPago = []			lxEcomValctacte = []			lxEcomCondpago = []			lxEcomCliedef = []			lxEcomTelenvio = .F.			lxEcomDescartar = .F.			lxEcomUsaotrabd = .F.			lxEcomValecamb = .F.			lxEcomConvenv = []			lxEcomConccolor = []			lxEcomConctalle = []			lxEcomConcart = []			lxEcomCargaautov = .F.			lxEcomUsaequival = .F.			lxEcomDtospago = .F.			lxEcomPedido = .F.			lxEcomFactsinper = .F.			lxEcomOrigenst = []			lxEcomPercctacte = .F.			lxEcomFecnov = ctod( '  /  /    ' )			lxEcomNumero = .F.			lxEcomRemito = .F.			lxEcomAccionfe = []			lxEcomAplicenvio = 0			lxEcomNrocarrito = .F.			lxEcomFactmanual = .F.			lxEcomBuzonfe = []			lxEcomPefactman = .F.			lxEcomFactmcep = .F.			lxEcomPefactmcep = .F.			lxEcomEnlaceop = .F.			lxEcomFactmvc = .F.			lxEcomBdfe = []			lxEcomFactelec = .F.			lxEcomPefactelec = .F.			lxEcomDatosret = .F.			lxEcomFactecep = .F.			lxEcomPefactecep = .F.			lxEcomFactevc = .F.			lxEcomObserva = .F.			lxEcomFactfiscal = .F.			lxEcomPefactfisc = .F.			lxEcomFactfcep = .F.			lxEcomPefactfcep = .F.			lxEcomPagado = .F.			lxEcomFactfvc = .F.			lxEcomPromos = .F.			lxEcomObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETERROR where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ECOMEQUIVAL where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ECOM where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
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
			lcTabla = 'ECOM' + '_' + tcCampo
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
		lcWhere = " Where  ECOM.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Cuenta" as "Descripcion", "Codlista" as "Listadeprecios", "Accion" as "Accion", "Cuentacom" as "Cuenta", "Vendedor" as "Vendedor", "Buzon" as "Buzon", "Tipoecom" as "Tipoecommerce", "Transpor" as "Transportista", "Basededato" as "Basededatos", "Idvinc" as "Idvinculacion", "Motivo" as "Motivo", "Ultorder" as "Ultimaorder", "Dtosenvio" as "Datosdeenvio", "Generacan" as "Generacancelacion", "Vacio" as "Vacio", "Pago" as "Pago", "Valctacte" as "Valorctacte", "Condpago" as "Condicionpagopreferente", "Cliedef" as "Clientedefault", "Telenvio" as "Telefonodeenvio", "Descartar" as "Descartar", "Usaotrabd" as "Utilizastockotrabase", "Valecamb" as "Usavalecambio", "Convenv" as "Concenvio", "Conccolor" as "Conccolor", "Conctalle" as "Conctalle", "Concart" as "Concarticulo", "Cargaautov" as "Cargaautomaticavalores", "Usaequival" as "Usaequivalores", "Dtospago" as "Datosdepago", "Pedido" as "Pedido", "Factsinper" as "Facturarsinpersonalizar", "Origenst" as "Bdorigenstock", "Percctacte" as "Percepcionesactacte", "Fecnov" as "Fechanovedades", "Numero" as "Numero", "Remito" as "Remito", "Accionfe" as "Accionfullenv", "Aplicenvio" as "Aplicarcostoenvio", "Nrocarrito" as "Numerodecarrito", "Factmanual" as "Facturamanual", "Buzonfe" as "Buzonfullenv", "Pefactman" as "Pedidofacturamanual", "Factmcep" as "Facturamanualconentregaposterior", "Pefactmcep" as "Pedidofacturamanualconentregapos", "Enlaceop" as "Enlacedelaoperacion", "Factmvc" as "Facturamanualconvtacont", "Bdfe" as "Basededatosfullenv", "Factelec" as "Facturaelectronica", "Pefactelec" as "Pedidofacturaelectronica", "Datosret" as "Datosderetiro", "Factecep" as "Facturaelectronicaconentregaposterior", "Pefactecep" as "Pedidofacturaelectronicaconentregapos", "Factevc" as "Facturaelectronicaconvtacont", "Observa" as "Observaciones", "Factfiscal" as "Facturafiscal", "Pefactfisc" as "Pedidofacturafiscal", "Factfcep" as "Facturafiscalconentregaposterior", "Pefactfcep" as "Pedidofacturafiscalconentregapos", "Pagado" as "Pagado", "Factfvc" as "Facturafiscalconvtacont", "Promos" as "Aplicarpromocionesautomaticas", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ECOM', '', tnTope )
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
	Function ObtenerDatosDetalleErrores( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETERROR.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Opeerror" as "Opeerror", "Storeorder" as "Storeorderid"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleErrores( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETERROR', 'Errores', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleErrores( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleErrores( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleEquiValoresDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ECOMEQUIVAL.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Valecom" as "Valorecommerce", "Tipovaleco" as "Tipovalorecommerce", "Valdragon" as "Valordragonfish", "Valdesc" as "Valordescripcion", "Tipovaldf" as "Tipovalordragon"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleEquiValoresDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ECOMEQUIVAL', 'EquiValoresDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleEquiValoresDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleEquiValoresDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUENTA AS DESCRIPCION'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'ACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCION AS ACCION'
				Case lcAtributo == 'CUENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUENTACOM AS CUENTA'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'BUZON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BUZON AS BUZON'
				Case lcAtributo == 'TIPOECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOECOM AS TIPOECOMMERCE'
				Case lcAtributo == 'TRANSPORTISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRANSPOR AS TRANSPORTISTA'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDEDATO AS BASEDEDATOS'
				Case lcAtributo == 'IDVINCULACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVINC AS IDVINCULACION'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'ULTIMAORDER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ULTORDER AS ULTIMAORDER'
				Case lcAtributo == 'DATOSDEENVIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DTOSENVIO AS DATOSDEENVIO'
				Case lcAtributo == 'GENERACANCELACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GENERACAN AS GENERACANCELACION'
				Case lcAtributo == 'VACIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VACIO AS VACIO'
				Case lcAtributo == 'PAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGO AS PAGO'
				Case lcAtributo == 'VALORCTACTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALCTACTE AS VALORCTACTE'
				Case lcAtributo == 'CONDICIONPAGOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONPAGOPREFERENTE'
				Case lcAtributo == 'CLIENTEDEFAULT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDEF AS CLIENTEDEFAULT'
				Case lcAtributo == 'TELEFONODEENVIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TELENVIO AS TELEFONODEENVIO'
				Case lcAtributo == 'DESCARTAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCARTAR AS DESCARTAR'
				Case lcAtributo == 'UTILIZASTOCKOTRABASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USAOTRABD AS UTILIZASTOCKOTRABASE'
				Case lcAtributo == 'USAVALECAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALECAMB AS USAVALECAMBIO'
				Case lcAtributo == 'CONCENVIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONVENV AS CONCENVIO'
				Case lcAtributo == 'CONCCOLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCCOLOR AS CONCCOLOR'
				Case lcAtributo == 'CONCTALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCTALLE AS CONCTALLE'
				Case lcAtributo == 'CONCARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCART AS CONCARTICULO'
				Case lcAtributo == 'CARGAAUTOMATICAVALORES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CARGAAUTOV AS CARGAAUTOMATICAVALORES'
				Case lcAtributo == 'USAEQUIVALORES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USAEQUIVAL AS USAEQUIVALORES'
				Case lcAtributo == 'DATOSDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DTOSPAGO AS DATOSDEPAGO'
				Case lcAtributo == 'PEDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEDIDO AS PEDIDO'
				Case lcAtributo == 'FACTURARSINPERSONALIZAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSINPER AS FACTURARSINPERSONALIZAR'
				Case lcAtributo == 'BDORIGENSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGENST AS BDORIGENSTOCK'
				Case lcAtributo == 'PERCEPCIONESACTACTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERCCTACTE AS PERCEPCIONESACTACTE'
				Case lcAtributo == 'FECHANOVEDADES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECNOV AS FECHANOVEDADES'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REMITO AS REMITO'
				Case lcAtributo == 'ACCIONFULLENV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCIONFE AS ACCIONFULLENV'
				Case lcAtributo == 'APLICARCOSTOENVIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APLICENVIO AS APLICARCOSTOENVIO'
				Case lcAtributo == 'NUMERODECARRITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCARRITO AS NUMERODECARRITO'
				Case lcAtributo == 'FACTURAMANUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTMANUAL AS FACTURAMANUAL'
				Case lcAtributo == 'BUZONFULLENV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BUZONFE AS BUZONFULLENV'
				Case lcAtributo == 'PEDIDOFACTURAMANUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEFACTMAN AS PEDIDOFACTURAMANUAL'
				Case lcAtributo == 'FACTURAMANUALCONENTREGAPOSTERIOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTMCEP AS FACTURAMANUALCONENTREGAPOSTERIOR'
				Case lcAtributo == 'PEDIDOFACTURAMANUALCONENTREGAPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEFACTMCEP AS PEDIDOFACTURAMANUALCONENTREGAPOS'
				Case lcAtributo == 'ENLACEDELAOPERACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENLACEOP AS ENLACEDELAOPERACION'
				Case lcAtributo == 'FACTURAMANUALCONVTACONT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTMVC AS FACTURAMANUALCONVTACONT'
				Case lcAtributo == 'BASEDEDATOSFULLENV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDFE AS BASEDEDATOSFULLENV'
				Case lcAtributo == 'FACTURAELECTRONICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTELEC AS FACTURAELECTRONICA'
				Case lcAtributo == 'PEDIDOFACTURAELECTRONICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEFACTELEC AS PEDIDOFACTURAELECTRONICA'
				Case lcAtributo == 'DATOSDERETIRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DATOSRET AS DATOSDERETIRO'
				Case lcAtributo == 'FACTURAELECTRONICACONENTREGAPOSTERIOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTECEP AS FACTURAELECTRONICACONENTREGAPOSTERIOR'
				Case lcAtributo == 'PEDIDOFACTURAELECTRONICACONENTREGAPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEFACTECEP AS PEDIDOFACTURAELECTRONICACONENTREGAPOS'
				Case lcAtributo == 'FACTURAELECTRONICACONVTACONT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTEVC AS FACTURAELECTRONICACONVTACONT'
				Case lcAtributo == 'OBSERVACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBSERVA AS OBSERVACIONES'
				Case lcAtributo == 'FACTURAFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTFISCAL AS FACTURAFISCAL'
				Case lcAtributo == 'PEDIDOFACTURAFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEFACTFISC AS PEDIDOFACTURAFISCAL'
				Case lcAtributo == 'FACTURAFISCALCONENTREGAPOSTERIOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTFCEP AS FACTURAFISCALCONENTREGAPOSTERIOR'
				Case lcAtributo == 'PEDIDOFACTURAFISCALCONENTREGAPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEFACTFCEP AS PEDIDOFACTURAFISCALCONENTREGAPOS'
				Case lcAtributo == 'PAGADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGADO AS PAGADO'
				Case lcAtributo == 'FACTURAFISCALCONVTACONT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTFVC AS FACTURAFISCALCONVTACONT'
				Case lcAtributo == 'APLICARPROMOCIONESAUTOMATICAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROMOS AS APLICARPROMOCIONESAUTOMATICAS'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleErrores( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OPEERROR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPEERROR AS OPEERROR'
				Case lcAtributo == 'STOREORDERID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'STOREORDER AS STOREORDERID'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleEquiValoresDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'VALORECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALECOM AS VALORECOMMERCE'
				Case lcAtributo == 'TIPOVALORECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOVALECO AS TIPOVALORECOMMERCE'
				Case lcAtributo == 'VALORDRAGONFISH'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALDRAGON AS VALORDRAGONFISH'
				Case lcAtributo == 'VALORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALDESC AS VALORDESCRIPCION'
				Case lcAtributo == 'TIPOVALORDRAGON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOVALDF AS TIPOVALORDRAGON'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'ACCION'
				lcCampo = 'ACCION'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTA'
				lcCampo = 'CUENTACOM'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'BUZON'
				lcCampo = 'BUZON'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOECOMMERCE'
				lcCampo = 'TIPOECOM'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTA'
				lcCampo = 'TRANSPOR'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASEDEDATO'
			Case upper( alltrim( tcAtributo ) ) == 'IDVINCULACION'
				lcCampo = 'IDVINC'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMAORDER'
				lcCampo = 'ULTORDER'
			Case upper( alltrim( tcAtributo ) ) == 'DATOSDEENVIO'
				lcCampo = 'DTOSENVIO'
			Case upper( alltrim( tcAtributo ) ) == 'GENERACANCELACION'
				lcCampo = 'GENERACAN'
			Case upper( alltrim( tcAtributo ) ) == 'VACIO'
				lcCampo = 'VACIO'
			Case upper( alltrim( tcAtributo ) ) == 'PAGO'
				lcCampo = 'PAGO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORCTACTE'
				lcCampo = 'VALCTACTE'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONPAGOPREFERENTE'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDEFAULT'
				lcCampo = 'CLIEDEF'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONODEENVIO'
				lcCampo = 'TELENVIO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCARTAR'
				lcCampo = 'DESCARTAR'
			Case upper( alltrim( tcAtributo ) ) == 'UTILIZASTOCKOTRABASE'
				lcCampo = 'USAOTRABD'
			Case upper( alltrim( tcAtributo ) ) == 'USAVALECAMBIO'
				lcCampo = 'VALECAMB'
			Case upper( alltrim( tcAtributo ) ) == 'CONCENVIO'
				lcCampo = 'CONVENV'
			Case upper( alltrim( tcAtributo ) ) == 'CONCCOLOR'
				lcCampo = 'CONCCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'CONCTALLE'
				lcCampo = 'CONCTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CONCARTICULO'
				lcCampo = 'CONCART'
			Case upper( alltrim( tcAtributo ) ) == 'CARGAAUTOMATICAVALORES'
				lcCampo = 'CARGAAUTOV'
			Case upper( alltrim( tcAtributo ) ) == 'USAEQUIVALORES'
				lcCampo = 'USAEQUIVAL'
			Case upper( alltrim( tcAtributo ) ) == 'DATOSDEPAGO'
				lcCampo = 'DTOSPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDO'
				lcCampo = 'PEDIDO'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURARSINPERSONALIZAR'
				lcCampo = 'FACTSINPER'
			Case upper( alltrim( tcAtributo ) ) == 'BDORIGENSTOCK'
				lcCampo = 'ORIGENST'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONESACTACTE'
				lcCampo = 'PERCCTACTE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHANOVEDADES'
				lcCampo = 'FECNOV'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'REMITO'
			Case upper( alltrim( tcAtributo ) ) == 'ACCIONFULLENV'
				lcCampo = 'ACCIONFE'
			Case upper( alltrim( tcAtributo ) ) == 'APLICARCOSTOENVIO'
				lcCampo = 'APLICENVIO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECARRITO'
				lcCampo = 'NROCARRITO'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAMANUAL'
				lcCampo = 'FACTMANUAL'
			Case upper( alltrim( tcAtributo ) ) == 'BUZONFULLENV'
				lcCampo = 'BUZONFE'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDOFACTURAMANUAL'
				lcCampo = 'PEFACTMAN'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAMANUALCONENTREGAPOSTERIOR'
				lcCampo = 'FACTMCEP'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDOFACTURAMANUALCONENTREGAPOS'
				lcCampo = 'PEFACTMCEP'
			Case upper( alltrim( tcAtributo ) ) == 'ENLACEDELAOPERACION'
				lcCampo = 'ENLACEOP'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAMANUALCONVTACONT'
				lcCampo = 'FACTMVC'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSFULLENV'
				lcCampo = 'BDFE'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAELECTRONICA'
				lcCampo = 'FACTELEC'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDOFACTURAELECTRONICA'
				lcCampo = 'PEFACTELEC'
			Case upper( alltrim( tcAtributo ) ) == 'DATOSDERETIRO'
				lcCampo = 'DATOSRET'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAELECTRONICACONENTREGAPOSTERIOR'
				lcCampo = 'FACTECEP'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDOFACTURAELECTRONICACONENTREGAPOS'
				lcCampo = 'PEFACTECEP'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAELECTRONICACONVTACONT'
				lcCampo = 'FACTEVC'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACIONES'
				lcCampo = 'OBSERVA'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAFISCAL'
				lcCampo = 'FACTFISCAL'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDOFACTURAFISCAL'
				lcCampo = 'PEFACTFISC'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAFISCALCONENTREGAPOSTERIOR'
				lcCampo = 'FACTFCEP'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDOFACTURAFISCALCONENTREGAPOS'
				lcCampo = 'PEFACTFCEP'
			Case upper( alltrim( tcAtributo ) ) == 'PAGADO'
				lcCampo = 'PAGADO'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAFISCALCONVTACONT'
				lcCampo = 'FACTFVC'
			Case upper( alltrim( tcAtributo ) ) == 'APLICARPROMOCIONESAUTOMATICAS'
				lcCampo = 'PROMOS'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleErrores( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OPEERROR'
				lcCampo = 'OPEERROR'
			Case upper( alltrim( tcAtributo ) ) == 'STOREORDERID'
				lcCampo = 'STOREORDER'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleEquiValoresDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORECOMMERCE'
				lcCampo = 'VALECOM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOVALORECOMMERCE'
				lcCampo = 'TIPOVALECO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDRAGONFISH'
				lcCampo = 'VALDRAGON'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDESCRIPCION'
				lcCampo = 'VALDESC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOVALORDRAGON'
				lcCampo = 'TIPOVALDF'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'ERRORES'
			lcRetorno = 'DETERROR'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'EQUIVALORESDETALLE'
			lcRetorno = 'ECOMEQUIVAL'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxEcomFecimpo, lxEcomFectrans, lxEcomFmodifw, lxEcomFecexpo, lxEcomFaltafw, lxEcomHaltafw, lxEcomBdaltafw, lxEcomEsttrans, lxEcomHoraexpo, lxEcomBdmodifw, lxEcomValtafw, lxEcomVmodifw, lxEcomUmodifw, lxEcomZadsfw, lxEcomUaltafw, lxEcomSmodifw, lxEcomHoraimpo, lxEcomHmodifw, lxEcomSaltafw, lxEcomCodigo, lxEcomCuenta, lxEcomCodlista, lxEcomAccion, lxEcomCuentacom, lxEcomVendedor, lxEcomBuzon, lxEcomTipoecom, lxEcomTranspor, lxEcomBasededato, lxEcomIdvinc, lxEcomMotivo, lxEcomUltorder, lxEcomDtosenvio, lxEcomGeneracan, lxEcomVacio, lxEcomPago, lxEcomValctacte, lxEcomCondpago, lxEcomCliedef, lxEcomTelenvio, lxEcomDescartar, lxEcomUsaotrabd, lxEcomValecamb, lxEcomConvenv, lxEcomConccolor, lxEcomConctalle, lxEcomConcart, lxEcomCargaautov, lxEcomUsaequival, lxEcomDtospago, lxEcomPedido, lxEcomFactsinper, lxEcomOrigenst, lxEcomPercctacte, lxEcomFecnov, lxEcomNumero, lxEcomRemito, lxEcomAccionfe, lxEcomAplicenvio, lxEcomNrocarrito, lxEcomFactmanual, lxEcomBuzonfe, lxEcomPefactman, lxEcomFactmcep, lxEcomPefactmcep, lxEcomEnlaceop, lxEcomFactmvc, lxEcomBdfe, lxEcomFactelec, lxEcomPefactelec, lxEcomDatosret, lxEcomFactecep, lxEcomPefactecep, lxEcomFactevc, lxEcomObserva, lxEcomFactfiscal, lxEcomPefactfisc, lxEcomFactfcep, lxEcomPefactfcep, lxEcomPagado, lxEcomFactfvc, lxEcomPromos, lxEcomObs
				lxEcomFecimpo =  .Fechaimpo			lxEcomFectrans =  .Fechatransferencia			lxEcomFmodifw =  .Fechamodificacionfw			lxEcomFecexpo =  .Fechaexpo			lxEcomFaltafw =  .Fechaaltafw			lxEcomHaltafw =  .Horaaltafw			lxEcomBdaltafw =  .Basededatosaltafw			lxEcomEsttrans =  .Estadotransferencia			lxEcomHoraexpo =  .Horaexpo			lxEcomBdmodifw =  .Basededatosmodificacionfw			lxEcomValtafw =  .Versionaltafw			lxEcomVmodifw =  .Versionmodificacionfw			lxEcomUmodifw =  .Usuariomodificacionfw			lxEcomZadsfw =  .Zadsfw			lxEcomUaltafw =  .Usuarioaltafw			lxEcomSmodifw =  .Seriemodificacionfw			lxEcomHoraimpo =  .Horaimpo			lxEcomHmodifw =  .Horamodificacionfw			lxEcomSaltafw =  .Seriealtafw			lxEcomCodigo =  .Codigo			lxEcomCuenta =  .Descripcion			lxEcomCodlista =  upper( .ListaDePrecios_PK ) 			lxEcomAccion =  .Accion			lxEcomCuentacom =  .Cuenta			lxEcomVendedor =  upper( .Vendedor_PK ) 			lxEcomBuzon =  .Buzon			lxEcomTipoecom =  .Tipoecommerce			lxEcomTranspor =  upper( .Transportista_PK ) 			lxEcomBasededato =  .Basededatos			lxEcomIdvinc =  .Idvinculacion			lxEcomMotivo =  upper( .Motivo_PK ) 			lxEcomUltorder =  .Ultimaorder			lxEcomDtosenvio =  .Datosdeenvio			lxEcomGeneracan =  .Generacancelacion			lxEcomVacio =  .Vacio			lxEcomPago =  upper( .Pago_PK ) 			lxEcomValctacte =  upper( .ValorCtaCte_PK ) 			lxEcomCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxEcomCliedef =  upper( .ClienteDefault_PK ) 			lxEcomTelenvio =  .Telefonodeenvio			lxEcomDescartar =  .Descartar			lxEcomUsaotrabd =  .Utilizastockotrabase			lxEcomValecamb =  .Usavalecambio			lxEcomConvenv =  upper( .Concenvio_PK ) 			lxEcomConccolor =  upper( .ConcColor_PK ) 			lxEcomConctalle =  upper( .ConcTalle_PK ) 			lxEcomConcart =  upper( .ConcArticulo_PK ) 			lxEcomCargaautov =  .Cargaautomaticavalores			lxEcomUsaequival =  .Usaequivalores			lxEcomDtospago =  .Datosdepago			lxEcomPedido =  .Pedido			lxEcomFactsinper =  .Facturarsinpersonalizar			lxEcomOrigenst =  .Bdorigenstock			lxEcomPercctacte =  .Percepcionesactacte			lxEcomFecnov =  .Fechanovedades			lxEcomNumero =  .Numero			lxEcomRemito =  .Remito			lxEcomAccionfe =  .Accionfullenv			lxEcomAplicenvio =  .Aplicarcostoenvio			lxEcomNrocarrito =  .Numerodecarrito			lxEcomFactmanual =  .Facturamanual			lxEcomBuzonfe =  .Buzonfullenv			lxEcomPefactman =  .Pedidofacturamanual			lxEcomFactmcep =  .Facturamanualconentregaposterior			lxEcomPefactmcep =  .Pedidofacturamanualconentregapos			lxEcomEnlaceop =  .Enlacedelaoperacion			lxEcomFactmvc =  .Facturamanualconvtacont			lxEcomBdfe =  .Basededatosfullenv			lxEcomFactelec =  .Facturaelectronica			lxEcomPefactelec =  .Pedidofacturaelectronica			lxEcomDatosret =  .Datosderetiro			lxEcomFactecep =  .Facturaelectronicaconentregaposterior			lxEcomPefactecep =  .Pedidofacturaelectronicaconentregapos			lxEcomFactevc =  .Facturaelectronicaconvtacont			lxEcomObserva =  .Observaciones			lxEcomFactfiscal =  .Facturafiscal			lxEcomPefactfisc =  .Pedidofacturafiscal			lxEcomFactfcep =  .Facturafiscalconentregaposterior			lxEcomPefactfcep =  .Pedidofacturafiscalconentregapos			lxEcomPagado =  .Pagado			lxEcomFactfvc =  .Facturafiscalconvtacont			lxEcomPromos =  .Aplicarpromocionesautomaticas			lxEcomObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ECOM ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Bdaltafw","Esttrans","Horaexpo","Bdmodifw","Valtafw","Vmodifw","Umodifw","Zadsfw","Ualtafw","Smodifw","Horaimpo","Hmodifw","Saltafw","Codigo","Cuenta","Codlista","Accion","Cuentacom","Vendedor","Buzon","Tipoecom","Transpor","Basededato","Idvinc","Motivo","Ultorder","Dtosenvio","Generacan","Vacio","Pago","Valctacte","Condpago","Cliedef","Telenvio","Descartar","Usaotrabd","Valecamb","Convenv","Conccolor","Conctalle","Concart","Cargaautov","Usaequival","Dtospago","Pedido","Factsinper","Origenst","Percctacte","Fecnov","Numero","Remito","Accionfe","Aplicenvio","Nrocarrito","Factmanual","Buzonfe","Pefactman","Factmcep","Pefactmcep","Enlaceop","Factmvc","Bdfe","Factelec","Pefactelec","Datosret","Factecep","Pefactecep","Factevc","Observa","Factfiscal","Pefactfisc","Factfcep","Pefactfcep","Pagado","Factfvc","Promos","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxEcomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEcomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEcomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEcomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEcomFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCuenta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomAccion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCuentacom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomVendedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomBuzon ) + "'" >>, <<lxEcomTipoecom >>, <<"'" + this.FormatearTextoSql( lxEcomTranspor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomBasededato ) + "'" >>, <<lxEcomIdvinc >>, <<"'" + this.FormatearTextoSql( lxEcomMotivo ) + "'" >>, <<lxEcomUltorder >>, <<iif( lxEcomDtosenvio, 1, 0 ) >>, <<iif( lxEcomGeneracan, 1, 0 ) >>, <<iif( lxEcomVacio, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomPago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomValctacte ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCondpago ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomCliedef ) + "'" >>, <<iif( lxEcomTelenvio, 1, 0 ) >>, <<iif( lxEcomDescartar, 1, 0 ) >>, <<iif( lxEcomUsaotrabd, 1, 0 ) >>, <<iif( lxEcomValecamb, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomConvenv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomConccolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomConctalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEcomConcart ) + "'" >>, <<iif( lxEcomCargaautov, 1, 0 ) >>, <<iif( lxEcomUsaequival, 1, 0 ) >>, <<iif( lxEcomDtospago, 1, 0 ) >>, <<iif( lxEcomPedido, 1, 0 ) >>, <<iif( lxEcomFactsinper, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomOrigenst ) + "'" >>, <<iif( lxEcomPercctacte, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxEcomFecnov ) + "'" >>, <<iif( lxEcomNumero, 1, 0 ) >>, <<iif( lxEcomRemito, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomAccionfe ) + "'" >>, <<lxEcomAplicenvio >>, <<iif( lxEcomNrocarrito, 1, 0 ) >>, <<iif( lxEcomFactmanual, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomBuzonfe ) + "'" >>, <<iif( lxEcomPefactman, 1, 0 ) >>, <<iif( lxEcomFactmcep, 1, 0 ) >>, <<iif( lxEcomPefactmcep, 1, 0 ) >>, <<iif( lxEcomEnlaceop, 1, 0 ) >>, <<iif( lxEcomFactmvc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomBdfe ) + "'" >>, <<iif( lxEcomFactelec, 1, 0 ) >>, <<iif( lxEcomPefactelec, 1, 0 ) >>, <<iif( lxEcomDatosret, 1, 0 ) >>, <<iif( lxEcomFactecep, 1, 0 ) >>, <<iif( lxEcomPefactecep, 1, 0 ) >>, <<iif( lxEcomFactevc, 1, 0 ) >>, <<iif( lxEcomObserva, 1, 0 ) >>, <<iif( lxEcomFactfiscal, 1, 0 ) >>, <<iif( lxEcomPefactfisc, 1, 0 ) >>, <<iif( lxEcomFactfcep, 1, 0 ) >>, <<iif( lxEcomPefactfcep, 1, 0 ) >>, <<iif( lxEcomPagado, 1, 0 ) >>, <<iif( lxEcomFactfvc, 1, 0 ) >>, <<iif( lxEcomPromos, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEcomObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ECOM' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Errores
				if this.oEntidad.Errores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxOpeerror = loItem.Opeerror
					lxStoreorderid = loItem.Storeorderid
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETERROR("NROITEM","Codigo","OpeError","STOREORDER" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxOpeerror>>, <<"'" + this.FormatearTextoSql( lxStoreorderid ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EquiValoresDetalle
				if this.oEntidad.EquiValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValorecommerce = loItem.Valorecommerce
					lxTipovalorecommerce = loItem.Tipovalorecommerce
					lxValordragonfish_PK = loItem.Valordragonfish_PK
					lxValordescripcion = loItem.Valordescripcion
					lxTipovalordragon = loItem.Tipovalordragon
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ECOMEQUIVAL("NROITEM","Codigo","ValEcom","TipoValEco","ValDragon","ValDesc","TipoValDf" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValorecommerce ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipovalorecommerce ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordragonfish_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipovalordragon ) + "'">> ) 
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
			local  lxEcomFecimpo, lxEcomFectrans, lxEcomFmodifw, lxEcomFecexpo, lxEcomFaltafw, lxEcomHaltafw, lxEcomBdaltafw, lxEcomEsttrans, lxEcomHoraexpo, lxEcomBdmodifw, lxEcomValtafw, lxEcomVmodifw, lxEcomUmodifw, lxEcomZadsfw, lxEcomUaltafw, lxEcomSmodifw, lxEcomHoraimpo, lxEcomHmodifw, lxEcomSaltafw, lxEcomCodigo, lxEcomCuenta, lxEcomCodlista, lxEcomAccion, lxEcomCuentacom, lxEcomVendedor, lxEcomBuzon, lxEcomTipoecom, lxEcomTranspor, lxEcomBasededato, lxEcomIdvinc, lxEcomMotivo, lxEcomUltorder, lxEcomDtosenvio, lxEcomGeneracan, lxEcomVacio, lxEcomPago, lxEcomValctacte, lxEcomCondpago, lxEcomCliedef, lxEcomTelenvio, lxEcomDescartar, lxEcomUsaotrabd, lxEcomValecamb, lxEcomConvenv, lxEcomConccolor, lxEcomConctalle, lxEcomConcart, lxEcomCargaautov, lxEcomUsaequival, lxEcomDtospago, lxEcomPedido, lxEcomFactsinper, lxEcomOrigenst, lxEcomPercctacte, lxEcomFecnov, lxEcomNumero, lxEcomRemito, lxEcomAccionfe, lxEcomAplicenvio, lxEcomNrocarrito, lxEcomFactmanual, lxEcomBuzonfe, lxEcomPefactman, lxEcomFactmcep, lxEcomPefactmcep, lxEcomEnlaceop, lxEcomFactmvc, lxEcomBdfe, lxEcomFactelec, lxEcomPefactelec, lxEcomDatosret, lxEcomFactecep, lxEcomPefactecep, lxEcomFactevc, lxEcomObserva, lxEcomFactfiscal, lxEcomPefactfisc, lxEcomFactfcep, lxEcomPefactfcep, lxEcomPagado, lxEcomFactfvc, lxEcomPromos, lxEcomObs
				lxEcomFecimpo =  .Fechaimpo			lxEcomFectrans =  .Fechatransferencia			lxEcomFmodifw =  .Fechamodificacionfw			lxEcomFecexpo =  .Fechaexpo			lxEcomFaltafw =  .Fechaaltafw			lxEcomHaltafw =  .Horaaltafw			lxEcomBdaltafw =  .Basededatosaltafw			lxEcomEsttrans =  .Estadotransferencia			lxEcomHoraexpo =  .Horaexpo			lxEcomBdmodifw =  .Basededatosmodificacionfw			lxEcomValtafw =  .Versionaltafw			lxEcomVmodifw =  .Versionmodificacionfw			lxEcomUmodifw =  .Usuariomodificacionfw			lxEcomZadsfw =  .Zadsfw			lxEcomUaltafw =  .Usuarioaltafw			lxEcomSmodifw =  .Seriemodificacionfw			lxEcomHoraimpo =  .Horaimpo			lxEcomHmodifw =  .Horamodificacionfw			lxEcomSaltafw =  .Seriealtafw			lxEcomCodigo =  .Codigo			lxEcomCuenta =  .Descripcion			lxEcomCodlista =  upper( .ListaDePrecios_PK ) 			lxEcomAccion =  .Accion			lxEcomCuentacom =  .Cuenta			lxEcomVendedor =  upper( .Vendedor_PK ) 			lxEcomBuzon =  .Buzon			lxEcomTipoecom =  .Tipoecommerce			lxEcomTranspor =  upper( .Transportista_PK ) 			lxEcomBasededato =  .Basededatos			lxEcomIdvinc =  .Idvinculacion			lxEcomMotivo =  upper( .Motivo_PK ) 			lxEcomUltorder =  .Ultimaorder			lxEcomDtosenvio =  .Datosdeenvio			lxEcomGeneracan =  .Generacancelacion			lxEcomVacio =  .Vacio			lxEcomPago =  upper( .Pago_PK ) 			lxEcomValctacte =  upper( .ValorCtaCte_PK ) 			lxEcomCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxEcomCliedef =  upper( .ClienteDefault_PK ) 			lxEcomTelenvio =  .Telefonodeenvio			lxEcomDescartar =  .Descartar			lxEcomUsaotrabd =  .Utilizastockotrabase			lxEcomValecamb =  .Usavalecambio			lxEcomConvenv =  upper( .Concenvio_PK ) 			lxEcomConccolor =  upper( .ConcColor_PK ) 			lxEcomConctalle =  upper( .ConcTalle_PK ) 			lxEcomConcart =  upper( .ConcArticulo_PK ) 			lxEcomCargaautov =  .Cargaautomaticavalores			lxEcomUsaequival =  .Usaequivalores			lxEcomDtospago =  .Datosdepago			lxEcomPedido =  .Pedido			lxEcomFactsinper =  .Facturarsinpersonalizar			lxEcomOrigenst =  .Bdorigenstock			lxEcomPercctacte =  .Percepcionesactacte			lxEcomFecnov =  .Fechanovedades			lxEcomNumero =  .Numero			lxEcomRemito =  .Remito			lxEcomAccionfe =  .Accionfullenv			lxEcomAplicenvio =  .Aplicarcostoenvio			lxEcomNrocarrito =  .Numerodecarrito			lxEcomFactmanual =  .Facturamanual			lxEcomBuzonfe =  .Buzonfullenv			lxEcomPefactman =  .Pedidofacturamanual			lxEcomFactmcep =  .Facturamanualconentregaposterior			lxEcomPefactmcep =  .Pedidofacturamanualconentregapos			lxEcomEnlaceop =  .Enlacedelaoperacion			lxEcomFactmvc =  .Facturamanualconvtacont			lxEcomBdfe =  .Basededatosfullenv			lxEcomFactelec =  .Facturaelectronica			lxEcomPefactelec =  .Pedidofacturaelectronica			lxEcomDatosret =  .Datosderetiro			lxEcomFactecep =  .Facturaelectronicaconentregaposterior			lxEcomPefactecep =  .Pedidofacturaelectronicaconentregapos			lxEcomFactevc =  .Facturaelectronicaconvtacont			lxEcomObserva =  .Observaciones			lxEcomFactfiscal =  .Facturafiscal			lxEcomPefactfisc =  .Pedidofacturafiscal			lxEcomFactfcep =  .Facturafiscalconentregaposterior			lxEcomPefactfcep =  .Pedidofacturafiscalconentregapos			lxEcomPagado =  .Pagado			lxEcomFactfvc =  .Facturafiscalconvtacont			lxEcomPromos =  .Aplicarpromocionesautomaticas			lxEcomObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ECOM.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ECOM set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxEcomFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxEcomFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxEcomFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxEcomFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxEcomFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxEcomHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEcomBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxEcomEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxEcomHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEcomBdmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxEcomValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxEcomVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxEcomUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxEcomZadsfw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxEcomUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxEcomSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxEcomHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxEcomHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxEcomSaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxEcomCodigo ) + "'">>, "Cuenta" = <<"'" + this.FormatearTextoSql( lxEcomCuenta ) + "'">>, "Codlista" = <<"'" + this.FormatearTextoSql( lxEcomCodlista ) + "'">>, "Accion" = <<"'" + this.FormatearTextoSql( lxEcomAccion ) + "'">>, "Cuentacom" = <<"'" + this.FormatearTextoSql( lxEcomCuentacom ) + "'">>, "Vendedor" = <<"'" + this.FormatearTextoSql( lxEcomVendedor ) + "'">>, "Buzon" = <<"'" + this.FormatearTextoSql( lxEcomBuzon ) + "'">>, "Tipoecom" = <<lxEcomTipoecom>>, "Transpor" = <<"'" + this.FormatearTextoSql( lxEcomTranspor ) + "'">>, "Basededato" = <<"'" + this.FormatearTextoSql( lxEcomBasededato ) + "'">>, "Idvinc" = <<lxEcomIdvinc>>, "Motivo" = <<"'" + this.FormatearTextoSql( lxEcomMotivo ) + "'">>, "Ultorder" = <<lxEcomUltorder>>, "Dtosenvio" = <<iif( lxEcomDtosenvio, 1, 0 )>>, "Generacan" = <<iif( lxEcomGeneracan, 1, 0 )>>, "Vacio" = <<iif( lxEcomVacio, 1, 0 )>>, "Pago" = <<"'" + this.FormatearTextoSql( lxEcomPago ) + "'">>, "Valctacte" = <<"'" + this.FormatearTextoSql( lxEcomValctacte ) + "'">>, "Condpago" = <<"'" + this.FormatearTextoSql( lxEcomCondpago ) + "'">>, "Cliedef" = <<"'" + this.FormatearTextoSql( lxEcomCliedef ) + "'">>, "Telenvio" = <<iif( lxEcomTelenvio, 1, 0 )>>, "Descartar" = <<iif( lxEcomDescartar, 1, 0 )>>, "Usaotrabd" = <<iif( lxEcomUsaotrabd, 1, 0 )>>, "Valecamb" = <<iif( lxEcomValecamb, 1, 0 )>>, "Convenv" = <<"'" + this.FormatearTextoSql( lxEcomConvenv ) + "'">>, "Conccolor" = <<"'" + this.FormatearTextoSql( lxEcomConccolor ) + "'">>, "Conctalle" = <<"'" + this.FormatearTextoSql( lxEcomConctalle ) + "'">>, "Concart" = <<"'" + this.FormatearTextoSql( lxEcomConcart ) + "'">>, "Cargaautov" = <<iif( lxEcomCargaautov, 1, 0 )>>, "Usaequival" = <<iif( lxEcomUsaequival, 1, 0 )>>, "Dtospago" = <<iif( lxEcomDtospago, 1, 0 )>>, "Pedido" = <<iif( lxEcomPedido, 1, 0 )>>, "Factsinper" = <<iif( lxEcomFactsinper, 1, 0 )>>, "Origenst" = <<"'" + this.FormatearTextoSql( lxEcomOrigenst ) + "'">>, "Percctacte" = <<iif( lxEcomPercctacte, 1, 0 )>>, "Fecnov" = <<"'" + this.ConvertirDateSql( lxEcomFecnov ) + "'">>, "Numero" = <<iif( lxEcomNumero, 1, 0 )>>, "Remito" = <<iif( lxEcomRemito, 1, 0 )>>, "Accionfe" = <<"'" + this.FormatearTextoSql( lxEcomAccionfe ) + "'">>, "Aplicenvio" = <<lxEcomAplicenvio>>, "Nrocarrito" = <<iif( lxEcomNrocarrito, 1, 0 )>>, "Factmanual" = <<iif( lxEcomFactmanual, 1, 0 )>>, "Buzonfe" = <<"'" + this.FormatearTextoSql( lxEcomBuzonfe ) + "'">>, "Pefactman" = <<iif( lxEcomPefactman, 1, 0 )>>, "Factmcep" = <<iif( lxEcomFactmcep, 1, 0 )>>, "Pefactmcep" = <<iif( lxEcomPefactmcep, 1, 0 )>>, "Enlaceop" = <<iif( lxEcomEnlaceop, 1, 0 )>>, "Factmvc" = <<iif( lxEcomFactmvc, 1, 0 )>>, "Bdfe" = <<"'" + this.FormatearTextoSql( lxEcomBdfe ) + "'">>, "Factelec" = <<iif( lxEcomFactelec, 1, 0 )>>, "Pefactelec" = <<iif( lxEcomPefactelec, 1, 0 )>>, "Datosret" = <<iif( lxEcomDatosret, 1, 0 )>>, "Factecep" = <<iif( lxEcomFactecep, 1, 0 )>>, "Pefactecep" = <<iif( lxEcomPefactecep, 1, 0 )>>, "Factevc" = <<iif( lxEcomFactevc, 1, 0 )>>, "Observa" = <<iif( lxEcomObserva, 1, 0 )>>, "Factfiscal" = <<iif( lxEcomFactfiscal, 1, 0 )>>, "Pefactfisc" = <<iif( lxEcomPefactfisc, 1, 0 )>>, "Factfcep" = <<iif( lxEcomFactfcep, 1, 0 )>>, "Pefactfcep" = <<iif( lxEcomPefactfcep, 1, 0 )>>, "Pagado" = <<iif( lxEcomPagado, 1, 0 )>>, "Factfvc" = <<iif( lxEcomFactfvc, 1, 0 )>>, "Promos" = <<iif( lxEcomPromos, 1, 0 )>>, "Obs" = <<"'" + this.FormatearTextoSql( lxEcomObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ECOM' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DETERROR where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ECOMEQUIVAL where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Errores
				if this.oEntidad.Errores.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxOpeerror = loItem.Opeerror
					lxStoreorderid = loItem.Storeorderid
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETERROR("NROITEM","Codigo","OpeError","STOREORDER" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxOpeerror>>, <<"'" + this.FormatearTextoSql( lxStoreorderid ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EquiValoresDetalle
				if this.oEntidad.EquiValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxValorecommerce = loItem.Valorecommerce
					lxTipovalorecommerce = loItem.Tipovalorecommerce
					lxValordragonfish_PK = loItem.Valordragonfish_PK
					lxValordescripcion = loItem.Valordescripcion
					lxTipovalordragon = loItem.Tipovalordragon
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ECOMEQUIVAL("NROITEM","Codigo","ValEcom","TipoValEco","ValDragon","ValDesc","TipoValDf" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValorecommerce ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipovalorecommerce ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordragonfish_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipovalordragon ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ECOM.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.ECOM where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DETERROR where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ECOMEQUIVAL where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'ECOM' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ECOM where  ECOM.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ECOM where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ECOM.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ECOMMERCE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ECOM Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ECOM set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, CUENTA = ] + "'" + this.FormatearTextoSql( &lcCursor..CUENTA ) + "'"+ [, CODLISTA = ] + "'" + this.FormatearTextoSql( &lcCursor..CODLISTA ) + "'"+ [, Accion = ] + "'" + this.FormatearTextoSql( &lcCursor..Accion ) + "'"+ [, CUENTACOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CUENTACOM ) + "'"+ [, VENDEDOR = ] + "'" + this.FormatearTextoSql( &lcCursor..VENDEDOR ) + "'"+ [, Buzon = ] + "'" + this.FormatearTextoSql( &lcCursor..Buzon ) + "'"+ [, TIPOECOM = ] + transform( &lcCursor..TIPOECOM )+ [, TRANSPOR = ] + "'" + this.FormatearTextoSql( &lcCursor..TRANSPOR ) + "'"+ [, Basededato = ] + "'" + this.FormatearTextoSql( &lcCursor..Basededato ) + "'"+ [, IDVinc = ] + transform( &lcCursor..IDVinc )+ [, MOTIVO = ] + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'"+ [, ULTORDER = ] + transform( &lcCursor..ULTORDER )+ [, DtosEnvio = ] + Transform( iif( &lcCursor..DtosEnvio, 1, 0 ))+ [, GeneraCan = ] + Transform( iif( &lcCursor..GeneraCan, 1, 0 ))+ [, Vacio = ] + Transform( iif( &lcCursor..Vacio, 1, 0 ))+ [, PAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..PAGO ) + "'"+ [, ValCtaCte = ] + "'" + this.FormatearTextoSql( &lcCursor..ValCtaCte ) + "'"+ [, CONDPAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"+ [, CLIEDEF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIEDEF ) + "'"+ [, TelEnvio = ] + Transform( iif( &lcCursor..TelEnvio, 1, 0 ))+ [, Descartar = ] + Transform( iif( &lcCursor..Descartar, 1, 0 ))+ [, USAOTRABD = ] + Transform( iif( &lcCursor..USAOTRABD, 1, 0 ))+ [, VALECAMB = ] + Transform( iif( &lcCursor..VALECAMB, 1, 0 ))+ [, ConvEnv = ] + "'" + this.FormatearTextoSql( &lcCursor..ConvEnv ) + "'"+ [, ConcColor = ] + "'" + this.FormatearTextoSql( &lcCursor..ConcColor ) + "'"+ [, ConcTalle = ] + "'" + this.FormatearTextoSql( &lcCursor..ConcTalle ) + "'"+ [, ConcArt = ] + "'" + this.FormatearTextoSql( &lcCursor..ConcArt ) + "'"+ [, CargaAutoV = ] + Transform( iif( &lcCursor..CargaAutoV, 1, 0 ))+ [, UsaEquiVal = ] + Transform( iif( &lcCursor..UsaEquiVal, 1, 0 ))+ [, DtosPago = ] + Transform( iif( &lcCursor..DtosPago, 1, 0 ))+ [, Pedido = ] + Transform( iif( &lcCursor..Pedido, 1, 0 ))+ [, FACTSINPER = ] + Transform( iif( &lcCursor..FACTSINPER, 1, 0 ))+ [, ORIGENST = ] + "'" + this.FormatearTextoSql( &lcCursor..ORIGENST ) + "'"+ [, PercCtaCte = ] + Transform( iif( &lcCursor..PercCtaCte, 1, 0 ))+ [, FECNOV = ] + "'" + this.ConvertirDateSql( &lcCursor..FECNOV ) + "'"+ [, Numero = ] + Transform( iif( &lcCursor..Numero, 1, 0 ))+ [, Remito = ] + Transform( iif( &lcCursor..Remito, 1, 0 ))+ [, ACCIONFE = ] + "'" + this.FormatearTextoSql( &lcCursor..ACCIONFE ) + "'"+ [, APLICENVIO = ] + transform( &lcCursor..APLICENVIO )+ [, NroCarrito = ] + Transform( iif( &lcCursor..NroCarrito, 1, 0 ))+ [, FactManual = ] + Transform( iif( &lcCursor..FactManual, 1, 0 ))+ [, BUZONFE = ] + "'" + this.FormatearTextoSql( &lcCursor..BUZONFE ) + "'"+ [, PeFactMan = ] + Transform( iif( &lcCursor..PeFactMan, 1, 0 ))+ [, FactMcEP = ] + Transform( iif( &lcCursor..FactMcEP, 1, 0 ))+ [, PeFactMcEP = ] + Transform( iif( &lcCursor..PeFactMcEP, 1, 0 ))+ [, EnlaceOp = ] + Transform( iif( &lcCursor..EnlaceOp, 1, 0 ))+ [, FactMVC = ] + Transform( iif( &lcCursor..FactMVC, 1, 0 ))+ [, BDFE = ] + "'" + this.FormatearTextoSql( &lcCursor..BDFE ) + "'"+ [, FactElec = ] + Transform( iif( &lcCursor..FactElec, 1, 0 ))+ [, PeFactElec = ] + Transform( iif( &lcCursor..PeFactElec, 1, 0 ))+ [, DatosRet = ] + Transform( iif( &lcCursor..DatosRet, 1, 0 ))+ [, FactEcEP = ] + Transform( iif( &lcCursor..FactEcEP, 1, 0 ))+ [, PeFactEcEP = ] + Transform( iif( &lcCursor..PeFactEcEP, 1, 0 ))+ [, FactEVC = ] + Transform( iif( &lcCursor..FactEVC, 1, 0 ))+ [, Observa = ] + Transform( iif( &lcCursor..Observa, 1, 0 ))+ [, FactFiscal = ] + Transform( iif( &lcCursor..FactFiscal, 1, 0 ))+ [, PeFactFisc = ] + Transform( iif( &lcCursor..PeFactFisc, 1, 0 ))+ [, FactFcEP = ] + Transform( iif( &lcCursor..FactFcEP, 1, 0 ))+ [, PeFactFcEP = ] + Transform( iif( &lcCursor..PeFactFcEP, 1, 0 ))+ [, Pagado = ] + Transform( iif( &lcCursor..Pagado, 1, 0 ))+ [, FactFVC = ] + Transform( iif( &lcCursor..FactFVC, 1, 0 ))+ [, Promos = ] + Transform( iif( &lcCursor..Promos, 1, 0 ))+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, HALTAFW, BDALTAFW, ESTTRANS, HORAEXPO, BDMODIFW, VALTAFW, VMODIFW, UMODIFW, ZADSFW, UALTAFW, SMODIFW, HORAIMPO, HMODIFW, SALTAFW, CODIGO, CUENTA, CODLISTA, Accion, CUENTACOM, VENDEDOR, Buzon, TIPOECOM, TRANSPOR, Basededato, IDVinc, MOTIVO, ULTORDER, DtosEnvio, GeneraCan, Vacio, PAGO, ValCtaCte, CONDPAGO, CLIEDEF, TelEnvio, Descartar, USAOTRABD, VALECAMB, ConvEnv, ConcColor, ConcTalle, ConcArt, CargaAutoV, UsaEquiVal, DtosPago, Pedido, FACTSINPER, ORIGENST, PercCtaCte, FECNOV, Numero, Remito, ACCIONFE, APLICENVIO, NroCarrito, FactManual, BUZONFE, PeFactMan, FactMcEP, PeFactMcEP, EnlaceOp, FactMVC, BDFE, FactElec, PeFactElec, DatosRet, FactEcEP, PeFactEcEP, FactEVC, Observa, FactFiscal, PeFactFisc, FactFcEP, PeFactFcEP, Pagado, FactFVC, Promos, OBS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CUENTA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODLISTA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Accion ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CUENTACOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VENDEDOR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Buzon ) + "'" + ',' + transform( &lcCursor..TIPOECOM ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..TRANSPOR ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Basededato ) + "'" + ',' + transform( &lcCursor..IDVinc ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MOTIVO ) + "'" + ',' + transform( &lcCursor..ULTORDER ) + ',' + Transform( iif( &lcCursor..DtosEnvio, 1, 0 )) + ',' + Transform( iif( &lcCursor..GeneraCan, 1, 0 )) + ',' + Transform( iif( &lcCursor..Vacio, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..PAGO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValCtaCte ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIEDEF ) + "'" + ',' + Transform( iif( &lcCursor..TelEnvio, 1, 0 )) + ',' + Transform( iif( &lcCursor..Descartar, 1, 0 )) + ',' + Transform( iif( &lcCursor..USAOTRABD, 1, 0 )) + ',' + Transform( iif( &lcCursor..VALECAMB, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConvEnv ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConcColor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConcTalle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConcArt ) + "'" + ',' + Transform( iif( &lcCursor..CargaAutoV, 1, 0 )) + ',' + Transform( iif( &lcCursor..UsaEquiVal, 1, 0 )) + ',' + Transform( iif( &lcCursor..DtosPago, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Pedido, 1, 0 )) + ',' + Transform( iif( &lcCursor..FACTSINPER, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ORIGENST ) + "'" + ',' + Transform( iif( &lcCursor..PercCtaCte, 1, 0 )) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECNOV ) + "'" + ',' + Transform( iif( &lcCursor..Numero, 1, 0 )) + ',' + Transform( iif( &lcCursor..Remito, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ACCIONFE ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..APLICENVIO ) + ',' + Transform( iif( &lcCursor..NroCarrito, 1, 0 )) + ',' + Transform( iif( &lcCursor..FactManual, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BUZONFE ) + "'" + ',' + Transform( iif( &lcCursor..PeFactMan, 1, 0 )) + ',' + Transform( iif( &lcCursor..FactMcEP, 1, 0 )) + ',' + Transform( iif( &lcCursor..PeFactMcEP, 1, 0 )) + ',' + Transform( iif( &lcCursor..EnlaceOp, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..FactMVC, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDFE ) + "'" + ',' + Transform( iif( &lcCursor..FactElec, 1, 0 )) + ',' + Transform( iif( &lcCursor..PeFactElec, 1, 0 )) + ',' + Transform( iif( &lcCursor..DatosRet, 1, 0 )) + ',' + Transform( iif( &lcCursor..FactEcEP, 1, 0 )) + ',' + Transform( iif( &lcCursor..PeFactEcEP, 1, 0 )) + ',' + Transform( iif( &lcCursor..FactEVC, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Observa, 1, 0 )) + ',' + Transform( iif( &lcCursor..FactFiscal, 1, 0 )) + ',' + Transform( iif( &lcCursor..PeFactFisc, 1, 0 )) + ',' + Transform( iif( &lcCursor..FactFcEP, 1, 0 )) + ',' + Transform( iif( &lcCursor..PeFactFcEP, 1, 0 )) + ',' + Transform( iif( &lcCursor..Pagado, 1, 0 )) + ',' + Transform( iif( &lcCursor..FactFVC, 1, 0 )) + ',' + Transform( iif( &lcCursor..Promos, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ECOM ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ECOMMERCE'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DETERROR Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ECOMEQUIVAL Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMERRORESECOMMERCE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","OpeError","STOREORDER"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DETERROR ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.OpeError   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.STOREORDER ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMEQUIVALORES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","ValEcom","TipoValEco","ValDragon","ValDesc","TipoValDf"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ECOMEQUIVAL ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValEcom    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoValEco ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValDragon  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValDesc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoValDf  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ECOMMERCE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ECOMMERCE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ECOMMERCE_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMERRORESECOMMERCE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMEQUIVALORES'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ECOM')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ECOMMERCE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ECOMMERCE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECNOV    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ECOM') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ECOM
Create Table ZooLogic.TablaTrabajo_ECOM ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"codigo" char( 10 )  null, 
"cuenta" char( 40 )  null, 
"codlista" char( 6 )  null, 
"accion" char( 30 )  null, 
"cuentacom" char( 40 )  null, 
"vendedor" char( 10 )  null, 
"buzon" char( 8 )  null, 
"tipoecom" numeric( 2, 0 )  null, 
"transpor" char( 15 )  null, 
"basededato" char( 11 )  null, 
"idvinc" numeric( 15, 0 )  null, 
"motivo" char( 3 )  null, 
"ultorder" numeric( 15, 0 )  null, 
"dtosenvio" bit  null, 
"generacan" bit  null, 
"vacio" bit  null, 
"pago" char( 5 )  null, 
"valctacte" char( 5 )  null, 
"condpago" char( 5 )  null, 
"cliedef" char( 10 )  null, 
"telenvio" bit  null, 
"descartar" bit  null, 
"usaotrabd" bit  null, 
"valecamb" bit  null, 
"convenv" char( 15 )  null, 
"conccolor" char( 6 )  null, 
"conctalle" char( 5 )  null, 
"concart" char( 15 )  null, 
"cargaautov" bit  null, 
"usaequival" bit  null, 
"dtospago" bit  null, 
"pedido" bit  null, 
"factsinper" bit  null, 
"origenst" char( 11 )  null, 
"percctacte" bit  null, 
"fecnov" datetime  null, 
"numero" bit  null, 
"remito" bit  null, 
"accionfe" char( 30 )  null, 
"aplicenvio" numeric( 1, 0 )  null, 
"nrocarrito" bit  null, 
"factmanual" bit  null, 
"buzonfe" char( 8 )  null, 
"pefactman" bit  null, 
"factmcep" bit  null, 
"pefactmcep" bit  null, 
"enlaceop" bit  null, 
"factmvc" bit  null, 
"bdfe" char( 11 )  null, 
"factelec" bit  null, 
"pefactelec" bit  null, 
"datosret" bit  null, 
"factecep" bit  null, 
"pefactecep" bit  null, 
"factevc" bit  null, 
"observa" bit  null, 
"factfiscal" bit  null, 
"pefactfisc" bit  null, 
"factfcep" bit  null, 
"pefactfcep" bit  null, 
"pagado" bit  null, 
"factfvc" bit  null, 
"promos" bit  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ECOM' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ECOM' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('cuenta','cuenta')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('accion','accion')
			.AgregarMapeo('cuentacom','cuentacom')
			.AgregarMapeo('vendedor','vendedor')
			.AgregarMapeo('buzon','buzon')
			.AgregarMapeo('tipoecom','tipoecom')
			.AgregarMapeo('transpor','transpor')
			.AgregarMapeo('basededato','basededato')
			.AgregarMapeo('idvinc','idvinc')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('ultorder','ultorder')
			.AgregarMapeo('dtosenvio','dtosenvio')
			.AgregarMapeo('generacan','generacan')
			.AgregarMapeo('vacio','vacio')
			.AgregarMapeo('pago','pago')
			.AgregarMapeo('valctacte','valctacte')
			.AgregarMapeo('condpago','condpago')
			.AgregarMapeo('cliedef','cliedef')
			.AgregarMapeo('telenvio','telenvio')
			.AgregarMapeo('descartar','descartar')
			.AgregarMapeo('usaotrabd','usaotrabd')
			.AgregarMapeo('valecamb','valecamb')
			.AgregarMapeo('convenv','convenv')
			.AgregarMapeo('conccolor','conccolor')
			.AgregarMapeo('conctalle','conctalle')
			.AgregarMapeo('concart','concart')
			.AgregarMapeo('cargaautov','cargaautov')
			.AgregarMapeo('usaequival','usaequival')
			.AgregarMapeo('dtospago','dtospago')
			.AgregarMapeo('pedido','pedido')
			.AgregarMapeo('factsinper','factsinper')
			.AgregarMapeo('origenst','origenst')
			.AgregarMapeo('percctacte','percctacte')
			.AgregarMapeo('fecnov','fecnov')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('remito','remito')
			.AgregarMapeo('accionfe','accionfe')
			.AgregarMapeo('aplicenvio','aplicenvio')
			.AgregarMapeo('nrocarrito','nrocarrito')
			.AgregarMapeo('factmanual','factmanual')
			.AgregarMapeo('buzonfe','buzonfe')
			.AgregarMapeo('pefactman','pefactman')
			.AgregarMapeo('factmcep','factmcep')
			.AgregarMapeo('pefactmcep','pefactmcep')
			.AgregarMapeo('enlaceop','enlaceop')
			.AgregarMapeo('factmvc','factmvc')
			.AgregarMapeo('bdfe','bdfe')
			.AgregarMapeo('factelec','factelec')
			.AgregarMapeo('pefactelec','pefactelec')
			.AgregarMapeo('datosret','datosret')
			.AgregarMapeo('factecep','factecep')
			.AgregarMapeo('pefactecep','pefactecep')
			.AgregarMapeo('factevc','factevc')
			.AgregarMapeo('observa','observa')
			.AgregarMapeo('factfiscal','factfiscal')
			.AgregarMapeo('pefactfisc','pefactfisc')
			.AgregarMapeo('factfcep','factfcep')
			.AgregarMapeo('pefactfcep','pefactfcep')
			.AgregarMapeo('pagado','pagado')
			.AgregarMapeo('factfvc','factfvc')
			.AgregarMapeo('promos','promos')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ECOM'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CUENTA = isnull( d.CUENTA, t.CUENTA ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.ACCION = isnull( d.ACCION, t.ACCION ),t.CUENTACOM = isnull( d.CUENTACOM, t.CUENTACOM ),t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),t.BUZON = isnull( d.BUZON, t.BUZON ),t.TIPOECOM = isnull( d.TIPOECOM, t.TIPOECOM ),t.TRANSPOR = isnull( d.TRANSPOR, t.TRANSPOR ),t.BASEDEDATO = isnull( d.BASEDEDATO, t.BASEDEDATO ),t.IDVINC = isnull( d.IDVINC, t.IDVINC ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.ULTORDER = isnull( d.ULTORDER, t.ULTORDER ),t.DTOSENVIO = isnull( d.DTOSENVIO, t.DTOSENVIO ),t.GENERACAN = isnull( d.GENERACAN, t.GENERACAN ),t.VACIO = isnull( d.VACIO, t.VACIO ),t.PAGO = isnull( d.PAGO, t.PAGO ),t.VALCTACTE = isnull( d.VALCTACTE, t.VALCTACTE ),t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),t.CLIEDEF = isnull( d.CLIEDEF, t.CLIEDEF ),t.TELENVIO = isnull( d.TELENVIO, t.TELENVIO ),t.DESCARTAR = isnull( d.DESCARTAR, t.DESCARTAR ),t.USAOTRABD = isnull( d.USAOTRABD, t.USAOTRABD ),t.VALECAMB = isnull( d.VALECAMB, t.VALECAMB ),t.CONVENV = isnull( d.CONVENV, t.CONVENV ),t.CONCCOLOR = isnull( d.CONCCOLOR, t.CONCCOLOR ),t.CONCTALLE = isnull( d.CONCTALLE, t.CONCTALLE ),t.CONCART = isnull( d.CONCART, t.CONCART ),t.CARGAAUTOV = isnull( d.CARGAAUTOV, t.CARGAAUTOV ),t.USAEQUIVAL = isnull( d.USAEQUIVAL, t.USAEQUIVAL ),t.DTOSPAGO = isnull( d.DTOSPAGO, t.DTOSPAGO ),t.PEDIDO = isnull( d.PEDIDO, t.PEDIDO ),t.FACTSINPER = isnull( d.FACTSINPER, t.FACTSINPER ),t.ORIGENST = isnull( d.ORIGENST, t.ORIGENST ),t.PERCCTACTE = isnull( d.PERCCTACTE, t.PERCCTACTE ),t.FECNOV = isnull( d.FECNOV, t.FECNOV ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.REMITO = isnull( d.REMITO, t.REMITO ),t.ACCIONFE = isnull( d.ACCIONFE, t.ACCIONFE ),t.APLICENVIO = isnull( d.APLICENVIO, t.APLICENVIO ),t.NROCARRITO = isnull( d.NROCARRITO, t.NROCARRITO ),t.FACTMANUAL = isnull( d.FACTMANUAL, t.FACTMANUAL ),t.BUZONFE = isnull( d.BUZONFE, t.BUZONFE ),t.PEFACTMAN = isnull( d.PEFACTMAN, t.PEFACTMAN ),t.FACTMCEP = isnull( d.FACTMCEP, t.FACTMCEP ),t.PEFACTMCEP = isnull( d.PEFACTMCEP, t.PEFACTMCEP ),t.ENLACEOP = isnull( d.ENLACEOP, t.ENLACEOP ),t.FACTMVC = isnull( d.FACTMVC, t.FACTMVC ),t.BDFE = isnull( d.BDFE, t.BDFE ),t.FACTELEC = isnull( d.FACTELEC, t.FACTELEC ),t.PEFACTELEC = isnull( d.PEFACTELEC, t.PEFACTELEC ),t.DATOSRET = isnull( d.DATOSRET, t.DATOSRET ),t.FACTECEP = isnull( d.FACTECEP, t.FACTECEP ),t.PEFACTECEP = isnull( d.PEFACTECEP, t.PEFACTECEP ),t.FACTEVC = isnull( d.FACTEVC, t.FACTEVC ),t.OBSERVA = isnull( d.OBSERVA, t.OBSERVA ),t.FACTFISCAL = isnull( d.FACTFISCAL, t.FACTFISCAL ),t.PEFACTFISC = isnull( d.PEFACTFISC, t.PEFACTFISC ),t.FACTFCEP = isnull( d.FACTFCEP, t.FACTFCEP ),t.PEFACTFCEP = isnull( d.PEFACTFCEP, t.PEFACTFCEP ),t.PAGADO = isnull( d.PAGADO, t.PAGADO ),t.FACTFVC = isnull( d.FACTFVC, t.FACTFVC ),t.PROMOS = isnull( d.PROMOS, t.PROMOS ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.ECOM t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.ECOM(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Bdaltafw,Esttrans,Horaexpo,Bdmodifw,Valtafw,Vmodifw,Umodifw,Zadsfw,Ualtafw,Smodifw,Horaimpo,Hmodifw,Saltafw,Codigo,Cuenta,Codlista,Accion,Cuentacom,Vendedor,Buzon,Tipoecom,Transpor,Basededato,Idvinc,Motivo,Ultorder,Dtosenvio,Generacan,Vacio,Pago,Valctacte,Condpago,Cliedef,Telenvio,Descartar,Usaotrabd,Valecamb,Convenv,Conccolor,Conctalle,Concart,Cargaautov,Usaequival,Dtospago,Pedido,Factsinper,Origenst,Percctacte,Fecnov,Numero,Remito,Accionfe,Aplicenvio,Nrocarrito,Factmanual,Buzonfe,Pefactman,Factmcep,Pefactmcep,Enlaceop,Factmvc,Bdfe,Factelec,Pefactelec,Datosret,Factecep,Pefactecep,Factevc,Observa,Factfiscal,Pefactfisc,Factfcep,Pefactfcep,Pagado,Factfvc,Promos,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.CODIGO,''),isnull( d.CUENTA,''),isnull( d.CODLISTA,''),isnull( d.ACCION,''),isnull( d.CUENTACOM,''),isnull( d.VENDEDOR,''),isnull( d.BUZON,''),isnull( d.TIPOECOM,0),isnull( d.TRANSPOR,''),isnull( d.BASEDEDATO,''),isnull( d.IDVINC,0),isnull( d.MOTIVO,''),isnull( d.ULTORDER,0),isnull( d.DTOSENVIO,0),isnull( d.GENERACAN,0),isnull( d.VACIO,0),isnull( d.PAGO,''),isnull( d.VALCTACTE,''),isnull( d.CONDPAGO,''),isnull( d.CLIEDEF,''),isnull( d.TELENVIO,0),isnull( d.DESCARTAR,0),isnull( d.USAOTRABD,0),isnull( d.VALECAMB,0),isnull( d.CONVENV,''),isnull( d.CONCCOLOR,''),isnull( d.CONCTALLE,''),isnull( d.CONCART,''),isnull( d.CARGAAUTOV,0),isnull( d.USAEQUIVAL,0),isnull( d.DTOSPAGO,0),isnull( d.PEDIDO,0),isnull( d.FACTSINPER,0),isnull( d.ORIGENST,''),isnull( d.PERCCTACTE,0),isnull( d.FECNOV,''),isnull( d.NUMERO,0),isnull( d.REMITO,0),isnull( d.ACCIONFE,''),isnull( d.APLICENVIO,0),isnull( d.NROCARRITO,0),isnull( d.FACTMANUAL,0),isnull( d.BUZONFE,''),isnull( d.PEFACTMAN,0),isnull( d.FACTMCEP,0),isnull( d.PEFACTMCEP,0),isnull( d.ENLACEOP,0),isnull( d.FACTMVC,0),isnull( d.BDFE,''),isnull( d.FACTELEC,0),isnull( d.PEFACTELEC,0),isnull( d.DATOSRET,0),isnull( d.FACTECEP,0),isnull( d.PEFACTECEP,0),isnull( d.FACTEVC,0),isnull( d.OBSERVA,0),isnull( d.FACTFISCAL,0),isnull( d.PEFACTFISC,0),isnull( d.FACTFCEP,0),isnull( d.PEFACTFCEP,0),isnull( d.PAGADO,0),isnull( d.FACTFVC,0),isnull( d.PROMOS,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.ECOM pk 
							 on d.CODIGO = pk.CODIGO
						Where pk.CODIGO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DETERROR( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ECOM_DETERROR
ON ZooLogic.TablaTrabajo_ECOM_DETERROR
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.OPEERROR = isnull( d.OPEERROR, t.OPEERROR ),
t.STOREORDER = isnull( d.STOREORDER, t.STOREORDER )
from ZooLogic.DETERROR t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DETERROR
( 
"NROITEM",
"CODIGO",
"OPEERROR",
"STOREORDER"
 )
Select 
d.NROITEM,
d.CODIGO,
d.OPEERROR,
d.STOREORDER
From deleted d left join ZooLogic.DETERROR pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ECOMEQUIVAL( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ECOM_ECOMEQUIVAL
ON ZooLogic.TablaTrabajo_ECOM_ECOMEQUIVAL
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.VALECOM = isnull( d.VALECOM, t.VALECOM ),
t.TIPOVALECO = isnull( d.TIPOVALECO, t.TIPOVALECO ),
t.VALDRAGON = isnull( d.VALDRAGON, t.VALDRAGON ),
t.VALDESC = isnull( d.VALDESC, t.VALDESC ),
t.TIPOVALDF = isnull( d.TIPOVALDF, t.TIPOVALDF )
from ZooLogic.ECOMEQUIVAL t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ECOMEQUIVAL
( 
"NROITEM",
"CODIGO",
"VALECOM",
"TIPOVALECO",
"VALDRAGON",
"VALDESC",
"TIPOVALDF"
 )
Select 
d.NROITEM,
d.CODIGO,
d.VALECOM,
d.TIPOVALECO,
d.VALDRAGON,
d.VALDESC,
d.TIPOVALDF
From deleted d left join ZooLogic.ECOMEQUIVAL pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ECOM') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ECOM
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ECOMMERCE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ECOMMERCE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ECOMMERCE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ECOMMERCE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ECOMMERCE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ECOMMERCE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_ECOMMERCE.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_ECOMMERCE.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_ECOMMERCE.Estadotransferencia, [] )
					.Horaexpo = nvl( c_ECOMMERCE.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_ECOMMERCE.Basededatosmodificacionfw, [] )
					.Versionaltafw = nvl( c_ECOMMERCE.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_ECOMMERCE.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_ECOMMERCE.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuarioaltafw = nvl( c_ECOMMERCE.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_ECOMMERCE.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_ECOMMERCE.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_ECOMMERCE.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_ECOMMERCE.Seriealtafw, [] )
					.Codigo = nvl( c_ECOMMERCE.Codigo, [] )
					.Descripcion = nvl( c_ECOMMERCE.Descripcion, [] )
					.Listadeprecios_PK =  nvl( c_ECOMMERCE.Listadeprecios, [] )
					.Accion = nvl( c_ECOMMERCE.Accion, [] )
					.Cuenta = nvl( c_ECOMMERCE.Cuenta, [] )
					.Vendedor_PK =  nvl( c_ECOMMERCE.Vendedor, [] )
					.Buzon = nvl( c_ECOMMERCE.Buzon, [] )
					.Tipoecommerce = nvl( c_ECOMMERCE.Tipoecommerce, 0 )
					.Transportista_PK =  nvl( c_ECOMMERCE.Transportista, [] )
					.Basededatos = nvl( c_ECOMMERCE.Basededatos, [] )
					.Idvinculacion = nvl( c_ECOMMERCE.Idvinculacion, 0 )
					.Motivo_PK =  nvl( c_ECOMMERCE.Motivo, [] )
					.Ultimaorder = nvl( c_ECOMMERCE.Ultimaorder, 0 )
					.Datosdeenvio = nvl( c_ECOMMERCE.Datosdeenvio, .F. )
					.Generacancelacion = nvl( c_ECOMMERCE.Generacancelacion, .F. )
					.Vacio = nvl( c_ECOMMERCE.Vacio, .F. )
					.Pago_PK =  nvl( c_ECOMMERCE.Pago, [] )
					.Valorctacte_PK =  nvl( c_ECOMMERCE.Valorctacte, [] )
					.Errores.Limpiar()
					.Errores.SetearEsNavegacion( .lProcesando )
					.Errores.Cargar()
					.Condicionpagopreferente_PK =  nvl( c_ECOMMERCE.Condicionpagopreferente, [] )
					.Clientedefault_PK =  nvl( c_ECOMMERCE.Clientedefault, [] )
					.Telefonodeenvio = nvl( c_ECOMMERCE.Telefonodeenvio, .F. )
					.Descartar = nvl( c_ECOMMERCE.Descartar, .F. )
					.Utilizastockotrabase = nvl( c_ECOMMERCE.Utilizastockotrabase, .F. )
					.Usavalecambio = nvl( c_ECOMMERCE.Usavalecambio, .F. )
					.Concenvio_PK =  nvl( c_ECOMMERCE.Concenvio, [] )
					.Conccolor_PK =  nvl( c_ECOMMERCE.Conccolor, [] )
					.Conctalle_PK =  nvl( c_ECOMMERCE.Conctalle, [] )
					.Concarticulo_PK =  nvl( c_ECOMMERCE.Concarticulo, [] )
					.Cargaautomaticavalores = nvl( c_ECOMMERCE.Cargaautomaticavalores, .F. )
					.Usaequivalores = nvl( c_ECOMMERCE.Usaequivalores, .F. )
					.Equivaloresdetalle.Limpiar()
					.Equivaloresdetalle.SetearEsNavegacion( .lProcesando )
					.Equivaloresdetalle.Cargar()
					.Datosdepago = nvl( c_ECOMMERCE.Datosdepago, .F. )
					.Pedido = nvl( c_ECOMMERCE.Pedido, .F. )
					.Facturarsinpersonalizar = nvl( c_ECOMMERCE.Facturarsinpersonalizar, .F. )
					.Bdorigenstock = nvl( c_ECOMMERCE.Bdorigenstock, [] )
					.Percepcionesactacte = nvl( c_ECOMMERCE.Percepcionesactacte, .F. )
					.Fechanovedades = GoLibrerias.ObtenerFechaFormateada( nvl( c_ECOMMERCE.Fechanovedades, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_ECOMMERCE.Numero, .F. )
					.Remito = nvl( c_ECOMMERCE.Remito, .F. )
					.Accionfullenv = nvl( c_ECOMMERCE.Accionfullenv, [] )
					.Aplicarcostoenvio = nvl( c_ECOMMERCE.Aplicarcostoenvio, 0 )
					.Numerodecarrito = nvl( c_ECOMMERCE.Numerodecarrito, .F. )
					.Facturamanual = nvl( c_ECOMMERCE.Facturamanual, .F. )
					.Buzonfullenv = nvl( c_ECOMMERCE.Buzonfullenv, [] )
					.Pedidofacturamanual = nvl( c_ECOMMERCE.Pedidofacturamanual, .F. )
					.Facturamanualconentregaposterior = nvl( c_ECOMMERCE.Facturamanualconentregaposterior, .F. )
					.Pedidofacturamanualconentregapos = nvl( c_ECOMMERCE.Pedidofacturamanualconentregapos, .F. )
					.Enlacedelaoperacion = nvl( c_ECOMMERCE.Enlacedelaoperacion, .F. )
					.Facturamanualconvtacont = nvl( c_ECOMMERCE.Facturamanualconvtacont, .F. )
					.Basededatosfullenv = nvl( c_ECOMMERCE.Basededatosfullenv, [] )
					.Facturaelectronica = nvl( c_ECOMMERCE.Facturaelectronica, .F. )
					.Pedidofacturaelectronica = nvl( c_ECOMMERCE.Pedidofacturaelectronica, .F. )
					.Datosderetiro = nvl( c_ECOMMERCE.Datosderetiro, .F. )
					.Facturaelectronicaconentregaposterior = nvl( c_ECOMMERCE.Facturaelectronicaconentregaposterior, .F. )
					.Pedidofacturaelectronicaconentregapos = nvl( c_ECOMMERCE.Pedidofacturaelectronicaconentregapos, .F. )
					.Facturaelectronicaconvtacont = nvl( c_ECOMMERCE.Facturaelectronicaconvtacont, .F. )
					.Observaciones = nvl( c_ECOMMERCE.Observaciones, .F. )
					.Facturafiscal = nvl( c_ECOMMERCE.Facturafiscal, .F. )
					.Pedidofacturafiscal = nvl( c_ECOMMERCE.Pedidofacturafiscal, .F. )
					.Facturafiscalconentregaposterior = nvl( c_ECOMMERCE.Facturafiscalconentregaposterior, .F. )
					.Pedidofacturafiscalconentregapos = nvl( c_ECOMMERCE.Pedidofacturafiscalconentregapos, .F. )
					.Pagado = nvl( c_ECOMMERCE.Pagado, .F. )
					.Facturafiscalconvtacont = nvl( c_ECOMMERCE.Facturafiscalconvtacont, .F. )
					.Aplicarpromocionesautomaticas = nvl( c_ECOMMERCE.Aplicarpromocionesautomaticas, .F. )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
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
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.Errores
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

		loDetalle = this.oEntidad.EquiValoresDetalle
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
		return c_ECOMMERCE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ECOM' )
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
								from ZooLogic.ECOM 
								Where   ECOM.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ECOM", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Codigo" as "Codigo", "Cuenta" as "Descripcion", "Codlista" as "Listadeprecios", "Accion" as "Accion", "Cuentacom" as "Cuenta", "Vendedor" as "Vendedor", "Buzon" as "Buzon", "Tipoecom" as "Tipoecommerce", "Transpor" as "Transportista", "Basededato" as "Basededatos", "Idvinc" as "Idvinculacion", "Motivo" as "Motivo", "Ultorder" as "Ultimaorder", "Dtosenvio" as "Datosdeenvio", "Generacan" as "Generacancelacion", "Vacio" as "Vacio", "Pago" as "Pago", "Valctacte" as "Valorctacte", "Condpago" as "Condicionpagopreferente", "Cliedef" as "Clientedefault", "Telenvio" as "Telefonodeenvio", "Descartar" as "Descartar", "Usaotrabd" as "Utilizastockotrabase", "Valecamb" as "Usavalecambio", "Convenv" as "Concenvio", "Conccolor" as "Conccolor", "Conctalle" as "Conctalle", "Concart" as "Concarticulo", "Cargaautov" as "Cargaautomaticavalores", "Usaequival" as "Usaequivalores", "Dtospago" as "Datosdepago", "Pedido" as "Pedido", "Factsinper" as "Facturarsinpersonalizar", "Origenst" as "Bdorigenstock", "Percctacte" as "Percepcionesactacte", "Fecnov" as "Fechanovedades", "Numero" as "Numero", "Remito" as "Remito", "Accionfe" as "Accionfullenv", "Aplicenvio" as "Aplicarcostoenvio", "Nrocarrito" as "Numerodecarrito", "Factmanual" as "Facturamanual", "Buzonfe" as "Buzonfullenv", "Pefactman" as "Pedidofacturamanual", "Factmcep" as "Facturamanualconentregaposterior", "Pefactmcep" as "Pedidofacturamanualconentregapos", "Enlaceop" as "Enlacedelaoperacion", "Factmvc" as "Facturamanualconvtacont", "Bdfe" as "Basededatosfullenv", "Factelec" as "Facturaelectronica", "Pefactelec" as "Pedidofacturaelectronica", "Datosret" as "Datosderetiro", "Factecep" as "Facturaelectronicaconentregaposterior", "Pefactecep" as "Pedidofacturaelectronicaconentregapos", "Factevc" as "Facturaelectronicaconvtacont", "Observa" as "Observaciones", "Factfiscal" as "Facturafiscal", "Pefactfisc" as "Pedidofacturafiscal", "Factfcep" as "Facturafiscalconentregaposterior", "Pefactfcep" as "Pedidofacturafiscalconentregapos", "Pagado" as "Pagado", "Factfvc" as "Facturafiscalconvtacont", "Promos" as "Aplicarpromocionesautomaticas", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ECOM 
								Where   ECOM.CODIGO != ''
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
	Tabla = 'ECOM'
	Filtro = " ECOM.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ECOM.CODIGO != ''"
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
	<row entidad="ECOMMERCE                               " atributo="FECHAIMPO                               " tabla="ECOM           " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FECHATRANSFERENCIA                      " tabla="ECOM           " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FECHAMODIFICACIONFW                     " tabla="ECOM           " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FECHAEXPO                               " tabla="ECOM           " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FECHAALTAFW                             " tabla="ECOM           " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="HORAALTAFW                              " tabla="ECOM           " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="BASEDEDATOSALTAFW                       " tabla="ECOM           " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="ESTADOTRANSFERENCIA                     " tabla="ECOM           " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="HORAEXPO                                " tabla="ECOM           " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ECOM           " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="VERSIONALTAFW                           " tabla="ECOM           " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="VERSIONMODIFICACIONFW                   " tabla="ECOM           " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="USUARIOMODIFICACIONFW                   " tabla="ECOM           " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="ZADSFW                                  " tabla="ECOM           " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="USUARIOALTAFW                           " tabla="ECOM           " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="SERIEMODIFICACIONFW                     " tabla="ECOM           " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="HORAIMPO                                " tabla="ECOM           " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="HORAMODIFICACIONFW                      " tabla="ECOM           " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="SERIEALTAFW                             " tabla="ECOM           " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="CODIGO                                  " tabla="ECOM           " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="DESCRIPCION                             " tabla="ECOM           " campo="CUENTA    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="LISTADEPRECIOS                          " tabla="ECOM           " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="ACCION                                  " tabla="ECOM           " campo="ACCION    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Acción                                                                                                                                                          " dominio="COMBOACCIONESECOMMERCE        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="CUENTA                                  " tabla="ECOM           " campo="CUENTACOM " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Cuenta                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="VENDEDOR                                " tabla="ECOM           " campo="VENDEDOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="BUZON                                   " tabla="ECOM           " campo="BUZON     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Buzón                                                                                                                                                           " dominio="COMBOBUZON                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="TIPOECOMMERCE                           " tabla="ECOM           " campo="TIPOECOM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Tipo ecommerce                                                                                                                                                  " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="TRANSPORTISTA                           " tabla="ECOM           " campo="TRANSPOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Transportista                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="BASEDEDATOS                             " tabla="ECOM           " campo="BASEDEDATO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="11" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Base de datos                                                                                                                                                   " dominio="COMBOSUCURSALESECOMMERCE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="IDVINCULACION                           " tabla="ECOM           " campo="IDVINC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="ID vinculación                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="MOTIVO                                  " tabla="ECOM           " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="ULTIMAORDER                             " tabla="ECOM           " campo="ULTORDER  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Ultima orden obtenida                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="DATOSDEENVIO                            " tabla="ECOM           " campo="DTOSENVIO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="416" etiqueta="Datos de envío                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="GENERACANCELACION                       " tabla="ECOM           " campo="GENERACAN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Generar cancelación/NC para op. canceladas                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="VACIO                                   " tabla="ECOM           " campo="VACIO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Vacío                                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PAGO                                    " tabla="ECOM           " campo="PAGO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="422" etiqueta="Valor a utilizar para generación de factura                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="VALORCTACTE                             " tabla="ECOM           " campo="VALCTACTE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Valor a utilizar en diferencia por percepciones                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="ERRORES                                 " tabla="DETERROR       " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Errores                                                                                                                                                         " dominio="DETALLEITEMERRORESECOMMERCE   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="CONDICIONPAGOPREFERENTE                 " tabla="ECOM           " campo="CONDPAGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="CLIENTEDEFAULT                          " tabla="ECOM           " campo="CLIEDEF   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Cliente Dragonfish                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="TELEFONODEENVIO                         " tabla="ECOM           " campo="TELENVIO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Teléfono de envío                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="DESCARTAR                               " tabla="ECOM           " campo="DESCARTAR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Descartar                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="UTILIZASTOCKOTRABASE                    " tabla="ECOM           " campo="USAOTRABD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Utilizar stock de otra base de datos                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="USAVALECAMBIO                           " tabla="ECOM           " campo="VALECAMB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Utiliza vale de cambio para pedido / remito pagado                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="CONCENVIO                               " tabla="ECOM           " campo="CONVENV   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Concepto para envío                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="CONCCOLOR                               " tabla="ECOM           " campo="CONCCOLOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Color del concepto para envío                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="CONCTALLE                               " tabla="ECOM           " campo="CONCTALLE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Talle del concepto para envío                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="CONCARTICULO                            " tabla="ECOM           " campo="CONCART   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Vinculación por defecto                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="CARGAAUTOMATICAVALORES                  " tabla="ECOM           " campo="CARGAAUTOV" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Carga automatica de valores                                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="USAEQUIVALORES                          " tabla="ECOM           " campo="USAEQUIVAL" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Habilitar equivalencias de valores                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="EQUIVALORESDETALLE                      " tabla="ECOMEQUIVAL    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Equivalencias de valores                                                                                                                                        " dominio="DETALLEITEMEQUIVALORES        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="9" orden="15" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="DATOSDEPAGO                             " tabla="ECOM           " campo="DTOSPAGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Datos de pago                                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PEDIDO                                  " tabla="ECOM           " campo="PEDIDO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Pedido                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURARSINPERSONALIZAR                 " tabla="ECOM           " campo="FACTSINPER" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Facturar sin personalizar a consumidores finales                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="BDORIGENSTOCK                           " tabla="ECOM           " campo="ORIGENST  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="11" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="456" etiqueta="Base de datos origen del stock                                                                                                                                  " dominio="COMBOSUCURSALESECOMMERCE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PERCEPCIONESACTACTE                     " tabla="ECOM           " campo="PERCCTACTE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Enviar percepciones a cta. cte.                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FECHANOVEDADES                          " tabla="ECOM           " campo="FECNOV    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Obtener novedades a partir de                                                                                                                                   " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="NUMERO                                  " tabla="ECOM           " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Número                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="REMITO                                  " tabla="ECOM           " campo="REMITO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Remito                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="ACCIONFULLENV                           " tabla="ECOM           " campo="ACCIONFE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="466" etiqueta="Acción tercerizada                                                                                                                                              " dominio="COMBOACCIONESECOMMERCE        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="APLICARCOSTOENVIO                       " tabla="ECOM           " campo="APLICENVIO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="468" etiqueta="Aplicar costos de envío                                                                                                                                         " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="NUMERODECARRITO                         " tabla="ECOM           " campo="NROCARRITO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="470" etiqueta="Número de carrito                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURAMANUAL                           " tabla="ECOM           " campo="FACTMANUAL" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="472" etiqueta="Factura manual                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="BUZONFULLENV                            " tabla="ECOM           " campo="BUZONFE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="474" etiqueta="Buzón tercerizado                                                                                                                                               " dominio="COMBOBUZON                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PEDIDOFACTURAMANUAL                     " tabla="ECOM           " campo="PEFACTMAN " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="476" etiqueta="Pedido y factura manual                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="43" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURAMANUALCONENTREGAPOSTERIOR        " tabla="ECOM           " campo="FACTMCEP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="478" etiqueta="Factura manual c/entrega posterior                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PEDIDOFACTURAMANUALCONENTREGAPOS        " tabla="ECOM           " campo="PEFACTMCEP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="480" etiqueta="Pedido y factura manual c/entrega posterior                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="48" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="ENLACEDELAOPERACION                     " tabla="ECOM           " campo="ENLACEOP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="482" etiqueta="Enlace a la operación                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURAMANUALCONVTACONT                 " tabla="ECOM           " campo="FACTMVC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="484" etiqueta="Factura manual c/venta continua                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="BASEDEDATOSFULLENV                      " tabla="ECOM           " campo="BDFE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="11" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="486" etiqueta="Base de datos tercerizada                                                                                                                                       " dominio="COMBOSUCURSALESECOMMERCE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURAELECTRONICA                      " tabla="ECOM           " campo="FACTELEC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="488" etiqueta="Factura electrónica                                                                                                                                             " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="55" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PEDIDOFACTURAELECTRONICA                " tabla="ECOM           " campo="PEFACTELEC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="490" etiqueta="Pedido y factura electrónica                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="58" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="DATOSDERETIRO                           " tabla="ECOM           " campo="DATOSRET  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="492" etiqueta="Datos de retiro                                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURAELECTRONICACONENTREGAPOSTERIOR   " tabla="ECOM           " campo="FACTECEP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="494" etiqueta="Factura electrónica c/entrega posterior                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PEDIDOFACTURAELECTRONICACONENTREGAPOS   " tabla="ECOM           " campo="PEFACTECEP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="496" etiqueta="Pedido y factura electrónica c/entrega posterior                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="63" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURAELECTRONICACONVTACONT            " tabla="ECOM           " campo="FACTEVC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="498" etiqueta="Factura electrónica c/venta continua                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="65" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="OBSERVACIONES                           " tabla="ECOM           " campo="OBSERVA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="500" etiqueta="Observación                                                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURAFISCAL                           " tabla="ECOM           " campo="FACTFISCAL" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="502" etiqueta="Factura fiscal                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PEDIDOFACTURAFISCAL                     " tabla="ECOM           " campo="PEFACTFISC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="504" etiqueta="Pedido y factura fiscal                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="73" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURAFISCALCONENTREGAPOSTERIOR        " tabla="ECOM           " campo="FACTFCEP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="506" etiqueta="Factura fiscal c/entrega posterior                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="75" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PEDIDOFACTURAFISCALCONENTREGAPOS        " tabla="ECOM           " campo="PEFACTFCEP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="508" etiqueta="Pedido y factura fiscal c/entrega posterior                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="78" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="PAGADO                                  " tabla="ECOM           " campo="PAGADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="510" etiqueta="Pagado                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="FACTURAFISCALCONVTACONT                 " tabla="ECOM           " campo="FACTFVC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="512" etiqueta="Factura fiscal c/venta continua                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="APLICARPROMOCIONESAUTOMATICAS           " tabla="ECOM           " campo="PROMOS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="514" etiqueta="Aplicar promociones automáticas no bancarias                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="85" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="OBSERVACION                             " tabla="ECOM           " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="516" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="99" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="401" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On ECOM.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On ECOM.VENDEDOR = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="411" etiqueta="Detalle Tra.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On ECOM.TRANSPOR = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On ECOM.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVAL           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVAL On ECOM.PAGO = XVAL.CLCOD And  XVAL.CLCOD != ''                                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVAL           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Val.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join XVAL On ECOM.VALCTACTE = XVAL.CLCOD And  XVAL.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="427" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On ECOM.CONDPAGO = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="429" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On ECOM.CLIEDEF = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="439" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On ECOM.CONVENV = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="441" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On ECOM.CONCCOLOR = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="443" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On ECOM.CONCTALLE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Vin.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On ECOM.CONCART = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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