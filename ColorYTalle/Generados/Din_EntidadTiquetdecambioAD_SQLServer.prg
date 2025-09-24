
define class Din_EntidadTIQUETDECAMBIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TIQUETDECAMBIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + NroArt + CantArt]
	cExpresionCCPorCampos = [str( #tabla#.TipoComp, 2, 0) + #tabla#.tLetra + str( #tabla#.tPVenta, 4, 0) + str( #tabla#.tNumero, 8, 0) + #tabla#.tNroArt + #tabla#.tCantArt]
	cTagClaveCandidata = '_TDCCC'
	cTagClavePk = '_TDCPK'
	cTablaPrincipal = 'TICKETCAMBIO'
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
			local  lxTicketcambioFmodifw, lxTicketcambioFectrans, lxTicketcambioFaltafw, lxTicketcambioFecimpo, lxTicketcambioFecexpo, lxTicketcambioHoraexpo, lxTicketcambioHaltafw, lxTicketcambioHoraimpo, lxTicketcambioUaltafw, lxTicketcambioVmodifw, lxTicketcambioZadsfw, lxTicketcambioValtafw, lxTicketcambioUmodifw, lxTicketcambioSaltafw, lxTicketcambioSmodifw, lxTicketcambioHmodifw, lxTicketcambioBdmodifw, lxTicketcambioBdaltafw, lxTicketcambioEsttrans, lxTicketcambioCodigo, lxTicketcambioTobs, lxTicketcambioTfecha, lxTicketcambioTletra, lxTicketcambioTpventa, lxTicketcambioTnumero, lxTicketcambioTcliente, lxTicketcambioTclides, lxTicketcambioTcuit, lxTicketcambioThora, lxTicketcambioTvende, lxTicketcambioTipocomp, lxTicketcambioTnroart, lxTicketcambioTcantart
				lxTicketcambioFmodifw =  .Fechamodificacionfw			lxTicketcambioFectrans =  .Fechatransferencia			lxTicketcambioFaltafw =  .Fechaaltafw			lxTicketcambioFecimpo =  .Fechaimpo			lxTicketcambioFecexpo =  .Fechaexpo			lxTicketcambioHoraexpo =  .Horaexpo			lxTicketcambioHaltafw =  .Horaaltafw			lxTicketcambioHoraimpo =  .Horaimpo			lxTicketcambioUaltafw =  .Usuarioaltafw			lxTicketcambioVmodifw =  .Versionmodificacionfw			lxTicketcambioZadsfw =  .Zadsfw			lxTicketcambioValtafw =  .Versionaltafw			lxTicketcambioUmodifw =  .Usuariomodificacionfw			lxTicketcambioSaltafw =  .Seriealtafw			lxTicketcambioSmodifw =  .Seriemodificacionfw			lxTicketcambioHmodifw =  .Horamodificacionfw			lxTicketcambioBdmodifw =  .Basededatosmodificacionfw			lxTicketcambioBdaltafw =  .Basededatosaltafw			lxTicketcambioEsttrans =  .Estadotransferencia			lxTicketcambioCodigo =  .Codigo			lxTicketcambioTobs =  .Obs			lxTicketcambioTfecha =  .Fecha			lxTicketcambioTletra =  .Letra			lxTicketcambioTpventa =  .Puntodeventa			lxTicketcambioTnumero =  .Numero			lxTicketcambioTcliente =  upper( .Cliente_PK ) 			lxTicketcambioTclides =  .Clientedescripcion			lxTicketcambioTcuit =  .Cuit			lxTicketcambioThora =  .Hora			lxTicketcambioTvende =  upper( .Vendedor_PK ) 			lxTicketcambioTipocomp =  .Tipocomprobante			lxTicketcambioTnroart =  .Nroart			lxTicketcambioTcantart =  .Cantart
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTicketcambioCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TICKETCAMBIO ( "Fmodifw","Fectrans","Faltafw","Fecimpo","Fecexpo","Horaexpo","Haltafw","Horaimpo","Ualtafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Tobs","Tfecha","Tletra","Tpventa","Tnumero","Tcliente","Tclides","Tcuit","Thora","Tvende","Tipocomp","Tnroart","Tcantart" ) values ( <<"'" + this.ConvertirDateSql( lxTicketcambioFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioTfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTletra ) + "'" >>, <<lxTicketcambioTpventa >>, <<lxTicketcambioTnumero >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTclides ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioThora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTvende ) + "'" >>, <<lxTicketcambioTipocomp >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTnroart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTcantart ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleComprobante
				if this.oEntidad.DetalleComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TICKETCAMBIODET("Codigo","tdArt","tdArtDes","tdColor","tdColDes","tdTalle","tdTalleDes","tdCant","Comp","NroItem" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxComportamiento>>, <<lxNroitem>> ) 
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
			local  lxTicketcambioFmodifw, lxTicketcambioFectrans, lxTicketcambioFaltafw, lxTicketcambioFecimpo, lxTicketcambioFecexpo, lxTicketcambioHoraexpo, lxTicketcambioHaltafw, lxTicketcambioHoraimpo, lxTicketcambioUaltafw, lxTicketcambioVmodifw, lxTicketcambioZadsfw, lxTicketcambioValtafw, lxTicketcambioUmodifw, lxTicketcambioSaltafw, lxTicketcambioSmodifw, lxTicketcambioHmodifw, lxTicketcambioBdmodifw, lxTicketcambioBdaltafw, lxTicketcambioEsttrans, lxTicketcambioCodigo, lxTicketcambioTobs, lxTicketcambioTfecha, lxTicketcambioTletra, lxTicketcambioTpventa, lxTicketcambioTnumero, lxTicketcambioTcliente, lxTicketcambioTclides, lxTicketcambioTcuit, lxTicketcambioThora, lxTicketcambioTvende, lxTicketcambioTipocomp, lxTicketcambioTnroart, lxTicketcambioTcantart
				lxTicketcambioFmodifw =  .Fechamodificacionfw			lxTicketcambioFectrans =  .Fechatransferencia			lxTicketcambioFaltafw =  .Fechaaltafw			lxTicketcambioFecimpo =  .Fechaimpo			lxTicketcambioFecexpo =  .Fechaexpo			lxTicketcambioHoraexpo =  .Horaexpo			lxTicketcambioHaltafw =  .Horaaltafw			lxTicketcambioHoraimpo =  .Horaimpo			lxTicketcambioUaltafw =  .Usuarioaltafw			lxTicketcambioVmodifw =  .Versionmodificacionfw			lxTicketcambioZadsfw =  .Zadsfw			lxTicketcambioValtafw =  .Versionaltafw			lxTicketcambioUmodifw =  .Usuariomodificacionfw			lxTicketcambioSaltafw =  .Seriealtafw			lxTicketcambioSmodifw =  .Seriemodificacionfw			lxTicketcambioHmodifw =  .Horamodificacionfw			lxTicketcambioBdmodifw =  .Basededatosmodificacionfw			lxTicketcambioBdaltafw =  .Basededatosaltafw			lxTicketcambioEsttrans =  .Estadotransferencia			lxTicketcambioCodigo =  .Codigo			lxTicketcambioTobs =  .Obs			lxTicketcambioTfecha =  .Fecha			lxTicketcambioTletra =  .Letra			lxTicketcambioTpventa =  .Puntodeventa			lxTicketcambioTnumero =  .Numero			lxTicketcambioTcliente =  upper( .Cliente_PK ) 			lxTicketcambioTclides =  .Clientedescripcion			lxTicketcambioTcuit =  .Cuit			lxTicketcambioThora =  .Hora			lxTicketcambioTvende =  upper( .Vendedor_PK ) 			lxTicketcambioTipocomp =  .Tipocomprobante			lxTicketcambioTnroart =  .Nroart			lxTicketcambioTcantart =  .Cantart
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TICKETCAMBIO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTicketcambioFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTicketcambioFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTicketcambioFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxTicketcambioFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxTicketcambioFecexpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTicketcambioHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTicketcambioHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTicketcambioZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTicketcambioEsttrans ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxTicketcambioCodigo ) + "'">>,"Tobs" = <<"'" + this.FormatearTextoSql( lxTicketcambioTobs ) + "'">>,"Tfecha" = <<"'" + this.ConvertirDateSql( lxTicketcambioTfecha ) + "'">>,"Tletra" = <<"'" + this.FormatearTextoSql( lxTicketcambioTletra ) + "'">>,"Tpventa" = <<lxTicketcambioTpventa>>,"Tnumero" = <<lxTicketcambioTnumero>>,"Tcliente" = <<"'" + this.FormatearTextoSql( lxTicketcambioTcliente ) + "'">>,"Tclides" = <<"'" + this.FormatearTextoSql( lxTicketcambioTclides ) + "'">>,"Tcuit" = <<"'" + this.FormatearTextoSql( lxTicketcambioTcuit ) + "'">>,"Thora" = <<"'" + this.FormatearTextoSql( lxTicketcambioThora ) + "'">>,"Tvende" = <<"'" + this.FormatearTextoSql( lxTicketcambioTvende ) + "'">>,"Tipocomp" = <<lxTicketcambioTipocomp>>,"Tnroart" = <<"'" + this.FormatearTextoSql( lxTicketcambioTnroart ) + "'">>,"Tcantart" = <<"'" + this.FormatearTextoSql( lxTicketcambioTcantart ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxTicketcambioCodigo ) + "'">> and  TICKETCAMBIO.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TICKETCAMBIODET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleComprobante
				if this.oEntidad.DetalleComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TICKETCAMBIODET("Codigo","tdArt","tdArtDes","tdColor","tdColDes","tdTalle","tdTalleDes","tdCant","Comp","NroItem" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxComportamiento>>, <<lxNroitem>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.TICKETCAMBIO where " + this.ConvertirFuncionesSql( " TICKETCAMBIO.CODIGO != ''" ) )
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
			Local lxTicketcambioCodigo
			lxTicketcambioCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Tobs" as "Obs", "Tfecha" as "Fecha", "Tletra" as "Letra", "Tpventa" as "Puntodeventa", "Tnumero" as "Numero", "Tcliente" as "Cliente", "Tclides" as "Clientedescripcion", "Tcuit" as "Cuit", "Thora" as "Hora", "Tvende" as "Vendedor", "Tipocomp" as "Tipocomprobante", "Tnroart" as "Nroart", "Tcantart" as "Cantart" from ZooLogic.TICKETCAMBIO where "Codigo" = <<"'" + this.FormatearTextoSql( lxTicketcambioCodigo ) + "'">> and  TICKETCAMBIO.CODIGO != ''
			endtext
			use in select('c_TIQUETDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIQUETDECAMBIO', set( 'Datasession' ) )

			if reccount( 'c_TIQUETDECAMBIO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Tdart" as "Articulo", "Tdartdes" as "Articulodetalle", "Tdcolor" as "Color", "Tdcoldes" as "Colordetalle", "Tdtalle" as "Talle", "Tdtalledes" as "Talledetalle", "Tdcant" as "Cantidad", "Comp" as "Comportamiento", "Nroitem" as "Nroitem" from ZooLogic.TICKETCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_TIQUETDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobante
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxTICKETCAMBIOTipoComp As Variant, lxTICKETCAMBIOtLetra As Variant, lxTICKETCAMBIOtPVenta As Variant, lxTICKETCAMBIOtNumero As Variant, lxTICKETCAMBIOtNroArt As Variant, lxTICKETCAMBIOtCantArt As Variant
			lxTICKETCAMBIOTipoComp = .TipoComprobante
			lxTICKETCAMBIOtLetra = .Letra
			lxTICKETCAMBIOtPVenta = .PuntoDeVenta
			lxTICKETCAMBIOtNumero = .Numero
			lxTICKETCAMBIOtNroArt = .NroArt
			lxTICKETCAMBIOtCantArt = .CantArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Tobs" as "Obs", "Tfecha" as "Fecha", "Tletra" as "Letra", "Tpventa" as "Puntodeventa", "Tnumero" as "Numero", "Tcliente" as "Cliente", "Tclides" as "Clientedescripcion", "Tcuit" as "Cuit", "Thora" as "Hora", "Tvende" as "Vendedor", "Tipocomp" as "Tipocomprobante", "Tnroart" as "Nroart", "Tcantart" as "Cantart" from ZooLogic.TICKETCAMBIO where  TICKETCAMBIO.CODIGO != '' And TipoComp = <<lxTICKETCAMBIOTipoComp>> and tLetra = <<"'" + this.FormatearTextoSql( lxTICKETCAMBIOtLetra ) + "'">> and tPVenta = <<lxTICKETCAMBIOtPVenta>> and tNumero = <<lxTICKETCAMBIOtNumero>> and tNroArt = <<"'" + this.FormatearTextoSql( lxTICKETCAMBIOtNroArt ) + "'">> and tCantArt = <<"'" + this.FormatearTextoSql( lxTICKETCAMBIOtCantArt ) + "'">>
			endtext
			use in select('c_TIQUETDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIQUETDECAMBIO', set( 'Datasession' ) )
			if reccount( 'c_TIQUETDECAMBIO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Tdart" as "Articulo", "Tdartdes" as "Articulodetalle", "Tdcolor" as "Color", "Tdcoldes" as "Colordetalle", "Tdtalle" as "Talle", "Tdtalledes" as "Talledetalle", "Tdcant" as "Cantidad", "Comp" as "Comportamiento", "Nroitem" as "Nroitem" from ZooLogic.TICKETCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_TIQUETDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobante
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTicketcambioCodigo as Variant
		llRetorno = .t.
		lxTicketcambioCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TICKETCAMBIO where "Codigo" = <<"'" + this.FormatearTextoSql( lxTicketcambioCodigo ) + "'">> and  TICKETCAMBIO.CODIGO != ''
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .NroArt + .CantArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Tobs" as "Obs", "Tfecha" as "Fecha", "Tletra" as "Letra", "Tpventa" as "Puntodeventa", "Tnumero" as "Numero", "Tcliente" as "Cliente", "Tclides" as "Clientedescripcion", "Tcuit" as "Cuit", "Thora" as "Hora", "Tvende" as "Vendedor", "Tipocomp" as "Tipocomprobante", "Tnroart" as "Nroart", "Tcantart" as "Cantart" from ZooLogic.TICKETCAMBIO where  TICKETCAMBIO.CODIGO != '' order by TipoComp,tLetra,tPVenta,tNumero,tNroArt,tCantArt
			endtext
			use in select('c_TIQUETDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIQUETDECAMBIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Tdart" as "Articulo", "Tdartdes" as "Articulodetalle", "Tdcolor" as "Color", "Tdcoldes" as "Colordetalle", "Tdtalle" as "Talle", "Tdtalledes" as "Talledetalle", "Tdcant" as "Cantidad", "Comp" as "Comportamiento", "Nroitem" as "Nroitem" from ZooLogic.TICKETCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_TIQUETDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobante
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .NroArt + .CantArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Tobs" as "Obs", "Tfecha" as "Fecha", "Tletra" as "Letra", "Tpventa" as "Puntodeventa", "Tnumero" as "Numero", "Tcliente" as "Cliente", "Tclides" as "Clientedescripcion", "Tcuit" as "Cuit", "Thora" as "Hora", "Tvende" as "Vendedor", "Tipocomp" as "Tipocomprobante", "Tnroart" as "Nroart", "Tcantart" as "Cantart" from ZooLogic.TICKETCAMBIO where  str( TipoComp, 2, 0) + funciones.padr( tLetra, 1, ' ' ) + str( tPVenta, 4, 0) + str( tNumero, 8, 0) + funciones.padr( tNroArt, 5, ' ' ) + funciones.padr( tCantArt, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TICKETCAMBIO.CODIGO != '' order by TipoComp,tLetra,tPVenta,tNumero,tNroArt,tCantArt
			endtext
			use in select('c_TIQUETDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIQUETDECAMBIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Tdart" as "Articulo", "Tdartdes" as "Articulodetalle", "Tdcolor" as "Color", "Tdcoldes" as "Colordetalle", "Tdtalle" as "Talle", "Tdtalledes" as "Talledetalle", "Tdcant" as "Cantidad", "Comp" as "Comportamiento", "Nroitem" as "Nroitem" from ZooLogic.TICKETCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_TIQUETDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobante
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .NroArt + .CantArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Tobs" as "Obs", "Tfecha" as "Fecha", "Tletra" as "Letra", "Tpventa" as "Puntodeventa", "Tnumero" as "Numero", "Tcliente" as "Cliente", "Tclides" as "Clientedescripcion", "Tcuit" as "Cuit", "Thora" as "Hora", "Tvende" as "Vendedor", "Tipocomp" as "Tipocomprobante", "Tnroart" as "Nroart", "Tcantart" as "Cantart" from ZooLogic.TICKETCAMBIO where  str( TipoComp, 2, 0) + funciones.padr( tLetra, 1, ' ' ) + str( tPVenta, 4, 0) + str( tNumero, 8, 0) + funciones.padr( tNroArt, 5, ' ' ) + funciones.padr( tCantArt, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TICKETCAMBIO.CODIGO != '' order by TipoComp desc,tLetra desc,tPVenta desc,tNumero desc,tNroArt desc,tCantArt desc
			endtext
			use in select('c_TIQUETDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIQUETDECAMBIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Tdart" as "Articulo", "Tdartdes" as "Articulodetalle", "Tdcolor" as "Color", "Tdcoldes" as "Colordetalle", "Tdtalle" as "Talle", "Tdtalledes" as "Talledetalle", "Tdcant" as "Cantidad", "Comp" as "Comportamiento", "Nroitem" as "Nroitem" from ZooLogic.TICKETCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_TIQUETDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobante
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .NroArt + .CantArt
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Tobs" as "Obs", "Tfecha" as "Fecha", "Tletra" as "Letra", "Tpventa" as "Puntodeventa", "Tnumero" as "Numero", "Tcliente" as "Cliente", "Tclides" as "Clientedescripcion", "Tcuit" as "Cuit", "Thora" as "Hora", "Tvende" as "Vendedor", "Tipocomp" as "Tipocomprobante", "Tnroart" as "Nroart", "Tcantart" as "Cantart" from ZooLogic.TICKETCAMBIO where  TICKETCAMBIO.CODIGO != '' order by TipoComp desc,tLetra desc,tPVenta desc,tNumero desc,tNroArt desc,tCantArt desc
			endtext
			use in select('c_TIQUETDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIQUETDECAMBIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Tdart" as "Articulo", "Tdartdes" as "Articulodetalle", "Tdcolor" as "Color", "Tdcoldes" as "Colordetalle", "Tdtalle" as "Talle", "Tdtalledes" as "Talledetalle", "Tdcant" as "Cantidad", "Comp" as "Comportamiento", "Nroitem" as "Nroitem" from ZooLogic.TICKETCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_TIQUETDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleComprobante
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Faltafw,Fecimpo,Fecexpo,Horaexpo,Haltafw,Horaimpo,Ualtafw,Vmodifw,Zadsfw,Va" + ;
"ltafw,Umodifw,Saltafw,Smodifw,Hmodifw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Tobs,Tfecha,Tletra,Tpventa,T" + ;
"numero,Tcliente,Tclides,Tcuit,Thora,Tvende,Tipocomp,Tnroart,Tcantart" + ;
" from ZooLogic.TICKETCAMBIO where  TICKETCAMBIO.CODIGO != '' and " + lcFiltro )
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
			local  lxTicketcambioFmodifw, lxTicketcambioFectrans, lxTicketcambioFaltafw, lxTicketcambioFecimpo, lxTicketcambioFecexpo, lxTicketcambioHoraexpo, lxTicketcambioHaltafw, lxTicketcambioHoraimpo, lxTicketcambioUaltafw, lxTicketcambioVmodifw, lxTicketcambioZadsfw, lxTicketcambioValtafw, lxTicketcambioUmodifw, lxTicketcambioSaltafw, lxTicketcambioSmodifw, lxTicketcambioHmodifw, lxTicketcambioBdmodifw, lxTicketcambioBdaltafw, lxTicketcambioEsttrans, lxTicketcambioCodigo, lxTicketcambioTobs, lxTicketcambioTfecha, lxTicketcambioTletra, lxTicketcambioTpventa, lxTicketcambioTnumero, lxTicketcambioTcliente, lxTicketcambioTclides, lxTicketcambioTcuit, lxTicketcambioThora, lxTicketcambioTvende, lxTicketcambioTipocomp, lxTicketcambioTnroart, lxTicketcambioTcantart
				lxTicketcambioFmodifw = ctod( '  /  /    ' )			lxTicketcambioFectrans = ctod( '  /  /    ' )			lxTicketcambioFaltafw = ctod( '  /  /    ' )			lxTicketcambioFecimpo = ctod( '  /  /    ' )			lxTicketcambioFecexpo = ctod( '  /  /    ' )			lxTicketcambioHoraexpo = []			lxTicketcambioHaltafw = []			lxTicketcambioHoraimpo = []			lxTicketcambioUaltafw = []			lxTicketcambioVmodifw = []			lxTicketcambioZadsfw = []			lxTicketcambioValtafw = []			lxTicketcambioUmodifw = []			lxTicketcambioSaltafw = []			lxTicketcambioSmodifw = []			lxTicketcambioHmodifw = []			lxTicketcambioBdmodifw = []			lxTicketcambioBdaltafw = []			lxTicketcambioEsttrans = []			lxTicketcambioCodigo = []			lxTicketcambioTobs = []			lxTicketcambioTfecha = ctod( '  /  /    ' )			lxTicketcambioTletra = []			lxTicketcambioTpventa = 0			lxTicketcambioTnumero = 0			lxTicketcambioTcliente = []			lxTicketcambioTclides = []			lxTicketcambioTcuit = []			lxTicketcambioThora = []			lxTicketcambioTvende = []			lxTicketcambioTipocomp = 0			lxTicketcambioTnroart = []			lxTicketcambioTcantart = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TICKETCAMBIODET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.TICKETCAMBIO where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TICKETCAMBIO' + '_' + tcCampo
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
		lcWhere = " Where  TICKETCAMBIO.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Tobs" as "Obs", "Tfecha" as "Fecha", "Tletra" as "Letra", "Tpventa" as "Puntodeventa", "Tnumero" as "Numero", "Tcliente" as "Cliente", "Tclides" as "Clientedescripcion", "Tcuit" as "Cuit", "Thora" as "Hora", "Tvende" as "Vendedor", "Tipocomp" as "Tipocomprobante", "Tnroart" as "Nroart", "Tcantart" as "Cantart"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TICKETCAMBIO', '', tnTope )
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
	Function ObtenerDatosDetalleDetalleComprobante( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  TICKETCAMBIODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codigo" as "Codigo", "Tdart" as "Articulo", "Tdartdes" as "Articulodetalle", "Tdcolor" as "Color", "Tdcoldes" as "Colordetalle", "Tdtalle" as "Talle", "Tdtalledes" as "Talledetalle", "Tdcant" as "Cantidad", "Comp" as "Comportamiento", "Nroitem" as "Nroitem"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleComprobante( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TICKETCAMBIODET', 'DetalleComprobante', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleComprobante( lcAtributo )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOBS AS OBS'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TFECHA AS FECHA'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TLETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TPVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TNUMERO AS NUMERO'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCLIENTE AS CLIENTE'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCLIDES AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCUIT AS CUIT'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'THORA AS HORA'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TVENDE AS VENDEDOR'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'NROART'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TNROART AS NROART'
				Case lcAtributo == 'CANTART'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCANTART AS CANTART'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDARTDES AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDCOLDES AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDTALLEDES AS TALLEDETALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDCANT AS CANTIDAD'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'TOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'TFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'TLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'TPVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'TNUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'TCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'TCLIDES'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'TCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'THORA'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'TVENDE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROART'
				lcCampo = 'TNROART'
			Case upper( alltrim( tcAtributo ) ) == 'CANTART'
				lcCampo = 'TCANTART'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleComprobante( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'TDART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'TDARTDES'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'TDCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'TDCOLDES'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TDTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'TDTALLEDES'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'TDCANT'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLECOMPROBANTE'
			lcRetorno = 'TICKETCAMBIODET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxTicketcambioFmodifw, lxTicketcambioFectrans, lxTicketcambioFaltafw, lxTicketcambioFecimpo, lxTicketcambioFecexpo, lxTicketcambioHoraexpo, lxTicketcambioHaltafw, lxTicketcambioHoraimpo, lxTicketcambioUaltafw, lxTicketcambioVmodifw, lxTicketcambioZadsfw, lxTicketcambioValtafw, lxTicketcambioUmodifw, lxTicketcambioSaltafw, lxTicketcambioSmodifw, lxTicketcambioHmodifw, lxTicketcambioBdmodifw, lxTicketcambioBdaltafw, lxTicketcambioEsttrans, lxTicketcambioCodigo, lxTicketcambioTobs, lxTicketcambioTfecha, lxTicketcambioTletra, lxTicketcambioTpventa, lxTicketcambioTnumero, lxTicketcambioTcliente, lxTicketcambioTclides, lxTicketcambioTcuit, lxTicketcambioThora, lxTicketcambioTvende, lxTicketcambioTipocomp, lxTicketcambioTnroart, lxTicketcambioTcantart
				lxTicketcambioFmodifw =  .Fechamodificacionfw			lxTicketcambioFectrans =  .Fechatransferencia			lxTicketcambioFaltafw =  .Fechaaltafw			lxTicketcambioFecimpo =  .Fechaimpo			lxTicketcambioFecexpo =  .Fechaexpo			lxTicketcambioHoraexpo =  .Horaexpo			lxTicketcambioHaltafw =  .Horaaltafw			lxTicketcambioHoraimpo =  .Horaimpo			lxTicketcambioUaltafw =  .Usuarioaltafw			lxTicketcambioVmodifw =  .Versionmodificacionfw			lxTicketcambioZadsfw =  .Zadsfw			lxTicketcambioValtafw =  .Versionaltafw			lxTicketcambioUmodifw =  .Usuariomodificacionfw			lxTicketcambioSaltafw =  .Seriealtafw			lxTicketcambioSmodifw =  .Seriemodificacionfw			lxTicketcambioHmodifw =  .Horamodificacionfw			lxTicketcambioBdmodifw =  .Basededatosmodificacionfw			lxTicketcambioBdaltafw =  .Basededatosaltafw			lxTicketcambioEsttrans =  .Estadotransferencia			lxTicketcambioCodigo =  .Codigo			lxTicketcambioTobs =  .Obs			lxTicketcambioTfecha =  .Fecha			lxTicketcambioTletra =  .Letra			lxTicketcambioTpventa =  .Puntodeventa			lxTicketcambioTnumero =  .Numero			lxTicketcambioTcliente =  upper( .Cliente_PK ) 			lxTicketcambioTclides =  .Clientedescripcion			lxTicketcambioTcuit =  .Cuit			lxTicketcambioThora =  .Hora			lxTicketcambioTvende =  upper( .Vendedor_PK ) 			lxTicketcambioTipocomp =  .Tipocomprobante			lxTicketcambioTnroart =  .Nroart			lxTicketcambioTcantart =  .Cantart
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TICKETCAMBIO ( "Fmodifw","Fectrans","Faltafw","Fecimpo","Fecexpo","Horaexpo","Haltafw","Horaimpo","Ualtafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Smodifw","Hmodifw","Bdmodifw","Bdaltafw","Esttrans","Codigo","Tobs","Tfecha","Tletra","Tpventa","Tnumero","Tcliente","Tclides","Tcuit","Thora","Tvende","Tipocomp","Tnroart","Tcantart" ) values ( <<"'" + this.ConvertirDateSql( lxTicketcambioFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTicketcambioTfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTletra ) + "'" >>, <<lxTicketcambioTpventa >>, <<lxTicketcambioTnumero >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTclides ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioThora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTvende ) + "'" >>, <<lxTicketcambioTipocomp >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTnroart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTicketcambioTcantart ) + "'" >> )
		endtext
		loColeccion.cTabla = 'TICKETCAMBIO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleComprobante
				if this.oEntidad.DetalleComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TICKETCAMBIODET("Codigo","tdArt","tdArtDes","tdColor","tdColDes","tdTalle","tdTalleDes","tdCant","Comp","NroItem" ) values ( << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxComportamiento>>, <<lxNroitem>> ) 
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
			local  lxTicketcambioFmodifw, lxTicketcambioFectrans, lxTicketcambioFaltafw, lxTicketcambioFecimpo, lxTicketcambioFecexpo, lxTicketcambioHoraexpo, lxTicketcambioHaltafw, lxTicketcambioHoraimpo, lxTicketcambioUaltafw, lxTicketcambioVmodifw, lxTicketcambioZadsfw, lxTicketcambioValtafw, lxTicketcambioUmodifw, lxTicketcambioSaltafw, lxTicketcambioSmodifw, lxTicketcambioHmodifw, lxTicketcambioBdmodifw, lxTicketcambioBdaltafw, lxTicketcambioEsttrans, lxTicketcambioCodigo, lxTicketcambioTobs, lxTicketcambioTfecha, lxTicketcambioTletra, lxTicketcambioTpventa, lxTicketcambioTnumero, lxTicketcambioTcliente, lxTicketcambioTclides, lxTicketcambioTcuit, lxTicketcambioThora, lxTicketcambioTvende, lxTicketcambioTipocomp, lxTicketcambioTnroart, lxTicketcambioTcantart
				lxTicketcambioFmodifw =  .Fechamodificacionfw			lxTicketcambioFectrans =  .Fechatransferencia			lxTicketcambioFaltafw =  .Fechaaltafw			lxTicketcambioFecimpo =  .Fechaimpo			lxTicketcambioFecexpo =  .Fechaexpo			lxTicketcambioHoraexpo =  .Horaexpo			lxTicketcambioHaltafw =  .Horaaltafw			lxTicketcambioHoraimpo =  .Horaimpo			lxTicketcambioUaltafw =  .Usuarioaltafw			lxTicketcambioVmodifw =  .Versionmodificacionfw			lxTicketcambioZadsfw =  .Zadsfw			lxTicketcambioValtafw =  .Versionaltafw			lxTicketcambioUmodifw =  .Usuariomodificacionfw			lxTicketcambioSaltafw =  .Seriealtafw			lxTicketcambioSmodifw =  .Seriemodificacionfw			lxTicketcambioHmodifw =  .Horamodificacionfw			lxTicketcambioBdmodifw =  .Basededatosmodificacionfw			lxTicketcambioBdaltafw =  .Basededatosaltafw			lxTicketcambioEsttrans =  .Estadotransferencia			lxTicketcambioCodigo =  .Codigo			lxTicketcambioTobs =  .Obs			lxTicketcambioTfecha =  .Fecha			lxTicketcambioTletra =  .Letra			lxTicketcambioTpventa =  .Puntodeventa			lxTicketcambioTnumero =  .Numero			lxTicketcambioTcliente =  upper( .Cliente_PK ) 			lxTicketcambioTclides =  .Clientedescripcion			lxTicketcambioTcuit =  .Cuit			lxTicketcambioThora =  .Hora			lxTicketcambioTvende =  upper( .Vendedor_PK ) 			lxTicketcambioTipocomp =  .Tipocomprobante			lxTicketcambioTnroart =  .Nroart			lxTicketcambioTcantart =  .Cantart
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TICKETCAMBIO.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.TICKETCAMBIO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTicketcambioFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTicketcambioFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTicketcambioFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTicketcambioFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTicketcambioFecexpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTicketcambioHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTicketcambioHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTicketcambioZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTicketcambioBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTicketcambioBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTicketcambioEsttrans ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxTicketcambioCodigo ) + "'">>, "Tobs" = <<"'" + this.FormatearTextoSql( lxTicketcambioTobs ) + "'">>, "Tfecha" = <<"'" + this.ConvertirDateSql( lxTicketcambioTfecha ) + "'">>, "Tletra" = <<"'" + this.FormatearTextoSql( lxTicketcambioTletra ) + "'">>, "Tpventa" = <<lxTicketcambioTpventa>>, "Tnumero" = <<lxTicketcambioTnumero>>, "Tcliente" = <<"'" + this.FormatearTextoSql( lxTicketcambioTcliente ) + "'">>, "Tclides" = <<"'" + this.FormatearTextoSql( lxTicketcambioTclides ) + "'">>, "Tcuit" = <<"'" + this.FormatearTextoSql( lxTicketcambioTcuit ) + "'">>, "Thora" = <<"'" + this.FormatearTextoSql( lxTicketcambioThora ) + "'">>, "Tvende" = <<"'" + this.FormatearTextoSql( lxTicketcambioTvende ) + "'">>, "Tipocomp" = <<lxTicketcambioTipocomp>>, "Tnroart" = <<"'" + this.FormatearTextoSql( lxTicketcambioTnroart ) + "'">>, "Tcantart" = <<"'" + this.FormatearTextoSql( lxTicketcambioTcantart ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TICKETCAMBIO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.TICKETCAMBIODET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleComprobante
				if this.oEntidad.DetalleComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TICKETCAMBIODET("Codigo","tdArt","tdArtDes","tdColor","tdColDes","tdTalle","tdTalleDes","tdCant","Comp","NroItem" ) values ( << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxComportamiento>>, <<lxNroitem>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TICKETCAMBIO.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.TICKETCAMBIO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.TICKETCAMBIODET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'TICKETCAMBIO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TICKETCAMBIO where  TICKETCAMBIO.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TICKETCAMBIO where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  TICKETCAMBIO.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxTICKETCAMBIOtLetra as variant, lxTICKETCAMBIOtPVenta as variant, lxTICKETCAMBIOtNumero as variant, lxTICKETCAMBIOTipoComp as variant, lxTICKETCAMBIOtNroArt as variant, lxTICKETCAMBIOtCantArt as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIQUETDECAMBIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TICKETCAMBIO Where  TipoComp = ] + transform( &lcCursor..TipoComp   ) + [ and tLetra = ] + "'" + this.FormatearTextoSql( &lcCursor..tLetra     ) + "'" + [ and tPVenta = ] + transform( &lcCursor..tPVenta    ) + [ and tNumero = ] + transform( &lcCursor..tNumero    ) + [ and tNroArt = ] + "'" + this.FormatearTextoSql( &lcCursor..tNroArt    ) + "'" + [ and tCantArt = ] + "'" + this.FormatearTextoSql( &lcCursor..tCantArt   ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.TICKETCAMBIO set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, tObs = ] + "'" + this.FormatearTextoSql( &lcCursor..tObs ) + "'"+ [, tFecha = ] + "'" + this.ConvertirDateSql( &lcCursor..tFecha ) + "'"+ [, tLetra = ] + "'" + this.FormatearTextoSql( &lcCursor..tLetra ) + "'"+ [, tPVenta = ] + transform( &lcCursor..tPVenta )+ [, tNumero = ] + transform( &lcCursor..tNumero )+ [, tCliente = ] + "'" + this.FormatearTextoSql( &lcCursor..tCliente ) + "'"+ [, tCliDes = ] + "'" + this.FormatearTextoSql( &lcCursor..tCliDes ) + "'"+ [, tCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..tCuit ) + "'"+ [, tHora = ] + "'" + this.FormatearTextoSql( &lcCursor..tHora ) + "'"+ [, tVende = ] + "'" + this.FormatearTextoSql( &lcCursor..tVende ) + "'"+ [, TipoComp = ] + transform( &lcCursor..TipoComp )+ [, tNroArt = ] + "'" + this.FormatearTextoSql( &lcCursor..tNroArt ) + "'"+ [, tCantArt = ] + "'" + this.FormatearTextoSql( &lcCursor..tCantArt ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.TICKETCAMBIO Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FECTRANS, FALTAFW, FECIMPO, FECEXPO, HORAEXPO, HALTAFW, HORAIMPO, UALTAFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SALTAFW, SMODIFW, HMODIFW, BDMODIFW, BDALTAFW, ESTTRANS, Codigo, tObs, tFecha, tLetra, tPVenta, tNumero, tCliente, tCliDes, tCuit, tHora, tVende, TipoComp, tNroArt, tCantArt
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tObs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..tFecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tLetra ) + "'" + ',' + transform( &lcCursor..tPVenta ) + ',' + transform( &lcCursor..tNumero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..tCliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tCliDes ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tCuit ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..tHora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tVende ) + "'" + ',' + transform( &lcCursor..TipoComp ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..tNroArt ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tCantArt ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.TICKETCAMBIO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIQUETDECAMBIO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.TICKETCAMBIODET Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMTIQUETDECAMBIO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Codigo","tdArt","tdArtDes","tdColor","tdColDes","tdTalle","tdTalleDes","tdCant","Comp","NroItem"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.TICKETCAMBIODET ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.tdArt      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.tdArtDes   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.tdColor    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.tdColDes   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.tdTalle    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.tdTalleDes ) + "'" + ',' + transform( cDetallesExistentes.tdCant     ) + ',' + transform( cDetallesExistentes.Comp       ) + ',' + transform( cDetallesExistentes.NroItem    ) + ' )'  )
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
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Tipo de comprobante: ' + transform( &tcCursor..TipoComp   )
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..tLetra     )
		lcRetorno = lcRetorno + ' - Pto. venta: ' + transform( &tcCursor..tPVenta    )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..tNumero    )
		lcRetorno = lcRetorno + ' - Número de artículos: ' + transform( &tcCursor..tNroArt    )
		lcRetorno = lcRetorno + ' - Cantidad de artículo: ' + transform( &tcCursor..tCantArt   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'TIQUETDECAMBIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TIQUETDECAMBIO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TIQUETDECAMBIO_TOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMTIQUETDECAMBIO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TICKETCAMBIO')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TIQUETDECAMBIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..TipoComp ) or isnull( &lcCursor..tLetra ) or isnull( &lcCursor..tPVenta ) or isnull( &lcCursor..tNumero ) or isnull( &lcCursor..tNroArt ) or isnull( &lcCursor..tCantArt )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TIQUETDECAMBIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIQUETDECAMBIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( TipoComp, 2, 0) + tLetra + str( tPVenta, 4, 0) + str( tNumero, 8, 0) + tNroArt + tCantArt as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( TipoComp, 2, 0) + tLetra + str( tPVenta, 4, 0) + str( tNumero, 8, 0) + tNroArt + tCantArt, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIQUETDECAMBIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  tFecha    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TICKETCAMBIO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TICKETCAMBIO
Create Table ZooLogic.TablaTrabajo_TICKETCAMBIO ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"codigo" char( 38 )  null, 
"tobs" varchar(max)  null, 
"tfecha" datetime  null, 
"tletra" char( 1 )  null, 
"tpventa" numeric( 4, 0 )  null, 
"tnumero" numeric( 8, 0 )  null, 
"tcliente" char( 10 )  null, 
"tclides" char( 185 )  null, 
"tcuit" char( 15 )  null, 
"thora" char( 8 )  null, 
"tvende" char( 10 )  null, 
"tipocomp" numeric( 2, 0 )  null, 
"tnroart" char( 5 )  null, 
"tcantart" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TICKETCAMBIO' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TICKETCAMBIO' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIQUETDECAMBIO'
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
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('tobs','tobs')
			.AgregarMapeo('tfecha','tfecha')
			.AgregarMapeo('tletra','tletra')
			.AgregarMapeo('tpventa','tpventa')
			.AgregarMapeo('tnumero','tnumero')
			.AgregarMapeo('tcliente','tcliente')
			.AgregarMapeo('tclides','tclides')
			.AgregarMapeo('tcuit','tcuit')
			.AgregarMapeo('thora','thora')
			.AgregarMapeo('tvende','tvende')
			.AgregarMapeo('tipocomp','tipocomp')
			.AgregarMapeo('tnroart','tnroart')
			.AgregarMapeo('tcantart','tcantart')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TICKETCAMBIO'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.TOBS = isnull( d.TOBS, t.TOBS ),t.TFECHA = isnull( d.TFECHA, t.TFECHA ),t.TLETRA = isnull( d.TLETRA, t.TLETRA ),t.TPVENTA = isnull( d.TPVENTA, t.TPVENTA ),t.TNUMERO = isnull( d.TNUMERO, t.TNUMERO ),t.TCLIENTE = isnull( d.TCLIENTE, t.TCLIENTE ),t.TCLIDES = isnull( d.TCLIDES, t.TCLIDES ),t.TCUIT = isnull( d.TCUIT, t.TCUIT ),t.THORA = isnull( d.THORA, t.THORA ),t.TVENDE = isnull( d.TVENDE, t.TVENDE ),t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),t.TNROART = isnull( d.TNROART, t.TNROART ),t.TCANTART = isnull( d.TCANTART, t.TCANTART )
					from ZooLogic.TICKETCAMBIO t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.TipoComp = d.TipoComp
							 and  t.tLetra = d.tLetra
							 and  t.tPVenta = d.tPVenta
							 and  t.tNumero = d.tNumero
							 and  t.tNroArt = d.tNroArt
							 and  t.tCantArt = d.tCantArt
				-- Fin Updates
				insert into ZooLogic.TICKETCAMBIO(Fmodifw,Fectrans,Faltafw,Fecimpo,Fecexpo,Horaexpo,Haltafw,Horaimpo,Ualtafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Saltafw,Smodifw,Hmodifw,Bdmodifw,Bdaltafw,Esttrans,Codigo,Tobs,Tfecha,Tletra,Tpventa,Tnumero,Tcliente,Tclides,Tcuit,Thora,Tvende,Tipocomp,Tnroart,Tcantart)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CODIGO,''),isnull( d.TOBS,''),isnull( d.TFECHA,''),isnull( d.TLETRA,''),isnull( d.TPVENTA,0),isnull( d.TNUMERO,0),isnull( d.TCLIENTE,''),isnull( d.TCLIDES,''),isnull( d.TCUIT,''),isnull( d.THORA,''),isnull( d.TVENDE,''),isnull( d.TIPOCOMP,0),isnull( d.TNROART,''),isnull( d.TCANTART,'')
						From deleted d left join ZooLogic.TICKETCAMBIO pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.TICKETCAMBIO cc 
							 on  d.TipoComp = cc.TipoComp
							 and  d.tLetra = cc.tLetra
							 and  d.tPVenta = cc.tPVenta
							 and  d.tNumero = cc.tNumero
							 and  d.tNroArt = cc.tNroArt
							 and  d.tCantArt = cc.tCantArt
						Where pk.Codigo Is Null 
							 and cc.TipoComp Is Null 
							 and cc.tLetra Is Null 
							 and cc.tPVenta Is Null 
							 and cc.tNumero Is Null 
							 and cc.tNroArt Is Null 
							 and cc.tCantArt Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.TipoComp as Varchar(2) ) + ', LETRA ' + cast( d.tLetra as Varchar(1) ) + ', PTO. VENTA ' + cast( d.tPVenta as Varchar(4) ) + ', NÚMERO ' + cast( d.tNumero as Varchar(8) ) + ', NÚMERO DE ARTÍCULOS ' + cast( d.tNroArt as Varchar(5) ) + ', CANTIDAD DE ARTÍCULO ' + cast( d.tCantArt as Varchar(10) ) + '','La clave principal no es la esperada'
					from ZooLogic.TICKETCAMBIO t inner join deleted d 
							on   t.TipoComp = d.TipoComp
							 and  t.tLetra = d.tLetra
							 and  t.tPVenta = d.tPVenta
							 and  t.tNumero = d.tNumero
							 and  t.tNroArt = d.tNroArt
							 and  t.tCantArt = d.tCantArt
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.TipoComp as Varchar(2) ) + ', LETRA ' + cast( d.tLetra as Varchar(1) ) + ', PTO. VENTA ' + cast( d.tPVenta as Varchar(4) ) + ', NÚMERO ' + cast( d.tNumero as Varchar(8) ) + ', NÚMERO DE ARTÍCULOS ' + cast( d.tNroArt as Varchar(5) ) + ', CANTIDAD DE ARTÍCULO ' + cast( d.tCantArt as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ZooLogic.TICKETCAMBIO t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.TipoComp = h.TipoComp
							 and   t.tLetra = h.tLetra
							 and   t.tPVenta = h.tPVenta
							 and   t.tNumero = h.tNumero
							 and   t.tNroArt = h.tNroArt
							 and   t.tCantArt = h.tCantArt
							where   h.TipoComp is null 
							 and   h.tLetra is null 
							 and   h.tPVenta is null 
							 and   h.tNumero is null 
							 and   h.tNroArt is null 
							 and   h.tCantArt is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_TICKETCAMBIODET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_TICKETCAMBIO_TICKETCAMBIODET
ON ZooLogic.TablaTrabajo_TICKETCAMBIO_TICKETCAMBIODET
AFTER DELETE
As
Begin
Update t Set 
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.TDART = isnull( d.TDART, t.TDART ),
t.TDARTDES = isnull( d.TDARTDES, t.TDARTDES ),
t.TDCOLOR = isnull( d.TDCOLOR, t.TDCOLOR ),
t.TDCOLDES = isnull( d.TDCOLDES, t.TDCOLDES ),
t.TDTALLE = isnull( d.TDTALLE, t.TDTALLE ),
t.TDTALLEDES = isnull( d.TDTALLEDES, t.TDTALLEDES ),
t.TDCANT = isnull( d.TDCANT, t.TDCANT ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM )
from ZooLogic.TICKETCAMBIODET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.TICKETCAMBIODET
( 
"CODIGO",
"TDART",
"TDARTDES",
"TDCOLOR",
"TDCOLDES",
"TDTALLE",
"TDTALLEDES",
"TDCANT",
"COMP",
"NROITEM"
 )
Select 
d.CODIGO,
d.TDART,
d.TDARTDES,
d.TDCOLOR,
d.TDCOLDES,
d.TDTALLE,
d.TDTALLEDES,
d.TDCANT,
d.COMP,
d.NROITEM
From deleted d left join ZooLogic.TICKETCAMBIODET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TICKETCAMBIO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TICKETCAMBIO
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TIQUETDECAMBIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIQUETDECAMBIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIQUETDECAMBIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIQUETDECAMBIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIQUETDECAMBIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIQUETDECAMBIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_TIQUETDECAMBIO.Horaexpo, [] )
					.Horaaltafw = nvl( c_TIQUETDECAMBIO.Horaaltafw, [] )
					.Horaimpo = nvl( c_TIQUETDECAMBIO.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_TIQUETDECAMBIO.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_TIQUETDECAMBIO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_TIQUETDECAMBIO.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_TIQUETDECAMBIO.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_TIQUETDECAMBIO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_TIQUETDECAMBIO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_TIQUETDECAMBIO.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_TIQUETDECAMBIO.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_TIQUETDECAMBIO.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_TIQUETDECAMBIO.Estadotransferencia, [] )
					.Codigo = nvl( c_TIQUETDECAMBIO.Codigo, [] )
					.Detallecomprobante.Limpiar()
					.Detallecomprobante.SetearEsNavegacion( .lProcesando )
					.Detallecomprobante.Cargar()
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIQUETDECAMBIO.Fecha, ctod( '  /  /    ' ) ) )
					.Letra = nvl( c_TIQUETDECAMBIO.Letra, [] )
					.Puntodeventa = nvl( c_TIQUETDECAMBIO.Puntodeventa, 0 )
					.Numero = nvl( c_TIQUETDECAMBIO.Numero, 0 )
					.Cliente_PK =  nvl( c_TIQUETDECAMBIO.Cliente, [] )
					.Clientedescripcion = nvl( c_TIQUETDECAMBIO.Clientedescripcion, [] )
					.Cuit = nvl( c_TIQUETDECAMBIO.Cuit, [] )
					.Hora = nvl( c_TIQUETDECAMBIO.Hora, [] )
					.Vendedor_PK =  nvl( c_TIQUETDECAMBIO.Vendedor, [] )
					.Tipocomprobante = nvl( c_TIQUETDECAMBIO.Tipocomprobante, 0 )
					.Nroart = nvl( c_TIQUETDECAMBIO.Nroart, [] )
					.Cantart = nvl( c_TIQUETDECAMBIO.Cantart, [] )
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
			lxRetorno = c_TIQUETDECAMBIO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.DetalleComprobante
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
		return c_TIQUETDECAMBIO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TICKETCAMBIO' )
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
								from ZooLogic.TICKETCAMBIO 
								Where   TICKETCAMBIO.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TICKETCAMBIO", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Tobs" as "Obs", "Tfecha" as "Fecha", "Tletra" as "Letra", "Tpventa" as "Puntodeventa", "Tnumero" as "Numero", "Tcliente" as "Cliente", "Tclides" as "Clientedescripcion", "Tcuit" as "Cuit", "Thora" as "Hora", "Tvende" as "Vendedor", "Tipocomp" as "Tipocomprobante", "Tnroart" as "Nroart", "Tcantart" as "Cantart"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TICKETCAMBIO 
								Where   TICKETCAMBIO.CODIGO != ''
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
	Tabla = 'TICKETCAMBIO'
	Filtro = " TICKETCAMBIO.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TICKETCAMBIO.CODIGO != ''"
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
	<row entidad="TIQUETDECAMBIO                          " atributo="FECHAMODIFICACIONFW                     " tabla="TICKETCAMBIO   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="FECHATRANSFERENCIA                      " tabla="TICKETCAMBIO   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="FECHAALTAFW                             " tabla="TICKETCAMBIO   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="FECHAIMPO                               " tabla="TICKETCAMBIO   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="FECHAEXPO                               " tabla="TICKETCAMBIO   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="HORAEXPO                                " tabla="TICKETCAMBIO   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="HORAALTAFW                              " tabla="TICKETCAMBIO   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="HORAIMPO                                " tabla="TICKETCAMBIO   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="USUARIOALTAFW                           " tabla="TICKETCAMBIO   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="VERSIONMODIFICACIONFW                   " tabla="TICKETCAMBIO   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="ZADSFW                                  " tabla="TICKETCAMBIO   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="VERSIONALTAFW                           " tabla="TICKETCAMBIO   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="USUARIOMODIFICACIONFW                   " tabla="TICKETCAMBIO   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="SERIEALTAFW                             " tabla="TICKETCAMBIO   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="SERIEMODIFICACIONFW                     " tabla="TICKETCAMBIO   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="HORAMODIFICACIONFW                      " tabla="TICKETCAMBIO   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TICKETCAMBIO   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="BASEDEDATOSALTAFW                       " tabla="TICKETCAMBIO   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="ESTADOTRANSFERENCIA                     " tabla="TICKETCAMBIO   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="CODIGO                                  " tabla="TICKETCAMBIO   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="DETALLECOMPROBANTE                      " tabla="TICKETCAMBIODET" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Artículos para cambio                                                                                                                                           " dominio="DETALLEITEMTIQUETDECAMBIO     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="OBS                                     " tabla="TICKETCAMBIO   " campo="TOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="FECHA                                   " tabla="TICKETCAMBIO   " campo="TFECHA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="LETRA                                   " tabla="TICKETCAMBIO   " campo="TLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="PUNTODEVENTA                            " tabla="TICKETCAMBIO   " campo="TPVENTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Pto. venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="NUMERO                                  " tabla="TICKETCAMBIO   " campo="TNUMERO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="25" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="CLIENTE                                 " tabla="TICKETCAMBIO   " campo="TCLIENTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="30" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="CLIENTEDESCRIPCION                      " tabla="TICKETCAMBIO   " campo="TCLIDES   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="35" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="CUIT                                    " tabla="TICKETCAMBIO   " campo="TCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sit. fis.                                                                                                                                                       " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="Cliente.cuit                                                                                                                                                                                                                                                  " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="HORA                                    " tabla="TICKETCAMBIO   " campo="THORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="VENDEDOR                                " tabla="TICKETCAMBIO   " campo="TVENDE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGOVENDEDOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="TIPOCOMPROBANTE                         " tabla="TICKETCAMBIO   " campo="TIPOCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="55" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="NROART                                  " tabla="TICKETCAMBIO   " campo="TNROART   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número de artículos                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="60" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIQUETDECAMBIO                          " atributo="CANTART                                 " tabla="TICKETCAMBIO   " campo="TCANTART  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cantidad de artículo                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="6" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="65" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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