
define class Din_EntidadREMITOELECTRONICOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REMITOELECTRONICO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_RELPK'
	cTablaPrincipal = 'REMELEC'
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
			local  lxRemelecFecexpo, lxRemelecFaltafw, lxRemelecFecimpo, lxRemelecFmodifw, lxRemelecFectrans, lxRemelecFecsal, lxRemelecFecha, lxRemelecNumero, lxRemelecHoraimpo, lxRemelecSmodifw, lxRemelecHmodifw, lxRemelecVmodifw, lxRemelecZadsfw, lxRemelecValtafw, lxRemelecUmodifw, lxRemelecHoraexpo, lxRemelecUaltafw, lxRemelecSaltafw, lxRemelecEsttrans, lxRemelecCodint, lxRemelecHaltafw, lxRemelecBdaltafw, lxRemelecBdmodifw, lxRemelecEntrega, lxRemelecTransporti, lxRemelecObs, lxRemelecDomveh, lxRemelecHora, lxRemelecSucursal, lxRemelecDomacop, lxRemelecBultos
				lxRemelecFecexpo =  .Fechaexpo			lxRemelecFaltafw =  .Fechaaltafw			lxRemelecFecimpo =  .Fechaimpo			lxRemelecFmodifw =  .Fechamodificacionfw			lxRemelecFectrans =  .Fechatransferencia			lxRemelecFecsal =  .Fechasalida			lxRemelecFecha =  .Fecha			lxRemelecNumero =  .Numero			lxRemelecHoraimpo =  .Horaimpo			lxRemelecSmodifw =  .Seriemodificacionfw			lxRemelecHmodifw =  .Horamodificacionfw			lxRemelecVmodifw =  .Versionmodificacionfw			lxRemelecZadsfw =  .Zadsfw			lxRemelecValtafw =  .Versionaltafw			lxRemelecUmodifw =  .Usuariomodificacionfw			lxRemelecHoraexpo =  .Horaexpo			lxRemelecUaltafw =  .Usuarioaltafw			lxRemelecSaltafw =  .Seriealtafw			lxRemelecEsttrans =  .Estadotransferencia			lxRemelecCodint =  .Codigointegridad			lxRemelecHaltafw =  .Horaaltafw			lxRemelecBdaltafw =  .Basededatosaltafw			lxRemelecBdmodifw =  .Basededatosmodificacionfw			lxRemelecEntrega =  .Entregaenorigen			lxRemelecTransporti =  upper( .Transportista_PK ) 			lxRemelecObs =  .Observacion			lxRemelecDomveh =  .Dominiovehiculo			lxRemelecHora =  .Hora			lxRemelecSucursal =  upper( .Sucursal_PK ) 			lxRemelecDomacop =  .Dominioacoplado			lxRemelecBultos =  .Bultos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRemelecNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.REMELEC ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Fecsal","Fecha","Numero","Horaimpo","Smodifw","Hmodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Horaexpo","Ualtafw","Saltafw","Esttrans","Codint","Haltafw","Bdaltafw","Bdmodifw","Entrega","Transporti","Obs","Domveh","Hora","Sucursal","Domacop","Bultos" ) values ( <<"'" + this.ConvertirDateSql( lxRemelecFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFecsal ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFecha ) + "'" >>, <<lxRemelecNumero >>, <<"'" + this.FormatearTextoSql( lxRemelecHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecCodint ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecBdmodifw ) + "'" >>, <<iif( lxRemelecEntrega, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxRemelecTransporti ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecDomveh ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecSucursal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecDomacop ) + "'" >>, <<lxRemelecBultos >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDeRemitos
				if this.oEntidad.DetalleDeRemitos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxImporteneto = loItem.Importeneto
					lxNroitem = lnContadorNroItem
					lxComprobante_PK = loItem.Comprobante_PK
					lxRemito = loItem.Remito
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxDireccion = loItem.Direccion
					lxCantidad = loItem.Cantidad
					lxNoterminadodevuelto = loItem.Noterminadodevuelto
					lxImportetotal = loItem.Importetotal
					lxProcesado = loItem.Procesado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detremelec("Codigo","ImpNeto","NROITEM","Comprob","Remito","Cliente","Cliedeta","Direccion","Cantidad","Notermdev","Importe","Procesado" ) values ( <<transform( lxValorClavePrimaria )>>, <<lxImporteneto>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxComprobante_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRemito ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxDireccion ) + "'">>, <<lxCantidad>>, <<iif( lxNoterminadodevuelto, 1, 0 )>>, <<lxImportetotal>>, <<"'" + this.FormatearTextoSql( lxProcesado ) + "'">> ) 
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
		endif
		if !empty( lcError )
			goServicios.Errores.LevantarExcepcionTexto( lcError )
		endif
		return this.oEntidad.NUMERO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxRemelecFecexpo, lxRemelecFaltafw, lxRemelecFecimpo, lxRemelecFmodifw, lxRemelecFectrans, lxRemelecFecsal, lxRemelecFecha, lxRemelecNumero, lxRemelecHoraimpo, lxRemelecSmodifw, lxRemelecHmodifw, lxRemelecVmodifw, lxRemelecZadsfw, lxRemelecValtafw, lxRemelecUmodifw, lxRemelecHoraexpo, lxRemelecUaltafw, lxRemelecSaltafw, lxRemelecEsttrans, lxRemelecCodint, lxRemelecHaltafw, lxRemelecBdaltafw, lxRemelecBdmodifw, lxRemelecEntrega, lxRemelecTransporti, lxRemelecObs, lxRemelecDomveh, lxRemelecHora, lxRemelecSucursal, lxRemelecDomacop, lxRemelecBultos
				lxRemelecFecexpo =  .Fechaexpo			lxRemelecFaltafw =  .Fechaaltafw			lxRemelecFecimpo =  .Fechaimpo			lxRemelecFmodifw =  .Fechamodificacionfw			lxRemelecFectrans =  .Fechatransferencia			lxRemelecFecsal =  .Fechasalida			lxRemelecFecha =  .Fecha			lxRemelecNumero =  .Numero			lxRemelecHoraimpo =  .Horaimpo			lxRemelecSmodifw =  .Seriemodificacionfw			lxRemelecHmodifw =  .Horamodificacionfw			lxRemelecVmodifw =  .Versionmodificacionfw			lxRemelecZadsfw =  .Zadsfw			lxRemelecValtafw =  .Versionaltafw			lxRemelecUmodifw =  .Usuariomodificacionfw			lxRemelecHoraexpo =  .Horaexpo			lxRemelecUaltafw =  .Usuarioaltafw			lxRemelecSaltafw =  .Seriealtafw			lxRemelecEsttrans =  .Estadotransferencia			lxRemelecCodint =  .Codigointegridad			lxRemelecHaltafw =  .Horaaltafw			lxRemelecBdaltafw =  .Basededatosaltafw			lxRemelecBdmodifw =  .Basededatosmodificacionfw			lxRemelecEntrega =  .Entregaenorigen			lxRemelecTransporti =  upper( .Transportista_PK ) 			lxRemelecObs =  .Observacion			lxRemelecDomveh =  .Dominiovehiculo			lxRemelecHora =  .Hora			lxRemelecSucursal =  upper( .Sucursal_PK ) 			lxRemelecDomacop =  .Dominioacoplado			lxRemelecBultos =  .Bultos
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.REMELEC set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRemelecFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRemelecFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxRemelecFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxRemelecFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxRemelecFectrans ) + "'">>,"Fecsal" = <<"'" + this.ConvertirDateSql( lxRemelecFecsal ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxRemelecFecha ) + "'">>,"Numero" = <<lxRemelecNumero>>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRemelecHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRemelecSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRemelecHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRemelecVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRemelecZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRemelecValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRemelecUmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRemelecHoraexpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRemelecUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRemelecSaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRemelecEsttrans ) + "'">>,"Codint" = <<"'" + this.FormatearTextoSql( lxRemelecCodint ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRemelecHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRemelecBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRemelecBdmodifw ) + "'">>,"Entrega" = <<iif( lxRemelecEntrega, 1, 0 )>>,"Transporti" = <<"'" + this.FormatearTextoSql( lxRemelecTransporti ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxRemelecObs ) + "'">>,"Domveh" = <<"'" + this.FormatearTextoSql( lxRemelecDomveh ) + "'">>,"Hora" = <<"'" + this.FormatearTextoSql( lxRemelecHora ) + "'">>,"Sucursal" = <<"'" + this.FormatearTextoSql( lxRemelecSucursal ) + "'">>,"Domacop" = <<"'" + this.FormatearTextoSql( lxRemelecDomacop ) + "'">>,"Bultos" = <<lxRemelecBultos>> where "Numero" = <<lxRemelecNumero>> and  REMELEC.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.detremelec where "Codigo" = ' + transform( .oEntidad.NUMERO ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDeRemitos
				if this.oEntidad.DetalleDeRemitos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxImporteneto = loItem.Importeneto
					lxNroitem = lnContadorNroItem
					lxComprobante_PK = loItem.Comprobante_PK
					lxRemito = loItem.Remito
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxDireccion = loItem.Direccion
					lxCantidad = loItem.Cantidad
					lxNoterminadodevuelto = loItem.Noterminadodevuelto
					lxImportetotal = loItem.Importetotal
					lxProcesado = loItem.Procesado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detremelec("Codigo","ImpNeto","NROITEM","Comprob","Remito","Cliente","Cliedeta","Direccion","Cantidad","Notermdev","Importe","Procesado" ) values ( <<transform( lxValorClavePrimaria )>>, <<lxImporteneto>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxComprobante_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRemito ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxDireccion ) + "'">>, <<lxCantidad>>, <<iif( lxNoterminadodevuelto, 1, 0 )>>, <<lxImportetotal>>, <<"'" + this.FormatearTextoSql( lxProcesado ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Numero from ZooLogic.REMELEC where " + this.ConvertirFuncionesSql( " REMELEC.NUMERO != 0" ) )
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
			Local lxRemelecNumero
			lxRemelecNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecsal" as "Fechasalida", "Fecha" as "Fecha", "Numero" as "Numero", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Codint" as "Codigointegridad", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Entrega" as "Entregaenorigen", "Transporti" as "Transportista", "Obs" as "Observacion", "Domveh" as "Dominiovehiculo", "Hora" as "Hora", "Sucursal" as "Sucursal", "Domacop" as "Dominioacoplado", "Bultos" as "Bultos" from ZooLogic.REMELEC where "Numero" = <<lxRemelecNumero>> and  REMELEC.NUMERO != 0
			endtext
			use in select('c_REMITOELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITOELECTRONICO', set( 'Datasession' ) )

			if reccount( 'c_REMITOELECTRONICO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Impneto" as "Importeneto", "Nroitem" as "Nroitem", "Comprob" as "Comprobante", "Remito" as "Remito", "Cliente" as "Cliente", "Cliedeta" as "Clientedetalle", "Direccion" as "Direccion", "Cantidad" as "Cantidad", "Notermdev" as "Noterminadodevuelto", "Importe" as "Importetotal", "Procesado" as "Procesado" from ZooLogic.detremelec where Codigo = <<transform( c_REMITOELECTRONICO.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleDeRemitos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDeRemitos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDeRemitos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxRemelecNumero as Variant
		llRetorno = .t.
		lxRemelecNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.REMELEC where "Numero" = <<lxRemelecNumero>> and  REMELEC.NUMERO != 0
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecsal" as "Fechasalida", "Fecha" as "Fecha", "Numero" as "Numero", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Codint" as "Codigointegridad", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Entrega" as "Entregaenorigen", "Transporti" as "Transportista", "Obs" as "Observacion", "Domveh" as "Dominiovehiculo", "Hora" as "Hora", "Sucursal" as "Sucursal", "Domacop" as "Dominioacoplado", "Bultos" as "Bultos" from ZooLogic.REMELEC where  REMELEC.NUMERO != 0 order by Numero
			endtext
			use in select('c_REMITOELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITOELECTRONICO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Impneto" as "Importeneto", "Nroitem" as "Nroitem", "Comprob" as "Comprobante", "Remito" as "Remito", "Cliente" as "Cliente", "Cliedeta" as "Clientedetalle", "Direccion" as "Direccion", "Cantidad" as "Cantidad", "Notermdev" as "Noterminadodevuelto", "Importe" as "Importetotal", "Procesado" as "Procesado" from ZooLogic.detremelec where Codigo = <<transform( c_REMITOELECTRONICO.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleDeRemitos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDeRemitos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDeRemitos
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecsal" as "Fechasalida", "Fecha" as "Fecha", "Numero" as "Numero", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Codint" as "Codigointegridad", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Entrega" as "Entregaenorigen", "Transporti" as "Transportista", "Obs" as "Observacion", "Domveh" as "Dominiovehiculo", "Hora" as "Hora", "Sucursal" as "Sucursal", "Domacop" as "Dominioacoplado", "Bultos" as "Bultos" from ZooLogic.REMELEC where  str( Numero, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REMELEC.NUMERO != 0 order by Numero
			endtext
			use in select('c_REMITOELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITOELECTRONICO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Impneto" as "Importeneto", "Nroitem" as "Nroitem", "Comprob" as "Comprobante", "Remito" as "Remito", "Cliente" as "Cliente", "Cliedeta" as "Clientedetalle", "Direccion" as "Direccion", "Cantidad" as "Cantidad", "Notermdev" as "Noterminadodevuelto", "Importe" as "Importetotal", "Procesado" as "Procesado" from ZooLogic.detremelec where Codigo = <<transform( c_REMITOELECTRONICO.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleDeRemitos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDeRemitos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDeRemitos
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecsal" as "Fechasalida", "Fecha" as "Fecha", "Numero" as "Numero", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Codint" as "Codigointegridad", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Entrega" as "Entregaenorigen", "Transporti" as "Transportista", "Obs" as "Observacion", "Domveh" as "Dominiovehiculo", "Hora" as "Hora", "Sucursal" as "Sucursal", "Domacop" as "Dominioacoplado", "Bultos" as "Bultos" from ZooLogic.REMELEC where  str( Numero, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REMELEC.NUMERO != 0 order by Numero desc
			endtext
			use in select('c_REMITOELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITOELECTRONICO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Impneto" as "Importeneto", "Nroitem" as "Nroitem", "Comprob" as "Comprobante", "Remito" as "Remito", "Cliente" as "Cliente", "Cliedeta" as "Clientedetalle", "Direccion" as "Direccion", "Cantidad" as "Cantidad", "Notermdev" as "Noterminadodevuelto", "Importe" as "Importetotal", "Procesado" as "Procesado" from ZooLogic.detremelec where Codigo = <<transform( c_REMITOELECTRONICO.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleDeRemitos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDeRemitos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDeRemitos
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecsal" as "Fechasalida", "Fecha" as "Fecha", "Numero" as "Numero", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Codint" as "Codigointegridad", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Entrega" as "Entregaenorigen", "Transporti" as "Transportista", "Obs" as "Observacion", "Domveh" as "Dominiovehiculo", "Hora" as "Hora", "Sucursal" as "Sucursal", "Domacop" as "Dominioacoplado", "Bultos" as "Bultos" from ZooLogic.REMELEC where  REMELEC.NUMERO != 0 order by Numero desc
			endtext
			use in select('c_REMITOELECTRONICO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REMITOELECTRONICO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Impneto" as "Importeneto", "Nroitem" as "Nroitem", "Comprob" as "Comprobante", "Remito" as "Remito", "Cliente" as "Cliente", "Cliedeta" as "Clientedetalle", "Direccion" as "Direccion", "Cantidad" as "Cantidad", "Notermdev" as "Noterminadodevuelto", "Importe" as "Importetotal", "Procesado" as "Procesado" from ZooLogic.detremelec where Codigo = <<transform( c_REMITOELECTRONICO.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleDeRemitos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleDeRemitos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleDeRemitos
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.NUMERO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Fecsal,Fecha,Numero,Horaimpo,Smodifw,Hmodifw,Vmodif" + ;
"w,Zadsfw,Valtafw,Umodifw,Horaexpo,Ualtafw,Saltafw,Esttrans,Codint,Haltafw,Bdaltafw,Bdmodifw,Entrega," + ;
"Transporti,Obs,Domveh,Hora,Sucursal,Domacop,Bultos" + ;
" from ZooLogic.REMELEC where  REMELEC.NUMERO != 0 and " + lcFiltro )
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
			local  lxRemelecFecexpo, lxRemelecFaltafw, lxRemelecFecimpo, lxRemelecFmodifw, lxRemelecFectrans, lxRemelecFecsal, lxRemelecFecha, lxRemelecNumero, lxRemelecHoraimpo, lxRemelecSmodifw, lxRemelecHmodifw, lxRemelecVmodifw, lxRemelecZadsfw, lxRemelecValtafw, lxRemelecUmodifw, lxRemelecHoraexpo, lxRemelecUaltafw, lxRemelecSaltafw, lxRemelecEsttrans, lxRemelecCodint, lxRemelecHaltafw, lxRemelecBdaltafw, lxRemelecBdmodifw, lxRemelecEntrega, lxRemelecTransporti, lxRemelecObs, lxRemelecDomveh, lxRemelecHora, lxRemelecSucursal, lxRemelecDomacop, lxRemelecBultos
				lxRemelecFecexpo = ctod( '  /  /    ' )			lxRemelecFaltafw = ctod( '  /  /    ' )			lxRemelecFecimpo = ctod( '  /  /    ' )			lxRemelecFmodifw = ctod( '  /  /    ' )			lxRemelecFectrans = ctod( '  /  /    ' )			lxRemelecFecsal = ctod( '  /  /    ' )			lxRemelecFecha = ctod( '  /  /    ' )			lxRemelecNumero = 0			lxRemelecHoraimpo = []			lxRemelecSmodifw = []			lxRemelecHmodifw = []			lxRemelecVmodifw = []			lxRemelecZadsfw = []			lxRemelecValtafw = []			lxRemelecUmodifw = []			lxRemelecHoraexpo = []			lxRemelecUaltafw = []			lxRemelecSaltafw = []			lxRemelecEsttrans = []			lxRemelecCodint = []			lxRemelecHaltafw = []			lxRemelecBdaltafw = []			lxRemelecBdmodifw = []			lxRemelecEntrega = .F.			lxRemelecTransporti = []			lxRemelecObs = []			lxRemelecDomveh = []			lxRemelecHora = []			lxRemelecSucursal = []			lxRemelecDomacop = []			lxRemelecBultos = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.detremelec where "Codigo" = ' + transform( .oEntidad.NUMERO ) )
			this.oConexion.EjecutarSql( [delete from ZooLogic.REMELEC where "Numero" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REMELEC' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Numero = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Numero, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REMELEC.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecsal" as "Fechasalida", "Fecha" as "Fecha", "Numero" as "Numero", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Codint" as "Codigointegridad", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Entrega" as "Entregaenorigen", "Transporti" as "Transportista", "Obs" as "Observacion", "Domveh" as "Dominiovehiculo", "Hora" as "Hora", "Sucursal" as "Sucursal", "Domacop" as "Dominioacoplado", "Bultos" as "Bultos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REMELEC', '', tnTope )
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
	Function ObtenerDatosDetalleDetalleDeRemitos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETREMELEC.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codigo" as "Codigo", "Impneto" as "Importeneto", "Nroitem" as "Nroitem", "Comprob" as "Comprobante", "Remito" as "Remito", "Cliente" as "Cliente", "Cliedeta" as "Clientedetalle", "Direccion" as "Direccion", "Cantidad" as "Cantidad", "Notermdev" as "Noterminadodevuelto", "Importe" as "Importetotal", "Procesado" as "Procesado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleDeRemitos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'detremelec', 'DetalleDeRemitos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleDeRemitos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleDeRemitos( lcAtributo )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHASALIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECSAL AS FECHASALIDA'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODIGOINTEGRIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODIGOINTEGRIDAD'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ENTREGAENORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTREGA AS ENTREGAENORIGEN'
				Case lcAtributo == 'TRANSPORTISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRANSPORTI AS TRANSPORTISTA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'DOMINIOVEHICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DOMVEH AS DOMINIOVEHICULO'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'SUCURSAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCURSAL AS SUCURSAL'
				Case lcAtributo == 'DOMINIOACOPLADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DOMACOP AS DOMINIOACOPLADO'
				Case lcAtributo == 'BULTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BULTOS AS BULTOS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleDeRemitos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IMPORTENETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPNETO AS IMPORTENETO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPROB AS COMPROBANTE'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REMITO AS REMITO'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CLIENTEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDETA AS CLIENTEDETALLE'
				Case lcAtributo == 'DIRECCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIRECCION AS DIRECCION'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'NOTERMINADODEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOTERMDEV AS NOTERMINADODEVUELTO'
				Case lcAtributo == 'IMPORTETOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTE AS IMPORTETOTAL'
				Case lcAtributo == 'PROCESADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESADO AS PROCESADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHASALIDA'
				lcCampo = 'FECSAL'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOINTEGRIDAD'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAENORIGEN'
				lcCampo = 'ENTREGA'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSPORTISTA'
				lcCampo = 'TRANSPORTI'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'DOMINIOVEHICULO'
				lcCampo = 'DOMVEH'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'SUCURSAL'
				lcCampo = 'SUCURSAL'
			Case upper( alltrim( tcAtributo ) ) == 'DOMINIOACOPLADO'
				lcCampo = 'DOMACOP'
			Case upper( alltrim( tcAtributo ) ) == 'BULTOS'
				lcCampo = 'BULTOS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleDeRemitos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTENETO'
				lcCampo = 'IMPNETO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'REMITO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDETALLE'
				lcCampo = 'CLIEDETA'
			Case upper( alltrim( tcAtributo ) ) == 'DIRECCION'
				lcCampo = 'DIRECCION'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'NOTERMINADODEVUELTO'
				lcCampo = 'NOTERMDEV'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTETOTAL'
				lcCampo = 'IMPORTE'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESADO'
				lcCampo = 'PROCESADO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLEDEREMITOS'
			lcRetorno = 'DETREMELEC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxRemelecFecexpo, lxRemelecFaltafw, lxRemelecFecimpo, lxRemelecFmodifw, lxRemelecFectrans, lxRemelecFecsal, lxRemelecFecha, lxRemelecNumero, lxRemelecHoraimpo, lxRemelecSmodifw, lxRemelecHmodifw, lxRemelecVmodifw, lxRemelecZadsfw, lxRemelecValtafw, lxRemelecUmodifw, lxRemelecHoraexpo, lxRemelecUaltafw, lxRemelecSaltafw, lxRemelecEsttrans, lxRemelecCodint, lxRemelecHaltafw, lxRemelecBdaltafw, lxRemelecBdmodifw, lxRemelecEntrega, lxRemelecTransporti, lxRemelecObs, lxRemelecDomveh, lxRemelecHora, lxRemelecSucursal, lxRemelecDomacop, lxRemelecBultos
				lxRemelecFecexpo =  .Fechaexpo			lxRemelecFaltafw =  .Fechaaltafw			lxRemelecFecimpo =  .Fechaimpo			lxRemelecFmodifw =  .Fechamodificacionfw			lxRemelecFectrans =  .Fechatransferencia			lxRemelecFecsal =  .Fechasalida			lxRemelecFecha =  .Fecha			lxRemelecNumero =  .Numero			lxRemelecHoraimpo =  .Horaimpo			lxRemelecSmodifw =  .Seriemodificacionfw			lxRemelecHmodifw =  .Horamodificacionfw			lxRemelecVmodifw =  .Versionmodificacionfw			lxRemelecZadsfw =  .Zadsfw			lxRemelecValtafw =  .Versionaltafw			lxRemelecUmodifw =  .Usuariomodificacionfw			lxRemelecHoraexpo =  .Horaexpo			lxRemelecUaltafw =  .Usuarioaltafw			lxRemelecSaltafw =  .Seriealtafw			lxRemelecEsttrans =  .Estadotransferencia			lxRemelecCodint =  .Codigointegridad			lxRemelecHaltafw =  .Horaaltafw			lxRemelecBdaltafw =  .Basededatosaltafw			lxRemelecBdmodifw =  .Basededatosmodificacionfw			lxRemelecEntrega =  .Entregaenorigen			lxRemelecTransporti =  upper( .Transportista_PK ) 			lxRemelecObs =  .Observacion			lxRemelecDomveh =  .Dominiovehiculo			lxRemelecHora =  .Hora			lxRemelecSucursal =  upper( .Sucursal_PK ) 			lxRemelecDomacop =  .Dominioacoplado			lxRemelecBultos =  .Bultos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.REMELEC ( "Fecexpo","Faltafw","Fecimpo","Fmodifw","Fectrans","Fecsal","Fecha","Numero","Horaimpo","Smodifw","Hmodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Horaexpo","Ualtafw","Saltafw","Esttrans","Codint","Haltafw","Bdaltafw","Bdmodifw","Entrega","Transporti","Obs","Domveh","Hora","Sucursal","Domacop","Bultos" ) values ( <<"'" + this.ConvertirDateSql( lxRemelecFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFecsal ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRemelecFecha ) + "'" >>, <<lxRemelecNumero >>, <<"'" + this.FormatearTextoSql( lxRemelecHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecCodint ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecBdmodifw ) + "'" >>, <<iif( lxRemelecEntrega, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxRemelecTransporti ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecDomveh ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecHora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecSucursal ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRemelecDomacop ) + "'" >>, <<lxRemelecBultos >> )
		endtext
		loColeccion.cTabla = 'REMELEC' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDeRemitos
				if this.oEntidad.DetalleDeRemitos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxImporteneto = loItem.Importeneto
					lxNroitem = lnContadorNroItem
					lxComprobante_PK = loItem.Comprobante_PK
					lxRemito = loItem.Remito
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxDireccion = loItem.Direccion
					lxCantidad = loItem.Cantidad
					lxNoterminadodevuelto = loItem.Noterminadodevuelto
					lxImportetotal = loItem.Importetotal
					lxProcesado = loItem.Procesado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detremelec("Codigo","ImpNeto","NROITEM","Comprob","Remito","Cliente","Cliedeta","Direccion","Cantidad","Notermdev","Importe","Procesado" ) values ( << lcValorClavePrimariaString >>, <<lxImporteneto>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxComprobante_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRemito ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxDireccion ) + "'">>, <<lxCantidad>>, <<iif( lxNoterminadodevuelto, 1, 0 )>>, <<lxImportetotal>>, <<"'" + this.FormatearTextoSql( lxProcesado ) + "'">> ) 
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
			local  lxRemelecFecexpo, lxRemelecFaltafw, lxRemelecFecimpo, lxRemelecFmodifw, lxRemelecFectrans, lxRemelecFecsal, lxRemelecFecha, lxRemelecNumero, lxRemelecHoraimpo, lxRemelecSmodifw, lxRemelecHmodifw, lxRemelecVmodifw, lxRemelecZadsfw, lxRemelecValtafw, lxRemelecUmodifw, lxRemelecHoraexpo, lxRemelecUaltafw, lxRemelecSaltafw, lxRemelecEsttrans, lxRemelecCodint, lxRemelecHaltafw, lxRemelecBdaltafw, lxRemelecBdmodifw, lxRemelecEntrega, lxRemelecTransporti, lxRemelecObs, lxRemelecDomveh, lxRemelecHora, lxRemelecSucursal, lxRemelecDomacop, lxRemelecBultos
				lxRemelecFecexpo =  .Fechaexpo			lxRemelecFaltafw =  .Fechaaltafw			lxRemelecFecimpo =  .Fechaimpo			lxRemelecFmodifw =  .Fechamodificacionfw			lxRemelecFectrans =  .Fechatransferencia			lxRemelecFecsal =  .Fechasalida			lxRemelecFecha =  .Fecha			lxRemelecNumero =  .Numero			lxRemelecHoraimpo =  .Horaimpo			lxRemelecSmodifw =  .Seriemodificacionfw			lxRemelecHmodifw =  .Horamodificacionfw			lxRemelecVmodifw =  .Versionmodificacionfw			lxRemelecZadsfw =  .Zadsfw			lxRemelecValtafw =  .Versionaltafw			lxRemelecUmodifw =  .Usuariomodificacionfw			lxRemelecHoraexpo =  .Horaexpo			lxRemelecUaltafw =  .Usuarioaltafw			lxRemelecSaltafw =  .Seriealtafw			lxRemelecEsttrans =  .Estadotransferencia			lxRemelecCodint =  .Codigointegridad			lxRemelecHaltafw =  .Horaaltafw			lxRemelecBdaltafw =  .Basededatosaltafw			lxRemelecBdmodifw =  .Basededatosmodificacionfw			lxRemelecEntrega =  .Entregaenorigen			lxRemelecTransporti =  upper( .Transportista_PK ) 			lxRemelecObs =  .Observacion			lxRemelecDomveh =  .Dominiovehiculo			lxRemelecHora =  .Hora			lxRemelecSucursal =  upper( .Sucursal_PK ) 			lxRemelecDomacop =  .Dominioacoplado			lxRemelecBultos =  .Bultos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  REMELEC.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.REMELEC set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRemelecFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRemelecFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRemelecFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRemelecFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxRemelecFectrans ) + "'">>, "Fecsal" = <<"'" + this.ConvertirDateSql( lxRemelecFecsal ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxRemelecFecha ) + "'">>, "Numero" = <<lxRemelecNumero>>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRemelecHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRemelecSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRemelecHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRemelecVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRemelecZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRemelecValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRemelecUmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRemelecHoraexpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRemelecUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRemelecSaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRemelecEsttrans ) + "'">>, "Codint" = <<"'" + this.FormatearTextoSql( lxRemelecCodint ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRemelecHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRemelecBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRemelecBdmodifw ) + "'">>, "Entrega" = <<iif( lxRemelecEntrega, 1, 0 )>>, "Transporti" = <<"'" + this.FormatearTextoSql( lxRemelecTransporti ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxRemelecObs ) + "'">>, "Domveh" = <<"'" + this.FormatearTextoSql( lxRemelecDomveh ) + "'">>, "Hora" = <<"'" + this.FormatearTextoSql( lxRemelecHora ) + "'">>, "Sucursal" = <<"'" + this.FormatearTextoSql( lxRemelecSucursal ) + "'">>, "Domacop" = <<"'" + this.FormatearTextoSql( lxRemelecDomacop ) + "'">>, "Bultos" = <<lxRemelecBultos>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REMELEC' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.detremelec where "Codigo" = ] + transform( .oEntidad.NUMERO ))

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleDeRemitos
				if this.oEntidad.DetalleDeRemitos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxImporteneto = loItem.Importeneto
					lxNroitem = lnContadorNroItem
					lxComprobante_PK = loItem.Comprobante_PK
					lxRemito = loItem.Remito
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxDireccion = loItem.Direccion
					lxCantidad = loItem.Cantidad
					lxNoterminadodevuelto = loItem.Noterminadodevuelto
					lxImportetotal = loItem.Importetotal
					lxProcesado = loItem.Procesado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.detremelec("Codigo","ImpNeto","NROITEM","Comprob","Remito","Cliente","Cliedeta","Direccion","Cantidad","Notermdev","Importe","Procesado" ) values ( << lcValorClavePrimariaString >>, <<lxImporteneto>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxComprobante_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxRemito ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxDireccion ) + "'">>, <<lxCantidad>>, <<iif( lxNoterminadodevuelto, 1, 0 )>>, <<lxImportetotal>>, <<"'" + this.FormatearTextoSql( lxProcesado ) + "'">> ) 
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
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  REMELEC.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.REMELEC where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.detremelec where "Codigo" = ] + transform( .oEntidad.NUMERO ))
			loColeccion.cTabla = 'REMELEC' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.REMELEC where  REMELEC.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.REMELEC where Numero = " + transform( this.oEntidad.NUMERO )+ " and  REMELEC.NUMERO != 0" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITOELECTRONICO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.REMELEC Where Numero = ] + transform( &lcCursor..Numero ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.REMELEC set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECSAL = ] + "'" + this.ConvertirDateSql( &lcCursor..FECSAL ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codint = ] + "'" + this.FormatearTextoSql( &lcCursor..Codint ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Entrega = ] + Transform( iif( &lcCursor..Entrega, 1, 0 ))+ [, Transporti = ] + "'" + this.FormatearTextoSql( &lcCursor..Transporti ) + "'"+ [, obs = ] + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'"+ [, DomVeh = ] + "'" + this.FormatearTextoSql( &lcCursor..DomVeh ) + "'"+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, Sucursal = ] + "'" + this.FormatearTextoSql( &lcCursor..Sucursal ) + "'"+ [, DomAcop = ] + "'" + this.FormatearTextoSql( &lcCursor..DomAcop ) + "'"+ [, Bultos = ] + transform( &lcCursor..Bultos ) + [ Where Numero = ] + transform( &lcCursor..Numero ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FALTAFW, FECIMPO, FMODIFW, FECTRANS, FECSAL, Fecha, Numero, HORAIMPO, SMODIFW, HMODIFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, HORAEXPO, UALTAFW, SALTAFW, ESTTRANS, Codint, HALTAFW, BDALTAFW, BDMODIFW, Entrega, Transporti, obs, DomVeh, Hora, Sucursal, DomAcop, Bultos
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECSAL ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codint ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + Transform( iif( &lcCursor..Entrega, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Transporti ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DomVeh ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Sucursal ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DomAcop ) + "'" + ',' + transform( &lcCursor..Bultos )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.REMELEC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITOELECTRONICO'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Numero','N')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Numero')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.detremelec Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMREMITOELEC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Numero from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Codigo","ImpNeto","NROITEM","Comprob","Remito","Cliente","Cliedeta","Direccion","Cantidad","Notermdev","Importe","Procesado"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.detremelec ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.Codigo     ) + ',' + transform( cDetallesExistentes.ImpNeto    ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Comprob    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Remito     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cliente    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cliedeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Direccion  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + Transform( iif( cDetallesExistentes.Notermdev , 1, 0 )) + ',' + transform( cDetallesExistentes.Importe    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Procesado  ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Numero N (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Numero     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'REMITOELECTRONICO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REMITOELECTRONICO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REMITOELECTRONICO_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMREMITOELEC'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_remelec')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REMITOELECTRONICO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Numero
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REMITOELECTRONICO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITOELECTRONICO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Numero as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Numero, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITOELECTRONICO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECSAL    
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_remelec') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_remelec
Create Table ZooLogic.TablaTrabajo_remelec ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecsal" datetime  null, 
"fecha" datetime  null, 
"numero" numeric( 8, 0 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"codint" char( 32 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"entrega" bit  null, 
"transporti" char( 15 )  null, 
"obs" varchar(max)  null, 
"domveh" char( 10 )  null, 
"hora" char( 5 )  null, 
"sucursal" char( 10 )  null, 
"domacop" char( 10 )  null, 
"bultos" numeric( 10, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_remelec' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_remelec' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REMITOELECTRONICO'
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecsal','fecsal')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codint','codint')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('entrega','entrega')
			.AgregarMapeo('transporti','transporti')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('domveh','domveh')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('sucursal','sucursal')
			.AgregarMapeo('domacop','domacop')
			.AgregarMapeo('bultos','bultos')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_remelec'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECSAL = isnull( d.FECSAL, t.FECSAL ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODINT = isnull( d.CODINT, t.CODINT ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ENTREGA = isnull( d.ENTREGA, t.ENTREGA ),t.TRANSPORTI = isnull( d.TRANSPORTI, t.TRANSPORTI ),t.OBS = isnull( d.OBS, t.OBS ),t.DOMVEH = isnull( d.DOMVEH, t.DOMVEH ),t.HORA = isnull( d.HORA, t.HORA ),t.SUCURSAL = isnull( d.SUCURSAL, t.SUCURSAL ),t.DOMACOP = isnull( d.DOMACOP, t.DOMACOP ),t.BULTOS = isnull( d.BULTOS, t.BULTOS )
					from ZooLogic.REMELEC t inner join deleted d 
							 on t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.REMELEC(Fecexpo,Faltafw,Fecimpo,Fmodifw,Fectrans,Fecsal,Fecha,Numero,Horaimpo,Smodifw,Hmodifw,Vmodifw,Zadsfw,Valtafw,Umodifw,Horaexpo,Ualtafw,Saltafw,Esttrans,Codint,Haltafw,Bdaltafw,Bdmodifw,Entrega,Transporti,Obs,Domveh,Hora,Sucursal,Domacop,Bultos)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECSAL,''),isnull( d.FECHA,''),isnull( d.NUMERO,0),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CODINT,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ENTREGA,0),isnull( d.TRANSPORTI,''),isnull( d.OBS,''),isnull( d.DOMVEH,''),isnull( d.HORA,''),isnull( d.SUCURSAL,''),isnull( d.DOMACOP,''),isnull( d.BULTOS,0)
						From deleted d left join ZooLogic.REMELEC pk 
							 on d.Numero = pk.Numero
						Where pk.Numero Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_detremelec( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REMELEC_detremelec
ON ZooLogic.TablaTrabajo_REMELEC_detremelec
AFTER DELETE
As
Begin
Update t Set 
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.IMPNETO = isnull( d.IMPNETO, t.IMPNETO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COMPROB = isnull( d.COMPROB, t.COMPROB ),
t.REMITO = isnull( d.REMITO, t.REMITO ),
t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),
t.CLIEDETA = isnull( d.CLIEDETA, t.CLIEDETA ),
t.DIRECCION = isnull( d.DIRECCION, t.DIRECCION ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.NOTERMDEV = isnull( d.NOTERMDEV, t.NOTERMDEV ),
t.IMPORTE = isnull( d.IMPORTE, t.IMPORTE ),
t.PROCESADO = isnull( d.PROCESADO, t.PROCESADO )
from ZooLogic.detremelec t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.detremelec
( 
"CODIGO",
"IMPNETO",
"NROITEM",
"COMPROB",
"REMITO",
"CLIENTE",
"CLIEDETA",
"DIRECCION",
"CANTIDAD",
"NOTERMDEV",
"IMPORTE",
"PROCESADO"
 )
Select 
d.CODIGO,
d.IMPNETO,
d.NROITEM,
d.COMPROB,
d.REMITO,
d.CLIENTE,
d.CLIEDETA,
d.DIRECCION,
d.CANTIDAD,
d.NOTERMDEV,
d.IMPORTE,
d.PROCESADO
From deleted d left join ZooLogic.detremelec pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_remelec') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_remelec
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REMITOELECTRONICO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITOELECTRONICO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITOELECTRONICO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITOELECTRONICO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITOELECTRONICO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITOELECTRONICO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechasalida = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITOELECTRONICO.Fechasalida, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_REMITOELECTRONICO.Fecha, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_REMITOELECTRONICO.Numero, 0 )
					.Horaimpo = nvl( c_REMITOELECTRONICO.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_REMITOELECTRONICO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_REMITOELECTRONICO.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_REMITOELECTRONICO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_REMITOELECTRONICO.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_REMITOELECTRONICO.Usuariomodificacionfw, [] )
					.Horaexpo = nvl( c_REMITOELECTRONICO.Horaexpo, [] )
					.Usuarioaltafw = nvl( c_REMITOELECTRONICO.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_REMITOELECTRONICO.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_REMITOELECTRONICO.Estadotransferencia, [] )
					.Codigointegridad = nvl( c_REMITOELECTRONICO.Codigointegridad, [] )
					.Horaaltafw = nvl( c_REMITOELECTRONICO.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_REMITOELECTRONICO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_REMITOELECTRONICO.Basededatosmodificacionfw, [] )
					.Entregaenorigen = nvl( c_REMITOELECTRONICO.Entregaenorigen, .F. )
					.Transportista_PK =  nvl( c_REMITOELECTRONICO.Transportista, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Detallederemitos.Limpiar()
					.Detallederemitos.SetearEsNavegacion( .lProcesando )
					.Detallederemitos.Cargar()
					.Dominiovehiculo = nvl( c_REMITOELECTRONICO.Dominiovehiculo, [] )
					.Hora = nvl( c_REMITOELECTRONICO.Hora, [] )
					.Sucursal_PK =  nvl( c_REMITOELECTRONICO.Sucursal, [] )
					.Dominioacoplado = nvl( c_REMITOELECTRONICO.Dominioacoplado, [] )
					.Bultos = nvl( c_REMITOELECTRONICO.Bultos, 0 )
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
		
		loDetalle = this.oEntidad.DetalleDeRemitos
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
		return c_REMITOELECTRONICO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.REMELEC' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Numero"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Numero as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Numero from (
							select * 
								from ZooLogic.REMELEC 
								Where   REMELEC.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REMELEC", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Numero"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecsal" as "Fechasalida", "Fecha" as "Fecha", "Numero" as "Numero", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Codint" as "Codigointegridad", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Entrega" as "Entregaenorigen", "Transporti" as "Transportista", "Obs" as "Observacion", "Domveh" as "Dominiovehiculo", "Hora" as "Hora", "Sucursal" as "Sucursal", "Domacop" as "Dominioacoplado", "Bultos" as "Bultos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.REMELEC 
								Where   REMELEC.NUMERO != 0
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
	Tabla = 'REMELEC'
	Filtro = " REMELEC.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REMELEC.NUMERO != 0"
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
	<row entidad="REMITOELECTRONICO                       " atributo="FECHAEXPO                               " tabla="REMELEC        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="FECHAALTAFW                             " tabla="REMELEC        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="FECHAIMPO                               " tabla="REMELEC        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="FECHAMODIFICACIONFW                     " tabla="REMELEC        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="FECHATRANSFERENCIA                      " tabla="REMELEC        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="FECHASALIDA                             " tabla="REMELEC        " campo="FECSAL    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="8" etiqueta="Fecha de salida                                                                                                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="FECHA                                   " tabla="REMELEC        " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="4" etiqueta="Fecha del remito electrónico                                                                                                                                                                                                                              " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="NUMERO                                  " tabla="REMELEC        " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="HORAIMPO                                " tabla="REMELEC        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="SERIEMODIFICACIONFW                     " tabla="REMELEC        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="HORAMODIFICACIONFW                      " tabla="REMELEC        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="VERSIONMODIFICACIONFW                   " tabla="REMELEC        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="ZADSFW                                  " tabla="REMELEC        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="VERSIONALTAFW                           " tabla="REMELEC        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="USUARIOMODIFICACIONFW                   " tabla="REMELEC        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="HORAEXPO                                " tabla="REMELEC        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="USUARIOALTAFW                           " tabla="REMELEC        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="SERIEALTAFW                             " tabla="REMELEC        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="ESTADOTRANSFERENCIA                     " tabla="REMELEC        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="CODIGOINTEGRIDAD                        " tabla="REMELEC        " campo="CODINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="32" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código de integridad                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="HORAALTAFW                              " tabla="REMELEC        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="BASEDEDATOSALTAFW                       " tabla="REMELEC        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REMELEC        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="ENTREGAENORIGEN                         " tabla="REMELEC        " campo="ENTREGA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Entrega en domicilio origen                                                                                                                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="TRANSPORTISTA                           " tabla="REMELEC        " campo="TRANSPORTI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TRANSPORTISTA                           " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Transportista                                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="OBSERVACION                             " tabla="REMELEC        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="DETALLEDEREMITOS                        " tabla="DETREMELEC     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Remitos                                                                                                                                                                                                                                                   " dominio="DETALLEITEMREMITOELEC         " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="DOMINIOVEHICULO                         " tabla="REMELEC        " campo="DOMVEH    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Dominio del vehículo                                                                                                                                                                                                                                      " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="HORA                                    " tabla="REMELEC        " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="=left( goservicios.libreRIAS.obtenerhora() , 5)                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="406" etiqueta="Hora                                                                                                                                                                                                                                                      " dominio="HORA                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99:99                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="SUCURSAL                                " tabla="REMELEC        " campo="SUCURSAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Sucursal                                                                                                                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="DOMINIOACOPLADO                         " tabla="REMELEC        " campo="DOMACOP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Dominio del acoplado                                                                                                                                                                                                                                      " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REMITOELECTRONICO                       " atributo="BULTOS                                  " tabla="REMELEC        " campo="BULTOS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Bultos                                                                                                                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TRANSPORTISTA                           " atributo="NOMBRE                                  " tabla="TRA            " campo="TRNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="11" etiqueta="Detalle Tra.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TRA On REMELEC.TRANSPORTI = TRA.TRCOD And  TRA.TRCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Suc.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On REMELEC.SUCURSAL = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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