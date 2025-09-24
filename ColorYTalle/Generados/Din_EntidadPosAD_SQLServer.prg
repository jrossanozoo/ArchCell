
define class Din_EntidadPOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_POS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_POSPK'
	cTablaPrincipal = 'POS'
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
			local  lxPosFmodifw, lxPosFecexpo, lxPosFecimpo, lxPosFectrans, lxPosFaltafw, lxPosEsttrans, lxPosHoraimpo, lxPosHoraexpo, lxPosSaltafw, lxPosHmodifw, lxPosHaltafw, lxPosSmodifw, lxPosValtafw, lxPosUmodifw, lxPosUaltafw, lxPosBdmodifw, lxPosZadsfw, lxPosBdaltafw, lxPosVmodifw, lxPosDispositiv, lxPosCodigo, lxPosObs, lxPosContacto, lxPosDescrip, lxPosTelsoporte, lxPosNrotermi, lxPosMarca, lxPosModelo, lxPosIntegrado, lxPosPrestador, lxPosPagoelec, lxPosPuerto, lxPosTpaquete, lxPosTmensaje, lxPosTchequeo, lxPosTimeoutrec, lxPosCodshop, lxPosCodempre, lxPosNrocaja, lxPosImporig, lxPosNumcomer, lxPosNomcomer, lxPosCuitcomer, lxPosPermiteoff, lxPosTiempoesp, lxPosTiemporein, lxPosIdcliente, lxPosUsuariomp, lxPosIdsecreto, lxPosBloqcieoff, lxPosColector, lxPosPuestoqr, lxPosLocalmp, lxPosStoreqr, lxPosCajamp, lxPosLeyenda, lxPosEnvsitef, lxPosFiservip, lxPosFiservport, lxPosFiservemp, lxPosFiservterm, lxPosFiservcert, lxPosDispfiserv, lxPosCloverid, lxPosCloverip, lxPosCloverport, lxPosClovermod, lxPosSerialclov, lxPosIdsmartl, lxPosPasssmartl, lxPosGuidstafe, lxPosFrasestafe, lxPosCajastafe, lxPosSucstafe, lxPosUrlstafe, lxPosCryptokey, lxPosMailgocuot, lxPosClavegocuo, lxPosTimeesppos, lxPosRutaini, lxPosPregtarqr
				lxPosFmodifw =  .Fechamodificacionfw			lxPosFecexpo =  .Fechaexpo			lxPosFecimpo =  .Fechaimpo			lxPosFectrans =  .Fechatransferencia			lxPosFaltafw =  .Fechaaltafw			lxPosEsttrans =  .Estadotransferencia			lxPosHoraimpo =  .Horaimpo			lxPosHoraexpo =  .Horaexpo			lxPosSaltafw =  .Seriealtafw			lxPosHmodifw =  .Horamodificacionfw			lxPosHaltafw =  .Horaaltafw			lxPosSmodifw =  .Seriemodificacionfw			lxPosValtafw =  .Versionaltafw			lxPosUmodifw =  .Usuariomodificacionfw			lxPosUaltafw =  .Usuarioaltafw			lxPosBdmodifw =  .Basededatosmodificacionfw			lxPosZadsfw =  .Zadsfw			lxPosBdaltafw =  .Basededatosaltafw			lxPosVmodifw =  .Versionmodificacionfw			lxPosDispositiv =  .Dispositivo			lxPosCodigo =  .Codigo			lxPosObs =  .Observacion			lxPosContacto =  .Contactosoportetecnico			lxPosDescrip =  .Descripcion			lxPosTelsoporte =  .Telefonosoportetecnico			lxPosNrotermi =  .Numeroterminal			lxPosMarca =  .Marca			lxPosModelo =  .Modelo			lxPosIntegrado =  .Integrado			lxPosPrestador =  .Prestador			lxPosPagoelec =  .Pagoelectronico			lxPosPuerto =  .Puerto			lxPosTpaquete =  .Paquete			lxPosTmensaje =  .Tiempomensaje			lxPosTchequeo =  .Tiempochequeo			lxPosTimeoutrec =  .Timeoutrecepcion			lxPosCodshop =  .Shopping			lxPosCodempre =  .Empresa			lxPosNrocaja =  .Caja			lxPosImporig =  .Imprimesolooriginal			lxPosNumcomer =  .Numerocomercio			lxPosNomcomer =  .Nombrecomercio			lxPosCuitcomer =  .Cuitcomercio			lxPosPermiteoff =  .Permitetransaccionesoffline			lxPosTiempoesp =  .Tiempodeespera			lxPosTiemporein =  .Tiempoporreintento			lxPosIdcliente =  .Idcliente			lxPosUsuariomp =  .Usuariomp			lxPosIdsecreto =  .Idsecreto			lxPosBloqcieoff =  .Bloquearcierrecajaoffline			lxPosColector =  .Colector			lxPosPuestoqr =  .Idpuestoqr			lxPosLocalmp =  .Localmp			lxPosStoreqr =  .Idstoreqr			lxPosCajamp =  .Cajamp			lxPosLeyenda =  .Leyenda			lxPosEnvsitef =  .Enviaventassitef			lxPosFiservip =  .Direccionip			lxPosFiservport =  .Puertofiserv			lxPosFiservemp =  .Empresafiserv			lxPosFiservterm =  .Terminalfiserv			lxPosFiservcert =  .Rutacertificado			lxPosDispfiserv =  .Dispositivofiserv			lxPosCloverid =  .Idcloverdisp			lxPosCloverip =  .Ipcloverdisp			lxPosCloverport =  .Puertocloverdisp			lxPosClovermod =  .Modeloclover			lxPosSerialclov =  .Serialclover			lxPosIdsmartl =  .Usuariosmartlapos			lxPosPasssmartl =  .Passsmartlapos			lxPosGuidstafe =  .Guidbilleterasantafe			lxPosFrasestafe =  .Frasebilleterasantafe			lxPosCajastafe =  .Cajabilleterasantafe			lxPosSucstafe =  .Sucursalbilleterasantafe			lxPosUrlstafe =  .Urlbilleterasantafe			lxPosCryptokey =  .Cryptoapikey			lxPosMailgocuot =  .Mailgocuotas			lxPosClavegocuo =  .Clavegocuotas			lxPosTimeesppos =  .Tiempodeesperaposnet			lxPosRutaini =  .Rutaarchivoiniposnet			lxPosPregtarqr =  .Preguntatarjetaqr
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxPosCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.POS ( "Fmodifw","Fecexpo","Fecimpo","Fectrans","Faltafw","Esttrans","Horaimpo","Horaexpo","Saltafw","Hmodifw","Haltafw","Smodifw","Valtafw","Umodifw","Ualtafw","Bdmodifw","Zadsfw","Bdaltafw","Vmodifw","Dispositiv","Codigo","Obs","Contacto","Descrip","Telsoporte","Nrotermi","Marca","Modelo","Integrado","Prestador","Pagoelec","Puerto","Tpaquete","Tmensaje","Tchequeo","Timeoutrec","Codshop","Codempre","Nrocaja","Imporig","Numcomer","Nomcomer","Cuitcomer","Permiteoff","Tiempoesp","Tiemporein","Idcliente","Usuariomp","Idsecreto","Bloqcieoff","Colector","Puestoqr","Localmp","Storeqr","Cajamp","Leyenda","Envsitef","Fiservip","Fiservport","Fiservemp","Fiservterm","Fiservcert","Dispfiserv","Cloverid","Cloverip","Cloverport","Clovermod","Serialclov","Idsmartl","Passsmartl","Guidstafe","Frasestafe","Cajastafe","Sucstafe","Urlstafe","Cryptokey","Mailgocuot","Clavegocuo","Timeesppos","Rutaini","Pregtarqr" ) values ( <<"'" + this.ConvertirDateSql( lxPosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPosFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPosFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosDispositiv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosContacto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosTelsoporte ) + "'" >>, <<lxPosNrotermi >>, <<"'" + this.FormatearTextoSql( lxPosMarca ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosModelo ) + "'" >>, <<iif( lxPosIntegrado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPosPrestador ) + "'" >>, <<iif( lxPosPagoelec, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPosPuerto ) + "'" >>, <<lxPosTpaquete >>, <<lxPosTmensaje >>, <<lxPosTchequeo >>, <<lxPosTimeoutrec >>, <<lxPosCodshop >>, <<lxPosCodempre >>, <<lxPosNrocaja >>, <<iif( lxPosImporig, 1, 0 ) >>, <<lxPosNumcomer >>, <<"'" + this.FormatearTextoSql( lxPosNomcomer ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCuitcomer ) + "'" >>, <<iif( lxPosPermiteoff, 1, 0 ) >>, <<lxPosTiempoesp >>, <<lxPosTiemporein >>, <<"'" + this.FormatearTextoSql( lxPosIdcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosUsuariomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosIdsecreto ) + "'" >>, <<iif( lxPosBloqcieoff, 1, 0 ) >>, <<lxPosColector >>, <<"'" + this.FormatearTextoSql( lxPosPuestoqr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosLocalmp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosStoreqr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCajamp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosLeyenda ) + "'" >>, <<iif( lxPosEnvsitef, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPosFiservip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFiservport ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFiservemp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFiservterm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFiservcert ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosDispfiserv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCloverid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCloverip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCloverport ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosClovermod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosSerialclov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosIdsmartl ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosPasssmartl ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosGuidstafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFrasestafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCajastafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosSucstafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosUrlstafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCryptokey ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosMailgocuot ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosClavegocuo ) + "'" >>, <<lxPosTimeesppos >>, <<"'" + this.FormatearTextoSql( lxPosRutaini ) + "'" >>, <<lxPosPregtarqr >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasDetalle
				if this.oEntidad.TarjetasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxOperadoradetarjeta_PK = loItem.Operadoradetarjeta_PK
					lxOperadoradetarjetadetalle = loItem.Operadoradetarjetadetalle
					lxNumerocomercio = loItem.Numerocomercio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSDetalleTarj("NROITEM","Codigo","TarjMad","DesTarjMad","NroComerci" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadoradetarjeta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadoradetarjetadetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocomercio ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MonedasDetalle
				if this.oEntidad.MonedasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSimbolo = loItem.Simbolo
					lxCodigodemoneda_PK = loItem.Codigodemoneda_PK
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSMonedas("NROITEM","Codigo","Simbolo","CodMoneda","Descrip" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSimbolo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodemoneda_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasICardDetalle
				if this.oEntidad.TarjetasICardDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumeroequivalencia = loItem.Numeroequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					lxAutorizador = loItem.Autorizador
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ICARDTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora","Autoriz" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNumeroequivalencia>>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">>, <<lxAutorizador>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AutorizadoresICardDetalle
				if this.oEntidad.AutorizadoresICardDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumeroequivalencia = loItem.Numeroequivalencia
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ICARDAutoriz("NROITEM","Codigo","Equivalen","Descrip" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNumeroequivalencia>>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasLaPosDetalle
				if this.oEntidad.TarjetasLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					lxNumerocomercio = loItem.Numerocomercio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora","NroComer" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">>, <<lxNumerocomercio>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DispositivoMovilPointDetalle
				if this.oEntidad.DispositivoMovilPointDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxDispositivomovil = loItem.Dispositivomovil
					lxDisponible = loItem.Disponible
					lxSugerido = loItem.Sugerido
					lxVinculacionpdv = loItem.Vinculacionpdv
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POINTDispMovil("NROITEM","Codigo","DispMovil","Disponible","Sugerido","VincPDV" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDispositivomovil ) + "'">>, <<iif( lxDisponible, 1, 0 )>>, <<iif( lxSugerido, 1, 0 )>>, <<iif( lxVinculacionpdv, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasFiServDetalle
				if this.oEntidad.TarjetasFiServDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FISERVTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TerminalesSmartLaposDetalle
				if this.oEntidad.TerminalesSmartLaposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminal = loItem.Terminal
					lxDisponible = loItem.Disponible
					lxSugerido = loItem.Sugerido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSTerminal("NROITEM","Codigo","Terminal","Disponible","Sugerido" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTerminal ) + "'">>, <<iif( lxDisponible, 1, 0 )>>, <<iif( lxSugerido, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasPosnetDetalle
				if this.oEntidad.TarjetasPosnetDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSNETTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesLaPosDetalle
				if this.oEntidad.PlanesLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SerialPointDetalle
				if this.oEntidad.SerialPointDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSerial = loItem.Serial
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POINTSerial("NROITEM","Codigo","Serial" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerial ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasSmartLaposDetalle
				if this.oEntidad.TarjetasSmartLaposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SMARTLTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesPosnetDetalle
				if this.oEntidad.PlanesPosnetDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSNETPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesSmartLaPosDetalle
				if this.oEntidad.PlanesSmartLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SMARTLPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
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
			local  lxPosFmodifw, lxPosFecexpo, lxPosFecimpo, lxPosFectrans, lxPosFaltafw, lxPosEsttrans, lxPosHoraimpo, lxPosHoraexpo, lxPosSaltafw, lxPosHmodifw, lxPosHaltafw, lxPosSmodifw, lxPosValtafw, lxPosUmodifw, lxPosUaltafw, lxPosBdmodifw, lxPosZadsfw, lxPosBdaltafw, lxPosVmodifw, lxPosDispositiv, lxPosCodigo, lxPosObs, lxPosContacto, lxPosDescrip, lxPosTelsoporte, lxPosNrotermi, lxPosMarca, lxPosModelo, lxPosIntegrado, lxPosPrestador, lxPosPagoelec, lxPosPuerto, lxPosTpaquete, lxPosTmensaje, lxPosTchequeo, lxPosTimeoutrec, lxPosCodshop, lxPosCodempre, lxPosNrocaja, lxPosImporig, lxPosNumcomer, lxPosNomcomer, lxPosCuitcomer, lxPosPermiteoff, lxPosTiempoesp, lxPosTiemporein, lxPosIdcliente, lxPosUsuariomp, lxPosIdsecreto, lxPosBloqcieoff, lxPosColector, lxPosPuestoqr, lxPosLocalmp, lxPosStoreqr, lxPosCajamp, lxPosLeyenda, lxPosEnvsitef, lxPosFiservip, lxPosFiservport, lxPosFiservemp, lxPosFiservterm, lxPosFiservcert, lxPosDispfiserv, lxPosCloverid, lxPosCloverip, lxPosCloverport, lxPosClovermod, lxPosSerialclov, lxPosIdsmartl, lxPosPasssmartl, lxPosGuidstafe, lxPosFrasestafe, lxPosCajastafe, lxPosSucstafe, lxPosUrlstafe, lxPosCryptokey, lxPosMailgocuot, lxPosClavegocuo, lxPosTimeesppos, lxPosRutaini, lxPosPregtarqr
				lxPosFmodifw =  .Fechamodificacionfw			lxPosFecexpo =  .Fechaexpo			lxPosFecimpo =  .Fechaimpo			lxPosFectrans =  .Fechatransferencia			lxPosFaltafw =  .Fechaaltafw			lxPosEsttrans =  .Estadotransferencia			lxPosHoraimpo =  .Horaimpo			lxPosHoraexpo =  .Horaexpo			lxPosSaltafw =  .Seriealtafw			lxPosHmodifw =  .Horamodificacionfw			lxPosHaltafw =  .Horaaltafw			lxPosSmodifw =  .Seriemodificacionfw			lxPosValtafw =  .Versionaltafw			lxPosUmodifw =  .Usuariomodificacionfw			lxPosUaltafw =  .Usuarioaltafw			lxPosBdmodifw =  .Basededatosmodificacionfw			lxPosZadsfw =  .Zadsfw			lxPosBdaltafw =  .Basededatosaltafw			lxPosVmodifw =  .Versionmodificacionfw			lxPosDispositiv =  .Dispositivo			lxPosCodigo =  .Codigo			lxPosObs =  .Observacion			lxPosContacto =  .Contactosoportetecnico			lxPosDescrip =  .Descripcion			lxPosTelsoporte =  .Telefonosoportetecnico			lxPosNrotermi =  .Numeroterminal			lxPosMarca =  .Marca			lxPosModelo =  .Modelo			lxPosIntegrado =  .Integrado			lxPosPrestador =  .Prestador			lxPosPagoelec =  .Pagoelectronico			lxPosPuerto =  .Puerto			lxPosTpaquete =  .Paquete			lxPosTmensaje =  .Tiempomensaje			lxPosTchequeo =  .Tiempochequeo			lxPosTimeoutrec =  .Timeoutrecepcion			lxPosCodshop =  .Shopping			lxPosCodempre =  .Empresa			lxPosNrocaja =  .Caja			lxPosImporig =  .Imprimesolooriginal			lxPosNumcomer =  .Numerocomercio			lxPosNomcomer =  .Nombrecomercio			lxPosCuitcomer =  .Cuitcomercio			lxPosPermiteoff =  .Permitetransaccionesoffline			lxPosTiempoesp =  .Tiempodeespera			lxPosTiemporein =  .Tiempoporreintento			lxPosIdcliente =  .Idcliente			lxPosUsuariomp =  .Usuariomp			lxPosIdsecreto =  .Idsecreto			lxPosBloqcieoff =  .Bloquearcierrecajaoffline			lxPosColector =  .Colector			lxPosPuestoqr =  .Idpuestoqr			lxPosLocalmp =  .Localmp			lxPosStoreqr =  .Idstoreqr			lxPosCajamp =  .Cajamp			lxPosLeyenda =  .Leyenda			lxPosEnvsitef =  .Enviaventassitef			lxPosFiservip =  .Direccionip			lxPosFiservport =  .Puertofiserv			lxPosFiservemp =  .Empresafiserv			lxPosFiservterm =  .Terminalfiserv			lxPosFiservcert =  .Rutacertificado			lxPosDispfiserv =  .Dispositivofiserv			lxPosCloverid =  .Idcloverdisp			lxPosCloverip =  .Ipcloverdisp			lxPosCloverport =  .Puertocloverdisp			lxPosClovermod =  .Modeloclover			lxPosSerialclov =  .Serialclover			lxPosIdsmartl =  .Usuariosmartlapos			lxPosPasssmartl =  .Passsmartlapos			lxPosGuidstafe =  .Guidbilleterasantafe			lxPosFrasestafe =  .Frasebilleterasantafe			lxPosCajastafe =  .Cajabilleterasantafe			lxPosSucstafe =  .Sucursalbilleterasantafe			lxPosUrlstafe =  .Urlbilleterasantafe			lxPosCryptokey =  .Cryptoapikey			lxPosMailgocuot =  .Mailgocuotas			lxPosClavegocuo =  .Clavegocuotas			lxPosTimeesppos =  .Tiempodeesperaposnet			lxPosRutaini =  .Rutaarchivoiniposnet			lxPosPregtarqr =  .Preguntatarjetaqr
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.POS set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPosFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxPosFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxPosFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxPosFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxPosFaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxPosEsttrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxPosHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxPosHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxPosSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxPosHmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxPosHaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxPosSmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxPosValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxPosUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxPosUaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPosBdmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxPosZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPosBdaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxPosVmodifw ) + "'">>,"Dispositiv" = <<"'" + this.FormatearTextoSql( lxPosDispositiv ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxPosCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxPosObs ) + "'">>,"Contacto" = <<"'" + this.FormatearTextoSql( lxPosContacto ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxPosDescrip ) + "'">>,"Telsoporte" = <<"'" + this.FormatearTextoSql( lxPosTelsoporte ) + "'">>,"Nrotermi" = <<lxPosNrotermi>>,"Marca" = <<"'" + this.FormatearTextoSql( lxPosMarca ) + "'">>,"Modelo" = <<"'" + this.FormatearTextoSql( lxPosModelo ) + "'">>,"Integrado" = <<iif( lxPosIntegrado, 1, 0 )>>,"Prestador" = <<"'" + this.FormatearTextoSql( lxPosPrestador ) + "'">>,"Pagoelec" = <<iif( lxPosPagoelec, 1, 0 )>>,"Puerto" = <<"'" + this.FormatearTextoSql( lxPosPuerto ) + "'">>,"Tpaquete" = <<lxPosTpaquete>>,"Tmensaje" = <<lxPosTmensaje>>,"Tchequeo" = <<lxPosTchequeo>>,"Timeoutrec" = <<lxPosTimeoutrec>>,"Codshop" = <<lxPosCodshop>>,"Codempre" = <<lxPosCodempre>>,"Nrocaja" = <<lxPosNrocaja>>,"Imporig" = <<iif( lxPosImporig, 1, 0 )>>,"Numcomer" = <<lxPosNumcomer>>,"Nomcomer" = <<"'" + this.FormatearTextoSql( lxPosNomcomer ) + "'">>,"Cuitcomer" = <<"'" + this.FormatearTextoSql( lxPosCuitcomer ) + "'">>,"Permiteoff" = <<iif( lxPosPermiteoff, 1, 0 )>>,"Tiempoesp" = <<lxPosTiempoesp>>,"Tiemporein" = <<lxPosTiemporein>>,"Idcliente" = <<"'" + this.FormatearTextoSql( lxPosIdcliente ) + "'">>,"Usuariomp" = <<"'" + this.FormatearTextoSql( lxPosUsuariomp ) + "'">>,"Idsecreto" = <<"'" + this.FormatearTextoSql( lxPosIdsecreto ) + "'">>,"Bloqcieoff" = <<iif( lxPosBloqcieoff, 1, 0 )>>,"Colector" = <<lxPosColector>>,"Puestoqr" = <<"'" + this.FormatearTextoSql( lxPosPuestoqr ) + "'">>,"Localmp" = <<"'" + this.FormatearTextoSql( lxPosLocalmp ) + "'">>,"Storeqr" = <<"'" + this.FormatearTextoSql( lxPosStoreqr ) + "'">>,"Cajamp" = <<"'" + this.FormatearTextoSql( lxPosCajamp ) + "'">>,"Leyenda" = <<"'" + this.FormatearTextoSql( lxPosLeyenda ) + "'">>,"Envsitef" = <<iif( lxPosEnvsitef, 1, 0 )>>,"Fiservip" = <<"'" + this.FormatearTextoSql( lxPosFiservip ) + "'">>,"Fiservport" = <<"'" + this.FormatearTextoSql( lxPosFiservport ) + "'">>,"Fiservemp" = <<"'" + this.FormatearTextoSql( lxPosFiservemp ) + "'">>,"Fiservterm" = <<"'" + this.FormatearTextoSql( lxPosFiservterm ) + "'">>,"Fiservcert" = <<"'" + this.FormatearTextoSql( lxPosFiservcert ) + "'">>,"Dispfiserv" = <<"'" + this.FormatearTextoSql( lxPosDispfiserv ) + "'">>,"Cloverid" = <<"'" + this.FormatearTextoSql( lxPosCloverid ) + "'">>,"Cloverip" = <<"'" + this.FormatearTextoSql( lxPosCloverip ) + "'">>,"Cloverport" = <<"'" + this.FormatearTextoSql( lxPosCloverport ) + "'">>,"Clovermod" = <<"'" + this.FormatearTextoSql( lxPosClovermod ) + "'">>,"Serialclov" = <<"'" + this.FormatearTextoSql( lxPosSerialclov ) + "'">>,"Idsmartl" = <<"'" + this.FormatearTextoSql( lxPosIdsmartl ) + "'">>,"Passsmartl" = <<"'" + this.FormatearTextoSql( lxPosPasssmartl ) + "'">>,"Guidstafe" = <<"'" + this.FormatearTextoSql( lxPosGuidstafe ) + "'">>,"Frasestafe" = <<"'" + this.FormatearTextoSql( lxPosFrasestafe ) + "'">>,"Cajastafe" = <<"'" + this.FormatearTextoSql( lxPosCajastafe ) + "'">>,"Sucstafe" = <<"'" + this.FormatearTextoSql( lxPosSucstafe ) + "'">>,"Urlstafe" = <<"'" + this.FormatearTextoSql( lxPosUrlstafe ) + "'">>,"Cryptokey" = <<"'" + this.FormatearTextoSql( lxPosCryptokey ) + "'">>,"Mailgocuot" = <<"'" + this.FormatearTextoSql( lxPosMailgocuot ) + "'">>,"Clavegocuo" = <<"'" + this.FormatearTextoSql( lxPosClavegocuo ) + "'">>,"Timeesppos" = <<lxPosTimeesppos>>,"Rutaini" = <<"'" + this.FormatearTextoSql( lxPosRutaini ) + "'">>,"Pregtarqr" = <<lxPosPregtarqr>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxPosCodigo ) + "'">> and  POS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POSDetalleTarj where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POSMonedas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ICARDTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ICARDAutoriz where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LAPOSTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POINTDispMovil where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.FISERVTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LAPOSTerminal where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POSNETTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LAPOSPlanes where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POINTSerial where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SMARTLTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POSNETPlanes where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SMARTLPlanes where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasDetalle
				if this.oEntidad.TarjetasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxOperadoradetarjeta_PK = loItem.Operadoradetarjeta_PK
					lxOperadoradetarjetadetalle = loItem.Operadoradetarjetadetalle
					lxNumerocomercio = loItem.Numerocomercio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSDetalleTarj("NROITEM","Codigo","TarjMad","DesTarjMad","NroComerci" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadoradetarjeta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadoradetarjetadetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocomercio ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MonedasDetalle
				if this.oEntidad.MonedasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSimbolo = loItem.Simbolo
					lxCodigodemoneda_PK = loItem.Codigodemoneda_PK
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSMonedas("NROITEM","Codigo","Simbolo","CodMoneda","Descrip" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSimbolo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodemoneda_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasICardDetalle
				if this.oEntidad.TarjetasICardDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumeroequivalencia = loItem.Numeroequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					lxAutorizador = loItem.Autorizador
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ICARDTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora","Autoriz" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNumeroequivalencia>>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">>, <<lxAutorizador>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AutorizadoresICardDetalle
				if this.oEntidad.AutorizadoresICardDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumeroequivalencia = loItem.Numeroequivalencia
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ICARDAutoriz("NROITEM","Codigo","Equivalen","Descrip" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNumeroequivalencia>>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasLaPosDetalle
				if this.oEntidad.TarjetasLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					lxNumerocomercio = loItem.Numerocomercio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora","NroComer" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">>, <<lxNumerocomercio>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DispositivoMovilPointDetalle
				if this.oEntidad.DispositivoMovilPointDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxDispositivomovil = loItem.Dispositivomovil
					lxDisponible = loItem.Disponible
					lxSugerido = loItem.Sugerido
					lxVinculacionpdv = loItem.Vinculacionpdv
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POINTDispMovil("NROITEM","Codigo","DispMovil","Disponible","Sugerido","VincPDV" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDispositivomovil ) + "'">>, <<iif( lxDisponible, 1, 0 )>>, <<iif( lxSugerido, 1, 0 )>>, <<iif( lxVinculacionpdv, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasFiServDetalle
				if this.oEntidad.TarjetasFiServDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FISERVTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TerminalesSmartLaposDetalle
				if this.oEntidad.TerminalesSmartLaposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminal = loItem.Terminal
					lxDisponible = loItem.Disponible
					lxSugerido = loItem.Sugerido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSTerminal("NROITEM","Codigo","Terminal","Disponible","Sugerido" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTerminal ) + "'">>, <<iif( lxDisponible, 1, 0 )>>, <<iif( lxSugerido, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasPosnetDetalle
				if this.oEntidad.TarjetasPosnetDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSNETTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesLaPosDetalle
				if this.oEntidad.PlanesLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SerialPointDetalle
				if this.oEntidad.SerialPointDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSerial = loItem.Serial
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POINTSerial("NROITEM","Codigo","Serial" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerial ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasSmartLaposDetalle
				if this.oEntidad.TarjetasSmartLaposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SMARTLTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesPosnetDetalle
				if this.oEntidad.PlanesPosnetDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSNETPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesSmartLaPosDetalle
				if this.oEntidad.PlanesSmartLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SMARTLPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.POS where " + this.ConvertirFuncionesSql( " POS.CODIGO != ''" ) )
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
			Local lxPosCodigo
			lxPosCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Dispositiv" as "Dispositivo", "Codigo" as "Codigo", "Obs" as "Observacion", "Contacto" as "Contactosoportetecnico", "Descrip" as "Descripcion", "Telsoporte" as "Telefonosoportetecnico", "Nrotermi" as "Numeroterminal", "Marca" as "Marca", "Modelo" as "Modelo", "Integrado" as "Integrado", "Prestador" as "Prestador", "Pagoelec" as "Pagoelectronico", "Puerto" as "Puerto", "Tpaquete" as "Paquete", "Tmensaje" as "Tiempomensaje", "Tchequeo" as "Tiempochequeo", "Timeoutrec" as "Timeoutrecepcion", "Codshop" as "Shopping", "Codempre" as "Empresa", "Nrocaja" as "Caja", "Imporig" as "Imprimesolooriginal", "Numcomer" as "Numerocomercio", "Nomcomer" as "Nombrecomercio", "Cuitcomer" as "Cuitcomercio", "Permiteoff" as "Permitetransaccionesoffline", "Tiempoesp" as "Tiempodeespera", "Tiemporein" as "Tiempoporreintento", "Idcliente" as "Idcliente", "Usuariomp" as "Usuariomp", "Idsecreto" as "Idsecreto", "Bloqcieoff" as "Bloquearcierrecajaoffline", "Colector" as "Colector", "Puestoqr" as "Idpuestoqr", "Localmp" as "Localmp", "Storeqr" as "Idstoreqr", "Cajamp" as "Cajamp", "Leyenda" as "Leyenda", "Envsitef" as "Enviaventassitef", "Fiservip" as "Direccionip", "Fiservport" as "Puertofiserv", "Fiservemp" as "Empresafiserv", "Fiservterm" as "Terminalfiserv", "Fiservcert" as "Rutacertificado", "Dispfiserv" as "Dispositivofiserv", "Cloverid" as "Idcloverdisp", "Cloverip" as "Ipcloverdisp", "Cloverport" as "Puertocloverdisp", "Clovermod" as "Modeloclover", "Serialclov" as "Serialclover", "Idsmartl" as "Usuariosmartlapos", "Passsmartl" as "Passsmartlapos", "Guidstafe" as "Guidbilleterasantafe", "Frasestafe" as "Frasebilleterasantafe", "Cajastafe" as "Cajabilleterasantafe", "Sucstafe" as "Sucursalbilleterasantafe", "Urlstafe" as "Urlbilleterasantafe", "Cryptokey" as "Cryptoapikey", "Mailgocuot" as "Mailgocuotas", "Clavegocuo" as "Clavegocuotas", "Timeesppos" as "Tiempodeesperaposnet", "Rutaini" as "Rutaarchivoiniposnet", "Pregtarqr" as "Preguntatarjetaqr" from ZooLogic.POS where "Codigo" = <<"'" + this.FormatearTextoSql( lxPosCodigo ) + "'">> and  POS.CODIGO != ''
			endtext
			use in select('c_POS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_POS', set( 'Datasession' ) )

			if reccount( 'c_POS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Tarjmad" as "Operadoradetarjeta", "Destarjmad" as "Operadoradetarjetadetalle", "Nrocomerci" as "Numerocomercio" from ZooLogic.POSDetalleTarj where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Simbolo" as "Simbolo", "Codmoneda" as "Codigodemoneda", "Descrip" as "Descripcion" from ZooLogic.POSMonedas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MonedasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MonedasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MonedasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Autoriz" as "Autorizador" from ZooLogic.ICARDTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion" from ZooLogic.ICARDAutoriz where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AutorizadoresICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AutorizadoresICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AutorizadoresICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Nrocomer" as "Numerocomercio" from ZooLogic.LAPOSTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dispmovil" as "Dispositivomovil", "Disponible" as "Disponible", "Sugerido" as "Sugerido", "Vincpdv" as "Vinculacionpdv" from ZooLogic.POINTDispMovil where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DispositivoMovilPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DispositivoMovilPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DispositivoMovilPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.FISERVTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasFiServDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasFiServDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasFiServDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Terminal" as "Terminal", "Disponible" as "Disponible", "Sugerido" as "Sugerido" from ZooLogic.LAPOSTerminal where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TerminalesSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TerminalesSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TerminalesSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.LAPOSPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Serial" as "Serial" from ZooLogic.POINTSerial where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SerialPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SerialPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SerialPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesSmartLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesSmartLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesSmartLaPosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxPosCodigo as Variant
		llRetorno = .t.
		lxPosCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.POS where "Codigo" = <<"'" + this.FormatearTextoSql( lxPosCodigo ) + "'">> and  POS.CODIGO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Dispositiv" as "Dispositivo", "Codigo" as "Codigo", "Obs" as "Observacion", "Contacto" as "Contactosoportetecnico", "Descrip" as "Descripcion", "Telsoporte" as "Telefonosoportetecnico", "Nrotermi" as "Numeroterminal", "Marca" as "Marca", "Modelo" as "Modelo", "Integrado" as "Integrado", "Prestador" as "Prestador", "Pagoelec" as "Pagoelectronico", "Puerto" as "Puerto", "Tpaquete" as "Paquete", "Tmensaje" as "Tiempomensaje", "Tchequeo" as "Tiempochequeo", "Timeoutrec" as "Timeoutrecepcion", "Codshop" as "Shopping", "Codempre" as "Empresa", "Nrocaja" as "Caja", "Imporig" as "Imprimesolooriginal", "Numcomer" as "Numerocomercio", "Nomcomer" as "Nombrecomercio", "Cuitcomer" as "Cuitcomercio", "Permiteoff" as "Permitetransaccionesoffline", "Tiempoesp" as "Tiempodeespera", "Tiemporein" as "Tiempoporreintento", "Idcliente" as "Idcliente", "Usuariomp" as "Usuariomp", "Idsecreto" as "Idsecreto", "Bloqcieoff" as "Bloquearcierrecajaoffline", "Colector" as "Colector", "Puestoqr" as "Idpuestoqr", "Localmp" as "Localmp", "Storeqr" as "Idstoreqr", "Cajamp" as "Cajamp", "Leyenda" as "Leyenda", "Envsitef" as "Enviaventassitef", "Fiservip" as "Direccionip", "Fiservport" as "Puertofiserv", "Fiservemp" as "Empresafiserv", "Fiservterm" as "Terminalfiserv", "Fiservcert" as "Rutacertificado", "Dispfiserv" as "Dispositivofiserv", "Cloverid" as "Idcloverdisp", "Cloverip" as "Ipcloverdisp", "Cloverport" as "Puertocloverdisp", "Clovermod" as "Modeloclover", "Serialclov" as "Serialclover", "Idsmartl" as "Usuariosmartlapos", "Passsmartl" as "Passsmartlapos", "Guidstafe" as "Guidbilleterasantafe", "Frasestafe" as "Frasebilleterasantafe", "Cajastafe" as "Cajabilleterasantafe", "Sucstafe" as "Sucursalbilleterasantafe", "Urlstafe" as "Urlbilleterasantafe", "Cryptokey" as "Cryptoapikey", "Mailgocuot" as "Mailgocuotas", "Clavegocuo" as "Clavegocuotas", "Timeesppos" as "Tiempodeesperaposnet", "Rutaini" as "Rutaarchivoiniposnet", "Pregtarqr" as "Preguntatarjetaqr" from ZooLogic.POS where  POS.CODIGO != '' order by Codigo
			endtext
			use in select('c_POS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_POS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Tarjmad" as "Operadoradetarjeta", "Destarjmad" as "Operadoradetarjetadetalle", "Nrocomerci" as "Numerocomercio" from ZooLogic.POSDetalleTarj where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Simbolo" as "Simbolo", "Codmoneda" as "Codigodemoneda", "Descrip" as "Descripcion" from ZooLogic.POSMonedas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MonedasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MonedasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MonedasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Autoriz" as "Autorizador" from ZooLogic.ICARDTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion" from ZooLogic.ICARDAutoriz where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AutorizadoresICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AutorizadoresICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AutorizadoresICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Nrocomer" as "Numerocomercio" from ZooLogic.LAPOSTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dispmovil" as "Dispositivomovil", "Disponible" as "Disponible", "Sugerido" as "Sugerido", "Vincpdv" as "Vinculacionpdv" from ZooLogic.POINTDispMovil where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DispositivoMovilPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DispositivoMovilPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DispositivoMovilPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.FISERVTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasFiServDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasFiServDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasFiServDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Terminal" as "Terminal", "Disponible" as "Disponible", "Sugerido" as "Sugerido" from ZooLogic.LAPOSTerminal where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TerminalesSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TerminalesSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TerminalesSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.LAPOSPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Serial" as "Serial" from ZooLogic.POINTSerial where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SerialPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SerialPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SerialPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesSmartLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesSmartLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesSmartLaPosDetalle
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Dispositiv" as "Dispositivo", "Codigo" as "Codigo", "Obs" as "Observacion", "Contacto" as "Contactosoportetecnico", "Descrip" as "Descripcion", "Telsoporte" as "Telefonosoportetecnico", "Nrotermi" as "Numeroterminal", "Marca" as "Marca", "Modelo" as "Modelo", "Integrado" as "Integrado", "Prestador" as "Prestador", "Pagoelec" as "Pagoelectronico", "Puerto" as "Puerto", "Tpaquete" as "Paquete", "Tmensaje" as "Tiempomensaje", "Tchequeo" as "Tiempochequeo", "Timeoutrec" as "Timeoutrecepcion", "Codshop" as "Shopping", "Codempre" as "Empresa", "Nrocaja" as "Caja", "Imporig" as "Imprimesolooriginal", "Numcomer" as "Numerocomercio", "Nomcomer" as "Nombrecomercio", "Cuitcomer" as "Cuitcomercio", "Permiteoff" as "Permitetransaccionesoffline", "Tiempoesp" as "Tiempodeespera", "Tiemporein" as "Tiempoporreintento", "Idcliente" as "Idcliente", "Usuariomp" as "Usuariomp", "Idsecreto" as "Idsecreto", "Bloqcieoff" as "Bloquearcierrecajaoffline", "Colector" as "Colector", "Puestoqr" as "Idpuestoqr", "Localmp" as "Localmp", "Storeqr" as "Idstoreqr", "Cajamp" as "Cajamp", "Leyenda" as "Leyenda", "Envsitef" as "Enviaventassitef", "Fiservip" as "Direccionip", "Fiservport" as "Puertofiserv", "Fiservemp" as "Empresafiserv", "Fiservterm" as "Terminalfiserv", "Fiservcert" as "Rutacertificado", "Dispfiserv" as "Dispositivofiserv", "Cloverid" as "Idcloverdisp", "Cloverip" as "Ipcloverdisp", "Cloverport" as "Puertocloverdisp", "Clovermod" as "Modeloclover", "Serialclov" as "Serialclover", "Idsmartl" as "Usuariosmartlapos", "Passsmartl" as "Passsmartlapos", "Guidstafe" as "Guidbilleterasantafe", "Frasestafe" as "Frasebilleterasantafe", "Cajastafe" as "Cajabilleterasantafe", "Sucstafe" as "Sucursalbilleterasantafe", "Urlstafe" as "Urlbilleterasantafe", "Cryptokey" as "Cryptoapikey", "Mailgocuot" as "Mailgocuotas", "Clavegocuo" as "Clavegocuotas", "Timeesppos" as "Tiempodeesperaposnet", "Rutaini" as "Rutaarchivoiniposnet", "Pregtarqr" as "Preguntatarjetaqr" from ZooLogic.POS where  funciones.padr( Codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  POS.CODIGO != '' order by Codigo
			endtext
			use in select('c_POS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_POS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Tarjmad" as "Operadoradetarjeta", "Destarjmad" as "Operadoradetarjetadetalle", "Nrocomerci" as "Numerocomercio" from ZooLogic.POSDetalleTarj where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Simbolo" as "Simbolo", "Codmoneda" as "Codigodemoneda", "Descrip" as "Descripcion" from ZooLogic.POSMonedas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MonedasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MonedasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MonedasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Autoriz" as "Autorizador" from ZooLogic.ICARDTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion" from ZooLogic.ICARDAutoriz where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AutorizadoresICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AutorizadoresICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AutorizadoresICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Nrocomer" as "Numerocomercio" from ZooLogic.LAPOSTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dispmovil" as "Dispositivomovil", "Disponible" as "Disponible", "Sugerido" as "Sugerido", "Vincpdv" as "Vinculacionpdv" from ZooLogic.POINTDispMovil where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DispositivoMovilPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DispositivoMovilPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DispositivoMovilPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.FISERVTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasFiServDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasFiServDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasFiServDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Terminal" as "Terminal", "Disponible" as "Disponible", "Sugerido" as "Sugerido" from ZooLogic.LAPOSTerminal where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TerminalesSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TerminalesSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TerminalesSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.LAPOSPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Serial" as "Serial" from ZooLogic.POINTSerial where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SerialPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SerialPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SerialPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesSmartLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesSmartLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesSmartLaPosDetalle
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Dispositiv" as "Dispositivo", "Codigo" as "Codigo", "Obs" as "Observacion", "Contacto" as "Contactosoportetecnico", "Descrip" as "Descripcion", "Telsoporte" as "Telefonosoportetecnico", "Nrotermi" as "Numeroterminal", "Marca" as "Marca", "Modelo" as "Modelo", "Integrado" as "Integrado", "Prestador" as "Prestador", "Pagoelec" as "Pagoelectronico", "Puerto" as "Puerto", "Tpaquete" as "Paquete", "Tmensaje" as "Tiempomensaje", "Tchequeo" as "Tiempochequeo", "Timeoutrec" as "Timeoutrecepcion", "Codshop" as "Shopping", "Codempre" as "Empresa", "Nrocaja" as "Caja", "Imporig" as "Imprimesolooriginal", "Numcomer" as "Numerocomercio", "Nomcomer" as "Nombrecomercio", "Cuitcomer" as "Cuitcomercio", "Permiteoff" as "Permitetransaccionesoffline", "Tiempoesp" as "Tiempodeespera", "Tiemporein" as "Tiempoporreintento", "Idcliente" as "Idcliente", "Usuariomp" as "Usuariomp", "Idsecreto" as "Idsecreto", "Bloqcieoff" as "Bloquearcierrecajaoffline", "Colector" as "Colector", "Puestoqr" as "Idpuestoqr", "Localmp" as "Localmp", "Storeqr" as "Idstoreqr", "Cajamp" as "Cajamp", "Leyenda" as "Leyenda", "Envsitef" as "Enviaventassitef", "Fiservip" as "Direccionip", "Fiservport" as "Puertofiserv", "Fiservemp" as "Empresafiserv", "Fiservterm" as "Terminalfiserv", "Fiservcert" as "Rutacertificado", "Dispfiserv" as "Dispositivofiserv", "Cloverid" as "Idcloverdisp", "Cloverip" as "Ipcloverdisp", "Cloverport" as "Puertocloverdisp", "Clovermod" as "Modeloclover", "Serialclov" as "Serialclover", "Idsmartl" as "Usuariosmartlapos", "Passsmartl" as "Passsmartlapos", "Guidstafe" as "Guidbilleterasantafe", "Frasestafe" as "Frasebilleterasantafe", "Cajastafe" as "Cajabilleterasantafe", "Sucstafe" as "Sucursalbilleterasantafe", "Urlstafe" as "Urlbilleterasantafe", "Cryptokey" as "Cryptoapikey", "Mailgocuot" as "Mailgocuotas", "Clavegocuo" as "Clavegocuotas", "Timeesppos" as "Tiempodeesperaposnet", "Rutaini" as "Rutaarchivoiniposnet", "Pregtarqr" as "Preguntatarjetaqr" from ZooLogic.POS where  funciones.padr( Codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  POS.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_POS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_POS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Tarjmad" as "Operadoradetarjeta", "Destarjmad" as "Operadoradetarjetadetalle", "Nrocomerci" as "Numerocomercio" from ZooLogic.POSDetalleTarj where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Simbolo" as "Simbolo", "Codmoneda" as "Codigodemoneda", "Descrip" as "Descripcion" from ZooLogic.POSMonedas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MonedasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MonedasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MonedasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Autoriz" as "Autorizador" from ZooLogic.ICARDTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion" from ZooLogic.ICARDAutoriz where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AutorizadoresICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AutorizadoresICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AutorizadoresICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Nrocomer" as "Numerocomercio" from ZooLogic.LAPOSTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dispmovil" as "Dispositivomovil", "Disponible" as "Disponible", "Sugerido" as "Sugerido", "Vincpdv" as "Vinculacionpdv" from ZooLogic.POINTDispMovil where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DispositivoMovilPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DispositivoMovilPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DispositivoMovilPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.FISERVTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasFiServDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasFiServDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasFiServDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Terminal" as "Terminal", "Disponible" as "Disponible", "Sugerido" as "Sugerido" from ZooLogic.LAPOSTerminal where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TerminalesSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TerminalesSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TerminalesSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.LAPOSPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Serial" as "Serial" from ZooLogic.POINTSerial where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SerialPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SerialPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SerialPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesSmartLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesSmartLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesSmartLaPosDetalle
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Dispositiv" as "Dispositivo", "Codigo" as "Codigo", "Obs" as "Observacion", "Contacto" as "Contactosoportetecnico", "Descrip" as "Descripcion", "Telsoporte" as "Telefonosoportetecnico", "Nrotermi" as "Numeroterminal", "Marca" as "Marca", "Modelo" as "Modelo", "Integrado" as "Integrado", "Prestador" as "Prestador", "Pagoelec" as "Pagoelectronico", "Puerto" as "Puerto", "Tpaquete" as "Paquete", "Tmensaje" as "Tiempomensaje", "Tchequeo" as "Tiempochequeo", "Timeoutrec" as "Timeoutrecepcion", "Codshop" as "Shopping", "Codempre" as "Empresa", "Nrocaja" as "Caja", "Imporig" as "Imprimesolooriginal", "Numcomer" as "Numerocomercio", "Nomcomer" as "Nombrecomercio", "Cuitcomer" as "Cuitcomercio", "Permiteoff" as "Permitetransaccionesoffline", "Tiempoesp" as "Tiempodeespera", "Tiemporein" as "Tiempoporreintento", "Idcliente" as "Idcliente", "Usuariomp" as "Usuariomp", "Idsecreto" as "Idsecreto", "Bloqcieoff" as "Bloquearcierrecajaoffline", "Colector" as "Colector", "Puestoqr" as "Idpuestoqr", "Localmp" as "Localmp", "Storeqr" as "Idstoreqr", "Cajamp" as "Cajamp", "Leyenda" as "Leyenda", "Envsitef" as "Enviaventassitef", "Fiservip" as "Direccionip", "Fiservport" as "Puertofiserv", "Fiservemp" as "Empresafiserv", "Fiservterm" as "Terminalfiserv", "Fiservcert" as "Rutacertificado", "Dispfiserv" as "Dispositivofiserv", "Cloverid" as "Idcloverdisp", "Cloverip" as "Ipcloverdisp", "Cloverport" as "Puertocloverdisp", "Clovermod" as "Modeloclover", "Serialclov" as "Serialclover", "Idsmartl" as "Usuariosmartlapos", "Passsmartl" as "Passsmartlapos", "Guidstafe" as "Guidbilleterasantafe", "Frasestafe" as "Frasebilleterasantafe", "Cajastafe" as "Cajabilleterasantafe", "Sucstafe" as "Sucursalbilleterasantafe", "Urlstafe" as "Urlbilleterasantafe", "Cryptokey" as "Cryptoapikey", "Mailgocuot" as "Mailgocuotas", "Clavegocuo" as "Clavegocuotas", "Timeesppos" as "Tiempodeesperaposnet", "Rutaini" as "Rutaarchivoiniposnet", "Pregtarqr" as "Preguntatarjetaqr" from ZooLogic.POS where  POS.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_POS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_POS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Tarjmad" as "Operadoradetarjeta", "Destarjmad" as "Operadoradetarjetadetalle", "Nrocomerci" as "Numerocomercio" from ZooLogic.POSDetalleTarj where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Simbolo" as "Simbolo", "Codmoneda" as "Codigodemoneda", "Descrip" as "Descripcion" from ZooLogic.POSMonedas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MonedasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MonedasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MonedasDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Autoriz" as "Autorizador" from ZooLogic.ICARDTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion" from ZooLogic.ICARDAutoriz where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AutorizadoresICardDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AutorizadoresICardDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AutorizadoresICardDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Nrocomer" as "Numerocomercio" from ZooLogic.LAPOSTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dispmovil" as "Dispositivomovil", "Disponible" as "Disponible", "Sugerido" as "Sugerido", "Vincpdv" as "Vinculacionpdv" from ZooLogic.POINTDispMovil where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DispositivoMovilPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DispositivoMovilPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DispositivoMovilPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.FISERVTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasFiServDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasFiServDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasFiServDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Terminal" as "Terminal", "Disponible" as "Disponible", "Sugerido" as "Sugerido" from ZooLogic.LAPOSTerminal where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TerminalesSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TerminalesSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TerminalesSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.LAPOSPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesLaPosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Serial" as "Serial" from ZooLogic.POINTSerial where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SerialPointDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SerialPointDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SerialPointDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLTarjetas where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_TarjetasSmartLaposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TarjetasSmartLaposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_TarjetasSmartLaposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.POSNETPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesPosnetDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesPosnetDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesPosnetDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora" from ZooLogic.SMARTLPlanes where Codigo = <<"'" + this.FormatearTextoSql( c_POS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PlanesSmartLaPosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PlanesSmartLaPosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PlanesSmartLaPosDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fecexpo,Fecimpo,Fectrans,Faltafw,Esttrans,Horaimpo,Horaexpo,Saltafw,Hmodifw,Haltafw," + ;
"Smodifw,Valtafw,Umodifw,Ualtafw,Bdmodifw,Zadsfw,Bdaltafw,Vmodifw,Dispositiv,Codigo,Obs,Contacto,Desc" + ;
"rip,Telsoporte,Nrotermi,Marca,Modelo,Integrado,Prestador,Pagoelec,Puerto,Tpaquete,Tmensaje,Tchequeo," + ;
"Timeoutrec,Codshop,Codempre,Nrocaja,Imporig,Numcomer,Nomcomer,Cuitcomer,Permiteoff,Tiempoesp,Tiempor" + ;
"ein,Idcliente,Usuariomp,Idsecreto,Bloqcieoff,Colector,Puestoqr,Localmp,Storeqr,Cajamp,Leyenda,Envsit" + ;
"ef,Fiservip,Fiservport,Fiservemp,Fiservterm,Fiservcert,Dispfiserv,Cloverid,Cloverip,Cloverport,Clove" + ;
"rmod,Serialclov,Idsmartl,Passsmartl,Guidstafe,Frasestafe,Cajastafe,Sucstafe,Urlstafe,Cryptokey,Mailg" + ;
"ocuot,Clavegocuo,Timeesppos,Rutaini,Pregtarqr" + ;
" from ZooLogic.POS where  POS.CODIGO != '' and " + lcFiltro )
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
			local  lxPosFmodifw, lxPosFecexpo, lxPosFecimpo, lxPosFectrans, lxPosFaltafw, lxPosEsttrans, lxPosHoraimpo, lxPosHoraexpo, lxPosSaltafw, lxPosHmodifw, lxPosHaltafw, lxPosSmodifw, lxPosValtafw, lxPosUmodifw, lxPosUaltafw, lxPosBdmodifw, lxPosZadsfw, lxPosBdaltafw, lxPosVmodifw, lxPosDispositiv, lxPosCodigo, lxPosObs, lxPosContacto, lxPosDescrip, lxPosTelsoporte, lxPosNrotermi, lxPosMarca, lxPosModelo, lxPosIntegrado, lxPosPrestador, lxPosPagoelec, lxPosPuerto, lxPosTpaquete, lxPosTmensaje, lxPosTchequeo, lxPosTimeoutrec, lxPosCodshop, lxPosCodempre, lxPosNrocaja, lxPosImporig, lxPosNumcomer, lxPosNomcomer, lxPosCuitcomer, lxPosPermiteoff, lxPosTiempoesp, lxPosTiemporein, lxPosIdcliente, lxPosUsuariomp, lxPosIdsecreto, lxPosBloqcieoff, lxPosColector, lxPosPuestoqr, lxPosLocalmp, lxPosStoreqr, lxPosCajamp, lxPosLeyenda, lxPosEnvsitef, lxPosFiservip, lxPosFiservport, lxPosFiservemp, lxPosFiservterm, lxPosFiservcert, lxPosDispfiserv, lxPosCloverid, lxPosCloverip, lxPosCloverport, lxPosClovermod, lxPosSerialclov, lxPosIdsmartl, lxPosPasssmartl, lxPosGuidstafe, lxPosFrasestafe, lxPosCajastafe, lxPosSucstafe, lxPosUrlstafe, lxPosCryptokey, lxPosMailgocuot, lxPosClavegocuo, lxPosTimeesppos, lxPosRutaini, lxPosPregtarqr
				lxPosFmodifw = ctod( '  /  /    ' )			lxPosFecexpo = ctod( '  /  /    ' )			lxPosFecimpo = ctod( '  /  /    ' )			lxPosFectrans = ctod( '  /  /    ' )			lxPosFaltafw = ctod( '  /  /    ' )			lxPosEsttrans = []			lxPosHoraimpo = []			lxPosHoraexpo = []			lxPosSaltafw = []			lxPosHmodifw = []			lxPosHaltafw = []			lxPosSmodifw = []			lxPosValtafw = []			lxPosUmodifw = []			lxPosUaltafw = []			lxPosBdmodifw = []			lxPosZadsfw = []			lxPosBdaltafw = []			lxPosVmodifw = []			lxPosDispositiv = []			lxPosCodigo = []			lxPosObs = []			lxPosContacto = []			lxPosDescrip = []			lxPosTelsoporte = []			lxPosNrotermi = 0			lxPosMarca = []			lxPosModelo = []			lxPosIntegrado = .F.			lxPosPrestador = []			lxPosPagoelec = .F.			lxPosPuerto = []			lxPosTpaquete = 0			lxPosTmensaje = 0			lxPosTchequeo = 0			lxPosTimeoutrec = 0			lxPosCodshop = 0			lxPosCodempre = 0			lxPosNrocaja = 0			lxPosImporig = .F.			lxPosNumcomer = 0			lxPosNomcomer = []			lxPosCuitcomer = []			lxPosPermiteoff = .F.			lxPosTiempoesp = 0			lxPosTiemporein = 0			lxPosIdcliente = []			lxPosUsuariomp = []			lxPosIdsecreto = []			lxPosBloqcieoff = .F.			lxPosColector = 0			lxPosPuestoqr = []			lxPosLocalmp = []			lxPosStoreqr = []			lxPosCajamp = []			lxPosLeyenda = []			lxPosEnvsitef = .F.			lxPosFiservip = []			lxPosFiservport = []			lxPosFiservemp = []			lxPosFiservterm = []			lxPosFiservcert = []			lxPosDispfiserv = []			lxPosCloverid = []			lxPosCloverip = []			lxPosCloverport = []			lxPosClovermod = []			lxPosSerialclov = []			lxPosIdsmartl = []			lxPosPasssmartl = []			lxPosGuidstafe = []			lxPosFrasestafe = []			lxPosCajastafe = []			lxPosSucstafe = []			lxPosUrlstafe = []			lxPosCryptokey = []			lxPosMailgocuot = []			lxPosClavegocuo = []			lxPosTimeesppos = 0			lxPosRutaini = []			lxPosPregtarqr = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POSDetalleTarj where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POSMonedas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ICARDTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ICARDAutoriz where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LAPOSTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POINTDispMovil where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.FISERVTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LAPOSTerminal where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POSNETTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.LAPOSPlanes where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POINTSerial where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SMARTLTarjetas where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.POSNETPlanes where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SMARTLPlanes where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.POS where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'POS' + '_' + tcCampo
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
		lcWhere = " Where  POS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Dispositiv" as "Dispositivo", "Codigo" as "Codigo", "Obs" as "Observacion", "Contacto" as "Contactosoportetecnico", "Descrip" as "Descripcion", "Telsoporte" as "Telefonosoportetecnico", "Nrotermi" as "Numeroterminal", "Marca" as "Marca", "Modelo" as "Modelo", "Integrado" as "Integrado", "Prestador" as "Prestador", "Pagoelec" as "Pagoelectronico", "Puerto" as "Puerto", "Tpaquete" as "Paquete", "Tmensaje" as "Tiempomensaje", "Tchequeo" as "Tiempochequeo", "Timeoutrec" as "Timeoutrecepcion", "Codshop" as "Shopping", "Codempre" as "Empresa", "Nrocaja" as "Caja", "Imporig" as "Imprimesolooriginal", "Numcomer" as "Numerocomercio", "Nomcomer" as "Nombrecomercio", "Cuitcomer" as "Cuitcomercio", "Permiteoff" as "Permitetransaccionesoffline", "Tiempoesp" as "Tiempodeespera", "Tiemporein" as "Tiempoporreintento", "Idcliente" as "Idcliente", "Usuariomp" as "Usuariomp", "Idsecreto" as "Idsecreto", "Bloqcieoff" as "Bloquearcierrecajaoffline", "Colector" as "Colector", "Puestoqr" as "Idpuestoqr", "Localmp" as "Localmp", "Storeqr" as "Idstoreqr", "Cajamp" as "Cajamp", "Leyenda" as "Leyenda", "Envsitef" as "Enviaventassitef", "Fiservip" as "Direccionip", "Fiservport" as "Puertofiserv", "Fiservemp" as "Empresafiserv", "Fiservterm" as "Terminalfiserv", "Fiservcert" as "Rutacertificado", "Dispfiserv" as "Dispositivofiserv", "Cloverid" as "Idcloverdisp", "Cloverip" as "Ipcloverdisp", "Cloverport" as "Puertocloverdisp", "Clovermod" as "Modeloclover", "Serialclov" as "Serialclover", "Idsmartl" as "Usuariosmartlapos", "Passsmartl" as "Passsmartlapos", "Guidstafe" as "Guidbilleterasantafe", "Frasestafe" as "Frasebilleterasantafe", "Cajastafe" as "Cajabilleterasantafe", "Sucstafe" as "Sucursalbilleterasantafe", "Urlstafe" as "Urlbilleterasantafe", "Cryptokey" as "Cryptoapikey", "Mailgocuot" as "Mailgocuotas", "Clavegocuo" as "Clavegocuotas", "Timeesppos" as "Tiempodeesperaposnet", "Rutaini" as "Rutaarchivoiniposnet", "Pregtarqr" as "Preguntatarjetaqr"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'POS', '', tnTope )
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
	Function ObtenerDatosDetalleTarjetasDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  POSDETALLETARJ.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Tarjmad" as "Operadoradetarjeta", "Destarjmad" as "Operadoradetarjetadetalle", "Nrocomerci" as "Numerocomercio"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleTarjetasDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'POSDetalleTarj', 'TarjetasDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleTarjetasDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleTarjetasDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleMonedasDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  POSMONEDAS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Simbolo" as "Simbolo", "Codmoneda" as "Codigodemoneda", "Descrip" as "Descripcion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleMonedasDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'POSMonedas', 'MonedasDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleMonedasDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleMonedasDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleTarjetasICardDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ICARDTARJETAS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Autoriz" as "Autorizador"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleTarjetasICardDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ICARDTarjetas', 'TarjetasICardDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleTarjetasICardDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleTarjetasICardDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleAutorizadoresICardDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ICARDAUTORIZ.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Numeroequivalencia", "Descrip" as "Descripcion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAutorizadoresICardDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ICARDAutoriz', 'AutorizadoresICardDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAutorizadoresICardDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAutorizadoresICardDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleTarjetasLaPosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LAPOSTARJETAS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora", "Nrocomer" as "Numerocomercio"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleTarjetasLaPosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LAPOSTarjetas', 'TarjetasLaPosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleTarjetasLaPosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleTarjetasLaPosDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDispositivoMovilPointDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  POINTDISPMOVIL.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Dispmovil" as "Dispositivomovil", "Disponible" as "Disponible", "Sugerido" as "Sugerido", "Vincpdv" as "Vinculacionpdv"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDispositivoMovilPointDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'POINTDispMovil', 'DispositivoMovilPointDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDispositivoMovilPointDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDispositivoMovilPointDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleTarjetasFiServDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  FISERVTARJETAS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleTarjetasFiServDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'FISERVTarjetas', 'TarjetasFiServDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleTarjetasFiServDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleTarjetasFiServDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleTerminalesSmartLaposDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LAPOSTERMINAL.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Terminal" as "Terminal", "Disponible" as "Disponible", "Sugerido" as "Sugerido"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleTerminalesSmartLaposDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LAPOSTerminal', 'TerminalesSmartLaposDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleTerminalesSmartLaposDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleTerminalesSmartLaposDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleTarjetasPosnetDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  POSNETTARJETAS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleTarjetasPosnetDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'POSNETTarjetas', 'TarjetasPosnetDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleTarjetasPosnetDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleTarjetasPosnetDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetallePlanesLaPosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LAPOSPLANES.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallePlanesLaPosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LAPOSPlanes', 'PlanesLaPosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallePlanesLaPosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallePlanesLaPosDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleSerialPointDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  POINTSERIAL.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Serial" as "Serial"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleSerialPointDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'POINTSerial', 'SerialPointDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleSerialPointDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleSerialPointDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleTarjetasSmartLaposDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  SMARTLTARJETAS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Equivalen" as "Codigoequivalencia", "Descrip" as "Descripcion", "Operadora" as "Operadora"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleTarjetasSmartLaposDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SMARTLTarjetas', 'TarjetasSmartLaposDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleTarjetasSmartLaposDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleTarjetasSmartLaposDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetallePlanesPosnetDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  POSNETPLANES.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallePlanesPosnetDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'POSNETPlanes', 'PlanesPosnetDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallePlanesPosnetDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallePlanesPosnetDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetallePlanesSmartLaPosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  SMARTLPLANES.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Codigoplan" as "Codigoplan", "Descrip" as "Descripcion", "Operadora" as "Operadora"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallePlanesSmartLaPosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SMARTLPlanes', 'PlanesSmartLaPosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallePlanesSmartLaPosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallePlanesSmartLaPosDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'DISPOSITIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISPOSITIV AS DISPOSITIVO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'CONTACTOSOPORTETECNICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONTACTO AS CONTACTOSOPORTETECNICO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'TELEFONOSOPORTETECNICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TELSOPORTE AS TELEFONOSOPORTETECNICO'
				Case lcAtributo == 'NUMEROTERMINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTERMI AS NUMEROTERMINAL'
				Case lcAtributo == 'MARCA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARCA AS MARCA'
				Case lcAtributo == 'MODELO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODELO AS MODELO'
				Case lcAtributo == 'INTEGRADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INTEGRADO AS INTEGRADO'
				Case lcAtributo == 'PRESTADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRESTADOR AS PRESTADOR'
				Case lcAtributo == 'PAGOELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGOELEC AS PAGOELECTRONICO'
				Case lcAtributo == 'PUERTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUERTO AS PUERTO'
				Case lcAtributo == 'PAQUETE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TPAQUETE AS PAQUETE'
				Case lcAtributo == 'TIEMPOMENSAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TMENSAJE AS TIEMPOMENSAJE'
				Case lcAtributo == 'TIEMPOCHEQUEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCHEQUEO AS TIEMPOCHEQUEO'
				Case lcAtributo == 'TIMEOUTRECEPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMEOUTREC AS TIMEOUTRECEPCION'
				Case lcAtributo == 'SHOPPING'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODSHOP AS SHOPPING'
				Case lcAtributo == 'EMPRESA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODEMPRE AS EMPRESA'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCAJA AS CAJA'
				Case lcAtributo == 'IMPRIMESOLOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORIG AS IMPRIMESOLOORIGINAL'
				Case lcAtributo == 'NUMEROCOMERCIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMER AS NUMEROCOMERCIO'
				Case lcAtributo == 'NOMBRECOMERCIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMCOMER AS NOMBRECOMERCIO'
				Case lcAtributo == 'CUITCOMERCIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUITCOMER AS CUITCOMERCIO'
				Case lcAtributo == 'PERMITETRANSACCIONESOFFLINE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERMITEOFF AS PERMITETRANSACCIONESOFFLINE'
				Case lcAtributo == 'TIEMPODEESPERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIEMPOESP AS TIEMPODEESPERA'
				Case lcAtributo == 'TIEMPOPORREINTENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIEMPOREIN AS TIEMPOPORREINTENTO'
				Case lcAtributo == 'IDCLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCLIENTE AS IDCLIENTE'
				Case lcAtributo == 'USUARIOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USUARIOMP AS USUARIOMP'
				Case lcAtributo == 'IDSECRETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDSECRETO AS IDSECRETO'
				Case lcAtributo == 'BLOQUEARCIERRECAJAOFFLINE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQCIEOFF AS BLOQUEARCIERRECAJAOFFLINE'
				Case lcAtributo == 'COLECTOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLECTOR AS COLECTOR'
				Case lcAtributo == 'IDPUESTOQR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUESTOQR AS IDPUESTOQR'
				Case lcAtributo == 'LOCALMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LOCALMP AS LOCALMP'
				Case lcAtributo == 'IDSTOREQR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'STOREQR AS IDSTOREQR'
				Case lcAtributo == 'CAJAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJAMP AS CAJAMP'
				Case lcAtributo == 'LEYENDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LEYENDA AS LEYENDA'
				Case lcAtributo == 'ENVIAVENTASSITEF'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENVSITEF AS ENVIAVENTASSITEF'
				Case lcAtributo == 'DIRECCIONIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FISERVIP AS DIRECCIONIP'
				Case lcAtributo == 'PUERTOFISERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FISERVPORT AS PUERTOFISERV'
				Case lcAtributo == 'EMPRESAFISERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FISERVEMP AS EMPRESAFISERV'
				Case lcAtributo == 'TERMINALFISERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FISERVTERM AS TERMINALFISERV'
				Case lcAtributo == 'RUTACERTIFICADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FISERVCERT AS RUTACERTIFICADO'
				Case lcAtributo == 'DISPOSITIVOFISERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISPFISERV AS DISPOSITIVOFISERV'
				Case lcAtributo == 'IDCLOVERDISP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOVERID AS IDCLOVERDISP'
				Case lcAtributo == 'IPCLOVERDISP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOVERIP AS IPCLOVERDISP'
				Case lcAtributo == 'PUERTOCLOVERDISP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOVERPORT AS PUERTOCLOVERDISP'
				Case lcAtributo == 'MODELOCLOVER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOVERMOD AS MODELOCLOVER'
				Case lcAtributo == 'SERIALCLOVER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIALCLOV AS SERIALCLOVER'
				Case lcAtributo == 'USUARIOSMARTLAPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDSMARTL AS USUARIOSMARTLAPOS'
				Case lcAtributo == 'PASSSMARTLAPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PASSSMARTL AS PASSSMARTLAPOS'
				Case lcAtributo == 'GUIDBILLETERASANTAFE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDSTAFE AS GUIDBILLETERASANTAFE'
				Case lcAtributo == 'FRASEBILLETERASANTAFE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FRASESTAFE AS FRASEBILLETERASANTAFE'
				Case lcAtributo == 'CAJABILLETERASANTAFE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJASTAFE AS CAJABILLETERASANTAFE'
				Case lcAtributo == 'SUCURSALBILLETERASANTAFE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCSTAFE AS SUCURSALBILLETERASANTAFE'
				Case lcAtributo == 'URLBILLETERASANTAFE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'URLSTAFE AS URLBILLETERASANTAFE'
				Case lcAtributo == 'CRYPTOAPIKEY'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRYPTOKEY AS CRYPTOAPIKEY'
				Case lcAtributo == 'MAILGOCUOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAILGOCUOT AS MAILGOCUOTAS'
				Case lcAtributo == 'CLAVEGOCUOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAVEGOCUO AS CLAVEGOCUOTAS'
				Case lcAtributo == 'TIEMPODEESPERAPOSNET'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMEESPPOS AS TIEMPODEESPERAPOSNET'
				Case lcAtributo == 'RUTAARCHIVOINIPOSNET'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUTAINI AS RUTAARCHIVOINIPOSNET'
				Case lcAtributo == 'PREGUNTATARJETAQR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PREGTARQR AS PREGUNTATARJETAQR'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleTarjetasDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OPERADORADETARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TARJMAD AS OPERADORADETARJETA'
				Case lcAtributo == 'OPERADORADETARJETADETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESTARJMAD AS OPERADORADETARJETADETALLE'
				Case lcAtributo == 'NUMEROCOMERCIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCOMERCI AS NUMEROCOMERCIO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleMonedasDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'SIMBOLO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBOLO AS SIMBOLO'
				Case lcAtributo == 'CODIGODEMONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODMONEDA AS CODIGODEMONEDA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleTarjetasICardDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NUMEROEQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIVALEN AS NUMEROEQUIVALENCIA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
				Case lcAtributo == 'AUTORIZADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTORIZ AS AUTORIZADOR'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAutorizadoresICardDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NUMEROEQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIVALEN AS NUMEROEQUIVALENCIA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleTarjetasLaPosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIGOEQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIVALEN AS CODIGOEQUIVALENCIA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
				Case lcAtributo == 'NUMEROCOMERCIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCOMER AS NUMEROCOMERCIO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDispositivoMovilPointDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DISPOSITIVOMOVIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISPMOVIL AS DISPOSITIVOMOVIL'
				Case lcAtributo == 'DISPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISPONIBLE AS DISPONIBLE'
				Case lcAtributo == 'SUGERIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUGERIDO AS SUGERIDO'
				Case lcAtributo == 'VINCULACIONPDV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VINCPDV AS VINCULACIONPDV'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleTarjetasFiServDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIGOEQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIVALEN AS CODIGOEQUIVALENCIA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleTerminalesSmartLaposDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TERMINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TERMINAL AS TERMINAL'
				Case lcAtributo == 'DISPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISPONIBLE AS DISPONIBLE'
				Case lcAtributo == 'SUGERIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUGERIDO AS SUGERIDO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleTarjetasPosnetDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIGOEQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIVALEN AS CODIGOEQUIVALENCIA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetallePlanesLaPosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIGOPLAN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOPLAN AS CODIGOPLAN'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleSerialPointDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'SERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIAL AS SERIAL'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleTarjetasSmartLaposDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIGOEQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIVALEN AS CODIGOEQUIVALENCIA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetallePlanesPosnetDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIGOPLAN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOPLAN AS CODIGOPLAN'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetallePlanesSmartLaPosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIGOPLAN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOPLAN AS CODIGOPLAN'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'OPERADORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADORA AS OPERADORA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DISPOSITIVO'
				lcCampo = 'DISPOSITIV'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'CONTACTOSOPORTETECNICO'
				lcCampo = 'CONTACTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONOSOPORTETECNICO'
				lcCampo = 'TELSOPORTE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTERMINAL'
				lcCampo = 'NROTERMI'
			Case upper( alltrim( tcAtributo ) ) == 'MARCA'
				lcCampo = 'MARCA'
			Case upper( alltrim( tcAtributo ) ) == 'MODELO'
				lcCampo = 'MODELO'
			Case upper( alltrim( tcAtributo ) ) == 'INTEGRADO'
				lcCampo = 'INTEGRADO'
			Case upper( alltrim( tcAtributo ) ) == 'PRESTADOR'
				lcCampo = 'PRESTADOR'
			Case upper( alltrim( tcAtributo ) ) == 'PAGOELECTRONICO'
				lcCampo = 'PAGOELEC'
			Case upper( alltrim( tcAtributo ) ) == 'PUERTO'
				lcCampo = 'PUERTO'
			Case upper( alltrim( tcAtributo ) ) == 'PAQUETE'
				lcCampo = 'TPAQUETE'
			Case upper( alltrim( tcAtributo ) ) == 'TIEMPOMENSAJE'
				lcCampo = 'TMENSAJE'
			Case upper( alltrim( tcAtributo ) ) == 'TIEMPOCHEQUEO'
				lcCampo = 'TCHEQUEO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMEOUTRECEPCION'
				lcCampo = 'TIMEOUTREC'
			Case upper( alltrim( tcAtributo ) ) == 'SHOPPING'
				lcCampo = 'CODSHOP'
			Case upper( alltrim( tcAtributo ) ) == 'EMPRESA'
				lcCampo = 'CODEMPRE'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'NROCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMESOLOORIGINAL'
				lcCampo = 'IMPORIG'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMERCIO'
				lcCampo = 'NUMCOMER'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRECOMERCIO'
				lcCampo = 'NOMCOMER'
			Case upper( alltrim( tcAtributo ) ) == 'CUITCOMERCIO'
				lcCampo = 'CUITCOMER'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITETRANSACCIONESOFFLINE'
				lcCampo = 'PERMITEOFF'
			Case upper( alltrim( tcAtributo ) ) == 'TIEMPODEESPERA'
				lcCampo = 'TIEMPOESP'
			Case upper( alltrim( tcAtributo ) ) == 'TIEMPOPORREINTENTO'
				lcCampo = 'TIEMPOREIN'
			Case upper( alltrim( tcAtributo ) ) == 'IDCLIENTE'
				lcCampo = 'IDCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMP'
				lcCampo = 'USUARIOMP'
			Case upper( alltrim( tcAtributo ) ) == 'IDSECRETO'
				lcCampo = 'IDSECRETO'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARCIERRECAJAOFFLINE'
				lcCampo = 'BLOQCIEOFF'
			Case upper( alltrim( tcAtributo ) ) == 'COLECTOR'
				lcCampo = 'COLECTOR'
			Case upper( alltrim( tcAtributo ) ) == 'IDPUESTOQR'
				lcCampo = 'PUESTOQR'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALMP'
				lcCampo = 'LOCALMP'
			Case upper( alltrim( tcAtributo ) ) == 'IDSTOREQR'
				lcCampo = 'STOREQR'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAMP'
				lcCampo = 'CAJAMP'
			Case upper( alltrim( tcAtributo ) ) == 'LEYENDA'
				lcCampo = 'LEYENDA'
			Case upper( alltrim( tcAtributo ) ) == 'ENVIAVENTASSITEF'
				lcCampo = 'ENVSITEF'
			Case upper( alltrim( tcAtributo ) ) == 'DIRECCIONIP'
				lcCampo = 'FISERVIP'
			Case upper( alltrim( tcAtributo ) ) == 'PUERTOFISERV'
				lcCampo = 'FISERVPORT'
			Case upper( alltrim( tcAtributo ) ) == 'EMPRESAFISERV'
				lcCampo = 'FISERVEMP'
			Case upper( alltrim( tcAtributo ) ) == 'TERMINALFISERV'
				lcCampo = 'FISERVTERM'
			Case upper( alltrim( tcAtributo ) ) == 'RUTACERTIFICADO'
				lcCampo = 'FISERVCERT'
			Case upper( alltrim( tcAtributo ) ) == 'DISPOSITIVOFISERV'
				lcCampo = 'DISPFISERV'
			Case upper( alltrim( tcAtributo ) ) == 'IDCLOVERDISP'
				lcCampo = 'CLOVERID'
			Case upper( alltrim( tcAtributo ) ) == 'IPCLOVERDISP'
				lcCampo = 'CLOVERIP'
			Case upper( alltrim( tcAtributo ) ) == 'PUERTOCLOVERDISP'
				lcCampo = 'CLOVERPORT'
			Case upper( alltrim( tcAtributo ) ) == 'MODELOCLOVER'
				lcCampo = 'CLOVERMOD'
			Case upper( alltrim( tcAtributo ) ) == 'SERIALCLOVER'
				lcCampo = 'SERIALCLOV'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOSMARTLAPOS'
				lcCampo = 'IDSMARTL'
			Case upper( alltrim( tcAtributo ) ) == 'PASSSMARTLAPOS'
				lcCampo = 'PASSSMARTL'
			Case upper( alltrim( tcAtributo ) ) == 'GUIDBILLETERASANTAFE'
				lcCampo = 'GUIDSTAFE'
			Case upper( alltrim( tcAtributo ) ) == 'FRASEBILLETERASANTAFE'
				lcCampo = 'FRASESTAFE'
			Case upper( alltrim( tcAtributo ) ) == 'CAJABILLETERASANTAFE'
				lcCampo = 'CAJASTAFE'
			Case upper( alltrim( tcAtributo ) ) == 'SUCURSALBILLETERASANTAFE'
				lcCampo = 'SUCSTAFE'
			Case upper( alltrim( tcAtributo ) ) == 'URLBILLETERASANTAFE'
				lcCampo = 'URLSTAFE'
			Case upper( alltrim( tcAtributo ) ) == 'CRYPTOAPIKEY'
				lcCampo = 'CRYPTOKEY'
			Case upper( alltrim( tcAtributo ) ) == 'MAILGOCUOTAS'
				lcCampo = 'MAILGOCUOT'
			Case upper( alltrim( tcAtributo ) ) == 'CLAVEGOCUOTAS'
				lcCampo = 'CLAVEGOCUO'
			Case upper( alltrim( tcAtributo ) ) == 'TIEMPODEESPERAPOSNET'
				lcCampo = 'TIMEESPPOS'
			Case upper( alltrim( tcAtributo ) ) == 'RUTAARCHIVOINIPOSNET'
				lcCampo = 'RUTAINI'
			Case upper( alltrim( tcAtributo ) ) == 'PREGUNTATARJETAQR'
				lcCampo = 'PREGTARQR'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleTarjetasDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORADETARJETA'
				lcCampo = 'TARJMAD'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORADETARJETADETALLE'
				lcCampo = 'DESTARJMAD'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMERCIO'
				lcCampo = 'NROCOMERCI'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleMonedasDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLO'
				lcCampo = 'SIMBOLO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGODEMONEDA'
				lcCampo = 'CODMONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleTarjetasICardDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROEQUIVALENCIA'
				lcCampo = 'EQUIVALEN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZADOR'
				lcCampo = 'AUTORIZ'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAutorizadoresICardDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROEQUIVALENCIA'
				lcCampo = 'EQUIVALEN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleTarjetasLaPosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOEQUIVALENCIA'
				lcCampo = 'EQUIVALEN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMERCIO'
				lcCampo = 'NROCOMER'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDispositivoMovilPointDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DISPOSITIVOMOVIL'
				lcCampo = 'DISPMOVIL'
			Case upper( alltrim( tcAtributo ) ) == 'DISPONIBLE'
				lcCampo = 'DISPONIBLE'
			Case upper( alltrim( tcAtributo ) ) == 'SUGERIDO'
				lcCampo = 'SUGERIDO'
			Case upper( alltrim( tcAtributo ) ) == 'VINCULACIONPDV'
				lcCampo = 'VINCPDV'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleTarjetasFiServDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOEQUIVALENCIA'
				lcCampo = 'EQUIVALEN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleTerminalesSmartLaposDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TERMINAL'
				lcCampo = 'TERMINAL'
			Case upper( alltrim( tcAtributo ) ) == 'DISPONIBLE'
				lcCampo = 'DISPONIBLE'
			Case upper( alltrim( tcAtributo ) ) == 'SUGERIDO'
				lcCampo = 'SUGERIDO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleTarjetasPosnetDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOEQUIVALENCIA'
				lcCampo = 'EQUIVALEN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetallePlanesLaPosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPLAN'
				lcCampo = 'CODIGOPLAN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleSerialPointDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIAL'
				lcCampo = 'SERIAL'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleTarjetasSmartLaposDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOEQUIVALENCIA'
				lcCampo = 'EQUIVALEN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetallePlanesPosnetDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPLAN'
				lcCampo = 'CODIGOPLAN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetallePlanesSmartLaPosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPLAN'
				lcCampo = 'CODIGOPLAN'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORA'
				lcCampo = 'OPERADORA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'TARJETASDETALLE'
			lcRetorno = 'POSDETALLETARJ'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'MONEDASDETALLE'
			lcRetorno = 'POSMONEDAS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'TARJETASICARDDETALLE'
			lcRetorno = 'ICARDTARJETAS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'AUTORIZADORESICARDDETALLE'
			lcRetorno = 'ICARDAUTORIZ'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'TARJETASLAPOSDETALLE'
			lcRetorno = 'LAPOSTARJETAS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DISPOSITIVOMOVILPOINTDETALLE'
			lcRetorno = 'POINTDISPMOVIL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'TARJETASFISERVDETALLE'
			lcRetorno = 'FISERVTARJETAS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'TERMINALESSMARTLAPOSDETALLE'
			lcRetorno = 'LAPOSTERMINAL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'TARJETASPOSNETDETALLE'
			lcRetorno = 'POSNETTARJETAS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'PLANESLAPOSDETALLE'
			lcRetorno = 'LAPOSPLANES'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'SERIALPOINTDETALLE'
			lcRetorno = 'POINTSERIAL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'TARJETASSMARTLAPOSDETALLE'
			lcRetorno = 'SMARTLTARJETAS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'PLANESPOSNETDETALLE'
			lcRetorno = 'POSNETPLANES'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'PLANESSMARTLAPOSDETALLE'
			lcRetorno = 'SMARTLPLANES'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxPosFmodifw, lxPosFecexpo, lxPosFecimpo, lxPosFectrans, lxPosFaltafw, lxPosEsttrans, lxPosHoraimpo, lxPosHoraexpo, lxPosSaltafw, lxPosHmodifw, lxPosHaltafw, lxPosSmodifw, lxPosValtafw, lxPosUmodifw, lxPosUaltafw, lxPosBdmodifw, lxPosZadsfw, lxPosBdaltafw, lxPosVmodifw, lxPosDispositiv, lxPosCodigo, lxPosObs, lxPosContacto, lxPosDescrip, lxPosTelsoporte, lxPosNrotermi, lxPosMarca, lxPosModelo, lxPosIntegrado, lxPosPrestador, lxPosPagoelec, lxPosPuerto, lxPosTpaquete, lxPosTmensaje, lxPosTchequeo, lxPosTimeoutrec, lxPosCodshop, lxPosCodempre, lxPosNrocaja, lxPosImporig, lxPosNumcomer, lxPosNomcomer, lxPosCuitcomer, lxPosPermiteoff, lxPosTiempoesp, lxPosTiemporein, lxPosIdcliente, lxPosUsuariomp, lxPosIdsecreto, lxPosBloqcieoff, lxPosColector, lxPosPuestoqr, lxPosLocalmp, lxPosStoreqr, lxPosCajamp, lxPosLeyenda, lxPosEnvsitef, lxPosFiservip, lxPosFiservport, lxPosFiservemp, lxPosFiservterm, lxPosFiservcert, lxPosDispfiserv, lxPosCloverid, lxPosCloverip, lxPosCloverport, lxPosClovermod, lxPosSerialclov, lxPosIdsmartl, lxPosPasssmartl, lxPosGuidstafe, lxPosFrasestafe, lxPosCajastafe, lxPosSucstafe, lxPosUrlstafe, lxPosCryptokey, lxPosMailgocuot, lxPosClavegocuo, lxPosTimeesppos, lxPosRutaini, lxPosPregtarqr
				lxPosFmodifw =  .Fechamodificacionfw			lxPosFecexpo =  .Fechaexpo			lxPosFecimpo =  .Fechaimpo			lxPosFectrans =  .Fechatransferencia			lxPosFaltafw =  .Fechaaltafw			lxPosEsttrans =  .Estadotransferencia			lxPosHoraimpo =  .Horaimpo			lxPosHoraexpo =  .Horaexpo			lxPosSaltafw =  .Seriealtafw			lxPosHmodifw =  .Horamodificacionfw			lxPosHaltafw =  .Horaaltafw			lxPosSmodifw =  .Seriemodificacionfw			lxPosValtafw =  .Versionaltafw			lxPosUmodifw =  .Usuariomodificacionfw			lxPosUaltafw =  .Usuarioaltafw			lxPosBdmodifw =  .Basededatosmodificacionfw			lxPosZadsfw =  .Zadsfw			lxPosBdaltafw =  .Basededatosaltafw			lxPosVmodifw =  .Versionmodificacionfw			lxPosDispositiv =  .Dispositivo			lxPosCodigo =  .Codigo			lxPosObs =  .Observacion			lxPosContacto =  .Contactosoportetecnico			lxPosDescrip =  .Descripcion			lxPosTelsoporte =  .Telefonosoportetecnico			lxPosNrotermi =  .Numeroterminal			lxPosMarca =  .Marca			lxPosModelo =  .Modelo			lxPosIntegrado =  .Integrado			lxPosPrestador =  .Prestador			lxPosPagoelec =  .Pagoelectronico			lxPosPuerto =  .Puerto			lxPosTpaquete =  .Paquete			lxPosTmensaje =  .Tiempomensaje			lxPosTchequeo =  .Tiempochequeo			lxPosTimeoutrec =  .Timeoutrecepcion			lxPosCodshop =  .Shopping			lxPosCodempre =  .Empresa			lxPosNrocaja =  .Caja			lxPosImporig =  .Imprimesolooriginal			lxPosNumcomer =  .Numerocomercio			lxPosNomcomer =  .Nombrecomercio			lxPosCuitcomer =  .Cuitcomercio			lxPosPermiteoff =  .Permitetransaccionesoffline			lxPosTiempoesp =  .Tiempodeespera			lxPosTiemporein =  .Tiempoporreintento			lxPosIdcliente =  .Idcliente			lxPosUsuariomp =  .Usuariomp			lxPosIdsecreto =  .Idsecreto			lxPosBloqcieoff =  .Bloquearcierrecajaoffline			lxPosColector =  .Colector			lxPosPuestoqr =  .Idpuestoqr			lxPosLocalmp =  .Localmp			lxPosStoreqr =  .Idstoreqr			lxPosCajamp =  .Cajamp			lxPosLeyenda =  .Leyenda			lxPosEnvsitef =  .Enviaventassitef			lxPosFiservip =  .Direccionip			lxPosFiservport =  .Puertofiserv			lxPosFiservemp =  .Empresafiserv			lxPosFiservterm =  .Terminalfiserv			lxPosFiservcert =  .Rutacertificado			lxPosDispfiserv =  .Dispositivofiserv			lxPosCloverid =  .Idcloverdisp			lxPosCloverip =  .Ipcloverdisp			lxPosCloverport =  .Puertocloverdisp			lxPosClovermod =  .Modeloclover			lxPosSerialclov =  .Serialclover			lxPosIdsmartl =  .Usuariosmartlapos			lxPosPasssmartl =  .Passsmartlapos			lxPosGuidstafe =  .Guidbilleterasantafe			lxPosFrasestafe =  .Frasebilleterasantafe			lxPosCajastafe =  .Cajabilleterasantafe			lxPosSucstafe =  .Sucursalbilleterasantafe			lxPosUrlstafe =  .Urlbilleterasantafe			lxPosCryptokey =  .Cryptoapikey			lxPosMailgocuot =  .Mailgocuotas			lxPosClavegocuo =  .Clavegocuotas			lxPosTimeesppos =  .Tiempodeesperaposnet			lxPosRutaini =  .Rutaarchivoiniposnet			lxPosPregtarqr =  .Preguntatarjetaqr
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.POS ( "Fmodifw","Fecexpo","Fecimpo","Fectrans","Faltafw","Esttrans","Horaimpo","Horaexpo","Saltafw","Hmodifw","Haltafw","Smodifw","Valtafw","Umodifw","Ualtafw","Bdmodifw","Zadsfw","Bdaltafw","Vmodifw","Dispositiv","Codigo","Obs","Contacto","Descrip","Telsoporte","Nrotermi","Marca","Modelo","Integrado","Prestador","Pagoelec","Puerto","Tpaquete","Tmensaje","Tchequeo","Timeoutrec","Codshop","Codempre","Nrocaja","Imporig","Numcomer","Nomcomer","Cuitcomer","Permiteoff","Tiempoesp","Tiemporein","Idcliente","Usuariomp","Idsecreto","Bloqcieoff","Colector","Puestoqr","Localmp","Storeqr","Cajamp","Leyenda","Envsitef","Fiservip","Fiservport","Fiservemp","Fiservterm","Fiservcert","Dispfiserv","Cloverid","Cloverip","Cloverport","Clovermod","Serialclov","Idsmartl","Passsmartl","Guidstafe","Frasestafe","Cajastafe","Sucstafe","Urlstafe","Cryptokey","Mailgocuot","Clavegocuo","Timeesppos","Rutaini","Pregtarqr" ) values ( <<"'" + this.ConvertirDateSql( lxPosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPosFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPosFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosDispositiv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosContacto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosTelsoporte ) + "'" >>, <<lxPosNrotermi >>, <<"'" + this.FormatearTextoSql( lxPosMarca ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosModelo ) + "'" >>, <<iif( lxPosIntegrado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPosPrestador ) + "'" >>, <<iif( lxPosPagoelec, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPosPuerto ) + "'" >>, <<lxPosTpaquete >>, <<lxPosTmensaje >>, <<lxPosTchequeo >>, <<lxPosTimeoutrec >>, <<lxPosCodshop >>, <<lxPosCodempre >>, <<lxPosNrocaja >>, <<iif( lxPosImporig, 1, 0 ) >>, <<lxPosNumcomer >>, <<"'" + this.FormatearTextoSql( lxPosNomcomer ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCuitcomer ) + "'" >>, <<iif( lxPosPermiteoff, 1, 0 ) >>, <<lxPosTiempoesp >>, <<lxPosTiemporein >>, <<"'" + this.FormatearTextoSql( lxPosIdcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosUsuariomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosIdsecreto ) + "'" >>, <<iif( lxPosBloqcieoff, 1, 0 ) >>, <<lxPosColector >>, <<"'" + this.FormatearTextoSql( lxPosPuestoqr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosLocalmp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosStoreqr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCajamp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosLeyenda ) + "'" >>, <<iif( lxPosEnvsitef, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPosFiservip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFiservport ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFiservemp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFiservterm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFiservcert ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosDispfiserv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCloverid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCloverip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCloverport ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosClovermod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosSerialclov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosIdsmartl ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosPasssmartl ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosGuidstafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosFrasestafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCajastafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosSucstafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosUrlstafe ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosCryptokey ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosMailgocuot ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPosClavegocuo ) + "'" >>, <<lxPosTimeesppos >>, <<"'" + this.FormatearTextoSql( lxPosRutaini ) + "'" >>, <<lxPosPregtarqr >> )
		endtext
		loColeccion.cTabla = 'POS' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasDetalle
				if this.oEntidad.TarjetasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxOperadoradetarjeta_PK = loItem.Operadoradetarjeta_PK
					lxOperadoradetarjetadetalle = loItem.Operadoradetarjetadetalle
					lxNumerocomercio = loItem.Numerocomercio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSDetalleTarj("NROITEM","Codigo","TarjMad","DesTarjMad","NroComerci" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxOperadoradetarjeta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadoradetarjetadetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocomercio ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MonedasDetalle
				if this.oEntidad.MonedasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSimbolo = loItem.Simbolo
					lxCodigodemoneda_PK = loItem.Codigodemoneda_PK
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSMonedas("NROITEM","Codigo","Simbolo","CodMoneda","Descrip" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSimbolo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodemoneda_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasICardDetalle
				if this.oEntidad.TarjetasICardDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumeroequivalencia = loItem.Numeroequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					lxAutorizador = loItem.Autorizador
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ICARDTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora","Autoriz" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxNumeroequivalencia>>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">>, <<lxAutorizador>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AutorizadoresICardDetalle
				if this.oEntidad.AutorizadoresICardDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumeroequivalencia = loItem.Numeroequivalencia
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ICARDAutoriz("NROITEM","Codigo","Equivalen","Descrip" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxNumeroequivalencia>>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasLaPosDetalle
				if this.oEntidad.TarjetasLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					lxNumerocomercio = loItem.Numerocomercio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora","NroComer" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">>, <<lxNumerocomercio>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DispositivoMovilPointDetalle
				if this.oEntidad.DispositivoMovilPointDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxDispositivomovil = loItem.Dispositivomovil
					lxDisponible = loItem.Disponible
					lxSugerido = loItem.Sugerido
					lxVinculacionpdv = loItem.Vinculacionpdv
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POINTDispMovil("NROITEM","Codigo","DispMovil","Disponible","Sugerido","VincPDV" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDispositivomovil ) + "'">>, <<iif( lxDisponible, 1, 0 )>>, <<iif( lxSugerido, 1, 0 )>>, <<iif( lxVinculacionpdv, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasFiServDetalle
				if this.oEntidad.TarjetasFiServDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FISERVTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TerminalesSmartLaposDetalle
				if this.oEntidad.TerminalesSmartLaposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminal = loItem.Terminal
					lxDisponible = loItem.Disponible
					lxSugerido = loItem.Sugerido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSTerminal("NROITEM","Codigo","Terminal","Disponible","Sugerido" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTerminal ) + "'">>, <<iif( lxDisponible, 1, 0 )>>, <<iif( lxSugerido, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasPosnetDetalle
				if this.oEntidad.TarjetasPosnetDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSNETTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesLaPosDetalle
				if this.oEntidad.PlanesLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SerialPointDetalle
				if this.oEntidad.SerialPointDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSerial = loItem.Serial
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POINTSerial("NROITEM","Codigo","Serial" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSerial ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasSmartLaposDetalle
				if this.oEntidad.TarjetasSmartLaposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SMARTLTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesPosnetDetalle
				if this.oEntidad.PlanesPosnetDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSNETPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesSmartLaPosDetalle
				if this.oEntidad.PlanesSmartLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SMARTLPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
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
			local  lxPosFmodifw, lxPosFecexpo, lxPosFecimpo, lxPosFectrans, lxPosFaltafw, lxPosEsttrans, lxPosHoraimpo, lxPosHoraexpo, lxPosSaltafw, lxPosHmodifw, lxPosHaltafw, lxPosSmodifw, lxPosValtafw, lxPosUmodifw, lxPosUaltafw, lxPosBdmodifw, lxPosZadsfw, lxPosBdaltafw, lxPosVmodifw, lxPosDispositiv, lxPosCodigo, lxPosObs, lxPosContacto, lxPosDescrip, lxPosTelsoporte, lxPosNrotermi, lxPosMarca, lxPosModelo, lxPosIntegrado, lxPosPrestador, lxPosPagoelec, lxPosPuerto, lxPosTpaquete, lxPosTmensaje, lxPosTchequeo, lxPosTimeoutrec, lxPosCodshop, lxPosCodempre, lxPosNrocaja, lxPosImporig, lxPosNumcomer, lxPosNomcomer, lxPosCuitcomer, lxPosPermiteoff, lxPosTiempoesp, lxPosTiemporein, lxPosIdcliente, lxPosUsuariomp, lxPosIdsecreto, lxPosBloqcieoff, lxPosColector, lxPosPuestoqr, lxPosLocalmp, lxPosStoreqr, lxPosCajamp, lxPosLeyenda, lxPosEnvsitef, lxPosFiservip, lxPosFiservport, lxPosFiservemp, lxPosFiservterm, lxPosFiservcert, lxPosDispfiserv, lxPosCloverid, lxPosCloverip, lxPosCloverport, lxPosClovermod, lxPosSerialclov, lxPosIdsmartl, lxPosPasssmartl, lxPosGuidstafe, lxPosFrasestafe, lxPosCajastafe, lxPosSucstafe, lxPosUrlstafe, lxPosCryptokey, lxPosMailgocuot, lxPosClavegocuo, lxPosTimeesppos, lxPosRutaini, lxPosPregtarqr
				lxPosFmodifw =  .Fechamodificacionfw			lxPosFecexpo =  .Fechaexpo			lxPosFecimpo =  .Fechaimpo			lxPosFectrans =  .Fechatransferencia			lxPosFaltafw =  .Fechaaltafw			lxPosEsttrans =  .Estadotransferencia			lxPosHoraimpo =  .Horaimpo			lxPosHoraexpo =  .Horaexpo			lxPosSaltafw =  .Seriealtafw			lxPosHmodifw =  .Horamodificacionfw			lxPosHaltafw =  .Horaaltafw			lxPosSmodifw =  .Seriemodificacionfw			lxPosValtafw =  .Versionaltafw			lxPosUmodifw =  .Usuariomodificacionfw			lxPosUaltafw =  .Usuarioaltafw			lxPosBdmodifw =  .Basededatosmodificacionfw			lxPosZadsfw =  .Zadsfw			lxPosBdaltafw =  .Basededatosaltafw			lxPosVmodifw =  .Versionmodificacionfw			lxPosDispositiv =  .Dispositivo			lxPosCodigo =  .Codigo			lxPosObs =  .Observacion			lxPosContacto =  .Contactosoportetecnico			lxPosDescrip =  .Descripcion			lxPosTelsoporte =  .Telefonosoportetecnico			lxPosNrotermi =  .Numeroterminal			lxPosMarca =  .Marca			lxPosModelo =  .Modelo			lxPosIntegrado =  .Integrado			lxPosPrestador =  .Prestador			lxPosPagoelec =  .Pagoelectronico			lxPosPuerto =  .Puerto			lxPosTpaquete =  .Paquete			lxPosTmensaje =  .Tiempomensaje			lxPosTchequeo =  .Tiempochequeo			lxPosTimeoutrec =  .Timeoutrecepcion			lxPosCodshop =  .Shopping			lxPosCodempre =  .Empresa			lxPosNrocaja =  .Caja			lxPosImporig =  .Imprimesolooriginal			lxPosNumcomer =  .Numerocomercio			lxPosNomcomer =  .Nombrecomercio			lxPosCuitcomer =  .Cuitcomercio			lxPosPermiteoff =  .Permitetransaccionesoffline			lxPosTiempoesp =  .Tiempodeespera			lxPosTiemporein =  .Tiempoporreintento			lxPosIdcliente =  .Idcliente			lxPosUsuariomp =  .Usuariomp			lxPosIdsecreto =  .Idsecreto			lxPosBloqcieoff =  .Bloquearcierrecajaoffline			lxPosColector =  .Colector			lxPosPuestoqr =  .Idpuestoqr			lxPosLocalmp =  .Localmp			lxPosStoreqr =  .Idstoreqr			lxPosCajamp =  .Cajamp			lxPosLeyenda =  .Leyenda			lxPosEnvsitef =  .Enviaventassitef			lxPosFiservip =  .Direccionip			lxPosFiservport =  .Puertofiserv			lxPosFiservemp =  .Empresafiserv			lxPosFiservterm =  .Terminalfiserv			lxPosFiservcert =  .Rutacertificado			lxPosDispfiserv =  .Dispositivofiserv			lxPosCloverid =  .Idcloverdisp			lxPosCloverip =  .Ipcloverdisp			lxPosCloverport =  .Puertocloverdisp			lxPosClovermod =  .Modeloclover			lxPosSerialclov =  .Serialclover			lxPosIdsmartl =  .Usuariosmartlapos			lxPosPasssmartl =  .Passsmartlapos			lxPosGuidstafe =  .Guidbilleterasantafe			lxPosFrasestafe =  .Frasebilleterasantafe			lxPosCajastafe =  .Cajabilleterasantafe			lxPosSucstafe =  .Sucursalbilleterasantafe			lxPosUrlstafe =  .Urlbilleterasantafe			lxPosCryptokey =  .Cryptoapikey			lxPosMailgocuot =  .Mailgocuotas			lxPosClavegocuo =  .Clavegocuotas			lxPosTimeesppos =  .Tiempodeesperaposnet			lxPosRutaini =  .Rutaarchivoiniposnet			lxPosPregtarqr =  .Preguntatarjetaqr
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  POS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.POS set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPosFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPosFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPosFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxPosFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxPosFaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxPosEsttrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxPosHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxPosHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxPosSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxPosHmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxPosHaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxPosSmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxPosValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxPosUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxPosUaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPosBdmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxPosZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPosBdaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxPosVmodifw ) + "'">>, "Dispositiv" = <<"'" + this.FormatearTextoSql( lxPosDispositiv ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxPosCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxPosObs ) + "'">>, "Contacto" = <<"'" + this.FormatearTextoSql( lxPosContacto ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxPosDescrip ) + "'">>, "Telsoporte" = <<"'" + this.FormatearTextoSql( lxPosTelsoporte ) + "'">>, "Nrotermi" = <<lxPosNrotermi>>, "Marca" = <<"'" + this.FormatearTextoSql( lxPosMarca ) + "'">>, "Modelo" = <<"'" + this.FormatearTextoSql( lxPosModelo ) + "'">>, "Integrado" = <<iif( lxPosIntegrado, 1, 0 )>>, "Prestador" = <<"'" + this.FormatearTextoSql( lxPosPrestador ) + "'">>, "Pagoelec" = <<iif( lxPosPagoelec, 1, 0 )>>, "Puerto" = <<"'" + this.FormatearTextoSql( lxPosPuerto ) + "'">>, "Tpaquete" = <<lxPosTpaquete>>, "Tmensaje" = <<lxPosTmensaje>>, "Tchequeo" = <<lxPosTchequeo>>, "Timeoutrec" = <<lxPosTimeoutrec>>, "Codshop" = <<lxPosCodshop>>, "Codempre" = <<lxPosCodempre>>, "Nrocaja" = <<lxPosNrocaja>>, "Imporig" = <<iif( lxPosImporig, 1, 0 )>>, "Numcomer" = <<lxPosNumcomer>>, "Nomcomer" = <<"'" + this.FormatearTextoSql( lxPosNomcomer ) + "'">>, "Cuitcomer" = <<"'" + this.FormatearTextoSql( lxPosCuitcomer ) + "'">>, "Permiteoff" = <<iif( lxPosPermiteoff, 1, 0 )>>, "Tiempoesp" = <<lxPosTiempoesp>>, "Tiemporein" = <<lxPosTiemporein>>, "Idcliente" = <<"'" + this.FormatearTextoSql( lxPosIdcliente ) + "'">>, "Usuariomp" = <<"'" + this.FormatearTextoSql( lxPosUsuariomp ) + "'">>, "Idsecreto" = <<"'" + this.FormatearTextoSql( lxPosIdsecreto ) + "'">>, "Bloqcieoff" = <<iif( lxPosBloqcieoff, 1, 0 )>>, "Colector" = <<lxPosColector>>, "Puestoqr" = <<"'" + this.FormatearTextoSql( lxPosPuestoqr ) + "'">>, "Localmp" = <<"'" + this.FormatearTextoSql( lxPosLocalmp ) + "'">>, "Storeqr" = <<"'" + this.FormatearTextoSql( lxPosStoreqr ) + "'">>, "Cajamp" = <<"'" + this.FormatearTextoSql( lxPosCajamp ) + "'">>, "Leyenda" = <<"'" + this.FormatearTextoSql( lxPosLeyenda ) + "'">>, "Envsitef" = <<iif( lxPosEnvsitef, 1, 0 )>>, "Fiservip" = <<"'" + this.FormatearTextoSql( lxPosFiservip ) + "'">>, "Fiservport" = <<"'" + this.FormatearTextoSql( lxPosFiservport ) + "'">>, "Fiservemp" = <<"'" + this.FormatearTextoSql( lxPosFiservemp ) + "'">>, "Fiservterm" = <<"'" + this.FormatearTextoSql( lxPosFiservterm ) + "'">>, "Fiservcert" = <<"'" + this.FormatearTextoSql( lxPosFiservcert ) + "'">>, "Dispfiserv" = <<"'" + this.FormatearTextoSql( lxPosDispfiserv ) + "'">>, "Cloverid" = <<"'" + this.FormatearTextoSql( lxPosCloverid ) + "'">>, "Cloverip" = <<"'" + this.FormatearTextoSql( lxPosCloverip ) + "'">>, "Cloverport" = <<"'" + this.FormatearTextoSql( lxPosCloverport ) + "'">>, "Clovermod" = <<"'" + this.FormatearTextoSql( lxPosClovermod ) + "'">>, "Serialclov" = <<"'" + this.FormatearTextoSql( lxPosSerialclov ) + "'">>, "Idsmartl" = <<"'" + this.FormatearTextoSql( lxPosIdsmartl ) + "'">>, "Passsmartl" = <<"'" + this.FormatearTextoSql( lxPosPasssmartl ) + "'">>, "Guidstafe" = <<"'" + this.FormatearTextoSql( lxPosGuidstafe ) + "'">>, "Frasestafe" = <<"'" + this.FormatearTextoSql( lxPosFrasestafe ) + "'">>, "Cajastafe" = <<"'" + this.FormatearTextoSql( lxPosCajastafe ) + "'">>, "Sucstafe" = <<"'" + this.FormatearTextoSql( lxPosSucstafe ) + "'">>, "Urlstafe" = <<"'" + this.FormatearTextoSql( lxPosUrlstafe ) + "'">>, "Cryptokey" = <<"'" + this.FormatearTextoSql( lxPosCryptokey ) + "'">>, "Mailgocuot" = <<"'" + this.FormatearTextoSql( lxPosMailgocuot ) + "'">>, "Clavegocuo" = <<"'" + this.FormatearTextoSql( lxPosClavegocuo ) + "'">>, "Timeesppos" = <<lxPosTimeesppos>>, "Rutaini" = <<"'" + this.FormatearTextoSql( lxPosRutaini ) + "'">>, "Pregtarqr" = <<lxPosPregtarqr>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'POS' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.POSDetalleTarj where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POSMonedas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ICARDTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ICARDAutoriz where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LAPOSTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POINTDispMovil where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.FISERVTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LAPOSTerminal where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POSNETTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LAPOSPlanes where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POINTSerial where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SMARTLTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POSNETPlanes where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SMARTLPlanes where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasDetalle
				if this.oEntidad.TarjetasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxOperadoradetarjeta_PK = loItem.Operadoradetarjeta_PK
					lxOperadoradetarjetadetalle = loItem.Operadoradetarjetadetalle
					lxNumerocomercio = loItem.Numerocomercio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSDetalleTarj("NROITEM","Codigo","TarjMad","DesTarjMad","NroComerci" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxOperadoradetarjeta_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadoradetarjetadetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocomercio ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MonedasDetalle
				if this.oEntidad.MonedasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSimbolo = loItem.Simbolo
					lxCodigodemoneda_PK = loItem.Codigodemoneda_PK
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSMonedas("NROITEM","Codigo","Simbolo","CodMoneda","Descrip" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSimbolo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodemoneda_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasICardDetalle
				if this.oEntidad.TarjetasICardDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumeroequivalencia = loItem.Numeroequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					lxAutorizador = loItem.Autorizador
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ICARDTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora","Autoriz" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxNumeroequivalencia>>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">>, <<lxAutorizador>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AutorizadoresICardDetalle
				if this.oEntidad.AutorizadoresICardDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumeroequivalencia = loItem.Numeroequivalencia
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ICARDAutoriz("NROITEM","Codigo","Equivalen","Descrip" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxNumeroequivalencia>>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasLaPosDetalle
				if this.oEntidad.TarjetasLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					lxNumerocomercio = loItem.Numerocomercio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora","NroComer" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">>, <<lxNumerocomercio>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DispositivoMovilPointDetalle
				if this.oEntidad.DispositivoMovilPointDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxDispositivomovil = loItem.Dispositivomovil
					lxDisponible = loItem.Disponible
					lxSugerido = loItem.Sugerido
					lxVinculacionpdv = loItem.Vinculacionpdv
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POINTDispMovil("NROITEM","Codigo","DispMovil","Disponible","Sugerido","VincPDV" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDispositivomovil ) + "'">>, <<iif( lxDisponible, 1, 0 )>>, <<iif( lxSugerido, 1, 0 )>>, <<iif( lxVinculacionpdv, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasFiServDetalle
				if this.oEntidad.TarjetasFiServDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FISERVTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TerminalesSmartLaposDetalle
				if this.oEntidad.TerminalesSmartLaposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminal = loItem.Terminal
					lxDisponible = loItem.Disponible
					lxSugerido = loItem.Sugerido
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSTerminal("NROITEM","Codigo","Terminal","Disponible","Sugerido" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTerminal ) + "'">>, <<iif( lxDisponible, 1, 0 )>>, <<iif( lxSugerido, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasPosnetDetalle
				if this.oEntidad.TarjetasPosnetDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSNETTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesLaPosDetalle
				if this.oEntidad.PlanesLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.LAPOSPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SerialPointDetalle
				if this.oEntidad.SerialPointDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxSerial = loItem.Serial
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POINTSerial("NROITEM","Codigo","Serial" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxSerial ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.TarjetasSmartLaposDetalle
				if this.oEntidad.TarjetasSmartLaposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoequivalencia = loItem.Codigoequivalencia
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SMARTLTarjetas("NROITEM","Codigo","Equivalen","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoequivalencia ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesPosnetDetalle
				if this.oEntidad.PlanesPosnetDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.POSNETPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PlanesSmartLaPosDetalle
				if this.oEntidad.PlanesSmartLaPosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigoplan = loItem.Codigoplan
					lxDescripcion = loItem.Descripcion
					lxOperadora_PK = loItem.Operadora_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SMARTLPlanes("NROITEM","Codigo","CodigoPlan","Descrip","Operadora" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigoplan ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxOperadora_PK ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  POS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.POS where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.POSDetalleTarj where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POSMonedas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ICARDTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ICARDAutoriz where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LAPOSTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POINTDispMovil where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.FISERVTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LAPOSTerminal where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POSNETTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.LAPOSPlanes where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POINTSerial where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SMARTLTarjetas where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.POSNETPlanes where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SMARTLPlanes where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'POS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.POS where  POS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.POS where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  POS.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'POS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.POS Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.POS set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, Dispositiv = ] + "'" + this.FormatearTextoSql( &lcCursor..Dispositiv ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Contacto = ] + "'" + this.FormatearTextoSql( &lcCursor..Contacto ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, TelSoporte = ] + "'" + this.FormatearTextoSql( &lcCursor..TelSoporte ) + "'"+ [, NroTermi = ] + transform( &lcCursor..NroTermi )+ [, Marca = ] + "'" + this.FormatearTextoSql( &lcCursor..Marca ) + "'"+ [, Modelo = ] + "'" + this.FormatearTextoSql( &lcCursor..Modelo ) + "'"+ [, Integrado = ] + Transform( iif( &lcCursor..Integrado, 1, 0 ))+ [, Prestador = ] + "'" + this.FormatearTextoSql( &lcCursor..Prestador ) + "'"+ [, PagoElec = ] + Transform( iif( &lcCursor..PagoElec, 1, 0 ))+ [, Puerto = ] + "'" + this.FormatearTextoSql( &lcCursor..Puerto ) + "'"+ [, TPaquete = ] + transform( &lcCursor..TPaquete )+ [, TMensaje = ] + transform( &lcCursor..TMensaje )+ [, TChequeo = ] + transform( &lcCursor..TChequeo )+ [, TimeOutRec = ] + transform( &lcCursor..TimeOutRec )+ [, CodShop = ] + transform( &lcCursor..CodShop )+ [, CodEmpre = ] + transform( &lcCursor..CodEmpre )+ [, NroCaja = ] + transform( &lcCursor..NroCaja )+ [, ImpOrig = ] + Transform( iif( &lcCursor..ImpOrig, 1, 0 ))+ [, NumComer = ] + transform( &lcCursor..NumComer )+ [, NomComer = ] + "'" + this.FormatearTextoSql( &lcCursor..NomComer ) + "'"+ [, CuitComer = ] + "'" + this.FormatearTextoSql( &lcCursor..CuitComer ) + "'"+ [, PermiteOff = ] + Transform( iif( &lcCursor..PermiteOff, 1, 0 ))+ [, TiempoEsp = ] + transform( &lcCursor..TiempoEsp )+ [, TiempoRein = ] + transform( &lcCursor..TiempoRein )+ [, IdCliente = ] + "'" + this.FormatearTextoSql( &lcCursor..IdCliente ) + "'"+ [, UsuarioMP = ] + "'" + this.FormatearTextoSql( &lcCursor..UsuarioMP ) + "'"+ [, IdSecreto = ] + "'" + this.FormatearTextoSql( &lcCursor..IdSecreto ) + "'"+ [, BloqCieOff = ] + Transform( iif( &lcCursor..BloqCieOff, 1, 0 ))+ [, Colector = ] + transform( &lcCursor..Colector )+ [, PuestoQR = ] + "'" + this.FormatearTextoSql( &lcCursor..PuestoQR ) + "'"+ [, LocalMP = ] + "'" + this.FormatearTextoSql( &lcCursor..LocalMP ) + "'"+ [, StoreQR = ] + "'" + this.FormatearTextoSql( &lcCursor..StoreQR ) + "'"+ [, CajaMP = ] + "'" + this.FormatearTextoSql( &lcCursor..CajaMP ) + "'"+ [, Leyenda = ] + "'" + this.FormatearTextoSql( &lcCursor..Leyenda ) + "'"+ [, EnvSitef = ] + Transform( iif( &lcCursor..EnvSitef, 1, 0 ))+ [, FiServIP = ] + "'" + this.FormatearTextoSql( &lcCursor..FiServIP ) + "'"+ [, FiServPort = ] + "'" + this.FormatearTextoSql( &lcCursor..FiServPort ) + "'"+ [, FiServEmp = ] + "'" + this.FormatearTextoSql( &lcCursor..FiServEmp ) + "'"+ [, FiServTerm = ] + "'" + this.FormatearTextoSql( &lcCursor..FiServTerm ) + "'"+ [, FiServCert = ] + "'" + this.FormatearTextoSql( &lcCursor..FiServCert ) + "'"+ [, DispFiServ = ] + "'" + this.FormatearTextoSql( &lcCursor..DispFiServ ) + "'"+ [, CloverID = ] + "'" + this.FormatearTextoSql( &lcCursor..CloverID ) + "'"+ [, CloverIP = ] + "'" + this.FormatearTextoSql( &lcCursor..CloverIP ) + "'"+ [, CloverPort = ] + "'" + this.FormatearTextoSql( &lcCursor..CloverPort ) + "'"+ [, CloverMod = ] + "'" + this.FormatearTextoSql( &lcCursor..CloverMod ) + "'"+ [, SerialClov = ] + "'" + this.FormatearTextoSql( &lcCursor..SerialClov ) + "'"+ [, IdSmartL = ] + "'" + this.FormatearTextoSql( &lcCursor..IdSmartL ) + "'"+ [, PassSmartl = ] + "'" + this.FormatearTextoSql( &lcCursor..PassSmartl ) + "'"+ [, GuidStaFe = ] + "'" + this.FormatearTextoSql( &lcCursor..GuidStaFe ) + "'"+ [, FraseStaFe = ] + "'" + this.FormatearTextoSql( &lcCursor..FraseStaFe ) + "'"+ [, CajaStaFe = ] + "'" + this.FormatearTextoSql( &lcCursor..CajaStaFe ) + "'"+ [, SucStaFe = ] + "'" + this.FormatearTextoSql( &lcCursor..SucStaFe ) + "'"+ [, UrlStaFe = ] + "'" + this.FormatearTextoSql( &lcCursor..UrlStaFe ) + "'"+ [, CryptoKey = ] + "'" + this.FormatearTextoSql( &lcCursor..CryptoKey ) + "'"+ [, MailGoCuot = ] + "'" + this.FormatearTextoSql( &lcCursor..MailGoCuot ) + "'"+ [, ClaveGoCuo = ] + "'" + this.FormatearTextoSql( &lcCursor..ClaveGoCuo ) + "'"+ [, TimeEspPos = ] + transform( &lcCursor..TimeEspPos )+ [, rutaIni = ] + "'" + this.FormatearTextoSql( &lcCursor..rutaIni ) + "'"+ [, PregTarQR = ] + transform( &lcCursor..PregTarQR ) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECEXPO, FECIMPO, FECTRANS, FALTAFW, ESTTRANS, HORAIMPO, HORAEXPO, SALTAFW, HMODIFW, HALTAFW, SMODIFW, VALTAFW, UMODIFW, UALTAFW, BDMODIFW, ZADSFW, BDALTAFW, VMODIFW, Dispositiv, Codigo, Obs, Contacto, Descrip, TelSoporte, NroTermi, Marca, Modelo, Integrado, Prestador, PagoElec, Puerto, TPaquete, TMensaje, TChequeo, TimeOutRec, CodShop, CodEmpre, NroCaja, ImpOrig, NumComer, NomComer, CuitComer, PermiteOff, TiempoEsp, TiempoRein, IdCliente, UsuarioMP, IdSecreto, BloqCieOff, Colector, PuestoQR, LocalMP, StoreQR, CajaMP, Leyenda, EnvSitef, FiServIP, FiServPort, FiServEmp, FiServTerm, FiServCert, DispFiServ, CloverID, CloverIP, CloverPort, CloverMod, SerialClov, IdSmartL, PassSmartl, GuidStaFe, FraseStaFe, CajaStaFe, SucStaFe, UrlStaFe, CryptoKey, MailGoCuot, ClaveGoCuo, TimeEspPos, rutaIni, PregTarQR
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Dispositiv ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Contacto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TelSoporte ) + "'" + ',' + transform( &lcCursor..NroTermi ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Marca ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Modelo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Integrado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Prestador ) + "'" + ',' + Transform( iif( &lcCursor..PagoElec, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Puerto ) + "'" + ',' + transform( &lcCursor..TPaquete ) + ',' + transform( &lcCursor..TMensaje ) + ',' + transform( &lcCursor..TChequeo ) + ',' + transform( &lcCursor..TimeOutRec )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CodShop ) + ',' + transform( &lcCursor..CodEmpre ) + ',' + transform( &lcCursor..NroCaja ) + ',' + Transform( iif( &lcCursor..ImpOrig, 1, 0 )) + ',' + transform( &lcCursor..NumComer ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..NomComer ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CuitComer ) + "'" + ',' + Transform( iif( &lcCursor..PermiteOff, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TiempoEsp ) + ',' + transform( &lcCursor..TiempoRein ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdCliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UsuarioMP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdSecreto ) + "'" + ',' + Transform( iif( &lcCursor..BloqCieOff, 1, 0 )) + ',' + transform( &lcCursor..Colector ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..PuestoQR ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..LocalMP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..StoreQR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CajaMP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Leyenda ) + "'" + ',' + Transform( iif( &lcCursor..EnvSitef, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FiServIP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FiServPort ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FiServEmp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FiServTerm ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FiServCert ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DispFiServ ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CloverID ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CloverIP ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CloverPort ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CloverMod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SerialClov ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdSmartL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PassSmartl ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GuidStaFe ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FraseStaFe ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CajaStaFe ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SucStaFe ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UrlStaFe ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CryptoKey ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MailGoCuot ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClaveGoCuo ) + "'" + ',' + transform( &lcCursor..TimeEspPos ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..rutaIni ) + "'" + ',' + transform( &lcCursor..PregTarQR )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.POS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'POS'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.POSDetalleTarj Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.POSMonedas Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ICARDTarjetas Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ICARDAutoriz Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.LAPOSTarjetas Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.POINTDispMovil Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.FISERVTarjetas Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.LAPOSTerminal Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.POSNETTarjetas Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.LAPOSPlanes Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.POINTSerial Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.SMARTLTarjetas Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.POSNETPlanes Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.SMARTLPlanes Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMOPERADORASDETARJETA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","TarjMad","DesTarjMad","NroComerci"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.POSDetalleTarj ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TarjMad    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DesTarjMad ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroComerci ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMONEDASDETARJETA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Simbolo","CodMoneda","Descrip"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.POSMonedas ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Simbolo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodMoneda  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMTARJETASICARD'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Equivalen","Descrip","Operadora","Autoriz"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ICARDTarjetas ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.Equivalen  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Operadora  ) + "'" + ',' + transform( cDetallesExistentes.Autoriz    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAUTORIZICARD'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Equivalen","Descrip"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ICARDAutoriz ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.Equivalen  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMTARJETASLAPOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Equivalen","Descrip","Operadora","NroComer"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.LAPOSTarjetas ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equivalen  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Operadora  ) + "'" + ',' + transform( cDetallesExistentes.NroComer   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMDISPMOVILPOINT'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","DispMovil","Disponible","Sugerido","VincPDV"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.POINTDispMovil ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DispMovil  ) + "'" + ',' + Transform( iif( cDetallesExistentes.Disponible, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.Sugerido  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.VincPDV   , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMTARJETASFISERV'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Equivalen","Descrip","Operadora"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.FISERVTarjetas ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equivalen  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Operadora  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMTERMINALESLAPOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Terminal","Disponible","Sugerido"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.LAPOSTerminal ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Terminal   ) + "'" + ',' + Transform( iif( cDetallesExistentes.Disponible, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.Sugerido  , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMTARJETASPOSNET'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Equivalen","Descrip","Operadora"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.POSNETTarjetas ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equivalen  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Operadora  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPLANESLAPOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","CodigoPlan","Descrip","Operadora"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.LAPOSPlanes ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodigoPlan ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Operadora  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMSERIALPOINT'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Serial"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.POINTSerial ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Serial     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMTARJETASSMARTLAPOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Equivalen","Descrip","Operadora"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.SMARTLTarjetas ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equivalen  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Operadora  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPLANESPOSNET'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","CodigoPlan","Descrip","Operadora"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.POSNETPlanes ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodigoPlan ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Operadora  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPLANESSMARTLAPOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","CodigoPlan","Descrip","Operadora"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.SMARTLPlanes ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodigoPlan ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Operadora  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'POS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'POS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'POS_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMOPERADORASDETARJETA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMONEDASDETARJETA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMTARJETASICARD'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAUTORIZICARD'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMTARJETASLAPOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMDISPMOVILPOINT'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMTARJETASFISERV'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMTERMINALESLAPOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMTARJETASPOSNET'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPLANESLAPOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMSERIALPOINT'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMTARJETASSMARTLAPOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPLANESPOSNET'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPLANESSMARTLAPOS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_POS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'POS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad POS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'POS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'POS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_POS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_POS
Create Table ZooLogic.TablaTrabajo_POS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"esttrans" char( 20 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"dispositiv" char( 29 )  null, 
"codigo" char( 10 )  null, 
"obs" varchar(max)  null, 
"contacto" char( 40 )  null, 
"descrip" char( 40 )  null, 
"telsoporte" char( 30 )  null, 
"nrotermi" numeric( 8, 0 )  null, 
"marca" char( 20 )  null, 
"modelo" char( 20 )  null, 
"integrado" bit  null, 
"prestador" char( 25 )  null, 
"pagoelec" bit  null, 
"puerto" char( 10 )  null, 
"tpaquete" numeric( 10, 0 )  null, 
"tmensaje" numeric( 10, 0 )  null, 
"tchequeo" numeric( 10, 0 )  null, 
"timeoutrec" numeric( 10, 0 )  null, 
"codshop" numeric( 10, 0 )  null, 
"codempre" numeric( 10, 0 )  null, 
"nrocaja" numeric( 2, 0 )  null, 
"imporig" bit  null, 
"numcomer" numeric( 15, 0 )  null, 
"nomcomer" char( 40 )  null, 
"cuitcomer" char( 15 )  null, 
"permiteoff" bit  null, 
"tiempoesp" numeric( 3, 0 )  null, 
"tiemporein" numeric( 3, 0 )  null, 
"idcliente" char( 20 )  null, 
"usuariomp" char( 100 )  null, 
"idsecreto" char( 100 )  null, 
"bloqcieoff" bit  null, 
"colector" numeric( 15, 0 )  null, 
"puestoqr" char( 100 )  null, 
"localmp" char( 50 )  null, 
"storeqr" char( 10 )  null, 
"cajamp" char( 50 )  null, 
"leyenda" char( 50 )  null, 
"envsitef" bit  null, 
"fiservip" char( 254 )  null, 
"fiservport" char( 5 )  null, 
"fiservemp" char( 15 )  null, 
"fiservterm" char( 10 )  null, 
"fiservcert" char( 254 )  null, 
"dispfiserv" char( 25 )  null, 
"cloverid" char( 20 )  null, 
"cloverip" char( 15 )  null, 
"cloverport" char( 10 )  null, 
"clovermod" char( 25 )  null, 
"serialclov" char( 20 )  null, 
"idsmartl" char( 80 )  null, 
"passsmartl" char( 150 )  null, 
"guidstafe" char( 80 )  null, 
"frasestafe" char( 150 )  null, 
"cajastafe" char( 20 )  null, 
"sucstafe" char( 10 )  null, 
"urlstafe" char( 254 )  null, 
"cryptokey" char( 150 )  null, 
"mailgocuot" char( 250 )  null, 
"clavegocuo" char( 150 )  null, 
"timeesppos" numeric( 3, 0 )  null, 
"rutaini" char( 254 )  null, 
"pregtarqr" numeric( 1, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_POS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_POS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'POS'
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
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('dispositiv','dispositiv')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('contacto','contacto')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('telsoporte','telsoporte')
			.AgregarMapeo('nrotermi','nrotermi')
			.AgregarMapeo('marca','marca')
			.AgregarMapeo('modelo','modelo')
			.AgregarMapeo('integrado','integrado')
			.AgregarMapeo('prestador','prestador')
			.AgregarMapeo('pagoelec','pagoelec')
			.AgregarMapeo('puerto','puerto')
			.AgregarMapeo('tpaquete','tpaquete')
			.AgregarMapeo('tmensaje','tmensaje')
			.AgregarMapeo('tchequeo','tchequeo')
			.AgregarMapeo('timeoutrec','timeoutrec')
			.AgregarMapeo('codshop','codshop')
			.AgregarMapeo('codempre','codempre')
			.AgregarMapeo('nrocaja','nrocaja')
			.AgregarMapeo('imporig','imporig')
			.AgregarMapeo('numcomer','numcomer')
			.AgregarMapeo('nomcomer','nomcomer')
			.AgregarMapeo('cuitcomer','cuitcomer')
			.AgregarMapeo('permiteoff','permiteoff')
			.AgregarMapeo('tiempoesp','tiempoesp')
			.AgregarMapeo('tiemporein','tiemporein')
			.AgregarMapeo('idcliente','idcliente')
			.AgregarMapeo('usuariomp','usuariomp')
			.AgregarMapeo('idsecreto','idsecreto')
			.AgregarMapeo('bloqcieoff','bloqcieoff')
			.AgregarMapeo('colector','colector')
			.AgregarMapeo('puestoqr','puestoqr')
			.AgregarMapeo('localmp','localmp')
			.AgregarMapeo('storeqr','storeqr')
			.AgregarMapeo('cajamp','cajamp')
			.AgregarMapeo('leyenda','leyenda')
			.AgregarMapeo('envsitef','envsitef')
			.AgregarMapeo('fiservip','fiservip')
			.AgregarMapeo('fiservport','fiservport')
			.AgregarMapeo('fiservemp','fiservemp')
			.AgregarMapeo('fiservterm','fiservterm')
			.AgregarMapeo('fiservcert','fiservcert')
			.AgregarMapeo('dispfiserv','dispfiserv')
			.AgregarMapeo('cloverid','cloverid')
			.AgregarMapeo('cloverip','cloverip')
			.AgregarMapeo('cloverport','cloverport')
			.AgregarMapeo('clovermod','clovermod')
			.AgregarMapeo('serialclov','serialclov')
			.AgregarMapeo('idsmartl','idsmartl')
			.AgregarMapeo('passsmartl','passsmartl')
			.AgregarMapeo('guidstafe','guidstafe')
			.AgregarMapeo('frasestafe','frasestafe')
			.AgregarMapeo('cajastafe','cajastafe')
			.AgregarMapeo('sucstafe','sucstafe')
			.AgregarMapeo('urlstafe','urlstafe')
			.AgregarMapeo('cryptokey','cryptokey')
			.AgregarMapeo('mailgocuot','mailgocuot')
			.AgregarMapeo('clavegocuo','clavegocuo')
			.AgregarMapeo('timeesppos','timeesppos')
			.AgregarMapeo('rutaini','rutaini')
			.AgregarMapeo('pregtarqr','pregtarqr')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_POS'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.DISPOSITIV = isnull( d.DISPOSITIV, t.DISPOSITIV ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.CONTACTO = isnull( d.CONTACTO, t.CONTACTO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.TELSOPORTE = isnull( d.TELSOPORTE, t.TELSOPORTE ),t.NROTERMI = isnull( d.NROTERMI, t.NROTERMI ),t.MARCA = isnull( d.MARCA, t.MARCA ),t.MODELO = isnull( d.MODELO, t.MODELO ),t.INTEGRADO = isnull( d.INTEGRADO, t.INTEGRADO ),t.PRESTADOR = isnull( d.PRESTADOR, t.PRESTADOR ),t.PAGOELEC = isnull( d.PAGOELEC, t.PAGOELEC ),t.PUERTO = isnull( d.PUERTO, t.PUERTO ),t.TPAQUETE = isnull( d.TPAQUETE, t.TPAQUETE ),t.TMENSAJE = isnull( d.TMENSAJE, t.TMENSAJE ),t.TCHEQUEO = isnull( d.TCHEQUEO, t.TCHEQUEO ),t.TIMEOUTREC = isnull( d.TIMEOUTREC, t.TIMEOUTREC ),t.CODSHOP = isnull( d.CODSHOP, t.CODSHOP ),t.CODEMPRE = isnull( d.CODEMPRE, t.CODEMPRE ),t.NROCAJA = isnull( d.NROCAJA, t.NROCAJA ),t.IMPORIG = isnull( d.IMPORIG, t.IMPORIG ),t.NUMCOMER = isnull( d.NUMCOMER, t.NUMCOMER ),t.NOMCOMER = isnull( d.NOMCOMER, t.NOMCOMER ),t.CUITCOMER = isnull( d.CUITCOMER, t.CUITCOMER ),t.PERMITEOFF = isnull( d.PERMITEOFF, t.PERMITEOFF ),t.TIEMPOESP = isnull( d.TIEMPOESP, t.TIEMPOESP ),t.TIEMPOREIN = isnull( d.TIEMPOREIN, t.TIEMPOREIN ),t.IDCLIENTE = isnull( d.IDCLIENTE, t.IDCLIENTE ),t.USUARIOMP = isnull( d.USUARIOMP, t.USUARIOMP ),t.IDSECRETO = isnull( d.IDSECRETO, t.IDSECRETO ),t.BLOQCIEOFF = isnull( d.BLOQCIEOFF, t.BLOQCIEOFF ),t.COLECTOR = isnull( d.COLECTOR, t.COLECTOR ),t.PUESTOQR = isnull( d.PUESTOQR, t.PUESTOQR ),t.LOCALMP = isnull( d.LOCALMP, t.LOCALMP ),t.STOREQR = isnull( d.STOREQR, t.STOREQR ),t.CAJAMP = isnull( d.CAJAMP, t.CAJAMP ),t.LEYENDA = isnull( d.LEYENDA, t.LEYENDA ),t.ENVSITEF = isnull( d.ENVSITEF, t.ENVSITEF ),t.FISERVIP = isnull( d.FISERVIP, t.FISERVIP ),t.FISERVPORT = isnull( d.FISERVPORT, t.FISERVPORT ),t.FISERVEMP = isnull( d.FISERVEMP, t.FISERVEMP ),t.FISERVTERM = isnull( d.FISERVTERM, t.FISERVTERM ),t.FISERVCERT = isnull( d.FISERVCERT, t.FISERVCERT ),t.DISPFISERV = isnull( d.DISPFISERV, t.DISPFISERV ),t.CLOVERID = isnull( d.CLOVERID, t.CLOVERID ),t.CLOVERIP = isnull( d.CLOVERIP, t.CLOVERIP ),t.CLOVERPORT = isnull( d.CLOVERPORT, t.CLOVERPORT ),t.CLOVERMOD = isnull( d.CLOVERMOD, t.CLOVERMOD ),t.SERIALCLOV = isnull( d.SERIALCLOV, t.SERIALCLOV ),t.IDSMARTL = isnull( d.IDSMARTL, t.IDSMARTL ),t.PASSSMARTL = isnull( d.PASSSMARTL, t.PASSSMARTL ),t.GUIDSTAFE = isnull( d.GUIDSTAFE, t.GUIDSTAFE ),t.FRASESTAFE = isnull( d.FRASESTAFE, t.FRASESTAFE ),t.CAJASTAFE = isnull( d.CAJASTAFE, t.CAJASTAFE ),t.SUCSTAFE = isnull( d.SUCSTAFE, t.SUCSTAFE ),t.URLSTAFE = isnull( d.URLSTAFE, t.URLSTAFE ),t.CRYPTOKEY = isnull( d.CRYPTOKEY, t.CRYPTOKEY ),t.MAILGOCUOT = isnull( d.MAILGOCUOT, t.MAILGOCUOT ),t.CLAVEGOCUO = isnull( d.CLAVEGOCUO, t.CLAVEGOCUO ),t.TIMEESPPOS = isnull( d.TIMEESPPOS, t.TIMEESPPOS ),t.RUTAINI = isnull( d.RUTAINI, t.RUTAINI ),t.PREGTARQR = isnull( d.PREGTARQR, t.PREGTARQR )
					from ZooLogic.POS t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.POS(Fmodifw,Fecexpo,Fecimpo,Fectrans,Faltafw,Esttrans,Horaimpo,Horaexpo,Saltafw,Hmodifw,Haltafw,Smodifw,Valtafw,Umodifw,Ualtafw,Bdmodifw,Zadsfw,Bdaltafw,Vmodifw,Dispositiv,Codigo,Obs,Contacto,Descrip,Telsoporte,Nrotermi,Marca,Modelo,Integrado,Prestador,Pagoelec,Puerto,Tpaquete,Tmensaje,Tchequeo,Timeoutrec,Codshop,Codempre,Nrocaja,Imporig,Numcomer,Nomcomer,Cuitcomer,Permiteoff,Tiempoesp,Tiemporein,Idcliente,Usuariomp,Idsecreto,Bloqcieoff,Colector,Puestoqr,Localmp,Storeqr,Cajamp,Leyenda,Envsitef,Fiservip,Fiservport,Fiservemp,Fiservterm,Fiservcert,Dispfiserv,Cloverid,Cloverip,Cloverport,Clovermod,Serialclov,Idsmartl,Passsmartl,Guidstafe,Frasestafe,Cajastafe,Sucstafe,Urlstafe,Cryptokey,Mailgocuot,Clavegocuo,Timeesppos,Rutaini,Pregtarqr)
					Select isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.ESTTRANS,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.SMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.VMODIFW,''),isnull( d.DISPOSITIV,''),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.CONTACTO,''),isnull( d.DESCRIP,''),isnull( d.TELSOPORTE,''),isnull( d.NROTERMI,0),isnull( d.MARCA,''),isnull( d.MODELO,''),isnull( d.INTEGRADO,0),isnull( d.PRESTADOR,''),isnull( d.PAGOELEC,0),isnull( d.PUERTO,''),isnull( d.TPAQUETE,0),isnull( d.TMENSAJE,0),isnull( d.TCHEQUEO,0),isnull( d.TIMEOUTREC,0),isnull( d.CODSHOP,0),isnull( d.CODEMPRE,0),isnull( d.NROCAJA,0),isnull( d.IMPORIG,0),isnull( d.NUMCOMER,0),isnull( d.NOMCOMER,''),isnull( d.CUITCOMER,''),isnull( d.PERMITEOFF,0),isnull( d.TIEMPOESP,0),isnull( d.TIEMPOREIN,0),isnull( d.IDCLIENTE,''),isnull( d.USUARIOMP,''),isnull( d.IDSECRETO,''),isnull( d.BLOQCIEOFF,0),isnull( d.COLECTOR,0),isnull( d.PUESTOQR,''),isnull( d.LOCALMP,''),isnull( d.STOREQR,''),isnull( d.CAJAMP,''),isnull( d.LEYENDA,''),isnull( d.ENVSITEF,0),isnull( d.FISERVIP,''),isnull( d.FISERVPORT,''),isnull( d.FISERVEMP,''),isnull( d.FISERVTERM,''),isnull( d.FISERVCERT,''),isnull( d.DISPFISERV,''),isnull( d.CLOVERID,''),isnull( d.CLOVERIP,''),isnull( d.CLOVERPORT,''),isnull( d.CLOVERMOD,''),isnull( d.SERIALCLOV,''),isnull( d.IDSMARTL,''),isnull( d.PASSSMARTL,''),isnull( d.GUIDSTAFE,''),isnull( d.FRASESTAFE,''),isnull( d.CAJASTAFE,''),isnull( d.SUCSTAFE,''),isnull( d.URLSTAFE,''),isnull( d.CRYPTOKEY,''),isnull( d.MAILGOCUOT,''),isnull( d.CLAVEGOCUO,''),isnull( d.TIMEESPPOS,0),isnull( d.RUTAINI,''),isnull( d.PREGTARQR,0)
						From deleted d left join ZooLogic.POS pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_POSDetalleTarj( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_POSDetalleTarj
ON ZooLogic.TablaTrabajo_POS_POSDetalleTarj
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.TARJMAD = isnull( d.TARJMAD, t.TARJMAD ),
t.DESTARJMAD = isnull( d.DESTARJMAD, t.DESTARJMAD ),
t.NROCOMERCI = isnull( d.NROCOMERCI, t.NROCOMERCI )
from ZooLogic.POSDetalleTarj t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.POSDetalleTarj
( 
"NROITEM",
"CODIGO",
"TARJMAD",
"DESTARJMAD",
"NROCOMERCI"
 )
Select 
d.NROITEM,
d.CODIGO,
d.TARJMAD,
d.DESTARJMAD,
d.NROCOMERCI
From deleted d left join ZooLogic.POSDetalleTarj pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_POSMonedas( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_POSMonedas
ON ZooLogic.TablaTrabajo_POS_POSMonedas
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.SIMBOLO = isnull( d.SIMBOLO, t.SIMBOLO ),
t.CODMONEDA = isnull( d.CODMONEDA, t.CODMONEDA ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP )
from ZooLogic.POSMonedas t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.POSMonedas
( 
"NROITEM",
"CODIGO",
"SIMBOLO",
"CODMONEDA",
"DESCRIP"
 )
Select 
d.NROITEM,
d.CODIGO,
d.SIMBOLO,
d.CODMONEDA,
d.DESCRIP
From deleted d left join ZooLogic.POSMonedas pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ICARDTarjetas( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_ICARDTarjetas
ON ZooLogic.TablaTrabajo_POS_ICARDTarjetas
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIVALEN = isnull( d.EQUIVALEN, t.EQUIVALEN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA ),
t.AUTORIZ = isnull( d.AUTORIZ, t.AUTORIZ )
from ZooLogic.ICARDTarjetas t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ICARDTarjetas
( 
"NROITEM",
"CODIGO",
"EQUIVALEN",
"DESCRIP",
"OPERADORA",
"AUTORIZ"
 )
Select 
d.NROITEM,
d.CODIGO,
d.EQUIVALEN,
d.DESCRIP,
d.OPERADORA,
d.AUTORIZ
From deleted d left join ZooLogic.ICARDTarjetas pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ICARDAutoriz( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_ICARDAutoriz
ON ZooLogic.TablaTrabajo_POS_ICARDAutoriz
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIVALEN = isnull( d.EQUIVALEN, t.EQUIVALEN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP )
from ZooLogic.ICARDAutoriz t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ICARDAutoriz
( 
"NROITEM",
"CODIGO",
"EQUIVALEN",
"DESCRIP"
 )
Select 
d.NROITEM,
d.CODIGO,
d.EQUIVALEN,
d.DESCRIP
From deleted d left join ZooLogic.ICARDAutoriz pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_LAPOSTarjetas( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_LAPOSTarjetas
ON ZooLogic.TablaTrabajo_POS_LAPOSTarjetas
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIVALEN = isnull( d.EQUIVALEN, t.EQUIVALEN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA ),
t.NROCOMER = isnull( d.NROCOMER, t.NROCOMER )
from ZooLogic.LAPOSTarjetas t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.LAPOSTarjetas
( 
"NROITEM",
"CODIGO",
"EQUIVALEN",
"DESCRIP",
"OPERADORA",
"NROCOMER"
 )
Select 
d.NROITEM,
d.CODIGO,
d.EQUIVALEN,
d.DESCRIP,
d.OPERADORA,
d.NROCOMER
From deleted d left join ZooLogic.LAPOSTarjetas pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_POINTDispMovil( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_POINTDispMovil
ON ZooLogic.TablaTrabajo_POS_POINTDispMovil
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.DISPMOVIL = isnull( d.DISPMOVIL, t.DISPMOVIL ),
t.DISPONIBLE = isnull( d.DISPONIBLE, t.DISPONIBLE ),
t.SUGERIDO = isnull( d.SUGERIDO, t.SUGERIDO ),
t.VINCPDV = isnull( d.VINCPDV, t.VINCPDV )
from ZooLogic.POINTDispMovil t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.POINTDispMovil
( 
"NROITEM",
"CODIGO",
"DISPMOVIL",
"DISPONIBLE",
"SUGERIDO",
"VINCPDV"
 )
Select 
d.NROITEM,
d.CODIGO,
d.DISPMOVIL,
d.DISPONIBLE,
d.SUGERIDO,
d.VINCPDV
From deleted d left join ZooLogic.POINTDispMovil pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_FISERVTarjetas( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_FISERVTarjetas
ON ZooLogic.TablaTrabajo_POS_FISERVTarjetas
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIVALEN = isnull( d.EQUIVALEN, t.EQUIVALEN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA )
from ZooLogic.FISERVTarjetas t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.FISERVTarjetas
( 
"NROITEM",
"CODIGO",
"EQUIVALEN",
"DESCRIP",
"OPERADORA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.EQUIVALEN,
d.DESCRIP,
d.OPERADORA
From deleted d left join ZooLogic.FISERVTarjetas pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_LAPOSTerminal( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_LAPOSTerminal
ON ZooLogic.TablaTrabajo_POS_LAPOSTerminal
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.TERMINAL = isnull( d.TERMINAL, t.TERMINAL ),
t.DISPONIBLE = isnull( d.DISPONIBLE, t.DISPONIBLE ),
t.SUGERIDO = isnull( d.SUGERIDO, t.SUGERIDO )
from ZooLogic.LAPOSTerminal t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.LAPOSTerminal
( 
"NROITEM",
"CODIGO",
"TERMINAL",
"DISPONIBLE",
"SUGERIDO"
 )
Select 
d.NROITEM,
d.CODIGO,
d.TERMINAL,
d.DISPONIBLE,
d.SUGERIDO
From deleted d left join ZooLogic.LAPOSTerminal pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_POSNETTarjetas( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_POSNETTarjetas
ON ZooLogic.TablaTrabajo_POS_POSNETTarjetas
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIVALEN = isnull( d.EQUIVALEN, t.EQUIVALEN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA )
from ZooLogic.POSNETTarjetas t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.POSNETTarjetas
( 
"NROITEM",
"CODIGO",
"EQUIVALEN",
"DESCRIP",
"OPERADORA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.EQUIVALEN,
d.DESCRIP,
d.OPERADORA
From deleted d left join ZooLogic.POSNETTarjetas pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_LAPOSPlanes( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_LAPOSPlanes
ON ZooLogic.TablaTrabajo_POS_LAPOSPlanes
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODIGOPLAN = isnull( d.CODIGOPLAN, t.CODIGOPLAN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA )
from ZooLogic.LAPOSPlanes t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.LAPOSPlanes
( 
"NROITEM",
"CODIGO",
"CODIGOPLAN",
"DESCRIP",
"OPERADORA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CODIGOPLAN,
d.DESCRIP,
d.OPERADORA
From deleted d left join ZooLogic.LAPOSPlanes pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_POINTSerial( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_POINTSerial
ON ZooLogic.TablaTrabajo_POS_POINTSerial
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.SERIAL = isnull( d.SERIAL, t.SERIAL )
from ZooLogic.POINTSerial t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.POINTSerial
( 
"NROITEM",
"CODIGO",
"SERIAL"
 )
Select 
d.NROITEM,
d.CODIGO,
d.SERIAL
From deleted d left join ZooLogic.POINTSerial pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_SMARTLTarjetas( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_SMARTLTarjetas
ON ZooLogic.TablaTrabajo_POS_SMARTLTarjetas
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIVALEN = isnull( d.EQUIVALEN, t.EQUIVALEN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA )
from ZooLogic.SMARTLTarjetas t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.SMARTLTarjetas
( 
"NROITEM",
"CODIGO",
"EQUIVALEN",
"DESCRIP",
"OPERADORA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.EQUIVALEN,
d.DESCRIP,
d.OPERADORA
From deleted d left join ZooLogic.SMARTLTarjetas pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_POSNETPlanes( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_POSNETPlanes
ON ZooLogic.TablaTrabajo_POS_POSNETPlanes
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODIGOPLAN = isnull( d.CODIGOPLAN, t.CODIGOPLAN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA )
from ZooLogic.POSNETPlanes t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.POSNETPlanes
( 
"NROITEM",
"CODIGO",
"CODIGOPLAN",
"DESCRIP",
"OPERADORA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CODIGOPLAN,
d.DESCRIP,
d.OPERADORA
From deleted d left join ZooLogic.POSNETPlanes pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_SMARTLPlanes( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_POS_SMARTLPlanes
ON ZooLogic.TablaTrabajo_POS_SMARTLPlanes
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODIGOPLAN = isnull( d.CODIGOPLAN, t.CODIGOPLAN ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.OPERADORA = isnull( d.OPERADORA, t.OPERADORA )
from ZooLogic.SMARTLPlanes t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.SMARTLPlanes
( 
"NROITEM",
"CODIGO",
"CODIGOPLAN",
"DESCRIP",
"OPERADORA"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CODIGOPLAN,
d.DESCRIP,
d.OPERADORA
From deleted d left join ZooLogic.SMARTLPlanes pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_POS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_POS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_POS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_POS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_POS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_POS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_POS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_POS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Estadotransferencia = nvl( c_POS.Estadotransferencia, [] )
					.Horaimpo = nvl( c_POS.Horaimpo, [] )
					.Horaexpo = nvl( c_POS.Horaexpo, [] )
					.Seriealtafw = nvl( c_POS.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_POS.Horamodificacionfw, [] )
					.Horaaltafw = nvl( c_POS.Horaaltafw, [] )
					.Seriemodificacionfw = nvl( c_POS.Seriemodificacionfw, [] )
					.Versionaltafw = nvl( c_POS.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_POS.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_POS.Usuarioaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_POS.Basededatosmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_POS.Basededatosaltafw, [] )
					.Versionmodificacionfw = nvl( c_POS.Versionmodificacionfw, [] )
					.Dispositivo = nvl( c_POS.Dispositivo, [] )
					.Codigo = nvl( c_POS.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Contactosoportetecnico = nvl( c_POS.Contactosoportetecnico, [] )
					.Descripcion = nvl( c_POS.Descripcion, [] )
					.Tarjetasdetalle.Limpiar()
					.Tarjetasdetalle.SetearEsNavegacion( .lProcesando )
					.Tarjetasdetalle.Cargar()
					.Monedasdetalle.Limpiar()
					.Monedasdetalle.SetearEsNavegacion( .lProcesando )
					.Monedasdetalle.Cargar()
					.Tarjetasicarddetalle.Limpiar()
					.Tarjetasicarddetalle.SetearEsNavegacion( .lProcesando )
					.Tarjetasicarddetalle.Cargar()
					.Autorizadoresicarddetalle.Limpiar()
					.Autorizadoresicarddetalle.SetearEsNavegacion( .lProcesando )
					.Autorizadoresicarddetalle.Cargar()
					.Tarjetaslaposdetalle.Limpiar()
					.Tarjetaslaposdetalle.SetearEsNavegacion( .lProcesando )
					.Tarjetaslaposdetalle.Cargar()
					.Dispositivomovilpointdetalle.Limpiar()
					.Dispositivomovilpointdetalle.SetearEsNavegacion( .lProcesando )
					.Dispositivomovilpointdetalle.Cargar()
					.Tarjetasfiservdetalle.Limpiar()
					.Tarjetasfiservdetalle.SetearEsNavegacion( .lProcesando )
					.Tarjetasfiservdetalle.Cargar()
					.Terminalessmartlaposdetalle.Limpiar()
					.Terminalessmartlaposdetalle.SetearEsNavegacion( .lProcesando )
					.Terminalessmartlaposdetalle.Cargar()
					.Tarjetasposnetdetalle.Limpiar()
					.Tarjetasposnetdetalle.SetearEsNavegacion( .lProcesando )
					.Tarjetasposnetdetalle.Cargar()
					.Telefonosoportetecnico = nvl( c_POS.Telefonosoportetecnico, [] )
					.Numeroterminal = nvl( c_POS.Numeroterminal, 0 )
					.Planeslaposdetalle.Limpiar()
					.Planeslaposdetalle.SetearEsNavegacion( .lProcesando )
					.Planeslaposdetalle.Cargar()
					.Serialpointdetalle.Limpiar()
					.Serialpointdetalle.SetearEsNavegacion( .lProcesando )
					.Serialpointdetalle.Cargar()
					.Tarjetassmartlaposdetalle.Limpiar()
					.Tarjetassmartlaposdetalle.SetearEsNavegacion( .lProcesando )
					.Tarjetassmartlaposdetalle.Cargar()
					.Planesposnetdetalle.Limpiar()
					.Planesposnetdetalle.SetearEsNavegacion( .lProcesando )
					.Planesposnetdetalle.Cargar()
					.Marca = nvl( c_POS.Marca, [] )
					.Planessmartlaposdetalle.Limpiar()
					.Planessmartlaposdetalle.SetearEsNavegacion( .lProcesando )
					.Planessmartlaposdetalle.Cargar()
					.Modelo = nvl( c_POS.Modelo, [] )
					.Integrado = nvl( c_POS.Integrado, .F. )
					.Prestador = nvl( c_POS.Prestador, [] )
					.Pagoelectronico = nvl( c_POS.Pagoelectronico, .F. )
					.Puerto = nvl( c_POS.Puerto, [] )
					.Paquete = nvl( c_POS.Paquete, 0 )
					.Tiempomensaje = nvl( c_POS.Tiempomensaje, 0 )
					.Tiempochequeo = nvl( c_POS.Tiempochequeo, 0 )
					.Timeoutrecepcion = nvl( c_POS.Timeoutrecepcion, 0 )
					.Shopping = nvl( c_POS.Shopping, 0 )
					.Empresa = nvl( c_POS.Empresa, 0 )
					.Caja = nvl( c_POS.Caja, 0 )
					.Imprimesolooriginal = nvl( c_POS.Imprimesolooriginal, .F. )
					.Numerocomercio = nvl( c_POS.Numerocomercio, 0 )
					.Nombrecomercio = nvl( c_POS.Nombrecomercio, [] )
					.Cuitcomercio = nvl( c_POS.Cuitcomercio, [] )
					.Permitetransaccionesoffline = nvl( c_POS.Permitetransaccionesoffline, .F. )
					.Tiempodeespera = nvl( c_POS.Tiempodeespera, 0 )
					.Tiempoporreintento = nvl( c_POS.Tiempoporreintento, 0 )
					.Idcliente = nvl( c_POS.Idcliente, [] )
					.Usuariomp = nvl( c_POS.Usuariomp, [] )
					.Idsecreto = nvl( c_POS.Idsecreto, [] )
					.Bloquearcierrecajaoffline = nvl( c_POS.Bloquearcierrecajaoffline, .F. )
					.Colector = nvl( c_POS.Colector, 0 )
					.Idpuestoqr = nvl( c_POS.Idpuestoqr, [] )
					.Localmp = nvl( c_POS.Localmp, [] )
					.Idstoreqr = nvl( c_POS.Idstoreqr, [] )
					.Cajamp = nvl( c_POS.Cajamp, [] )
					.Leyenda = nvl( c_POS.Leyenda, [] )
					.Enviaventassitef = nvl( c_POS.Enviaventassitef, .F. )
					.Direccionip = nvl( c_POS.Direccionip, [] )
					.Puertofiserv = nvl( c_POS.Puertofiserv, [] )
					.Empresafiserv = nvl( c_POS.Empresafiserv, [] )
					.Terminalfiserv = nvl( c_POS.Terminalfiserv, [] )
					.Rutacertificado = nvl( c_POS.Rutacertificado, [] )
					.Dispositivofiserv = nvl( c_POS.Dispositivofiserv, [] )
					.Idcloverdisp = nvl( c_POS.Idcloverdisp, [] )
					.Ipcloverdisp = nvl( c_POS.Ipcloverdisp, [] )
					.Puertocloverdisp = nvl( c_POS.Puertocloverdisp, [] )
					.Modeloclover = nvl( c_POS.Modeloclover, [] )
					.Serialclover = nvl( c_POS.Serialclover, [] )
					.Usuariosmartlapos = nvl( c_POS.Usuariosmartlapos, [] )
					.Passsmartlapos = nvl( c_POS.Passsmartlapos, [] )
					.Guidbilleterasantafe = nvl( c_POS.Guidbilleterasantafe, [] )
					.Frasebilleterasantafe = nvl( c_POS.Frasebilleterasantafe, [] )
					.Cajabilleterasantafe = nvl( c_POS.Cajabilleterasantafe, [] )
					.Sucursalbilleterasantafe = nvl( c_POS.Sucursalbilleterasantafe, [] )
					.Urlbilleterasantafe = nvl( c_POS.Urlbilleterasantafe, [] )
					.Cryptoapikey = nvl( c_POS.Cryptoapikey, [] )
					.Mailgocuotas = nvl( c_POS.Mailgocuotas, [] )
					.Clavegocuotas = nvl( c_POS.Clavegocuotas, [] )
					.Tiempodeesperaposnet = nvl( c_POS.Tiempodeesperaposnet, 0 )
					.Rutaarchivoiniposnet = nvl( c_POS.Rutaarchivoiniposnet, [] )
					.Preguntatarjetaqr = nvl( c_POS.Preguntatarjetaqr, 0 )
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
		
		loDetalle = this.oEntidad.TarjetasDetalle
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

		loDetalle = this.oEntidad.MonedasDetalle
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

		loDetalle = this.oEntidad.TarjetasICardDetalle
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

		loDetalle = this.oEntidad.AutorizadoresICardDetalle
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

		loDetalle = this.oEntidad.TarjetasLaPosDetalle
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

		loDetalle = this.oEntidad.DispositivoMovilPointDetalle
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

		loDetalle = this.oEntidad.TarjetasFiServDetalle
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

		loDetalle = this.oEntidad.TerminalesSmartLaposDetalle
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

		loDetalle = this.oEntidad.TarjetasPosnetDetalle
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

		loDetalle = this.oEntidad.PlanesLaPosDetalle
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

		loDetalle = this.oEntidad.SerialPointDetalle
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

		loDetalle = this.oEntidad.TarjetasSmartLaposDetalle
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

		loDetalle = this.oEntidad.PlanesPosnetDetalle
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

		loDetalle = this.oEntidad.PlanesSmartLaPosDetalle
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
		return c_POS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.POS' )
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
								from ZooLogic.POS 
								Where   POS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "POS", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Dispositiv" as "Dispositivo", "Codigo" as "Codigo", "Obs" as "Observacion", "Contacto" as "Contactosoportetecnico", "Descrip" as "Descripcion", "Telsoporte" as "Telefonosoportetecnico", "Nrotermi" as "Numeroterminal", "Marca" as "Marca", "Modelo" as "Modelo", "Integrado" as "Integrado", "Prestador" as "Prestador", "Pagoelec" as "Pagoelectronico", "Puerto" as "Puerto", "Tpaquete" as "Paquete", "Tmensaje" as "Tiempomensaje", "Tchequeo" as "Tiempochequeo", "Timeoutrec" as "Timeoutrecepcion", "Codshop" as "Shopping", "Codempre" as "Empresa", "Nrocaja" as "Caja", "Imporig" as "Imprimesolooriginal", "Numcomer" as "Numerocomercio", "Nomcomer" as "Nombrecomercio", "Cuitcomer" as "Cuitcomercio", "Permiteoff" as "Permitetransaccionesoffline", "Tiempoesp" as "Tiempodeespera", "Tiemporein" as "Tiempoporreintento", "Idcliente" as "Idcliente", "Usuariomp" as "Usuariomp", "Idsecreto" as "Idsecreto", "Bloqcieoff" as "Bloquearcierrecajaoffline", "Colector" as "Colector", "Puestoqr" as "Idpuestoqr", "Localmp" as "Localmp", "Storeqr" as "Idstoreqr", "Cajamp" as "Cajamp", "Leyenda" as "Leyenda", "Envsitef" as "Enviaventassitef", "Fiservip" as "Direccionip", "Fiservport" as "Puertofiserv", "Fiservemp" as "Empresafiserv", "Fiservterm" as "Terminalfiserv", "Fiservcert" as "Rutacertificado", "Dispfiserv" as "Dispositivofiserv", "Cloverid" as "Idcloverdisp", "Cloverip" as "Ipcloverdisp", "Cloverport" as "Puertocloverdisp", "Clovermod" as "Modeloclover", "Serialclov" as "Serialclover", "Idsmartl" as "Usuariosmartlapos", "Passsmartl" as "Passsmartlapos", "Guidstafe" as "Guidbilleterasantafe", "Frasestafe" as "Frasebilleterasantafe", "Cajastafe" as "Cajabilleterasantafe", "Sucstafe" as "Sucursalbilleterasantafe", "Urlstafe" as "Urlbilleterasantafe", "Cryptokey" as "Cryptoapikey", "Mailgocuot" as "Mailgocuotas", "Clavegocuo" as "Clavegocuotas", "Timeesppos" as "Tiempodeesperaposnet", "Rutaini" as "Rutaarchivoiniposnet", "Pregtarqr" as "Preguntatarjetaqr"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.POS 
								Where   POS.CODIGO != ''
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
	Tabla = 'POS'
	Filtro = " POS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " POS.CODIGO != ''"
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
	<row entidad="POS                                     " atributo="FECHAMODIFICACIONFW                     " tabla="POS            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="FECHAEXPO                               " tabla="POS            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="FECHAIMPO                               " tabla="POS            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="FECHATRANSFERENCIA                      " tabla="POS            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="FECHAALTAFW                             " tabla="POS            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="ESTADOTRANSFERENCIA                     " tabla="POS            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="HORAIMPO                                " tabla="POS            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="HORAEXPO                                " tabla="POS            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="SERIEALTAFW                             " tabla="POS            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="HORAMODIFICACIONFW                      " tabla="POS            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="HORAALTAFW                              " tabla="POS            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="SERIEMODIFICACIONFW                     " tabla="POS            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="VERSIONALTAFW                           " tabla="POS            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="USUARIOMODIFICACIONFW                   " tabla="POS            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="USUARIOALTAFW                           " tabla="POS            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="POS            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="ZADSFW                                  " tabla="POS            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="BASEDEDATOSALTAFW                       " tabla="POS            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="VERSIONMODIFICACIONFW                   " tabla="POS            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="DISPOSITIVO                             " tabla="POS            " campo="DISPOSITIV" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="29" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="CODIGO                                  " tabla="POS            " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Código POS                                                                                                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="OBSERVACION                             " tabla="POS            " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="CONTACTOSOPORTETECNICO                  " tabla="POS            " campo="CONTACTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Contacto                                                                                                                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="DESCRIPCION                             " tabla="POS            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                                                                                                               " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TARJETASDETALLE                         " tabla="POSDETALLETARJ " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Operadora                                                                                                                                                                                                                                                 " dominio="DETALLEITEMOPERADORASDETARJETA" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="MONEDASDETALLE                          " tabla="POSMONEDAS     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda tarjeta                                                                                                                                                                                                                                            " dominio="DETALLEITEMMONEDASDETARJETA   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TARJETASICARDDETALLE                    " tabla="ICARDTARJETAS  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Equivalencia tarjeta                                                                                                                                                                                                                                      " dominio="DETALLEITEMTARJETASICARD      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="AUTORIZADORESICARDDETALLE               " tabla="ICARDAUTORIZ   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Autorizador tarjeta                                                                                                                                                                                                                                       " dominio="DETALLEITEMAUTORIZICARD       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TARJETASLAPOSDETALLE                    " tabla="LAPOSTARJETAS  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Tarjeta LaPos                                                                                                                                                                                                                                             " dominio="DETALLEITEMTARJETASLAPOS      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="DISPOSITIVOMOVILPOINTDETALLE            " tabla="POINTDISPMOVIL " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Dispositivo móvil                                                                                                                                                                                                                                         " dominio="DETALLEITEMDISPMOVILPOINT     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TARJETASFISERVDETALLE                   " tabla="FISERVTARJETAS " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Tarjetas                                                                                                                                                                                                                                                  " dominio="DETALLEITEMTARJETASFISERV     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TERMINALESSMARTLAPOSDETALLE             " tabla="LAPOSTERMINAL  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="Terminales smart LaPos                                                                                                                                                                                                                                    " dominio="DETALLEITEMTERMINALESLAPOS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="6" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TARJETASPOSNETDETALLE                   " tabla="POSNETTARJETAS " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Tarjeta Posnet                                                                                                                                                                                                                                            " dominio="DETALLEITEMTARJETASPOSNET     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="7" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TELEFONOSOPORTETECNICO                  " tabla="POS            " campo="TELSOPORTE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="Teléfono                                                                                                                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="NUMEROTERMINAL                          " tabla="POS            " campo="NROTERMI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Nro. terminal                                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PLANESLAPOSDETALLE                      " tabla="LAPOSPLANES    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="Planes                                                                                                                                                                                                                                                    " dominio="DETALLEITEMPLANESLAPOS        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="SERIALPOINTDETALLE                      " tabla="POINTSERIAL    " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="Serial                                                                                                                                                                                                                                                    " dominio="DETALLEITEMSERIALPOINT        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TARJETASSMARTLAPOSDETALLE               " tabla="SMARTLTARJETAS " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="Tarjeta smart LaPos                                                                                                                                                                                                                                       " dominio="DETALLEITEMTARJETASSMARTLAPOS " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="6" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PLANESPOSNETDETALLE                     " tabla="POSNETPLANES   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="211" etiqueta="Planes Posnet                                                                                                                                                                                                                                             " dominio="DETALLEITEMPLANESPOSNET       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="7" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="MARCA                                   " tabla="POS            " campo="MARCA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Marca                                                                                                                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PLANESSMARTLAPOSDETALLE                 " tabla="SMARTLPLANES   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="212" etiqueta="Planes smart                                                                                                                                                                                                                                              " dominio="DETALLEITEMPLANESSMARTLAPOS   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="6" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="MODELO                                  " tabla="POS            " campo="MODELO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Modelo                                                                                                                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="INTEGRADO                               " tabla="POS            " campo="INTEGRADO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="213" etiqueta="Integrado                                                                                                                                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PRESTADOR                               " tabla="POS            " campo="PRESTADOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="214" etiqueta="Prestador                                                                                                                                                                                                                                                 " dominio="COMBOPRESTADOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PAGOELECTRONICO                         " tabla="POS            " campo="PAGOELEC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="215" etiqueta="Es pago electrónico                                                                                                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PUERTO                                  " tabla="POS            " campo="PUERTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="216" etiqueta="Puerto                                                                                                                                                                                                                                                    " dominio="COMBOPUERTOSERIE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PAQUETE                                 " tabla="POS            " campo="TPAQUETE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="217" etiqueta="Tamaño de paquete                                                                                                                                                                                                                                         " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TIEMPOMENSAJE                           " tabla="POS            " campo="TMENSAJE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="218" etiqueta="Tiempo entre mensajes                                                                                                                                                                                                                                     " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TIEMPOCHEQUEO                           " tabla="POS            " campo="TCHEQUEO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="219" etiqueta="Tiempo de chequeo entre mensajes                                                                                                                                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TIMEOUTRECEPCION                        " tabla="POS            " campo="TIMEOUTREC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="220" etiqueta="Tiempo límite de recepción                                                                                                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="SHOPPING                                " tabla="POS            " campo="CODSHOP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="221" etiqueta="Shopping                                                                                                                                                                                                                                                  " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="EMPRESA                                 " tabla="POS            " campo="CODEMPRE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="222" etiqueta="Empresa                                                                                                                                                                                                                                                   " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="100" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="CAJA                                    " tabla="POS            " campo="NROCAJA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="goParametros.Felino.GestionDeVentas.NumeroDeCaja                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="223" etiqueta="Caja                                                                                                                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="110" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="IMPRIMESOLOORIGINAL                     " tabla="POS            " campo="IMPORIG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="224" etiqueta="Imprime sólo ticket original                                                                                                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="120" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="NUMEROCOMERCIO                          " tabla="POS            " campo="NUMCOMER  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="225" etiqueta="Número de comercio                                                                                                                                                                                                                                        " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="130" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="NOMBRECOMERCIO                          " tabla="POS            " campo="NOMCOMER  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="226" etiqueta="Nombre de comercio                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="140" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="CUITCOMERCIO                            " tabla="POS            " campo="CUITCOMER " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="227" etiqueta="CUIT de comercio                                                                                                                                                                                                                                          " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="150" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PERMITETRANSACCIONESOFFLINE             " tabla="POS            " campo="PERMITEOFF" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="228" etiqueta="Permite transacciones off line                                                                                                                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="160" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TIEMPODEESPERA                          " tabla="POS            " campo="TIEMPOESP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="60                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="229" etiqueta="Tiempo de espera                                                                                                                                                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="170" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TIEMPOPORREINTENTO                      " tabla="POS            " campo="TIEMPOREIN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="60                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="230" etiqueta="Tiempo por reintento                                                                                                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="180" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="IDCLIENTE                               " tabla="POS            " campo="IDCLIENTE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="231" etiqueta="Id cliente                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="190" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="USUARIOMP                               " tabla="POS            " campo="USUARIOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="232" etiqueta="Nombre Usuario MP                                                                                                                                                                                                                                         " dominio="COMBOUSUARIOMP                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="195" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="IDSECRETO                               " tabla="POS            " campo="IDSECRETO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="233" etiqueta="Cliente secreto                                                                                                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="200" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="BLOQUEARCIERRECAJAOFFLINE               " tabla="POS            " campo="BLOQCIEOFF" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="234" etiqueta="Bloquea cierre de caja offline                                                                                                                                                                                                                            " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="210" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="COLECTOR                                " tabla="POS            " campo="COLECTOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Colector                                                                                                                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="220" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="IDPUESTOQR                              " tabla="POS            " campo="PUESTOQR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="235" etiqueta="Id puesto QR                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="230" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="LOCALMP                                 " tabla="POS            " campo="LOCALMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="236" etiqueta="Local                                                                                                                                                                                                                                                     " dominio="COMBOLOCALMP                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="235" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="IDSTOREQR                               " tabla="POS            " campo="STOREQR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="237" etiqueta="Id store QR                                                                                                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999999999               " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="240" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="CAJAMP                                  " tabla="POS            " campo="CAJAMP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="238" etiqueta="Nombre Caja MP                                                                                                                                                                                                                                            " dominio="COMBOCAJAMP                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="245" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="LEYENDA                                 " tabla="POS            " campo="LEYENDA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="239" etiqueta="Leyenda para clientes                                                                                                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="250" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="ENVIAVENTASSITEF                        " tabla="POS            " campo="ENVSITEF  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="240" etiqueta="Informa a SiTef                                                                                                                                                                                                                                           " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="260" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="DIRECCIONIP                             " tabla="POS            " campo="FISERVIP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="241" etiqueta="Dirección ip                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="270" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PUERTOFISERV                            " tabla="POS            " campo="FISERVPORT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="242" etiqueta="Puerto de conexión                                                                                                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="280" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="EMPRESAFISERV                           " tabla="POS            " campo="FISERVEMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="243" etiqueta="Código de empresa                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="290" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TERMINALFISERV                          " tabla="POS            " campo="FISERVTERM" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="244" etiqueta="Terminal                                                                                                                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="300" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="RUTACERTIFICADO                         " tabla="POS            " campo="FISERVCERT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="= addbs( _Screen.zoo.cRutaInicial ) + &quot;Bin\ca_cert_prod.pem&quot;                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="245" etiqueta="Ruta para envío                                                                                                                                                                                                                                           " dominio="ARCHIVO                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="310" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="DISPOSITIVOFISERV                       " tabla="POS            " campo="DISPFISERV" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="246" etiqueta="Dispositivo                                                                                                                                                                                                                                               " dominio="COMBODISPOSITIVOFISERV        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="320" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="IDCLOVERDISP                            " tabla="POS            " campo="CLOVERID  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="247" etiqueta="ID dispositivo                                                                                                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="330" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="IPCLOVERDISP                            " tabla="POS            " campo="CLOVERIP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="248" etiqueta="IP de dispositivo                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="340" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PUERTOCLOVERDISP                        " tabla="POS            " campo="CLOVERPORT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="249" etiqueta="Puerto de dispositivo                                                                                                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="350" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="MODELOCLOVER                            " tabla="POS            " campo="CLOVERMOD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="250" etiqueta="Modelo de dispositivo                                                                                                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="360" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="SERIALCLOVER                            " tabla="POS            " campo="SERIALCLOV" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="251" etiqueta="Código serial                                                                                                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="370" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="USUARIOSMARTLAPOS                       " tabla="POS            " campo="IDSMARTL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="252" etiqueta="Usuario                                                                                                                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="380" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PASSSMARTLAPOS                          " tabla="POS            " campo="PASSSMARTL" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="253" etiqueta="Clave                                                                                                                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="400" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="GUIDBILLETERASANTAFE                    " tabla="POS            " campo="GUIDSTAFE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="254" etiqueta="Guid                                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="410" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="FRASEBILLETERASANTAFE                   " tabla="POS            " campo="FRASESTAFE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="255" etiqueta="Frase                                                                                                                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="420" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="CAJABILLETERASANTAFE                    " tabla="POS            " campo="CAJASTAFE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="256" etiqueta="Caja Santa Fe                                                                                                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="430" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="SUCURSALBILLETERASANTAFE                " tabla="POS            " campo="SUCSTAFE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="257" etiqueta="Sucursal                                                                                                                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="440" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="URLBILLETERASANTAFE                     " tabla="POS            " campo="URLSTAFE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="258" etiqueta="Url código QR                                                                                                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="450" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="CRYPTOAPIKEY                            " tabla="POS            " campo="CRYPTOKEY " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="259" etiqueta="Api Key                                                                                                                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="460" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="MAILGOCUOTAS                            " tabla="POS            " campo="MAILGOCUOT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="260" etiqueta="Email                                                                                                                                                                                                                                                     " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="470" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="CLAVEGOCUOTAS                           " tabla="POS            " campo="CLAVEGOCUO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="261" etiqueta="Clave sucursal                                                                                                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="480" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="TIEMPODEESPERAPOSNET                    " tabla="POS            " campo="TIMEESPPOS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="115                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="262" etiqueta="Tiempo de espera (seg.)                                                                                                                                                                                                                                   " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="500" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="RUTAARCHIVOINIPOSNET                    " tabla="POS            " campo="RUTAINI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="= &quot;C:\Posnet\DeviceIntegrator\DeviceIntegrator.ini&quot;                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="263" etiqueta="Ruta archivo DeviceIntegrator.ini                                                                                                                                                                                                                         " dominio="ARCHIVO                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="510" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="POS                                     " atributo="PREGUNTATARJETAQR                       " tabla="POS            " campo="PREGTARQR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="264" etiqueta="Cobro directo por QR                                                                                                                                                                                                                                      " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="520" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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