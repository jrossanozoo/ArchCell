
define class Din_EntidadCOMPROBANTESECOMMERCEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_COMPROBANTESECOMMERCE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_COEPK'
	cTablaPrincipal = 'COMPECOM'
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
			local  lxCompecomFecexpo, lxCompecomFectrans, lxCompecomFecimpo, lxCompecomFaltafw, lxCompecomFmodifw, lxCompecomNumero, lxCompecomPendiente, lxCompecomSmodifw, lxCompecomSaltafw, lxCompecomUaltafw, lxCompecomVmodifw, lxCompecomZadsfw, lxCompecomValtafw, lxCompecomHmodifw, lxCompecomUmodifw, lxCompecomHaltafw, lxCompecomHoraimpo, lxCompecomBdaltafw, lxCompecomBdmodifw, lxCompecomEsttrans, lxCompecomHoraexpo, lxCompecomEcommerce, lxCompecomFecha, lxCompecomObs
				lxCompecomFecexpo =  .Fechaexpo			lxCompecomFectrans =  .Fechatransferencia			lxCompecomFecimpo =  .Fechaimpo			lxCompecomFaltafw =  .Fechaaltafw			lxCompecomFmodifw =  .Fechamodificacionfw			lxCompecomNumero =  .Numero			lxCompecomPendiente =  .Operacionespendientes			lxCompecomSmodifw =  .Seriemodificacionfw			lxCompecomSaltafw =  .Seriealtafw			lxCompecomUaltafw =  .Usuarioaltafw			lxCompecomVmodifw =  .Versionmodificacionfw			lxCompecomZadsfw =  .Zadsfw			lxCompecomValtafw =  .Versionaltafw			lxCompecomHmodifw =  .Horamodificacionfw			lxCompecomUmodifw =  .Usuariomodificacionfw			lxCompecomHaltafw =  .Horaaltafw			lxCompecomHoraimpo =  .Horaimpo			lxCompecomBdaltafw =  .Basededatosaltafw			lxCompecomBdmodifw =  .Basededatosmodificacionfw			lxCompecomEsttrans =  .Estadotransferencia			lxCompecomHoraexpo =  .Horaexpo			lxCompecomEcommerce =  upper( .Ecommerce_PK ) 			lxCompecomFecha =  .Fecha			lxCompecomObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCompecomNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMPECOM ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Numero","Pendiente","Smodifw","Saltafw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Hmodifw","Umodifw","Haltafw","Horaimpo","Bdaltafw","Bdmodifw","Esttrans","Horaexpo","Ecommerce","Fecha","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCompecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFmodifw ) + "'" >>, <<lxCompecomNumero >>, <<iif( lxCompecomPendiente, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCompecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomEcommerce ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleOperaciones
				if this.oEntidad.DetalleOperaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumerooperacion = loItem.Numerooperacion
					lxCantidad = loItem.Cantidad
					lxMonto = loItem.Monto
					lxClientedescripcion = loItem.Clientedescripcion
					lxCliente_PK = loItem.Cliente_PK
					lxClientedragon_PK = loItem.Clientedragon_PK
					lxEnvio = loItem.Envio
					lxFullenvios = loItem.Fullenvios
					lxCancelada = loItem.Cancelada
					lxTipocomprobante = loItem.Tipocomprobante
					lxClientenombre = loItem.Clientenombre
					lxPagado = loItem.Pagado
					lxOperacion_PK = loItem.Operacion_PK
					lxPlataforma = loItem.Plataforma
					lxBuzon = loItem.Buzon
					lxBasededatos = loItem.Basededatos
					lxUtilizastockotrabase = loItem.Utilizastockotrabase
					lxNumerocomprobante = loItem.Numerocomprobante
					lxBdorigenstock = loItem.Bdorigenstock
					lxComprobanteafectado = loItem.Comprobanteafectado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ECCOMPDET("NROITEM","NUMERO","OPENUM","CANT","MONTO","CLIEDSC","CLIENTE","CLIDRAGON","ENVIO","FULLENVIOS","CANCELADA","TIPOCOMP","NOMBRE","PAGADO","OPECOD","PLATA","BUZON","BDATOS","USAOTRABD","NROCOMP","ORIGENST","NROCOMPAFE" ) values ( <<lxNroitem>>, <<transform( lxValorClavePrimaria )>>, <<"'" + this.FormatearTextoSql( lxNumerooperacion ) + "'">>, <<lxCantidad>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedragon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEnvio ) + "'">>, <<iif( lxFullenvios, 1, 0 )>>, <<iif( lxCancelada, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientenombre ) + "'">>, <<iif( lxPagado, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxOperacion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma ) + "'">>, <<"'" + this.FormatearTextoSql( lxBuzon ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatos ) + "'">>, <<iif( lxUtilizastockotrabase, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBdorigenstock ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobanteafectado ) + "'">> ) 
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
			local  lxCompecomFecexpo, lxCompecomFectrans, lxCompecomFecimpo, lxCompecomFaltafw, lxCompecomFmodifw, lxCompecomNumero, lxCompecomPendiente, lxCompecomSmodifw, lxCompecomSaltafw, lxCompecomUaltafw, lxCompecomVmodifw, lxCompecomZadsfw, lxCompecomValtafw, lxCompecomHmodifw, lxCompecomUmodifw, lxCompecomHaltafw, lxCompecomHoraimpo, lxCompecomBdaltafw, lxCompecomBdmodifw, lxCompecomEsttrans, lxCompecomHoraexpo, lxCompecomEcommerce, lxCompecomFecha, lxCompecomObs
				lxCompecomFecexpo =  .Fechaexpo			lxCompecomFectrans =  .Fechatransferencia			lxCompecomFecimpo =  .Fechaimpo			lxCompecomFaltafw =  .Fechaaltafw			lxCompecomFmodifw =  .Fechamodificacionfw			lxCompecomNumero =  .Numero			lxCompecomPendiente =  .Operacionespendientes			lxCompecomSmodifw =  .Seriemodificacionfw			lxCompecomSaltafw =  .Seriealtafw			lxCompecomUaltafw =  .Usuarioaltafw			lxCompecomVmodifw =  .Versionmodificacionfw			lxCompecomZadsfw =  .Zadsfw			lxCompecomValtafw =  .Versionaltafw			lxCompecomHmodifw =  .Horamodificacionfw			lxCompecomUmodifw =  .Usuariomodificacionfw			lxCompecomHaltafw =  .Horaaltafw			lxCompecomHoraimpo =  .Horaimpo			lxCompecomBdaltafw =  .Basededatosaltafw			lxCompecomBdmodifw =  .Basededatosmodificacionfw			lxCompecomEsttrans =  .Estadotransferencia			lxCompecomHoraexpo =  .Horaexpo			lxCompecomEcommerce =  upper( .Ecommerce_PK ) 			lxCompecomFecha =  .Fecha			lxCompecomObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.COMPECOM set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompecomFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCompecomFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompecomFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCompecomFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompecomFmodifw ) + "'">>,"Numero" = <<lxCompecomNumero>>,"Pendiente" = <<iif( lxCompecomPendiente, 1, 0 )>>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCompecomSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCompecomSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompecomUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompecomVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompecomZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCompecomValtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompecomHmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCompecomUmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCompecomHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompecomHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompecomBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompecomBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCompecomEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompecomHoraexpo ) + "'">>,"Ecommerce" = <<"'" + this.FormatearTextoSql( lxCompecomEcommerce ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCompecomFecha ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCompecomObs ) + "'">> where "Numero" = <<lxCompecomNumero>> and  COMPECOM.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ECCOMPDET where "NUMERO" = ' + transform( .oEntidad.NUMERO ) )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleOperaciones
				if this.oEntidad.DetalleOperaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumerooperacion = loItem.Numerooperacion
					lxCantidad = loItem.Cantidad
					lxMonto = loItem.Monto
					lxClientedescripcion = loItem.Clientedescripcion
					lxCliente_PK = loItem.Cliente_PK
					lxClientedragon_PK = loItem.Clientedragon_PK
					lxEnvio = loItem.Envio
					lxFullenvios = loItem.Fullenvios
					lxCancelada = loItem.Cancelada
					lxTipocomprobante = loItem.Tipocomprobante
					lxClientenombre = loItem.Clientenombre
					lxPagado = loItem.Pagado
					lxOperacion_PK = loItem.Operacion_PK
					lxPlataforma = loItem.Plataforma
					lxBuzon = loItem.Buzon
					lxBasededatos = loItem.Basededatos
					lxUtilizastockotrabase = loItem.Utilizastockotrabase
					lxNumerocomprobante = loItem.Numerocomprobante
					lxBdorigenstock = loItem.Bdorigenstock
					lxComprobanteafectado = loItem.Comprobanteafectado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ECCOMPDET("NROITEM","NUMERO","OPENUM","CANT","MONTO","CLIEDSC","CLIENTE","CLIDRAGON","ENVIO","FULLENVIOS","CANCELADA","TIPOCOMP","NOMBRE","PAGADO","OPECOD","PLATA","BUZON","BDATOS","USAOTRABD","NROCOMP","ORIGENST","NROCOMPAFE" ) values ( <<lxNroitem>>, <<transform( lxValorClavePrimaria )>>, <<"'" + this.FormatearTextoSql( lxNumerooperacion ) + "'">>, <<lxCantidad>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedragon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEnvio ) + "'">>, <<iif( lxFullenvios, 1, 0 )>>, <<iif( lxCancelada, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientenombre ) + "'">>, <<iif( lxPagado, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxOperacion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma ) + "'">>, <<"'" + this.FormatearTextoSql( lxBuzon ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatos ) + "'">>, <<iif( lxUtilizastockotrabase, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBdorigenstock ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobanteafectado ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.COMPECOM where " + this.ConvertirFuncionesSql( " COMPECOM.NUMERO != 0" ) )
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
			Local lxCompecomNumero
			lxCompecomNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Pendiente" as "Operacionespendientes", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Ecommerce" as "Ecommerce", "Fecha" as "Fecha", "Obs" as "Observacion" from ZooLogic.COMPECOM where "Numero" = <<lxCompecomNumero>> and  COMPECOM.NUMERO != 0
			endtext
			use in select('c_COMPROBANTESECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTESECOMMERCE', set( 'Datasession' ) )

			if reccount( 'c_COMPROBANTESECOMMERCE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Numero" as "Numero", "Openum" as "Numerooperacion", "Cant" as "Cantidad", "Monto" as "Monto", "Cliedsc" as "Clientedescripcion", "Cliente" as "Cliente", "Clidragon" as "Clientedragon", "Envio" as "Envio", "Fullenvios" as "Fullenvios", "Cancelada" as "Cancelada", "Tipocomp" as "Tipocomprobante", "Nombre" as "Clientenombre", "Pagado" as "Pagado", "Opecod" as "Operacion", "Plata" as "Plataforma", "Buzon" as "Buzon", "Bdatos" as "Basededatos", "Usaotrabd" as "Utilizastockotrabase", "Nrocomp" as "Numerocomprobante", "Origenst" as "Bdorigenstock", "Nrocompafe" as "Comprobanteafectado" from ZooLogic.ECCOMPDET where NUMERO = <<transform( c_COMPROBANTESECOMMERCE.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleOperaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOperaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOperaciones
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCompecomNumero as Variant
		llRetorno = .t.
		lxCompecomNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPECOM where "Numero" = <<lxCompecomNumero>> and  COMPECOM.NUMERO != 0
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
				lcOrden =  str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Pendiente" as "Operacionespendientes", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Ecommerce" as "Ecommerce", "Fecha" as "Fecha", "Obs" as "Observacion" from ZooLogic.COMPECOM where  COMPECOM.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_COMPROBANTESECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTESECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Numero" as "Numero", "Openum" as "Numerooperacion", "Cant" as "Cantidad", "Monto" as "Monto", "Cliedsc" as "Clientedescripcion", "Cliente" as "Cliente", "Clidragon" as "Clientedragon", "Envio" as "Envio", "Fullenvios" as "Fullenvios", "Cancelada" as "Cancelada", "Tipocomp" as "Tipocomprobante", "Nombre" as "Clientenombre", "Pagado" as "Pagado", "Opecod" as "Operacion", "Plata" as "Plataforma", "Buzon" as "Buzon", "Bdatos" as "Basededatos", "Usaotrabd" as "Utilizastockotrabase", "Nrocomp" as "Numerocomprobante", "Origenst" as "Bdorigenstock", "Nrocompafe" as "Comprobanteafectado" from ZooLogic.ECCOMPDET where NUMERO = <<transform( c_COMPROBANTESECOMMERCE.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleOperaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOperaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOperaciones
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
				lcOrden =  str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Pendiente" as "Operacionespendientes", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Ecommerce" as "Ecommerce", "Fecha" as "Fecha", "Obs" as "Observacion" from ZooLogic.COMPECOM where  str( NUMERO, 10, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPECOM.NUMERO != 0 order by NUMERO
			endtext
			use in select('c_COMPROBANTESECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTESECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Numero" as "Numero", "Openum" as "Numerooperacion", "Cant" as "Cantidad", "Monto" as "Monto", "Cliedsc" as "Clientedescripcion", "Cliente" as "Cliente", "Clidragon" as "Clientedragon", "Envio" as "Envio", "Fullenvios" as "Fullenvios", "Cancelada" as "Cancelada", "Tipocomp" as "Tipocomprobante", "Nombre" as "Clientenombre", "Pagado" as "Pagado", "Opecod" as "Operacion", "Plata" as "Plataforma", "Buzon" as "Buzon", "Bdatos" as "Basededatos", "Usaotrabd" as "Utilizastockotrabase", "Nrocomp" as "Numerocomprobante", "Origenst" as "Bdorigenstock", "Nrocompafe" as "Comprobanteafectado" from ZooLogic.ECCOMPDET where NUMERO = <<transform( c_COMPROBANTESECOMMERCE.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleOperaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOperaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOperaciones
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
				lcOrden =  str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Pendiente" as "Operacionespendientes", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Ecommerce" as "Ecommerce", "Fecha" as "Fecha", "Obs" as "Observacion" from ZooLogic.COMPECOM where  str( NUMERO, 10, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPECOM.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_COMPROBANTESECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTESECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Numero" as "Numero", "Openum" as "Numerooperacion", "Cant" as "Cantidad", "Monto" as "Monto", "Cliedsc" as "Clientedescripcion", "Cliente" as "Cliente", "Clidragon" as "Clientedragon", "Envio" as "Envio", "Fullenvios" as "Fullenvios", "Cancelada" as "Cancelada", "Tipocomp" as "Tipocomprobante", "Nombre" as "Clientenombre", "Pagado" as "Pagado", "Opecod" as "Operacion", "Plata" as "Plataforma", "Buzon" as "Buzon", "Bdatos" as "Basededatos", "Usaotrabd" as "Utilizastockotrabase", "Nrocomp" as "Numerocomprobante", "Origenst" as "Bdorigenstock", "Nrocompafe" as "Comprobanteafectado" from ZooLogic.ECCOMPDET where NUMERO = <<transform( c_COMPROBANTESECOMMERCE.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleOperaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOperaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOperaciones
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
				lcOrden =  str( .Numero, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Pendiente" as "Operacionespendientes", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Ecommerce" as "Ecommerce", "Fecha" as "Fecha", "Obs" as "Observacion" from ZooLogic.COMPECOM where  COMPECOM.NUMERO != 0 order by NUMERO desc
			endtext
			use in select('c_COMPROBANTESECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTESECOMMERCE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Numero" as "Numero", "Openum" as "Numerooperacion", "Cant" as "Cantidad", "Monto" as "Monto", "Cliedsc" as "Clientedescripcion", "Cliente" as "Cliente", "Clidragon" as "Clientedragon", "Envio" as "Envio", "Fullenvios" as "Fullenvios", "Cancelada" as "Cancelada", "Tipocomp" as "Tipocomprobante", "Nombre" as "Clientenombre", "Pagado" as "Pagado", "Opecod" as "Operacion", "Plata" as "Plataforma", "Buzon" as "Buzon", "Bdatos" as "Basededatos", "Usaotrabd" as "Utilizastockotrabase", "Nrocomp" as "Numerocomprobante", "Origenst" as "Bdorigenstock", "Nrocompafe" as "Comprobanteafectado" from ZooLogic.ECCOMPDET where NUMERO = <<transform( c_COMPROBANTESECOMMERCE.NUMERO )>> Order by NroItem
			endtext
			use in select('c_DetalleOperaciones')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleOperaciones', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleOperaciones
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Numero,Pendiente,Smodifw,Saltafw,Ualtafw,Vmodifw,Za" + ;
"dsfw,Valtafw,Hmodifw,Umodifw,Haltafw,Horaimpo,Bdaltafw,Bdmodifw,Esttrans,Horaexpo,Ecommerce,Fecha,Ob" + ;
"s" + ;
" from ZooLogic.COMPECOM where  COMPECOM.NUMERO != 0 and " + lcFiltro )
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
			local  lxCompecomFecexpo, lxCompecomFectrans, lxCompecomFecimpo, lxCompecomFaltafw, lxCompecomFmodifw, lxCompecomNumero, lxCompecomPendiente, lxCompecomSmodifw, lxCompecomSaltafw, lxCompecomUaltafw, lxCompecomVmodifw, lxCompecomZadsfw, lxCompecomValtafw, lxCompecomHmodifw, lxCompecomUmodifw, lxCompecomHaltafw, lxCompecomHoraimpo, lxCompecomBdaltafw, lxCompecomBdmodifw, lxCompecomEsttrans, lxCompecomHoraexpo, lxCompecomEcommerce, lxCompecomFecha, lxCompecomObs
				lxCompecomFecexpo = ctod( '  /  /    ' )			lxCompecomFectrans = ctod( '  /  /    ' )			lxCompecomFecimpo = ctod( '  /  /    ' )			lxCompecomFaltafw = ctod( '  /  /    ' )			lxCompecomFmodifw = ctod( '  /  /    ' )			lxCompecomNumero = 0			lxCompecomPendiente = .F.			lxCompecomSmodifw = []			lxCompecomSaltafw = []			lxCompecomUaltafw = []			lxCompecomVmodifw = []			lxCompecomZadsfw = []			lxCompecomValtafw = []			lxCompecomHmodifw = []			lxCompecomUmodifw = []			lxCompecomHaltafw = []			lxCompecomHoraimpo = []			lxCompecomBdaltafw = []			lxCompecomBdmodifw = []			lxCompecomEsttrans = []			lxCompecomHoraexpo = []			lxCompecomEcommerce = []			lxCompecomFecha = ctod( '  /  /    ' )			lxCompecomObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ECCOMPDET where "NUMERO" = ' + transform( .oEntidad.NUMERO ) )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMPECOM where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMPECOM' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where NUMERO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(NUMERO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPECOM.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Pendiente" as "Operacionespendientes", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Ecommerce" as "Ecommerce", "Fecha" as "Fecha", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPECOM', '', tnTope )
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
	Function ObtenerDatosDetalleDetalleOperaciones( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ECCOMPDET.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Numero" as "Numero", "Openum" as "Numerooperacion", "Cant" as "Cantidad", "Monto" as "Monto", "Cliedsc" as "Clientedescripcion", "Cliente" as "Cliente", "Clidragon" as "Clientedragon", "Envio" as "Envio", "Fullenvios" as "Fullenvios", "Cancelada" as "Cancelada", "Tipocomp" as "Tipocomprobante", "Nombre" as "Clientenombre", "Pagado" as "Pagado", "Opecod" as "Operacion", "Plata" as "Plataforma", "Buzon" as "Buzon", "Bdatos" as "Basededatos", "Usaotrabd" as "Utilizastockotrabase", "Nrocomp" as "Numerocomprobante", "Origenst" as "Bdorigenstock", "Nrocompafe" as "Comprobanteafectado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleOperaciones( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ECCOMPDET', 'DetalleOperaciones', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleOperaciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleOperaciones( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'OPERACIONESPENDIENTES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PENDIENTE AS OPERACIONESPENDIENTES'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ECOMMERCE AS ECOMMERCE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleOperaciones( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'NUMEROOPERACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPENUM AS NUMEROOPERACION'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANT AS CANTIDAD'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDSC AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CLIENTEDRAGON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIDRAGON AS CLIENTEDRAGON'
				Case lcAtributo == 'ENVIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENVIO AS ENVIO'
				Case lcAtributo == 'FULLENVIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FULLENVIOS AS FULLENVIOS'
				Case lcAtributo == 'CANCELADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANCELADA AS CANCELADA'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'CLIENTENOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMBRE AS CLIENTENOMBRE'
				Case lcAtributo == 'PAGADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGADO AS PAGADO'
				Case lcAtributo == 'OPERACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPECOD AS OPERACION'
				Case lcAtributo == 'PLATAFORMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PLATA AS PLATAFORMA'
				Case lcAtributo == 'BUZON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BUZON AS BUZON'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDATOS AS BASEDEDATOS'
				Case lcAtributo == 'UTILIZASTOCKOTRABASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USAOTRABD AS UTILIZASTOCKOTRABASE'
				Case lcAtributo == 'NUMEROCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCOMP AS NUMEROCOMPROBANTE'
				Case lcAtributo == 'BDORIGENSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGENST AS BDORIGENSTOCK'
				Case lcAtributo == 'COMPROBANTEAFECTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCOMPAFE AS COMPROBANTEAFECTADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'OPERACIONESPENDIENTES'
				lcCampo = 'PENDIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ECOMMERCE'
				lcCampo = 'ECOMMERCE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleOperaciones( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROOPERACION'
				lcCampo = 'OPENUM'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'CLIEDSC'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDRAGON'
				lcCampo = 'CLIDRAGON'
			Case upper( alltrim( tcAtributo ) ) == 'ENVIO'
				lcCampo = 'ENVIO'
			Case upper( alltrim( tcAtributo ) ) == 'FULLENVIOS'
				lcCampo = 'FULLENVIOS'
			Case upper( alltrim( tcAtributo ) ) == 'CANCELADA'
				lcCampo = 'CANCELADA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTENOMBRE'
				lcCampo = 'NOMBRE'
			Case upper( alltrim( tcAtributo ) ) == 'PAGADO'
				lcCampo = 'PAGADO'
			Case upper( alltrim( tcAtributo ) ) == 'OPERACION'
				lcCampo = 'OPECOD'
			Case upper( alltrim( tcAtributo ) ) == 'PLATAFORMA'
				lcCampo = 'PLATA'
			Case upper( alltrim( tcAtributo ) ) == 'BUZON'
				lcCampo = 'BUZON'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'UTILIZASTOCKOTRABASE'
				lcCampo = 'USAOTRABD'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCOMPROBANTE'
				lcCampo = 'NROCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'BDORIGENSTOCK'
				lcCampo = 'ORIGENST'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEAFECTADO'
				lcCampo = 'NROCOMPAFE'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLEOPERACIONES'
			lcRetorno = 'ECCOMPDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCompecomFecexpo, lxCompecomFectrans, lxCompecomFecimpo, lxCompecomFaltafw, lxCompecomFmodifw, lxCompecomNumero, lxCompecomPendiente, lxCompecomSmodifw, lxCompecomSaltafw, lxCompecomUaltafw, lxCompecomVmodifw, lxCompecomZadsfw, lxCompecomValtafw, lxCompecomHmodifw, lxCompecomUmodifw, lxCompecomHaltafw, lxCompecomHoraimpo, lxCompecomBdaltafw, lxCompecomBdmodifw, lxCompecomEsttrans, lxCompecomHoraexpo, lxCompecomEcommerce, lxCompecomFecha, lxCompecomObs
				lxCompecomFecexpo =  .Fechaexpo			lxCompecomFectrans =  .Fechatransferencia			lxCompecomFecimpo =  .Fechaimpo			lxCompecomFaltafw =  .Fechaaltafw			lxCompecomFmodifw =  .Fechamodificacionfw			lxCompecomNumero =  .Numero			lxCompecomPendiente =  .Operacionespendientes			lxCompecomSmodifw =  .Seriemodificacionfw			lxCompecomSaltafw =  .Seriealtafw			lxCompecomUaltafw =  .Usuarioaltafw			lxCompecomVmodifw =  .Versionmodificacionfw			lxCompecomZadsfw =  .Zadsfw			lxCompecomValtafw =  .Versionaltafw			lxCompecomHmodifw =  .Horamodificacionfw			lxCompecomUmodifw =  .Usuariomodificacionfw			lxCompecomHaltafw =  .Horaaltafw			lxCompecomHoraimpo =  .Horaimpo			lxCompecomBdaltafw =  .Basededatosaltafw			lxCompecomBdmodifw =  .Basededatosmodificacionfw			lxCompecomEsttrans =  .Estadotransferencia			lxCompecomHoraexpo =  .Horaexpo			lxCompecomEcommerce =  upper( .Ecommerce_PK ) 			lxCompecomFecha =  .Fecha			lxCompecomObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPECOM ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Numero","Pendiente","Smodifw","Saltafw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Hmodifw","Umodifw","Haltafw","Horaimpo","Bdaltafw","Bdmodifw","Esttrans","Horaexpo","Ecommerce","Fecha","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCompecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFmodifw ) + "'" >>, <<lxCompecomNumero >>, <<iif( lxCompecomPendiente, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCompecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomEcommerce ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompecomFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompecomObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMPECOM' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleOperaciones
				if this.oEntidad.DetalleOperaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumerooperacion = loItem.Numerooperacion
					lxCantidad = loItem.Cantidad
					lxMonto = loItem.Monto
					lxClientedescripcion = loItem.Clientedescripcion
					lxCliente_PK = loItem.Cliente_PK
					lxClientedragon_PK = loItem.Clientedragon_PK
					lxEnvio = loItem.Envio
					lxFullenvios = loItem.Fullenvios
					lxCancelada = loItem.Cancelada
					lxTipocomprobante = loItem.Tipocomprobante
					lxClientenombre = loItem.Clientenombre
					lxPagado = loItem.Pagado
					lxOperacion_PK = loItem.Operacion_PK
					lxPlataforma = loItem.Plataforma
					lxBuzon = loItem.Buzon
					lxBasededatos = loItem.Basededatos
					lxUtilizastockotrabase = loItem.Utilizastockotrabase
					lxNumerocomprobante = loItem.Numerocomprobante
					lxBdorigenstock = loItem.Bdorigenstock
					lxComprobanteafectado = loItem.Comprobanteafectado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ECCOMPDET("NROITEM","NUMERO","OPENUM","CANT","MONTO","CLIEDSC","CLIENTE","CLIDRAGON","ENVIO","FULLENVIOS","CANCELADA","TIPOCOMP","NOMBRE","PAGADO","OPECOD","PLATA","BUZON","BDATOS","USAOTRABD","NROCOMP","ORIGENST","NROCOMPAFE" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerooperacion ) + "'">>, <<lxCantidad>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedragon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEnvio ) + "'">>, <<iif( lxFullenvios, 1, 0 )>>, <<iif( lxCancelada, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientenombre ) + "'">>, <<iif( lxPagado, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxOperacion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma ) + "'">>, <<"'" + this.FormatearTextoSql( lxBuzon ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatos ) + "'">>, <<iif( lxUtilizastockotrabase, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBdorigenstock ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobanteafectado ) + "'">> ) 
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
			local  lxCompecomFecexpo, lxCompecomFectrans, lxCompecomFecimpo, lxCompecomFaltafw, lxCompecomFmodifw, lxCompecomNumero, lxCompecomPendiente, lxCompecomSmodifw, lxCompecomSaltafw, lxCompecomUaltafw, lxCompecomVmodifw, lxCompecomZadsfw, lxCompecomValtafw, lxCompecomHmodifw, lxCompecomUmodifw, lxCompecomHaltafw, lxCompecomHoraimpo, lxCompecomBdaltafw, lxCompecomBdmodifw, lxCompecomEsttrans, lxCompecomHoraexpo, lxCompecomEcommerce, lxCompecomFecha, lxCompecomObs
				lxCompecomFecexpo =  .Fechaexpo			lxCompecomFectrans =  .Fechatransferencia			lxCompecomFecimpo =  .Fechaimpo			lxCompecomFaltafw =  .Fechaaltafw			lxCompecomFmodifw =  .Fechamodificacionfw			lxCompecomNumero =  .Numero			lxCompecomPendiente =  .Operacionespendientes			lxCompecomSmodifw =  .Seriemodificacionfw			lxCompecomSaltafw =  .Seriealtafw			lxCompecomUaltafw =  .Usuarioaltafw			lxCompecomVmodifw =  .Versionmodificacionfw			lxCompecomZadsfw =  .Zadsfw			lxCompecomValtafw =  .Versionaltafw			lxCompecomHmodifw =  .Horamodificacionfw			lxCompecomUmodifw =  .Usuariomodificacionfw			lxCompecomHaltafw =  .Horaaltafw			lxCompecomHoraimpo =  .Horaimpo			lxCompecomBdaltafw =  .Basededatosaltafw			lxCompecomBdmodifw =  .Basededatosmodificacionfw			lxCompecomEsttrans =  .Estadotransferencia			lxCompecomHoraexpo =  .Horaexpo			lxCompecomEcommerce =  upper( .Ecommerce_PK ) 			lxCompecomFecha =  .Fecha			lxCompecomObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  COMPECOM.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPECOM set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompecomFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCompecomFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompecomFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCompecomFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompecomFmodifw ) + "'">>, "Numero" = <<lxCompecomNumero>>, "Pendiente" = <<iif( lxCompecomPendiente, 1, 0 )>>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCompecomSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCompecomSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompecomUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompecomVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompecomZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCompecomValtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompecomHmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCompecomUmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCompecomHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompecomHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompecomBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompecomBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCompecomEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompecomHoraexpo ) + "'">>, "Ecommerce" = <<"'" + this.FormatearTextoSql( lxCompecomEcommerce ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCompecomFecha ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCompecomObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPECOM' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ECCOMPDET where "NUMERO" = ] + transform( .oEntidad.NUMERO ))

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleOperaciones
				if this.oEntidad.DetalleOperaciones.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxNumerooperacion = loItem.Numerooperacion
					lxCantidad = loItem.Cantidad
					lxMonto = loItem.Monto
					lxClientedescripcion = loItem.Clientedescripcion
					lxCliente_PK = loItem.Cliente_PK
					lxClientedragon_PK = loItem.Clientedragon_PK
					lxEnvio = loItem.Envio
					lxFullenvios = loItem.Fullenvios
					lxCancelada = loItem.Cancelada
					lxTipocomprobante = loItem.Tipocomprobante
					lxClientenombre = loItem.Clientenombre
					lxPagado = loItem.Pagado
					lxOperacion_PK = loItem.Operacion_PK
					lxPlataforma = loItem.Plataforma
					lxBuzon = loItem.Buzon
					lxBasededatos = loItem.Basededatos
					lxUtilizastockotrabase = loItem.Utilizastockotrabase
					lxNumerocomprobante = loItem.Numerocomprobante
					lxBdorigenstock = loItem.Bdorigenstock
					lxComprobanteafectado = loItem.Comprobanteafectado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ECCOMPDET("NROITEM","NUMERO","OPENUM","CANT","MONTO","CLIEDSC","CLIENTE","CLIDRAGON","ENVIO","FULLENVIOS","CANCELADA","TIPOCOMP","NOMBRE","PAGADO","OPECOD","PLATA","BUZON","BDATOS","USAOTRABD","NROCOMP","ORIGENST","NROCOMPAFE" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerooperacion ) + "'">>, <<lxCantidad>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedragon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEnvio ) + "'">>, <<iif( lxFullenvios, 1, 0 )>>, <<iif( lxCancelada, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxTipocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientenombre ) + "'">>, <<iif( lxPagado, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxOperacion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPlataforma ) + "'">>, <<"'" + this.FormatearTextoSql( lxBuzon ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasededatos ) + "'">>, <<iif( lxUtilizastockotrabase, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxBdorigenstock ) + "'">>, <<"'" + this.FormatearTextoSql( lxComprobanteafectado ) + "'">> ) 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  COMPECOM.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.COMPECOM where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ECCOMPDET where "NUMERO" = ] + transform( .oEntidad.NUMERO ))
			loColeccion.cTabla = 'COMPECOM' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPECOM where  COMPECOM.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPECOM where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  COMPECOM.NUMERO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTESECOMMERCE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPECOM Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPECOM set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, PENDIENTE = ] + Transform( iif( &lcCursor..PENDIENTE, 1, 0 ))+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ECOMMERCE = ] + "'" + this.FormatearTextoSql( &lcCursor..ECOMMERCE ) + "'"+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + [ Where NUMERO = ] + transform( &lcCursor..NUMERO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, NUMERO, PENDIENTE, SMODIFW, SALTAFW, UALTAFW, VMODIFW, ZADSFW, VALTAFW, HMODIFW, UMODIFW, HALTAFW, HORAIMPO, BDALTAFW, BDMODIFW, ESTTRANS, HORAEXPO, ECOMMERCE, FECHA, OBS
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..NUMERO ) + ',' + Transform( iif( &lcCursor..PENDIENTE, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ECOMMERCE ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPECOM ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTESECOMMERCE'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'NUMERO','N')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','NUMERO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ECCOMPDET Where NUMERO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMOPERACIONESECOM'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where NUMERO in ( select NUMERO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","NUMERO","OPENUM","CANT","MONTO","CLIEDSC","CLIENTE","CLIDRAGON","ENVIO","FULLENVIOS","CANCELADA","TIPOCOMP","NOMBRE","PAGADO","OPECOD","PLATA","BUZON","BDATOS","USAOTRABD","NROCOMP","ORIGENST","NROCOMPAFE"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ECCOMPDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.NUMERO     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPENUM     ) + "'" + ',' + transform( cDetallesExistentes.CANT       ) + ',' + transform( cDetallesExistentes.MONTO      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CLIEDSC    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CLIENTE    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CLIDRAGON  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ENVIO      ) + "'" + ',' + Transform( iif( cDetallesExistentes.FULLENVIOS, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CANCELADA , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TIPOCOMP   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NOMBRE     ) + "'" + ',' + Transform( iif( cDetallesExistentes.PAGADO    , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.OPECOD     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.PLATA      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.BUZON      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.BDATOS     ) + "'" + ',' + Transform( iif( cDetallesExistentes.USAOTRABD , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NROCOMP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ORIGENST   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NROCOMPAFE ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( NUMERO N (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..NUMERO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'COMPROBANTESECOMMERCE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPROBANTESECOMMERCE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPROBANTESECOMMERCE_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMOPERACIONESECOM'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COMPECOM')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'COMPROBANTESECOMMERCE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad COMPROBANTESECOMMERCE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTESECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,NUMERO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NUMERO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTESECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECHA     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPECOM') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPECOM
Create Table ZooLogic.TablaTrabajo_COMPECOM ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"numero" numeric( 10, 0 )  null, 
"pendiente" bit  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"ecommerce" char( 10 )  null, 
"fecha" datetime  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COMPECOM' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COMPECOM' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTESECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('pendiente','pendiente')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('ecommerce','ecommerce')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COMPECOM'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.PENDIENTE = isnull( d.PENDIENTE, t.PENDIENTE ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ECOMMERCE = isnull( d.ECOMMERCE, t.ECOMMERCE ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.COMPECOM t inner join deleted d 
							 on t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.COMPECOM(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Numero,Pendiente,Smodifw,Saltafw,Ualtafw,Vmodifw,Zadsfw,Valtafw,Hmodifw,Umodifw,Haltafw,Horaimpo,Bdaltafw,Bdmodifw,Esttrans,Horaexpo,Ecommerce,Fecha,Obs)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.NUMERO,0),isnull( d.PENDIENTE,0),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.UMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.ECOMMERCE,''),isnull( d.FECHA,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.COMPECOM pk 
							 on d.NUMERO = pk.NUMERO
						Where pk.NUMERO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ECCOMPDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPECOM_ECCOMPDET
ON ZooLogic.TablaTrabajo_COMPECOM_ECCOMPDET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.NUMERO = isnull( d.NUMERO, t.NUMERO ),
t.OPENUM = isnull( d.OPENUM, t.OPENUM ),
t.CANT = isnull( d.CANT, t.CANT ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.CLIEDSC = isnull( d.CLIEDSC, t.CLIEDSC ),
t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),
t.CLIDRAGON = isnull( d.CLIDRAGON, t.CLIDRAGON ),
t.ENVIO = isnull( d.ENVIO, t.ENVIO ),
t.FULLENVIOS = isnull( d.FULLENVIOS, t.FULLENVIOS ),
t.CANCELADA = isnull( d.CANCELADA, t.CANCELADA ),
t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),
t.NOMBRE = isnull( d.NOMBRE, t.NOMBRE ),
t.PAGADO = isnull( d.PAGADO, t.PAGADO ),
t.OPECOD = isnull( d.OPECOD, t.OPECOD ),
t.PLATA = isnull( d.PLATA, t.PLATA ),
t.BUZON = isnull( d.BUZON, t.BUZON ),
t.BDATOS = isnull( d.BDATOS, t.BDATOS ),
t.USAOTRABD = isnull( d.USAOTRABD, t.USAOTRABD ),
t.NROCOMP = isnull( d.NROCOMP, t.NROCOMP ),
t.ORIGENST = isnull( d.ORIGENST, t.ORIGENST ),
t.NROCOMPAFE = isnull( d.NROCOMPAFE, t.NROCOMPAFE )
from ZooLogic.ECCOMPDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ECCOMPDET
( 
"NROITEM",
"NUMERO",
"OPENUM",
"CANT",
"MONTO",
"CLIEDSC",
"CLIENTE",
"CLIDRAGON",
"ENVIO",
"FULLENVIOS",
"CANCELADA",
"TIPOCOMP",
"NOMBRE",
"PAGADO",
"OPECOD",
"PLATA",
"BUZON",
"BDATOS",
"USAOTRABD",
"NROCOMP",
"ORIGENST",
"NROCOMPAFE"
 )
Select 
d.NROITEM,
d.NUMERO,
d.OPENUM,
d.CANT,
d.MONTO,
d.CLIEDSC,
d.CLIENTE,
d.CLIDRAGON,
d.ENVIO,
d.FULLENVIOS,
d.CANCELADA,
d.TIPOCOMP,
d.NOMBRE,
d.PAGADO,
d.OPECOD,
d.PLATA,
d.BUZON,
d.BDATOS,
d.USAOTRABD,
d.NROCOMP,
d.ORIGENST,
d.NROCOMPAFE
From deleted d left join ZooLogic.ECCOMPDET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPECOM') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPECOM
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_COMPROBANTESECOMMERCE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTESECOMMERCE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTESECOMMERCE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTESECOMMERCE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTESECOMMERCE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTESECOMMERCE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_COMPROBANTESECOMMERCE.Numero, 0 )
					.Operacionespendientes = nvl( c_COMPROBANTESECOMMERCE.Operacionespendientes, .F. )
					.Seriemodificacionfw = nvl( c_COMPROBANTESECOMMERCE.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_COMPROBANTESECOMMERCE.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_COMPROBANTESECOMMERCE.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_COMPROBANTESECOMMERCE.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_COMPROBANTESECOMMERCE.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_COMPROBANTESECOMMERCE.Horamodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_COMPROBANTESECOMMERCE.Usuariomodificacionfw, [] )
					.Horaaltafw = nvl( c_COMPROBANTESECOMMERCE.Horaaltafw, [] )
					.Horaimpo = nvl( c_COMPROBANTESECOMMERCE.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_COMPROBANTESECOMMERCE.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_COMPROBANTESECOMMERCE.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_COMPROBANTESECOMMERCE.Estadotransferencia, [] )
					.Horaexpo = nvl( c_COMPROBANTESECOMMERCE.Horaexpo, [] )
					.Ecommerce_PK =  nvl( c_COMPROBANTESECOMMERCE.Ecommerce, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTESECOMMERCE.Fecha, ctod( '  /  /    ' ) ) )
					.Detalleoperaciones.Limpiar()
					.Detalleoperaciones.SetearEsNavegacion( .lProcesando )
					.Detalleoperaciones.Cargar()
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
		
		loDetalle = this.oEntidad.DetalleOperaciones
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
		return c_COMPROBANTESECOMMERCE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMPECOM' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,NUMERO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    NUMERO from (
							select * 
								from ZooLogic.COMPECOM 
								Where   COMPECOM.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMPECOM", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Numero" as "Numero", "Pendiente" as "Operacionespendientes", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Ecommerce" as "Ecommerce", "Fecha" as "Fecha", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPECOM 
								Where   COMPECOM.NUMERO != 0
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
	Tabla = 'COMPECOM'
	Filtro = " COMPECOM.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPECOM.NUMERO != 0"
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
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="FECHAEXPO                               " tabla="COMPECOM       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="FECHATRANSFERENCIA                      " tabla="COMPECOM       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="FECHAIMPO                               " tabla="COMPECOM       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="FECHAALTAFW                             " tabla="COMPECOM       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="FECHAMODIFICACIONFW                     " tabla="COMPECOM       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="NUMERO                                  " tabla="COMPECOM       " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="OPERACIONESPENDIENTES                   " tabla="COMPECOM       " campo="PENDIENTE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Operaciones Pendientes                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="SERIEMODIFICACIONFW                     " tabla="COMPECOM       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="SERIEALTAFW                             " tabla="COMPECOM       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="USUARIOALTAFW                           " tabla="COMPECOM       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPECOM       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="ZADSFW                                  " tabla="COMPECOM       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="VERSIONALTAFW                           " tabla="COMPECOM       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="HORAMODIFICACIONFW                      " tabla="COMPECOM       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPECOM       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="HORAALTAFW                              " tabla="COMPECOM       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="HORAIMPO                                " tabla="COMPECOM       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="BASEDEDATOSALTAFW                       " tabla="COMPECOM       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPECOM       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPECOM       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="HORAEXPO                                " tabla="COMPECOM       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="ECOMMERCE                               " tabla="COMPECOM       " campo="ECOMMERCE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ECOMMERCE                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Plataforma                                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="FECHA                                   " tabla="COMPECOM       " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="6" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="DETALLEOPERACIONES                      " tabla="ECCOMPDET      " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Detalle comprobantes                                                                                                                                            " dominio="DETALLEITEMOPERACIONESECOM    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTESECOMMERCE                   " atributo="OBSERVACION                             " tabla="COMPECOM       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="DESCRIPCION                             " tabla="ECOM           " campo="CUENTA    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="5" etiqueta="Detalle Pla.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ECOM On COMPECOM.ECOMMERCE = ECOM.CODIGO And  ECOM.CODIGO != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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