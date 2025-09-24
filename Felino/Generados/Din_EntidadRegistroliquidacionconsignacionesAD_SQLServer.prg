
define class Din_EntidadREGISTROLIQUIDACIONCONSIGNACIONESAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REGISTROLIQUIDACIONCONSIGNACIONES'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_RLCPK'
	cTablaPrincipal = 'REGCONSIGNACION'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'SUCURSAL'
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
			local  lxRegconsignacionFectrans, lxRegconsignacionFaltafw, lxRegconsignacionFmodifw, lxRegconsignacionFecimpo, lxRegconsignacionFecexpo, lxRegconsignacionHoraexpo, lxRegconsignacionHaltafw, lxRegconsignacionSaltafw, lxRegconsignacionVmodifw, lxRegconsignacionZadsfw, lxRegconsignacionValtafw, lxRegconsignacionUaltafw, lxRegconsignacionUmodifw, lxRegconsignacionHmodifw, lxRegconsignacionSmodifw, lxRegconsignacionHoraimpo, lxRegconsignacionEsttrans, lxRegconsignacionBdaltafw, lxRegconsignacionBdmodifw, lxRegconsignacionCodigo, lxRegconsignacionBliquida, lxRegconsignacionBliquidada, lxRegconsignacionIditemliq, lxRegconsignacionFart, lxRegconsignacionCcolor, lxRegconsignacionTalle, lxRegconsignacionAfecant, lxRegconsignacionCantidad, lxRegconsignacionMovtipo, lxRegconsignacionMovdesc, lxRegconsignacionCompcodigo, lxRegconsignacionLiqdesc, lxRegconsignacionLiqcodigo, lxRegconsignacionLiqcant, lxRegconsignacionLiqiditem, lxRegconsignacionConsigcod, lxRegconsignacionConsigdesc, lxRegconsignacionRemafecod, lxRegconsignacionAnulado
				lxRegconsignacionFectrans =  .Fechatransferencia			lxRegconsignacionFaltafw =  .Fechaaltafw			lxRegconsignacionFmodifw =  .Fechamodificacionfw			lxRegconsignacionFecimpo =  .Fechaimpo			lxRegconsignacionFecexpo =  .Fechaexpo			lxRegconsignacionHoraexpo =  .Horaexpo			lxRegconsignacionHaltafw =  .Horaaltafw			lxRegconsignacionSaltafw =  .Seriealtafw			lxRegconsignacionVmodifw =  .Versionmodificacionfw			lxRegconsignacionZadsfw =  .Zadsfw			lxRegconsignacionValtafw =  .Versionaltafw			lxRegconsignacionUaltafw =  .Usuarioaltafw			lxRegconsignacionUmodifw =  .Usuariomodificacionfw			lxRegconsignacionHmodifw =  .Horamodificacionfw			lxRegconsignacionSmodifw =  .Seriemodificacionfw			lxRegconsignacionHoraimpo =  .Horaimpo			lxRegconsignacionEsttrans =  .Estadotransferencia			lxRegconsignacionBdaltafw =  .Basededatosaltafw			lxRegconsignacionBdmodifw =  .Basededatosmodificacionfw			lxRegconsignacionCodigo =  .Codigo			lxRegconsignacionBliquida =  .Bliquida			lxRegconsignacionBliquidada =  .Bliquidada			lxRegconsignacionIditemliq =  .Iditemliquidado			lxRegconsignacionFart =  .Articulo			lxRegconsignacionCcolor =  .Color			lxRegconsignacionTalle =  .Talle			lxRegconsignacionAfecant =  .Afecant			lxRegconsignacionCantidad =  .Cantidad			lxRegconsignacionMovtipo =  .Movimientotipo			lxRegconsignacionMovdesc =  .Movimientodescrip			lxRegconsignacionCompcodigo =  .Comprobanteconsignadorcodigo			lxRegconsignacionLiqdesc =  .Compliquidaciondescripcion			lxRegconsignacionLiqcodigo =  .Compliquidacioncodigo			lxRegconsignacionLiqcant =  .Liquidadocantidad			lxRegconsignacionLiqiditem =  .Compliquidacioniditem			lxRegconsignacionConsigcod =  .Comprobanteconsignatariocodigo			lxRegconsignacionConsigdesc =  .Comprobanteconsignatariodescripcion			lxRegconsignacionRemafecod =  .Remitoafectadocodigo			lxRegconsignacionAnulado =  .Anulado
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRegconsignacionCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.REGCONSIGNACION ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Horaexpo","Haltafw","Saltafw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Hmodifw","Smodifw","Horaimpo","Esttrans","Bdaltafw","Bdmodifw","Codigo","Bliquida","Bliquidada","Iditemliq","Fart","Ccolor","Talle","Afecant","Cantidad","Movtipo","Movdesc","Compcodigo","Liqdesc","Liqcodigo","Liqcant","Liqiditem","Consigcod","Consigdesc","Remafecod","Anulado" ) values ( <<"'" + this.ConvertirDateSql( lxRegconsignacionFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegconsignacionFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegconsignacionFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegconsignacionFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegconsignacionFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionBliquida ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionBliquidada ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionIditemliq ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionFart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionCcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionTalle ) + "'" >>, <<lxRegconsignacionAfecant >>, <<lxRegconsignacionCantidad >>, <<lxRegconsignacionMovtipo >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionMovdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionCompcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqcodigo ) + "'" >>, <<lxRegconsignacionLiqcant >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqiditem ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionConsigcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionConsigdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionRemafecod ) + "'" >>, <<iif( lxRegconsignacionAnulado, 1, 0 ) >> )
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
			local  lxRegconsignacionFectrans, lxRegconsignacionFaltafw, lxRegconsignacionFmodifw, lxRegconsignacionFecimpo, lxRegconsignacionFecexpo, lxRegconsignacionHoraexpo, lxRegconsignacionHaltafw, lxRegconsignacionSaltafw, lxRegconsignacionVmodifw, lxRegconsignacionZadsfw, lxRegconsignacionValtafw, lxRegconsignacionUaltafw, lxRegconsignacionUmodifw, lxRegconsignacionHmodifw, lxRegconsignacionSmodifw, lxRegconsignacionHoraimpo, lxRegconsignacionEsttrans, lxRegconsignacionBdaltafw, lxRegconsignacionBdmodifw, lxRegconsignacionCodigo, lxRegconsignacionBliquida, lxRegconsignacionBliquidada, lxRegconsignacionIditemliq, lxRegconsignacionFart, lxRegconsignacionCcolor, lxRegconsignacionTalle, lxRegconsignacionAfecant, lxRegconsignacionCantidad, lxRegconsignacionMovtipo, lxRegconsignacionMovdesc, lxRegconsignacionCompcodigo, lxRegconsignacionLiqdesc, lxRegconsignacionLiqcodigo, lxRegconsignacionLiqcant, lxRegconsignacionLiqiditem, lxRegconsignacionConsigcod, lxRegconsignacionConsigdesc, lxRegconsignacionRemafecod, lxRegconsignacionAnulado
				lxRegconsignacionFectrans =  .Fechatransferencia			lxRegconsignacionFaltafw =  .Fechaaltafw			lxRegconsignacionFmodifw =  .Fechamodificacionfw			lxRegconsignacionFecimpo =  .Fechaimpo			lxRegconsignacionFecexpo =  .Fechaexpo			lxRegconsignacionHoraexpo =  .Horaexpo			lxRegconsignacionHaltafw =  .Horaaltafw			lxRegconsignacionSaltafw =  .Seriealtafw			lxRegconsignacionVmodifw =  .Versionmodificacionfw			lxRegconsignacionZadsfw =  .Zadsfw			lxRegconsignacionValtafw =  .Versionaltafw			lxRegconsignacionUaltafw =  .Usuarioaltafw			lxRegconsignacionUmodifw =  .Usuariomodificacionfw			lxRegconsignacionHmodifw =  .Horamodificacionfw			lxRegconsignacionSmodifw =  .Seriemodificacionfw			lxRegconsignacionHoraimpo =  .Horaimpo			lxRegconsignacionEsttrans =  .Estadotransferencia			lxRegconsignacionBdaltafw =  .Basededatosaltafw			lxRegconsignacionBdmodifw =  .Basededatosmodificacionfw			lxRegconsignacionCodigo =  .Codigo			lxRegconsignacionBliquida =  .Bliquida			lxRegconsignacionBliquidada =  .Bliquidada			lxRegconsignacionIditemliq =  .Iditemliquidado			lxRegconsignacionFart =  .Articulo			lxRegconsignacionCcolor =  .Color			lxRegconsignacionTalle =  .Talle			lxRegconsignacionAfecant =  .Afecant			lxRegconsignacionCantidad =  .Cantidad			lxRegconsignacionMovtipo =  .Movimientotipo			lxRegconsignacionMovdesc =  .Movimientodescrip			lxRegconsignacionCompcodigo =  .Comprobanteconsignadorcodigo			lxRegconsignacionLiqdesc =  .Compliquidaciondescripcion			lxRegconsignacionLiqcodigo =  .Compliquidacioncodigo			lxRegconsignacionLiqcant =  .Liquidadocantidad			lxRegconsignacionLiqiditem =  .Compliquidacioniditem			lxRegconsignacionConsigcod =  .Comprobanteconsignatariocodigo			lxRegconsignacionConsigdesc =  .Comprobanteconsignatariodescripcion			lxRegconsignacionRemafecod =  .Remitoafectadocodigo			lxRegconsignacionAnulado =  .Anulado
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.REGCONSIGNACION set "Fectrans" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFecexpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionHaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRegconsignacionEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionBdmodifw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionCodigo ) + "'">>,"Bliquida" = <<"'" + this.FormatearTextoSql( lxRegconsignacionBliquida ) + "'">>,"Bliquidada" = <<"'" + this.FormatearTextoSql( lxRegconsignacionBliquidada ) + "'">>,"Iditemliq" = <<"'" + this.FormatearTextoSql( lxRegconsignacionIditemliq ) + "'">>,"Fart" = <<"'" + this.FormatearTextoSql( lxRegconsignacionFart ) + "'">>,"Ccolor" = <<"'" + this.FormatearTextoSql( lxRegconsignacionCcolor ) + "'">>,"Talle" = <<"'" + this.FormatearTextoSql( lxRegconsignacionTalle ) + "'">>,"Afecant" = <<lxRegconsignacionAfecant>>,"Cantidad" = <<lxRegconsignacionCantidad>>,"Movtipo" = <<lxRegconsignacionMovtipo>>,"Movdesc" = <<"'" + this.FormatearTextoSql( lxRegconsignacionMovdesc ) + "'">>,"Compcodigo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionCompcodigo ) + "'">>,"Liqdesc" = <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqdesc ) + "'">>,"Liqcodigo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqcodigo ) + "'">>,"Liqcant" = <<lxRegconsignacionLiqcant>>,"Liqiditem" = <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqiditem ) + "'">>,"Consigcod" = <<"'" + this.FormatearTextoSql( lxRegconsignacionConsigcod ) + "'">>,"Consigdesc" = <<"'" + this.FormatearTextoSql( lxRegconsignacionConsigdesc ) + "'">>,"Remafecod" = <<"'" + this.FormatearTextoSql( lxRegconsignacionRemafecod ) + "'">>,"Anulado" = <<iif( lxRegconsignacionAnulado, 1, 0 )>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionCodigo ) + "'">> and  REGCONSIGNACION.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.REGCONSIGNACION where " + this.ConvertirFuncionesSql( " REGCONSIGNACION.CODIGO != ''" ) )
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
			Local lxRegconsignacionCodigo
			lxRegconsignacionCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Bliquida" as "Bliquida", "Bliquidada" as "Bliquidada", "Iditemliq" as "Iditemliquidado", "Fart" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Afecant" as "Afecant", "Cantidad" as "Cantidad", "Movtipo" as "Movimientotipo", "Movdesc" as "Movimientodescrip", "Compcodigo" as "Comprobanteconsignadorcodigo", "Liqdesc" as "Compliquidaciondescripcion", "Liqcodigo" as "Compliquidacioncodigo", "Liqcant" as "Liquidadocantidad", "Liqiditem" as "Compliquidacioniditem", "Consigcod" as "Comprobanteconsignatariocodigo", "Consigdesc" as "Comprobanteconsignatariodescripcion", "Remafecod" as "Remitoafectadocodigo", "Anulado" as "Anulado" from ZooLogic.REGCONSIGNACION where "Codigo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionCodigo ) + "'">> and  REGCONSIGNACION.CODIGO != ''
			endtext
			use in select('c_REGISTROLIQUIDACIONCONSIGNACIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTROLIQUIDACIONCONSIGNACIONES', set( 'Datasession' ) )

			if reccount( 'c_REGISTROLIQUIDACIONCONSIGNACIONES' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxRegconsignacionCodigo as Variant
		llRetorno = .t.
		lxRegconsignacionCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.REGCONSIGNACION where "Codigo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionCodigo ) + "'">> and  REGCONSIGNACION.CODIGO != ''
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Bliquida" as "Bliquida", "Bliquidada" as "Bliquidada", "Iditemliq" as "Iditemliquidado", "Fart" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Afecant" as "Afecant", "Cantidad" as "Cantidad", "Movtipo" as "Movimientotipo", "Movdesc" as "Movimientodescrip", "Compcodigo" as "Comprobanteconsignadorcodigo", "Liqdesc" as "Compliquidaciondescripcion", "Liqcodigo" as "Compliquidacioncodigo", "Liqcant" as "Liquidadocantidad", "Liqiditem" as "Compliquidacioniditem", "Consigcod" as "Comprobanteconsignatariocodigo", "Consigdesc" as "Comprobanteconsignatariodescripcion", "Remafecod" as "Remitoafectadocodigo", "Anulado" as "Anulado" from ZooLogic.REGCONSIGNACION where  REGCONSIGNACION.CODIGO != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_REGISTROLIQUIDACIONCONSIGNACIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTROLIQUIDACIONCONSIGNACIONES', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Bliquida" as "Bliquida", "Bliquidada" as "Bliquidada", "Iditemliq" as "Iditemliquidado", "Fart" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Afecant" as "Afecant", "Cantidad" as "Cantidad", "Movtipo" as "Movimientotipo", "Movdesc" as "Movimientodescrip", "Compcodigo" as "Comprobanteconsignadorcodigo", "Liqdesc" as "Compliquidaciondescripcion", "Liqcodigo" as "Compliquidacioncodigo", "Liqcant" as "Liquidadocantidad", "Liqiditem" as "Compliquidacioniditem", "Consigcod" as "Comprobanteconsignatariocodigo", "Consigdesc" as "Comprobanteconsignatariodescripcion", "Remafecod" as "Remitoafectadocodigo", "Anulado" as "Anulado" from ZooLogic.REGCONSIGNACION where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGCONSIGNACION.CODIGO != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_REGISTROLIQUIDACIONCONSIGNACIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTROLIQUIDACIONCONSIGNACIONES', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Bliquida" as "Bliquida", "Bliquidada" as "Bliquidada", "Iditemliq" as "Iditemliquidado", "Fart" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Afecant" as "Afecant", "Cantidad" as "Cantidad", "Movtipo" as "Movimientotipo", "Movdesc" as "Movimientodescrip", "Compcodigo" as "Comprobanteconsignadorcodigo", "Liqdesc" as "Compliquidaciondescripcion", "Liqcodigo" as "Compliquidacioncodigo", "Liqcant" as "Liquidadocantidad", "Liqiditem" as "Compliquidacioniditem", "Consigcod" as "Comprobanteconsignatariocodigo", "Consigdesc" as "Comprobanteconsignatariodescripcion", "Remafecod" as "Remitoafectadocodigo", "Anulado" as "Anulado" from ZooLogic.REGCONSIGNACION where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGCONSIGNACION.CODIGO != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_REGISTROLIQUIDACIONCONSIGNACIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTROLIQUIDACIONCONSIGNACIONES', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Bliquida" as "Bliquida", "Bliquidada" as "Bliquidada", "Iditemliq" as "Iditemliquidado", "Fart" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Afecant" as "Afecant", "Cantidad" as "Cantidad", "Movtipo" as "Movimientotipo", "Movdesc" as "Movimientodescrip", "Compcodigo" as "Comprobanteconsignadorcodigo", "Liqdesc" as "Compliquidaciondescripcion", "Liqcodigo" as "Compliquidacioncodigo", "Liqcant" as "Liquidadocantidad", "Liqiditem" as "Compliquidacioniditem", "Consigcod" as "Comprobanteconsignatariocodigo", "Consigdesc" as "Comprobanteconsignatariodescripcion", "Remafecod" as "Remitoafectadocodigo", "Anulado" as "Anulado" from ZooLogic.REGCONSIGNACION where  REGCONSIGNACION.CODIGO != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_REGISTROLIQUIDACIONCONSIGNACIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGISTROLIQUIDACIONCONSIGNACIONES', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Horaexpo,Haltafw,Saltafw,Vmodifw,Zadsfw,Valtafw,Ual" + ;
"tafw,Umodifw,Hmodifw,Smodifw,Horaimpo,Esttrans,Bdaltafw,Bdmodifw,Codigo,Bliquida,Bliquidada,Iditemli" + ;
"q,Fart,Ccolor,Talle,Afecant,Cantidad,Movtipo,Movdesc,Compcodigo,Liqdesc,Liqcodigo,Liqcant,Liqiditem," + ;
"Consigcod,Consigdesc,Remafecod,Anulado" + ;
" from ZooLogic.REGCONSIGNACION where  REGCONSIGNACION.CODIGO != '' and " + lcFiltro )
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
			local  lxRegconsignacionFectrans, lxRegconsignacionFaltafw, lxRegconsignacionFmodifw, lxRegconsignacionFecimpo, lxRegconsignacionFecexpo, lxRegconsignacionHoraexpo, lxRegconsignacionHaltafw, lxRegconsignacionSaltafw, lxRegconsignacionVmodifw, lxRegconsignacionZadsfw, lxRegconsignacionValtafw, lxRegconsignacionUaltafw, lxRegconsignacionUmodifw, lxRegconsignacionHmodifw, lxRegconsignacionSmodifw, lxRegconsignacionHoraimpo, lxRegconsignacionEsttrans, lxRegconsignacionBdaltafw, lxRegconsignacionBdmodifw, lxRegconsignacionCodigo, lxRegconsignacionBliquida, lxRegconsignacionBliquidada, lxRegconsignacionIditemliq, lxRegconsignacionFart, lxRegconsignacionCcolor, lxRegconsignacionTalle, lxRegconsignacionAfecant, lxRegconsignacionCantidad, lxRegconsignacionMovtipo, lxRegconsignacionMovdesc, lxRegconsignacionCompcodigo, lxRegconsignacionLiqdesc, lxRegconsignacionLiqcodigo, lxRegconsignacionLiqcant, lxRegconsignacionLiqiditem, lxRegconsignacionConsigcod, lxRegconsignacionConsigdesc, lxRegconsignacionRemafecod, lxRegconsignacionAnulado
				lxRegconsignacionFectrans = ctod( '  /  /    ' )			lxRegconsignacionFaltafw = ctod( '  /  /    ' )			lxRegconsignacionFmodifw = ctod( '  /  /    ' )			lxRegconsignacionFecimpo = ctod( '  /  /    ' )			lxRegconsignacionFecexpo = ctod( '  /  /    ' )			lxRegconsignacionHoraexpo = []			lxRegconsignacionHaltafw = []			lxRegconsignacionSaltafw = []			lxRegconsignacionVmodifw = []			lxRegconsignacionZadsfw = []			lxRegconsignacionValtafw = []			lxRegconsignacionUaltafw = []			lxRegconsignacionUmodifw = []			lxRegconsignacionHmodifw = []			lxRegconsignacionSmodifw = []			lxRegconsignacionHoraimpo = []			lxRegconsignacionEsttrans = []			lxRegconsignacionBdaltafw = []			lxRegconsignacionBdmodifw = []			lxRegconsignacionCodigo = []			lxRegconsignacionBliquida = []			lxRegconsignacionBliquidada = []			lxRegconsignacionIditemliq = []			lxRegconsignacionFart = []			lxRegconsignacionCcolor = []			lxRegconsignacionTalle = []			lxRegconsignacionAfecant = 0			lxRegconsignacionCantidad = 0			lxRegconsignacionMovtipo = 0			lxRegconsignacionMovdesc = []			lxRegconsignacionCompcodigo = []			lxRegconsignacionLiqdesc = []			lxRegconsignacionLiqcodigo = []			lxRegconsignacionLiqcant = 0			lxRegconsignacionLiqiditem = []			lxRegconsignacionConsigcod = []			lxRegconsignacionConsigdesc = []			lxRegconsignacionRemafecod = []			lxRegconsignacionAnulado = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.REGCONSIGNACION where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REGCONSIGNACION' + '_' + tcCampo
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
		lcWhere = " Where  REGCONSIGNACION.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Bliquida" as "Bliquida", "Bliquidada" as "Bliquidada", "Iditemliq" as "Iditemliquidado", "Fart" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Afecant" as "Afecant", "Cantidad" as "Cantidad", "Movtipo" as "Movimientotipo", "Movdesc" as "Movimientodescrip", "Compcodigo" as "Comprobanteconsignadorcodigo", "Liqdesc" as "Compliquidaciondescripcion", "Liqcodigo" as "Compliquidacioncodigo", "Liqcant" as "Liquidadocantidad", "Liqiditem" as "Compliquidacioniditem", "Consigcod" as "Comprobanteconsignatariocodigo", "Consigdesc" as "Comprobanteconsignatariodescripcion", "Remafecod" as "Remitoafectadocodigo", "Anulado" as "Anulado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REGCONSIGNACION', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'BLIQUIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLIQUIDA AS BLIQUIDA'
				Case lcAtributo == 'BLIQUIDADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLIQUIDADA AS BLIQUIDADA'
				Case lcAtributo == 'IDITEMLIQUIDADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMLIQ AS IDITEMLIQUIDADO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FART AS ARTICULO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'AFECANT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFECANT'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'MOVIMIENTOTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOVTIPO AS MOVIMIENTOTIPO'
				Case lcAtributo == 'MOVIMIENTODESCRIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOVDESC AS MOVIMIENTODESCRIP'
				Case lcAtributo == 'COMPROBANTECONSIGNADORCODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPCODIGO AS COMPROBANTECONSIGNADORCODIGO'
				Case lcAtributo == 'COMPLIQUIDACIONDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LIQDESC AS COMPLIQUIDACIONDESCRIPCION'
				Case lcAtributo == 'COMPLIQUIDACIONCODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LIQCODIGO AS COMPLIQUIDACIONCODIGO'
				Case lcAtributo == 'LIQUIDADOCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LIQCANT AS LIQUIDADOCANTIDAD'
				Case lcAtributo == 'COMPLIQUIDACIONIDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LIQIDITEM AS COMPLIQUIDACIONIDITEM'
				Case lcAtributo == 'COMPROBANTECONSIGNATARIOCODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONSIGCOD AS COMPROBANTECONSIGNATARIOCODIGO'
				Case lcAtributo == 'COMPROBANTECONSIGNATARIODESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONSIGDESC AS COMPROBANTECONSIGNATARIODESCRIPCION'
				Case lcAtributo == 'REMITOAFECTADOCODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REMAFECOD AS REMITOAFECTADOCODIGO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'BLIQUIDA'
				lcCampo = 'BLIQUIDA'
			Case upper( alltrim( tcAtributo ) ) == 'BLIQUIDADA'
				lcCampo = 'BLIQUIDADA'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMLIQUIDADO'
				lcCampo = 'IDITEMLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FART'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'AFECANT'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIMIENTOTIPO'
				lcCampo = 'MOVTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'MOVIMIENTODESCRIP'
				lcCampo = 'MOVDESC'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTECONSIGNADORCODIGO'
				lcCampo = 'COMPCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPLIQUIDACIONDESCRIPCION'
				lcCampo = 'LIQDESC'
			Case upper( alltrim( tcAtributo ) ) == 'COMPLIQUIDACIONCODIGO'
				lcCampo = 'LIQCODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'LIQUIDADOCANTIDAD'
				lcCampo = 'LIQCANT'
			Case upper( alltrim( tcAtributo ) ) == 'COMPLIQUIDACIONIDITEM'
				lcCampo = 'LIQIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTECONSIGNATARIOCODIGO'
				lcCampo = 'CONSIGCOD'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTECONSIGNATARIODESCRIPCION'
				lcCampo = 'CONSIGDESC'
			Case upper( alltrim( tcAtributo ) ) == 'REMITOAFECTADOCODIGO'
				lcCampo = 'REMAFECOD'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
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
			local  lxRegconsignacionFectrans, lxRegconsignacionFaltafw, lxRegconsignacionFmodifw, lxRegconsignacionFecimpo, lxRegconsignacionFecexpo, lxRegconsignacionHoraexpo, lxRegconsignacionHaltafw, lxRegconsignacionSaltafw, lxRegconsignacionVmodifw, lxRegconsignacionZadsfw, lxRegconsignacionValtafw, lxRegconsignacionUaltafw, lxRegconsignacionUmodifw, lxRegconsignacionHmodifw, lxRegconsignacionSmodifw, lxRegconsignacionHoraimpo, lxRegconsignacionEsttrans, lxRegconsignacionBdaltafw, lxRegconsignacionBdmodifw, lxRegconsignacionCodigo, lxRegconsignacionBliquida, lxRegconsignacionBliquidada, lxRegconsignacionIditemliq, lxRegconsignacionFart, lxRegconsignacionCcolor, lxRegconsignacionTalle, lxRegconsignacionAfecant, lxRegconsignacionCantidad, lxRegconsignacionMovtipo, lxRegconsignacionMovdesc, lxRegconsignacionCompcodigo, lxRegconsignacionLiqdesc, lxRegconsignacionLiqcodigo, lxRegconsignacionLiqcant, lxRegconsignacionLiqiditem, lxRegconsignacionConsigcod, lxRegconsignacionConsigdesc, lxRegconsignacionRemafecod, lxRegconsignacionAnulado
				lxRegconsignacionFectrans =  .Fechatransferencia			lxRegconsignacionFaltafw =  .Fechaaltafw			lxRegconsignacionFmodifw =  .Fechamodificacionfw			lxRegconsignacionFecimpo =  .Fechaimpo			lxRegconsignacionFecexpo =  .Fechaexpo			lxRegconsignacionHoraexpo =  .Horaexpo			lxRegconsignacionHaltafw =  .Horaaltafw			lxRegconsignacionSaltafw =  .Seriealtafw			lxRegconsignacionVmodifw =  .Versionmodificacionfw			lxRegconsignacionZadsfw =  .Zadsfw			lxRegconsignacionValtafw =  .Versionaltafw			lxRegconsignacionUaltafw =  .Usuarioaltafw			lxRegconsignacionUmodifw =  .Usuariomodificacionfw			lxRegconsignacionHmodifw =  .Horamodificacionfw			lxRegconsignacionSmodifw =  .Seriemodificacionfw			lxRegconsignacionHoraimpo =  .Horaimpo			lxRegconsignacionEsttrans =  .Estadotransferencia			lxRegconsignacionBdaltafw =  .Basededatosaltafw			lxRegconsignacionBdmodifw =  .Basededatosmodificacionfw			lxRegconsignacionCodigo =  .Codigo			lxRegconsignacionBliquida =  .Bliquida			lxRegconsignacionBliquidada =  .Bliquidada			lxRegconsignacionIditemliq =  .Iditemliquidado			lxRegconsignacionFart =  .Articulo			lxRegconsignacionCcolor =  .Color			lxRegconsignacionTalle =  .Talle			lxRegconsignacionAfecant =  .Afecant			lxRegconsignacionCantidad =  .Cantidad			lxRegconsignacionMovtipo =  .Movimientotipo			lxRegconsignacionMovdesc =  .Movimientodescrip			lxRegconsignacionCompcodigo =  .Comprobanteconsignadorcodigo			lxRegconsignacionLiqdesc =  .Compliquidaciondescripcion			lxRegconsignacionLiqcodigo =  .Compliquidacioncodigo			lxRegconsignacionLiqcant =  .Liquidadocantidad			lxRegconsignacionLiqiditem =  .Compliquidacioniditem			lxRegconsignacionConsigcod =  .Comprobanteconsignatariocodigo			lxRegconsignacionConsigdesc =  .Comprobanteconsignatariodescripcion			lxRegconsignacionRemafecod =  .Remitoafectadocodigo			lxRegconsignacionAnulado =  .Anulado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.REGCONSIGNACION ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Horaexpo","Haltafw","Saltafw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Hmodifw","Smodifw","Horaimpo","Esttrans","Bdaltafw","Bdmodifw","Codigo","Bliquida","Bliquidada","Iditemliq","Fart","Ccolor","Talle","Afecant","Cantidad","Movtipo","Movdesc","Compcodigo","Liqdesc","Liqcodigo","Liqcant","Liqiditem","Consigcod","Consigdesc","Remafecod","Anulado" ) values ( <<"'" + this.ConvertirDateSql( lxRegconsignacionFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegconsignacionFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegconsignacionFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegconsignacionFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRegconsignacionFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionBliquida ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionBliquidada ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionIditemliq ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionFart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionCcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionTalle ) + "'" >>, <<lxRegconsignacionAfecant >>, <<lxRegconsignacionCantidad >>, <<lxRegconsignacionMovtipo >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionMovdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionCompcodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqcodigo ) + "'" >>, <<lxRegconsignacionLiqcant >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqiditem ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionConsigcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionConsigdesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRegconsignacionRemafecod ) + "'" >>, <<iif( lxRegconsignacionAnulado, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'REGCONSIGNACION' 
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
			local  lxRegconsignacionFectrans, lxRegconsignacionFaltafw, lxRegconsignacionFmodifw, lxRegconsignacionFecimpo, lxRegconsignacionFecexpo, lxRegconsignacionHoraexpo, lxRegconsignacionHaltafw, lxRegconsignacionSaltafw, lxRegconsignacionVmodifw, lxRegconsignacionZadsfw, lxRegconsignacionValtafw, lxRegconsignacionUaltafw, lxRegconsignacionUmodifw, lxRegconsignacionHmodifw, lxRegconsignacionSmodifw, lxRegconsignacionHoraimpo, lxRegconsignacionEsttrans, lxRegconsignacionBdaltafw, lxRegconsignacionBdmodifw, lxRegconsignacionCodigo, lxRegconsignacionBliquida, lxRegconsignacionBliquidada, lxRegconsignacionIditemliq, lxRegconsignacionFart, lxRegconsignacionCcolor, lxRegconsignacionTalle, lxRegconsignacionAfecant, lxRegconsignacionCantidad, lxRegconsignacionMovtipo, lxRegconsignacionMovdesc, lxRegconsignacionCompcodigo, lxRegconsignacionLiqdesc, lxRegconsignacionLiqcodigo, lxRegconsignacionLiqcant, lxRegconsignacionLiqiditem, lxRegconsignacionConsigcod, lxRegconsignacionConsigdesc, lxRegconsignacionRemafecod, lxRegconsignacionAnulado
				lxRegconsignacionFectrans =  .Fechatransferencia			lxRegconsignacionFaltafw =  .Fechaaltafw			lxRegconsignacionFmodifw =  .Fechamodificacionfw			lxRegconsignacionFecimpo =  .Fechaimpo			lxRegconsignacionFecexpo =  .Fechaexpo			lxRegconsignacionHoraexpo =  .Horaexpo			lxRegconsignacionHaltafw =  .Horaaltafw			lxRegconsignacionSaltafw =  .Seriealtafw			lxRegconsignacionVmodifw =  .Versionmodificacionfw			lxRegconsignacionZadsfw =  .Zadsfw			lxRegconsignacionValtafw =  .Versionaltafw			lxRegconsignacionUaltafw =  .Usuarioaltafw			lxRegconsignacionUmodifw =  .Usuariomodificacionfw			lxRegconsignacionHmodifw =  .Horamodificacionfw			lxRegconsignacionSmodifw =  .Seriemodificacionfw			lxRegconsignacionHoraimpo =  .Horaimpo			lxRegconsignacionEsttrans =  .Estadotransferencia			lxRegconsignacionBdaltafw =  .Basededatosaltafw			lxRegconsignacionBdmodifw =  .Basededatosmodificacionfw			lxRegconsignacionCodigo =  .Codigo			lxRegconsignacionBliquida =  .Bliquida			lxRegconsignacionBliquidada =  .Bliquidada			lxRegconsignacionIditemliq =  .Iditemliquidado			lxRegconsignacionFart =  .Articulo			lxRegconsignacionCcolor =  .Color			lxRegconsignacionTalle =  .Talle			lxRegconsignacionAfecant =  .Afecant			lxRegconsignacionCantidad =  .Cantidad			lxRegconsignacionMovtipo =  .Movimientotipo			lxRegconsignacionMovdesc =  .Movimientodescrip			lxRegconsignacionCompcodigo =  .Comprobanteconsignadorcodigo			lxRegconsignacionLiqdesc =  .Compliquidaciondescripcion			lxRegconsignacionLiqcodigo =  .Compliquidacioncodigo			lxRegconsignacionLiqcant =  .Liquidadocantidad			lxRegconsignacionLiqiditem =  .Compliquidacioniditem			lxRegconsignacionConsigcod =  .Comprobanteconsignatariocodigo			lxRegconsignacionConsigdesc =  .Comprobanteconsignatariodescripcion			lxRegconsignacionRemafecod =  .Remitoafectadocodigo			lxRegconsignacionAnulado =  .Anulado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REGCONSIGNACION.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.REGCONSIGNACION set "Fectrans" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRegconsignacionFecexpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionHaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRegconsignacionEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRegconsignacionBdmodifw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionCodigo ) + "'">>, "Bliquida" = <<"'" + this.FormatearTextoSql( lxRegconsignacionBliquida ) + "'">>, "Bliquidada" = <<"'" + this.FormatearTextoSql( lxRegconsignacionBliquidada ) + "'">>, "Iditemliq" = <<"'" + this.FormatearTextoSql( lxRegconsignacionIditemliq ) + "'">>, "Fart" = <<"'" + this.FormatearTextoSql( lxRegconsignacionFart ) + "'">>, "Ccolor" = <<"'" + this.FormatearTextoSql( lxRegconsignacionCcolor ) + "'">>, "Talle" = <<"'" + this.FormatearTextoSql( lxRegconsignacionTalle ) + "'">>, "Afecant" = <<lxRegconsignacionAfecant>>, "Cantidad" = <<lxRegconsignacionCantidad>>, "Movtipo" = <<lxRegconsignacionMovtipo>>, "Movdesc" = <<"'" + this.FormatearTextoSql( lxRegconsignacionMovdesc ) + "'">>, "Compcodigo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionCompcodigo ) + "'">>, "Liqdesc" = <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqdesc ) + "'">>, "Liqcodigo" = <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqcodigo ) + "'">>, "Liqcant" = <<lxRegconsignacionLiqcant>>, "Liqiditem" = <<"'" + this.FormatearTextoSql( lxRegconsignacionLiqiditem ) + "'">>, "Consigcod" = <<"'" + this.FormatearTextoSql( lxRegconsignacionConsigcod ) + "'">>, "Consigdesc" = <<"'" + this.FormatearTextoSql( lxRegconsignacionConsigdesc ) + "'">>, "Remafecod" = <<"'" + this.FormatearTextoSql( lxRegconsignacionRemafecod ) + "'">>, "Anulado" = <<iif( lxRegconsignacionAnulado, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REGCONSIGNACION' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REGCONSIGNACION.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.REGCONSIGNACION where ' + lcFiltro )
			loColeccion.cTabla = 'REGCONSIGNACION' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.REGCONSIGNACION where  REGCONSIGNACION.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.REGCONSIGNACION where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  REGCONSIGNACION.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTROLIQUIDACIONCONSIGNACIONES'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.REGCONSIGNACION Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.REGCONSIGNACION set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, BLiquida = ] + "'" + this.FormatearTextoSql( &lcCursor..BLiquida ) + "'"+ [, BLiquidada = ] + "'" + this.FormatearTextoSql( &lcCursor..BLiquidada ) + "'"+ [, IdItemLiq = ] + "'" + this.FormatearTextoSql( &lcCursor..IdItemLiq ) + "'"+ [, FART = ] + "'" + this.FormatearTextoSql( &lcCursor..FART ) + "'"+ [, CCOLOR = ] + "'" + this.FormatearTextoSql( &lcCursor..CCOLOR ) + "'"+ [, TALLE = ] + "'" + this.FormatearTextoSql( &lcCursor..TALLE ) + "'"+ [, AfeCant = ] + transform( &lcCursor..AfeCant )+ [, Cantidad = ] + transform( &lcCursor..Cantidad )+ [, MovTipo = ] + transform( &lcCursor..MovTipo )+ [, MovDesc = ] + "'" + this.FormatearTextoSql( &lcCursor..MovDesc ) + "'"+ [, CompCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..CompCodigo ) + "'"+ [, LiqDesc = ] + "'" + this.FormatearTextoSql( &lcCursor..LiqDesc ) + "'"+ [, LiqCodigo = ] + "'" + this.FormatearTextoSql( &lcCursor..LiqCodigo ) + "'"+ [, LiqCant = ] + transform( &lcCursor..LiqCant )+ [, LiqIdItem = ] + "'" + this.FormatearTextoSql( &lcCursor..LiqIdItem ) + "'"+ [, ConsigCod = ] + "'" + this.FormatearTextoSql( &lcCursor..ConsigCod ) + "'"+ [, ConsigDesc = ] + "'" + this.FormatearTextoSql( &lcCursor..ConsigDesc ) + "'"+ [, RemAfeCod = ] + "'" + this.FormatearTextoSql( &lcCursor..RemAfeCod ) + "'"+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 )) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FALTAFW, FMODIFW, FECIMPO, FECEXPO, HORAEXPO, HALTAFW, SALTAFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, HMODIFW, SMODIFW, HORAIMPO, ESTTRANS, BDALTAFW, BDMODIFW, Codigo, BLiquida, BLiquidada, IdItemLiq, FART, CCOLOR, TALLE, AfeCant, Cantidad, MovTipo, MovDesc, CompCodigo, LiqDesc, LiqCodigo, LiqCant, LiqIdItem, ConsigCod, ConsigDesc, RemAfeCod, Anulado
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BLiquida ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BLiquidada ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IdItemLiq ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FART ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCOLOR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TALLE ) + "'" + ',' + transform( &lcCursor..AfeCant ) + ',' + transform( &lcCursor..Cantidad )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MovTipo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MovDesc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CompCodigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LiqDesc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LiqCodigo ) + "'" + ',' + transform( &lcCursor..LiqCant ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..LiqIdItem ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConsigCod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ConsigDesc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RemAfeCod ) + "'" + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.REGCONSIGNACION ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTROLIQUIDACIONCONSIGNACIONES'
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
			Case  lcAlias == lcPrefijo + 'REGISTROLIQUIDACIONCONSIGNACIONES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGISTROLIQUIDACIONCONSIGNACIONES_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_RegConsignacion')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REGISTROLIQUIDACIONCONSIGNACIONES'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REGISTROLIQUIDACIONCONSIGNACIONES. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTROLIQUIDACIONCONSIGNACIONES'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTROLIQUIDACIONCONSIGNACIONES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_RegConsignacion') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_RegConsignacion
Create Table ZooLogic.TablaTrabajo_RegConsignacion ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"bliquida" char( 11 )  null, 
"bliquidada" char( 11 )  null, 
"iditemliq" char( 38 )  null, 
"fart" char( 15 )  null, 
"ccolor" char( 6 )  null, 
"talle" char( 5 )  null, 
"afecant" numeric( 15, 2 )  null, 
"cantidad" numeric( 15, 2 )  null, 
"movtipo" numeric( 2, 0 )  null, 
"movdesc" char( 100 )  null, 
"compcodigo" char( 38 )  null, 
"liqdesc" char( 100 )  null, 
"liqcodigo" char( 38 )  null, 
"liqcant" numeric( 15, 2 )  null, 
"liqiditem" char( 38 )  null, 
"consigcod" char( 38 )  null, 
"consigdesc" char( 200 )  null, 
"remafecod" char( 38 )  null, 
"anulado" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_RegConsignacion' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_RegConsignacion' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGISTROLIQUIDACIONCONSIGNACIONES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('bliquida','bliquida')
			.AgregarMapeo('bliquidada','bliquidada')
			.AgregarMapeo('iditemliq','iditemliq')
			.AgregarMapeo('fart','fart')
			.AgregarMapeo('ccolor','ccolor')
			.AgregarMapeo('talle','talle')
			.AgregarMapeo('afecant','afecant')
			.AgregarMapeo('cantidad','cantidad')
			.AgregarMapeo('movtipo','movtipo')
			.AgregarMapeo('movdesc','movdesc')
			.AgregarMapeo('compcodigo','compcodigo')
			.AgregarMapeo('liqdesc','liqdesc')
			.AgregarMapeo('liqcodigo','liqcodigo')
			.AgregarMapeo('liqcant','liqcant')
			.AgregarMapeo('liqiditem','liqiditem')
			.AgregarMapeo('consigcod','consigcod')
			.AgregarMapeo('consigdesc','consigdesc')
			.AgregarMapeo('remafecod','remafecod')
			.AgregarMapeo('anulado','anulado')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_RegConsignacion'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.BLIQUIDA = isnull( d.BLIQUIDA, t.BLIQUIDA ),t.BLIQUIDADA = isnull( d.BLIQUIDADA, t.BLIQUIDADA ),t.IDITEMLIQ = isnull( d.IDITEMLIQ, t.IDITEMLIQ ),t.FART = isnull( d.FART, t.FART ),t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),t.TALLE = isnull( d.TALLE, t.TALLE ),t.AFECANT = isnull( d.AFECANT, t.AFECANT ),t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),t.MOVTIPO = isnull( d.MOVTIPO, t.MOVTIPO ),t.MOVDESC = isnull( d.MOVDESC, t.MOVDESC ),t.COMPCODIGO = isnull( d.COMPCODIGO, t.COMPCODIGO ),t.LIQDESC = isnull( d.LIQDESC, t.LIQDESC ),t.LIQCODIGO = isnull( d.LIQCODIGO, t.LIQCODIGO ),t.LIQCANT = isnull( d.LIQCANT, t.LIQCANT ),t.LIQIDITEM = isnull( d.LIQIDITEM, t.LIQIDITEM ),t.CONSIGCOD = isnull( d.CONSIGCOD, t.CONSIGCOD ),t.CONSIGDESC = isnull( d.CONSIGDESC, t.CONSIGDESC ),t.REMAFECOD = isnull( d.REMAFECOD, t.REMAFECOD ),t.ANULADO = isnull( d.ANULADO, t.ANULADO )
					from ZooLogic.REGCONSIGNACION t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.REGCONSIGNACION(Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Horaexpo,Haltafw,Saltafw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Hmodifw,Smodifw,Horaimpo,Esttrans,Bdaltafw,Bdmodifw,Codigo,Bliquida,Bliquidada,Iditemliq,Fart,Ccolor,Talle,Afecant,Cantidad,Movtipo,Movdesc,Compcodigo,Liqdesc,Liqcodigo,Liqcant,Liqiditem,Consigcod,Consigdesc,Remafecod,Anulado)
					Select isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CODIGO,''),isnull( d.BLIQUIDA,''),isnull( d.BLIQUIDADA,''),isnull( d.IDITEMLIQ,''),isnull( d.FART,''),isnull( d.CCOLOR,''),isnull( d.TALLE,''),isnull( d.AFECANT,0),isnull( d.CANTIDAD,0),isnull( d.MOVTIPO,0),isnull( d.MOVDESC,''),isnull( d.COMPCODIGO,''),isnull( d.LIQDESC,''),isnull( d.LIQCODIGO,''),isnull( d.LIQCANT,0),isnull( d.LIQIDITEM,''),isnull( d.CONSIGCOD,''),isnull( d.CONSIGDESC,''),isnull( d.REMAFECOD,''),isnull( d.ANULADO,0)
						From deleted d left join ZooLogic.REGCONSIGNACION pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_RegConsignacion') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_RegConsignacion
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REGISTROLIQUIDACIONCONSIGNACIONES' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Horaexpo, [] )
					.Horaaltafw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Horaaltafw, [] )
					.Seriealtafw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Horaimpo, [] )
					.Estadotransferencia = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Codigo, [] )
					.Bliquida = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Bliquida, [] )
					.Bliquidada = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Bliquidada, [] )
					.Iditemliquidado = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Iditemliquidado, [] )
					.Articulo = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Articulo, [] )
					.Color = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Color, [] )
					.Talle = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Talle, [] )
					.Afecant = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Afecant, 0 )
					.Cantidad = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Cantidad, 0 )
					.Movimientotipo = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Movimientotipo, 0 )
					.Movimientodescrip = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Movimientodescrip, [] )
					.Comprobanteconsignadorcodigo = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Comprobanteconsignadorcodigo, [] )
					.Compliquidaciondescripcion = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Compliquidaciondescripcion, [] )
					.Compliquidacioncodigo = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Compliquidacioncodigo, [] )
					.Liquidadocantidad = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Liquidadocantidad, 0 )
					.Compliquidacioniditem = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Compliquidacioniditem, [] )
					.Comprobanteconsignatariocodigo = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Comprobanteconsignatariocodigo, [] )
					.Comprobanteconsignatariodescripcion = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Comprobanteconsignatariodescripcion, [] )
					.Remitoafectadocodigo = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Remitoafectadocodigo, [] )
					.Anulado = nvl( c_REGISTROLIQUIDACIONCONSIGNACIONES.Anulado, .F. )
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
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_REGISTROLIQUIDACIONCONSIGNACIONES.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		local lcNombreBD as String 
		lcNombreBD = ''
		lcNombreBD = this.oConexion.ObtenerNombreBD( 'ZOOLOGICMASTER' )
		lcNombreBD = goLibrerias.EscapeCaracteresSqlServer( lcNombreBD )

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.REGCONSIGNACION' )
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
								from ZooLogic.REGCONSIGNACION 
								Where   REGCONSIGNACION.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REGCONSIGNACION", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Bliquida" as "Bliquida", "Bliquidada" as "Bliquidada", "Iditemliq" as "Iditemliquidado", "Fart" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Afecant" as "Afecant", "Cantidad" as "Cantidad", "Movtipo" as "Movimientotipo", "Movdesc" as "Movimientodescrip", "Compcodigo" as "Comprobanteconsignadorcodigo", "Liqdesc" as "Compliquidaciondescripcion", "Liqcodigo" as "Compliquidacioncodigo", "Liqcant" as "Liquidadocantidad", "Liqiditem" as "Compliquidacioniditem", "Consigcod" as "Comprobanteconsignatariocodigo", "Consigdesc" as "Comprobanteconsignatariodescripcion", "Remafecod" as "Remitoafectadocodigo", "Anulado" as "Anulado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.REGCONSIGNACION 
								Where   REGCONSIGNACION.CODIGO != ''
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
	Tabla = 'REGCONSIGNACION'
	Filtro = " REGCONSIGNACION.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REGCONSIGNACION.CODIGO != ''"
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
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="FECHATRANSFERENCIA                      " tabla="REGCONSIGNACION" campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="FECHAALTAFW                             " tabla="REGCONSIGNACION" campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="FECHAMODIFICACIONFW                     " tabla="REGCONSIGNACION" campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="FECHAIMPO                               " tabla="REGCONSIGNACION" campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="FECHAEXPO                               " tabla="REGCONSIGNACION" campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="HORAEXPO                                " tabla="REGCONSIGNACION" campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="HORAALTAFW                              " tabla="REGCONSIGNACION" campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="SERIEALTAFW                             " tabla="REGCONSIGNACION" campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="VERSIONMODIFICACIONFW                   " tabla="REGCONSIGNACION" campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="ZADSFW                                  " tabla="REGCONSIGNACION" campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="VERSIONALTAFW                           " tabla="REGCONSIGNACION" campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="USUARIOALTAFW                           " tabla="REGCONSIGNACION" campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="USUARIOMODIFICACIONFW                   " tabla="REGCONSIGNACION" campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="HORAMODIFICACIONFW                      " tabla="REGCONSIGNACION" campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="SERIEMODIFICACIONFW                     " tabla="REGCONSIGNACION" campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="HORAIMPO                                " tabla="REGCONSIGNACION" campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="ESTADOTRANSFERENCIA                     " tabla="REGCONSIGNACION" campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="BASEDEDATOSALTAFW                       " tabla="REGCONSIGNACION" campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REGCONSIGNACION" campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="CODIGO                                  " tabla="REGCONSIGNACION" campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="99" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="BLIQUIDA                                " tabla="REGCONSIGNACION" campo="BLIQUIDA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="11" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos consignador                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="BLIQUIDADA                              " tabla="REGCONSIGNACION" campo="BLIQUIDADA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="11" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos consignataria                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="IDITEMLIQUIDADO                         " tabla="REGCONSIGNACION" campo="IDITEMLIQ " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id Item Consignatario                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="ARTICULO                                " tabla="REGCONSIGNACION" campo="FART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Articulo Consignatario                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="25" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="COLOR                                   " tabla="REGCONSIGNACION" campo="CCOLOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Color Consignatario                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="30" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="TALLE                                   " tabla="REGCONSIGNACION" campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Talle Consignatario                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="35" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="AFECANT                                 " tabla="REGCONSIGNACION" campo="AFECANT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cantidad afectada                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="CANTIDAD                                " tabla="REGCONSIGNACION" campo="CANTIDAD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cantidad inicial                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="MOVIMIENTOTIPO                          " tabla="REGCONSIGNACION" campo="MOVTIPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de operación realizada                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="MOVIMIENTODESCRIP                       " tabla="REGCONSIGNACION" campo="MOVDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descripción de operación realizada                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="55" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="COMPROBANTECONSIGNADORCODIGO            " tabla="REGCONSIGNACION" campo="COMPCODIGO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante liquidación                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="57" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="COMPLIQUIDACIONDESCRIPCION              " tabla="REGCONSIGNACION" campo="LIQDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Liquidación Descripción                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="60" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="COMPLIQUIDACIONCODIGO                   " tabla="REGCONSIGNACION" campo="LIQCODIGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Liquidación Codigo                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="65" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="LIQUIDADOCANTIDAD                       " tabla="REGCONSIGNACION" campo="LIQCANT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cantidad liquidada                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="67" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="COMPLIQUIDACIONIDITEM                   " tabla="REGCONSIGNACION" campo="LIQIDITEM " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Liquidación Item                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="70" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="COMPROBANTECONSIGNATARIOCODIGO          " tabla="REGCONSIGNACION" campo="CONSIGCOD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Consignatario código                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="75" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="COMPROBANTECONSIGNATARIODESCRIPCION     " tabla="REGCONSIGNACION" campo="CONSIGDESC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Consignatario Descipción                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="80" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="REMITOAFECTADOCODIGO                    " tabla="REGCONSIGNACION" campo="REMAFECOD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="85" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGISTROLIQUIDACIONCONSIGNACIONES       " atributo="ANULADO                                 " tabla="REGCONSIGNACION" campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="87" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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