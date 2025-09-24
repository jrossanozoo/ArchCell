
define class Din_EntidadSTOCKCOMBINACIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_STOCKCOMBINACION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Articulo + Color + Talle]
	cExpresionCCPorCampos = [#tabla#.COART + #tabla#.COCOL + #tabla#.COTLL]
	cTagClaveCandidata = '_012CC'
	cTagClavePk = '_012PK'
	cTablaPrincipal = 'COMB'
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
			local  lxCombFecimpo, lxCombFaltafw, lxCombFecexpo, lxCombFectrans, lxCombFmodifw, lxCombSaltafw, lxCombSmodifw, lxCombUmodifw, lxCombHmodifw, lxCombZadsfw, lxCombValtafw, lxCombVmodifw, lxCombUaltafw, lxCombDescfw, lxCombCotll, lxCombHoraimpo, lxCombBdaltafw, lxCombHoraexpo, lxCombBdmodifw, lxCombEsttrans, lxCombHaltafw, lxCombCoart, lxCombCocod, lxCombCocol, lxCombPresupuest, lxCombCorigprepa, lxCombCorigpreco, lxCombPreparado, lxCombCorigpresu, lxCombSolcompra, lxCombPrecompra, lxCombCorigsolco, lxCombCorigsenia, lxCombReqcompra, lxCombSeniado, lxCombCorigreqco, lxCombCorigpedid, lxCombCocant, lxCombCorigpedco, lxCombPedcompra, lxCombPedido, lxCombMinrepo, lxCombCorig, lxCombMaxrepo, lxCombEntregapen, lxCombCorigentre
				lxCombFecimpo =  .Fechaimpo			lxCombFaltafw =  .Fechaaltafw			lxCombFecexpo =  .Fechaexpo			lxCombFectrans =  .Fechatransferencia			lxCombFmodifw =  .Fechamodificacionfw			lxCombSaltafw =  .Seriealtafw			lxCombSmodifw =  .Seriemodificacionfw			lxCombUmodifw =  .Usuariomodificacionfw			lxCombHmodifw =  .Horamodificacionfw			lxCombZadsfw =  .Zadsfw			lxCombValtafw =  .Versionaltafw			lxCombVmodifw =  .Versionmodificacionfw			lxCombUaltafw =  .Usuarioaltafw			lxCombDescfw =  .Descripcionfw			lxCombCotll =  .Talle			lxCombHoraimpo =  .Horaimpo			lxCombBdaltafw =  .Basededatosaltafw			lxCombHoraexpo =  .Horaexpo			lxCombBdmodifw =  .Basededatosmodificacionfw			lxCombEsttrans =  .Estadotransferencia			lxCombHaltafw =  .Horaaltafw			lxCombCoart =  upper( .Articulo_PK ) 			lxCombCocod =  .Codigo			lxCombCocol =  upper( .Color_PK ) 			lxCombPresupuest =  .Presupuestado			lxCombCorigprepa =  .Preparadooriginal			lxCombCorigpreco =  .Precompraoriginal			lxCombPreparado =  .Preparado			lxCombCorigpresu =  .Presupuestadooriginal			lxCombSolcompra =  .Solcompra			lxCombPrecompra =  .Precompra			lxCombCorigsolco =  .Solcompraoriginal			lxCombCorigsenia =  .Seniadooriginal			lxCombReqcompra =  .Reqcompra			lxCombSeniado =  .Seniado			lxCombCorigreqco =  .Reqcompraoriginal			lxCombCorigpedid =  .Pedidooriginal			lxCombCocant =  .Cantidad			lxCombCorigpedco =  .Pedcompraoriginal			lxCombPedcompra =  .Pedcompra			lxCombPedido =  .Pedido			lxCombMinrepo =  .Minreposicion			lxCombCorig =  .Cantidadoriginal			lxCombMaxrepo =  .Maxreposicion			lxCombEntregapen =  .Entregapen			lxCombCorigentre =  .Entregapenoriginal
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCombCocod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMB ( "Fecimpo","Faltafw","Fecexpo","Fectrans","Fmodifw","Saltafw","Smodifw","Umodifw","Hmodifw","Zadsfw","Valtafw","Vmodifw","Ualtafw","Descfw","Cotll","Horaimpo","Bdaltafw","Horaexpo","Bdmodifw","Esttrans","Haltafw","Coart","Cocod","Cocol","Presupuest","Corigprepa","Corigpreco","Preparado","Corigpresu","Solcompra","Precompra","Corigsolco","Corigsenia","Reqcompra","Seniado","Corigreqco","Corigpedid","Cocant","Corigpedco","Pedcompra","Pedido","Minrepo","Corig","Maxrepo","Entregapen","Corigentre" ) values ( <<"'" + this.ConvertirDateSql( lxCombFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCombFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCombFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCombFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCombFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombCotll ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombCoart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombCocol ) + "'" >>, <<lxCombPresupuest >>, <<lxCombCorigprepa >>, <<lxCombCorigpreco >>, <<lxCombPreparado >>, <<lxCombCorigpresu >>, <<lxCombSolcompra >>, <<lxCombPrecompra >>, <<lxCombCorigsolco >>, <<lxCombCorigsenia >>, <<lxCombReqcompra >>, <<lxCombSeniado >>, <<lxCombCorigreqco >>, <<lxCombCorigpedid >>, <<lxCombCocant >>, <<lxCombCorigpedco >>, <<lxCombPedcompra >>, <<lxCombPedido >>, <<lxCombMinrepo >>, <<lxCombCorig >>, <<lxCombMaxrepo >>, <<lxCombEntregapen >>, <<lxCombCorigentre >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
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
			local  lxCombFecimpo, lxCombFaltafw, lxCombFecexpo, lxCombFectrans, lxCombFmodifw, lxCombSaltafw, lxCombSmodifw, lxCombUmodifw, lxCombHmodifw, lxCombZadsfw, lxCombValtafw, lxCombVmodifw, lxCombUaltafw, lxCombDescfw, lxCombCotll, lxCombHoraimpo, lxCombBdaltafw, lxCombHoraexpo, lxCombBdmodifw, lxCombEsttrans, lxCombHaltafw, lxCombCoart, lxCombCocod, lxCombCocol, lxCombPresupuest, lxCombCorigprepa, lxCombCorigpreco, lxCombPreparado, lxCombCorigpresu, lxCombSolcompra, lxCombPrecompra, lxCombCorigsolco, lxCombCorigsenia, lxCombReqcompra, lxCombSeniado, lxCombCorigreqco, lxCombCorigpedid, lxCombCocant, lxCombCorigpedco, lxCombPedcompra, lxCombPedido, lxCombMinrepo, lxCombCorig, lxCombMaxrepo, lxCombEntregapen, lxCombCorigentre
				lxCombFecimpo =  .Fechaimpo			lxCombFaltafw =  .Fechaaltafw			lxCombFecexpo =  .Fechaexpo			lxCombFectrans =  .Fechatransferencia			lxCombFmodifw =  .Fechamodificacionfw			lxCombSaltafw =  .Seriealtafw			lxCombSmodifw =  .Seriemodificacionfw			lxCombUmodifw =  .Usuariomodificacionfw			lxCombHmodifw =  .Horamodificacionfw			lxCombZadsfw =  .Zadsfw			lxCombValtafw =  .Versionaltafw			lxCombVmodifw =  .Versionmodificacionfw			lxCombUaltafw =  .Usuarioaltafw			lxCombDescfw =  .Descripcionfw			lxCombCotll =  .Talle			lxCombHoraimpo =  .Horaimpo			lxCombBdaltafw =  .Basededatosaltafw			lxCombHoraexpo =  .Horaexpo			lxCombBdmodifw =  .Basededatosmodificacionfw			lxCombEsttrans =  .Estadotransferencia			lxCombHaltafw =  .Horaaltafw			lxCombCoart =  upper( .Articulo_PK ) 			lxCombCocod =  .Codigo			lxCombCocol =  upper( .Color_PK ) 			lxCombPresupuest =  .Presupuestado			lxCombCorigprepa =  .Preparadooriginal			lxCombCorigpreco =  .Precompraoriginal			lxCombPreparado =  .Preparado			lxCombCorigpresu =  .Presupuestadooriginal			lxCombSolcompra =  .Solcompra			lxCombPrecompra =  .Precompra			lxCombCorigsolco =  .Solcompraoriginal			lxCombCorigsenia =  .Seniadooriginal			lxCombReqcompra =  .Reqcompra			lxCombSeniado =  .Seniado			lxCombCorigreqco =  .Reqcompraoriginal			lxCombCorigpedid =  .Pedidooriginal			lxCombCocant =  .Cantidad			lxCombCorigpedco =  .Pedcompraoriginal			lxCombPedcompra =  .Pedcompra			lxCombPedido =  .Pedido			lxCombMinrepo =  .Minreposicion			lxCombCorig =  .Cantidadoriginal			lxCombMaxrepo =  .Maxreposicion			lxCombEntregapen =  .Entregapen			lxCombCorigentre =  .Entregapenoriginal
		endwith
		
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  0 != .oEntidad.PRESUPUESTADO or  .oEntidad.oAtributosAuditoria.PREPARADOOriginal != .oEntidad.PREPARADOOriginal or  .oEntidad.oAtributosAuditoria.PRECOMPRAOriginal != .oEntidad.PRECOMPRAOriginal or  0 != .oEntidad.PREPARADO or  .oEntidad.oAtributosAuditoria.PRESUPUESTADOOriginal != .oEntidad.PRESUPUESTADOOriginal or  0 != .oEntidad.SOLCOMPRA or  0 != .oEntidad.PRECOMPRA or  .oEntidad.oAtributosAuditoria.SOLCOMPRAOriginal != .oEntidad.SOLCOMPRAOriginal or  .oEntidad.oAtributosAuditoria.SENIADOOriginal != .oEntidad.SENIADOOriginal or  0 != .oEntidad.REQCOMPRA or  0 != .oEntidad.SENIADO or  .oEntidad.oAtributosAuditoria.REQCOMPRAOriginal != .oEntidad.REQCOMPRAOriginal or  .oEntidad.oAtributosAuditoria.PEDIDOOriginal != .oEntidad.PEDIDOOriginal or  0 != .oEntidad.Cantidad or  .oEntidad.oAtributosAuditoria.PEDCOMPRAOriginal != .oEntidad.PEDCOMPRAOriginal or  0 != .oEntidad.PEDCOMPRA or  0 != .oEntidad.PEDIDO or  .oEntidad.oAtributosAuditoria.CantidadOriginal != .oEntidad.CantidadOriginal or  0 != .oEntidad.EntregaPen or  .oEntidad.oAtributosAuditoria.EntregaPenOriginal != .oEntidad.EntregaPenOriginal )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.COMB set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCombFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCombFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCombFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCombFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCombFmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCombSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCombSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCombUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCombHmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCombZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCombValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCombVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCombUaltafw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxCombDescfw ) + "'">>,"Cotll" = <<"'" + this.FormatearTextoSql( lxCombCotll ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCombHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCombBdaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCombHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCombBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCombEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCombHaltafw ) + "'">>,"Coart" = <<"'" + this.FormatearTextoSql( lxCombCoart ) + "'">>,"Cocod" = <<"'" + this.FormatearTextoSql( lxCombCocod ) + "'">>,"Cocol" = <<"'" + this.FormatearTextoSql( lxCombCocol ) + "'">>,"Presupuest" = "Presupuest" + <<lxCombPresupuest>>,"Corigprepa" = <<lxCombCorigprepa>>,"Corigpreco" = <<lxCombCorigpreco>>,"Preparado" = "Preparado" + <<lxCombPreparado>>,"Corigpresu" = <<lxCombCorigpresu>>,"Solcompra" = "Solcompra" + <<lxCombSolcompra>>,"Precompra" = "Precompra" + <<lxCombPrecompra>>,"Corigsolco" = <<lxCombCorigsolco>>,"Corigsenia" = <<lxCombCorigsenia>>,"Reqcompra" = "Reqcompra" + <<lxCombReqcompra>>,"Seniado" = "Seniado" + <<lxCombSeniado>>,"Corigreqco" = <<lxCombCorigreqco>>,"Corigpedid" = <<lxCombCorigpedid>>,"Cocant" = "Cocant" + <<lxCombCocant>>,"Corigpedco" = <<lxCombCorigpedco>>,"Pedcompra" = "Pedcompra" + <<lxCombPedcompra>>,"Pedido" = "Pedido" + <<lxCombPedido>>,"Minrepo" = <<lxCombMinrepo>>,"Corig" = <<lxCombCorig>>,"Maxrepo" = <<lxCombMaxrepo>>,"Entregapen" = "Entregapen" + <<lxCombEntregapen>>,"Corigentre" = <<lxCombCorigentre>> where "Cocod" = <<"'" + this.FormatearTextoSql( lxCombCocod ) + "'">> and  COMB.COCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 COCOD from ZooLogic.COMB where " + this.ConvertirFuncionesSql( " COMB.COCOD != ''" ) )
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
			Local lxCombCocod
			lxCombCocod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descfw" as "Descripcionfw", "Cotll" as "Talle", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Coart" as "Articulo", "Cocod" as "Codigo", "Cocol" as "Color", "Presupuest" as "Presupuestado", "Corigprepa" as "Preparadooriginal", "Corigpreco" as "Precompraoriginal", "Preparado" as "Preparado", "Corigpresu" as "Presupuestadooriginal", "Solcompra" as "Solcompra", "Precompra" as "Precompra", "Corigsolco" as "Solcompraoriginal", "Corigsenia" as "Seniadooriginal", "Reqcompra" as "Reqcompra", "Seniado" as "Seniado", "Corigreqco" as "Reqcompraoriginal", "Corigpedid" as "Pedidooriginal", "Cocant" as "Cantidad", "Corigpedco" as "Pedcompraoriginal", "Pedcompra" as "Pedcompra", "Pedido" as "Pedido", "Minrepo" as "Minreposicion", "Corig" as "Cantidadoriginal", "Maxrepo" as "Maxreposicion", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal" from ZooLogic.COMB where "Cocod" = <<"'" + this.FormatearTextoSql( lxCombCocod ) + "'">> and  COMB.COCOD != ''
			endtext
			use in select('c_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKCOMBINACION', set( 'Datasession' ) )

			if reccount( 'c_STOCKCOMBINACION' ) = 0
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
			Local lxCOMBCOART As Variant, lxCOMBCOCOL As Variant, lxCOMBCOTLL As Variant
			lxCOMBCOART = .Articulo_Pk
			lxCOMBCOCOL = .Color_Pk
			lxCOMBCOTLL = .Talle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descfw" as "Descripcionfw", "Cotll" as "Talle", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Coart" as "Articulo", "Cocod" as "Codigo", "Cocol" as "Color", "Presupuest" as "Presupuestado", "Corigprepa" as "Preparadooriginal", "Corigpreco" as "Precompraoriginal", "Preparado" as "Preparado", "Corigpresu" as "Presupuestadooriginal", "Solcompra" as "Solcompra", "Precompra" as "Precompra", "Corigsolco" as "Solcompraoriginal", "Corigsenia" as "Seniadooriginal", "Reqcompra" as "Reqcompra", "Seniado" as "Seniado", "Corigreqco" as "Reqcompraoriginal", "Corigpedid" as "Pedidooriginal", "Cocant" as "Cantidad", "Corigpedco" as "Pedcompraoriginal", "Pedcompra" as "Pedcompra", "Pedido" as "Pedido", "Minrepo" as "Minreposicion", "Corig" as "Cantidadoriginal", "Maxrepo" as "Maxreposicion", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal" from ZooLogic.COMB where  COMB.COCOD != '' And COART = <<"'" + this.FormatearTextoSql( lxCOMBCOART ) + "'">> and COCOL = <<"'" + this.FormatearTextoSql( lxCOMBCOCOL ) + "'">> and COTLL = <<"'" + this.FormatearTextoSql( lxCOMBCOTLL ) + "'">>
			endtext
			use in select('c_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKCOMBINACION', set( 'Datasession' ) )
			if reccount( 'c_STOCKCOMBINACION' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCombCocod as Variant
		llRetorno = .t.
		lxCombCocod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMB where "Cocod" = <<"'" + this.FormatearTextoSql( lxCombCocod ) + "'">> and  COMB.COCOD != ''
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
				lcOrden =  .Articulo_PK + .Color_PK + .Talle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descfw" as "Descripcionfw", "Cotll" as "Talle", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Coart" as "Articulo", "Cocod" as "Codigo", "Cocol" as "Color", "Presupuest" as "Presupuestado", "Corigprepa" as "Preparadooriginal", "Corigpreco" as "Precompraoriginal", "Preparado" as "Preparado", "Corigpresu" as "Presupuestadooriginal", "Solcompra" as "Solcompra", "Precompra" as "Precompra", "Corigsolco" as "Solcompraoriginal", "Corigsenia" as "Seniadooriginal", "Reqcompra" as "Reqcompra", "Seniado" as "Seniado", "Corigreqco" as "Reqcompraoriginal", "Corigpedid" as "Pedidooriginal", "Cocant" as "Cantidad", "Corigpedco" as "Pedcompraoriginal", "Pedcompra" as "Pedcompra", "Pedido" as "Pedido", "Minrepo" as "Minreposicion", "Corig" as "Cantidadoriginal", "Maxrepo" as "Maxreposicion", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal" from ZooLogic.COMB where  COMB.COCOD != '' order by COART,COCOL,COTLL
			endtext
			use in select('c_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKCOMBINACION', set( 'Datasession' ) )
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
				lcOrden =  .Articulo_PK + .Color_PK + .Talle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descfw" as "Descripcionfw", "Cotll" as "Talle", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Coart" as "Articulo", "Cocod" as "Codigo", "Cocol" as "Color", "Presupuest" as "Presupuestado", "Corigprepa" as "Preparadooriginal", "Corigpreco" as "Precompraoriginal", "Preparado" as "Preparado", "Corigpresu" as "Presupuestadooriginal", "Solcompra" as "Solcompra", "Precompra" as "Precompra", "Corigsolco" as "Solcompraoriginal", "Corigsenia" as "Seniadooriginal", "Reqcompra" as "Reqcompra", "Seniado" as "Seniado", "Corigreqco" as "Reqcompraoriginal", "Corigpedid" as "Pedidooriginal", "Cocant" as "Cantidad", "Corigpedco" as "Pedcompraoriginal", "Pedcompra" as "Pedcompra", "Pedido" as "Pedido", "Minrepo" as "Minreposicion", "Corig" as "Cantidadoriginal", "Maxrepo" as "Maxreposicion", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal" from ZooLogic.COMB where  funciones.padr( COART, 13, ' ' ) + funciones.padr( COCOL, 2, ' ' ) + funciones.padr( COTLL, 3, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMB.COCOD != '' order by COART,COCOL,COTLL
			endtext
			use in select('c_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKCOMBINACION', set( 'Datasession' ) )
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
				lcOrden =  .Articulo_PK + .Color_PK + .Talle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descfw" as "Descripcionfw", "Cotll" as "Talle", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Coart" as "Articulo", "Cocod" as "Codigo", "Cocol" as "Color", "Presupuest" as "Presupuestado", "Corigprepa" as "Preparadooriginal", "Corigpreco" as "Precompraoriginal", "Preparado" as "Preparado", "Corigpresu" as "Presupuestadooriginal", "Solcompra" as "Solcompra", "Precompra" as "Precompra", "Corigsolco" as "Solcompraoriginal", "Corigsenia" as "Seniadooriginal", "Reqcompra" as "Reqcompra", "Seniado" as "Seniado", "Corigreqco" as "Reqcompraoriginal", "Corigpedid" as "Pedidooriginal", "Cocant" as "Cantidad", "Corigpedco" as "Pedcompraoriginal", "Pedcompra" as "Pedcompra", "Pedido" as "Pedido", "Minrepo" as "Minreposicion", "Corig" as "Cantidadoriginal", "Maxrepo" as "Maxreposicion", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal" from ZooLogic.COMB where  funciones.padr( COART, 13, ' ' ) + funciones.padr( COCOL, 2, ' ' ) + funciones.padr( COTLL, 3, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMB.COCOD != '' order by COART desc,COCOL desc,COTLL desc
			endtext
			use in select('c_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKCOMBINACION', set( 'Datasession' ) )
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
				lcOrden =  .Articulo_PK + .Color_PK + .Talle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descfw" as "Descripcionfw", "Cotll" as "Talle", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Coart" as "Articulo", "Cocod" as "Codigo", "Cocol" as "Color", "Presupuest" as "Presupuestado", "Corigprepa" as "Preparadooriginal", "Corigpreco" as "Precompraoriginal", "Preparado" as "Preparado", "Corigpresu" as "Presupuestadooriginal", "Solcompra" as "Solcompra", "Precompra" as "Precompra", "Corigsolco" as "Solcompraoriginal", "Corigsenia" as "Seniadooriginal", "Reqcompra" as "Reqcompra", "Seniado" as "Seniado", "Corigreqco" as "Reqcompraoriginal", "Corigpedid" as "Pedidooriginal", "Cocant" as "Cantidad", "Corigpedco" as "Pedcompraoriginal", "Pedcompra" as "Pedcompra", "Pedido" as "Pedido", "Minrepo" as "Minreposicion", "Corig" as "Cantidadoriginal", "Maxrepo" as "Maxreposicion", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal" from ZooLogic.COMB where  COMB.COCOD != '' order by COART desc,COCOL desc,COTLL desc
			endtext
			use in select('c_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_STOCKCOMBINACION', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Faltafw,Fecexpo,Fectrans,Fmodifw,Saltafw,Smodifw,Umodifw,Hmodifw,Zadsfw,Valtafw,Vmod" + ;
"ifw,Ualtafw,Descfw,Cotll,Horaimpo,Bdaltafw,Horaexpo,Bdmodifw,Esttrans,Haltafw,Coart,Cocod,Cocol,Pres" + ;
"upuest,Corigprepa,Corigpreco,Preparado,Corigpresu,Solcompra,Precompra,Corigsolco,Corigsenia,Reqcompr" + ;
"a,Seniado,Corigreqco,Corigpedid,Cocant,Corigpedco,Pedcompra,Pedido,Minrepo,Corig,Maxrepo,Entregapen," + ;
"Corigentre" + ;
" from ZooLogic.COMB where  COMB.COCOD != '' and " + lcFiltro )
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
			local  lxCombFecimpo, lxCombFaltafw, lxCombFecexpo, lxCombFectrans, lxCombFmodifw, lxCombSaltafw, lxCombSmodifw, lxCombUmodifw, lxCombHmodifw, lxCombZadsfw, lxCombValtafw, lxCombVmodifw, lxCombUaltafw, lxCombDescfw, lxCombCotll, lxCombHoraimpo, lxCombBdaltafw, lxCombHoraexpo, lxCombBdmodifw, lxCombEsttrans, lxCombHaltafw, lxCombCoart, lxCombCocod, lxCombCocol, lxCombPresupuest, lxCombCorigprepa, lxCombCorigpreco, lxCombPreparado, lxCombCorigpresu, lxCombSolcompra, lxCombPrecompra, lxCombCorigsolco, lxCombCorigsenia, lxCombReqcompra, lxCombSeniado, lxCombCorigreqco, lxCombCorigpedid, lxCombCocant, lxCombCorigpedco, lxCombPedcompra, lxCombPedido, lxCombMinrepo, lxCombCorig, lxCombMaxrepo, lxCombEntregapen, lxCombCorigentre
				lxCombFecimpo = ctod( '  /  /    ' )			lxCombFaltafw = ctod( '  /  /    ' )			lxCombFecexpo = ctod( '  /  /    ' )			lxCombFectrans = ctod( '  /  /    ' )			lxCombFmodifw = ctod( '  /  /    ' )			lxCombSaltafw = []			lxCombSmodifw = []			lxCombUmodifw = []			lxCombHmodifw = []			lxCombZadsfw = []			lxCombValtafw = []			lxCombVmodifw = []			lxCombUaltafw = []			lxCombDescfw = []			lxCombCotll = []			lxCombHoraimpo = []			lxCombBdaltafw = []			lxCombHoraexpo = []			lxCombBdmodifw = []			lxCombEsttrans = []			lxCombHaltafw = []			lxCombCoart = []			lxCombCocod = []			lxCombCocol = []			lxCombPresupuest = 0			lxCombCorigprepa = 0			lxCombCorigpreco = 0			lxCombPreparado = 0			lxCombCorigpresu = 0			lxCombSolcompra = 0			lxCombPrecompra = 0			lxCombCorigsolco = 0			lxCombCorigsenia = 0			lxCombReqcompra = 0			lxCombSeniado = 0			lxCombCorigreqco = 0			lxCombCorigpedid = 0			lxCombCocant = 0			lxCombCorigpedco = 0			lxCombPedcompra = 0			lxCombPedido = 0			lxCombMinrepo = 0			lxCombCorig = 0			lxCombMaxrepo = 0			lxCombEntregapen = 0			lxCombCorigentre = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMB where "COCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMB' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where COCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(COCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMB.COCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descfw" as "Descripcionfw", "Cotll" as "Talle", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Coart" as "Articulo", "Cocod" as "Codigo", "Cocol" as "Color", "Presupuest" as "Presupuestado", "Corigprepa" as "Preparadooriginal", "Corigpreco" as "Precompraoriginal", "Preparado" as "Preparado", "Corigpresu" as "Presupuestadooriginal", "Solcompra" as "Solcompra", "Precompra" as "Precompra", "Corigsolco" as "Solcompraoriginal", "Corigsenia" as "Seniadooriginal", "Reqcompra" as "Reqcompra", "Seniado" as "Seniado", "Corigreqco" as "Reqcompraoriginal", "Corigpedid" as "Pedidooriginal", "Cocant" as "Cantidad", "Corigpedco" as "Pedcompraoriginal", "Pedcompra" as "Pedcompra", "Pedido" as "Pedido", "Minrepo" as "Minreposicion", "Corig" as "Cantidadoriginal", "Maxrepo" as "Maxreposicion", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMB', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTLL AS TALLE'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COART AS ARTICULO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOD AS CODIGO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOL AS COLOR'
				Case lcAtributo == 'PRESUPUESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRESUPUEST AS PRESUPUESTADO'
				Case lcAtributo == 'PREPARADOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPREPA AS PREPARADOORIGINAL'
				Case lcAtributo == 'PRECOMPRAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPRECO AS PRECOMPRAORIGINAL'
				Case lcAtributo == 'PREPARADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PREPARADO AS PREPARADO'
				Case lcAtributo == 'PRESUPUESTADOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPRESU AS PRESUPUESTADOORIGINAL'
				Case lcAtributo == 'SOLCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SOLCOMPRA AS SOLCOMPRA'
				Case lcAtributo == 'PRECOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECOMPRA AS PRECOMPRA'
				Case lcAtributo == 'SOLCOMPRAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGSOLCO AS SOLCOMPRAORIGINAL'
				Case lcAtributo == 'SENIADOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGSENIA AS SENIADOORIGINAL'
				Case lcAtributo == 'REQCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REQCOMPRA AS REQCOMPRA'
				Case lcAtributo == 'SENIADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIADO AS SENIADO'
				Case lcAtributo == 'REQCOMPRAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGREQCO AS REQCOMPRAORIGINAL'
				Case lcAtributo == 'PEDIDOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPEDID AS PEDIDOORIGINAL'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCANT AS CANTIDAD'
				Case lcAtributo == 'PEDCOMPRAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPEDCO AS PEDCOMPRAORIGINAL'
				Case lcAtributo == 'PEDCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEDCOMPRA AS PEDCOMPRA'
				Case lcAtributo == 'PEDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEDIDO AS PEDIDO'
				Case lcAtributo == 'MINREPOSICION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINREPO AS MINREPOSICION'
				Case lcAtributo == 'CANTIDADORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIG AS CANTIDADORIGINAL'
				Case lcAtributo == 'MAXREPOSICION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAXREPO AS MAXREPOSICION'
				Case lcAtributo == 'ENTREGAPEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTREGAPEN AS ENTREGAPEN'
				Case lcAtributo == 'ENTREGAPENORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGENTRE AS ENTREGAPENORIGINAL'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'COTLL'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'COART'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COCOD'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'COCOL'
			Case upper( alltrim( tcAtributo ) ) == 'PRESUPUESTADO'
				lcCampo = 'PRESUPUEST'
			Case upper( alltrim( tcAtributo ) ) == 'PREPARADOORIGINAL'
				lcCampo = 'CORIGPREPA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECOMPRAORIGINAL'
				lcCampo = 'CORIGPRECO'
			Case upper( alltrim( tcAtributo ) ) == 'PREPARADO'
				lcCampo = 'PREPARADO'
			Case upper( alltrim( tcAtributo ) ) == 'PRESUPUESTADOORIGINAL'
				lcCampo = 'CORIGPRESU'
			Case upper( alltrim( tcAtributo ) ) == 'SOLCOMPRA'
				lcCampo = 'SOLCOMPRA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECOMPRA'
				lcCampo = 'PRECOMPRA'
			Case upper( alltrim( tcAtributo ) ) == 'SOLCOMPRAORIGINAL'
				lcCampo = 'CORIGSOLCO'
			Case upper( alltrim( tcAtributo ) ) == 'SENIADOORIGINAL'
				lcCampo = 'CORIGSENIA'
			Case upper( alltrim( tcAtributo ) ) == 'REQCOMPRA'
				lcCampo = 'REQCOMPRA'
			Case upper( alltrim( tcAtributo ) ) == 'SENIADO'
				lcCampo = 'SENIADO'
			Case upper( alltrim( tcAtributo ) ) == 'REQCOMPRAORIGINAL'
				lcCampo = 'CORIGREQCO'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDOORIGINAL'
				lcCampo = 'CORIGPEDID'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'COCANT'
			Case upper( alltrim( tcAtributo ) ) == 'PEDCOMPRAORIGINAL'
				lcCampo = 'CORIGPEDCO'
			Case upper( alltrim( tcAtributo ) ) == 'PEDCOMPRA'
				lcCampo = 'PEDCOMPRA'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDO'
				lcCampo = 'PEDIDO'
			Case upper( alltrim( tcAtributo ) ) == 'MINREPOSICION'
				lcCampo = 'MINREPO'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADORIGINAL'
				lcCampo = 'CORIG'
			Case upper( alltrim( tcAtributo ) ) == 'MAXREPOSICION'
				lcCampo = 'MAXREPO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPEN'
				lcCampo = 'ENTREGAPEN'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPENORIGINAL'
				lcCampo = 'CORIGENTRE'
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
			local  lxCombFecimpo, lxCombFaltafw, lxCombFecexpo, lxCombFectrans, lxCombFmodifw, lxCombSaltafw, lxCombSmodifw, lxCombUmodifw, lxCombHmodifw, lxCombZadsfw, lxCombValtafw, lxCombVmodifw, lxCombUaltafw, lxCombDescfw, lxCombCotll, lxCombHoraimpo, lxCombBdaltafw, lxCombHoraexpo, lxCombBdmodifw, lxCombEsttrans, lxCombHaltafw, lxCombCoart, lxCombCocod, lxCombCocol, lxCombPresupuest, lxCombCorigprepa, lxCombCorigpreco, lxCombPreparado, lxCombCorigpresu, lxCombSolcompra, lxCombPrecompra, lxCombCorigsolco, lxCombCorigsenia, lxCombReqcompra, lxCombSeniado, lxCombCorigreqco, lxCombCorigpedid, lxCombCocant, lxCombCorigpedco, lxCombPedcompra, lxCombPedido, lxCombMinrepo, lxCombCorig, lxCombMaxrepo, lxCombEntregapen, lxCombCorigentre
				lxCombFecimpo =  .Fechaimpo			lxCombFaltafw =  .Fechaaltafw			lxCombFecexpo =  .Fechaexpo			lxCombFectrans =  .Fechatransferencia			lxCombFmodifw =  .Fechamodificacionfw			lxCombSaltafw =  .Seriealtafw			lxCombSmodifw =  .Seriemodificacionfw			lxCombUmodifw =  .Usuariomodificacionfw			lxCombHmodifw =  .Horamodificacionfw			lxCombZadsfw =  .Zadsfw			lxCombValtafw =  .Versionaltafw			lxCombVmodifw =  .Versionmodificacionfw			lxCombUaltafw =  .Usuarioaltafw			lxCombDescfw =  .Descripcionfw			lxCombCotll =  .Talle			lxCombHoraimpo =  .Horaimpo			lxCombBdaltafw =  .Basededatosaltafw			lxCombHoraexpo =  .Horaexpo			lxCombBdmodifw =  .Basededatosmodificacionfw			lxCombEsttrans =  .Estadotransferencia			lxCombHaltafw =  .Horaaltafw			lxCombCoart =  upper( .Articulo_PK ) 			lxCombCocod =  .Codigo			lxCombCocol =  upper( .Color_PK ) 			lxCombPresupuest =  .Presupuestado			lxCombCorigprepa =  .Preparadooriginal			lxCombCorigpreco =  .Precompraoriginal			lxCombPreparado =  .Preparado			lxCombCorigpresu =  .Presupuestadooriginal			lxCombSolcompra =  .Solcompra			lxCombPrecompra =  .Precompra			lxCombCorigsolco =  .Solcompraoriginal			lxCombCorigsenia =  .Seniadooriginal			lxCombReqcompra =  .Reqcompra			lxCombSeniado =  .Seniado			lxCombCorigreqco =  .Reqcompraoriginal			lxCombCorigpedid =  .Pedidooriginal			lxCombCocant =  .Cantidad			lxCombCorigpedco =  .Pedcompraoriginal			lxCombPedcompra =  .Pedcompra			lxCombPedido =  .Pedido			lxCombMinrepo =  .Minreposicion			lxCombCorig =  .Cantidadoriginal			lxCombMaxrepo =  .Maxreposicion			lxCombEntregapen =  .Entregapen			lxCombCorigentre =  .Entregapenoriginal
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMB ( "Fecimpo","Faltafw","Fecexpo","Fectrans","Fmodifw","Saltafw","Smodifw","Umodifw","Hmodifw","Zadsfw","Valtafw","Vmodifw","Ualtafw","Descfw","Cotll","Horaimpo","Bdaltafw","Horaexpo","Bdmodifw","Esttrans","Haltafw","Coart","Cocod","Cocol","Presupuest","Corigprepa","Corigpreco","Preparado","Corigpresu","Solcompra","Precompra","Corigsolco","Corigsenia","Reqcompra","Seniado","Corigreqco","Corigpedid","Cocant","Corigpedco","Pedcompra","Pedido","Minrepo","Corig","Maxrepo","Entregapen","Corigentre" ) values ( <<"'" + this.ConvertirDateSql( lxCombFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCombFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCombFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCombFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCombFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombCotll ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombCoart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCombCocol ) + "'" >>, <<lxCombPresupuest >>, <<lxCombCorigprepa >>, <<lxCombCorigpreco >>, <<lxCombPreparado >>, <<lxCombCorigpresu >>, <<lxCombSolcompra >>, <<lxCombPrecompra >>, <<lxCombCorigsolco >>, <<lxCombCorigsenia >>, <<lxCombReqcompra >>, <<lxCombSeniado >>, <<lxCombCorigreqco >>, <<lxCombCorigpedid >>, <<lxCombCocant >>, <<lxCombCorigpedco >>, <<lxCombPedcompra >>, <<lxCombPedido >>, <<lxCombMinrepo >>, <<lxCombCorig >>, <<lxCombMaxrepo >>, <<lxCombEntregapen >>, <<lxCombCorigentre >> )
		endtext
		loColeccion.cTabla = 'COMB' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCombFecimpo, lxCombFaltafw, lxCombFecexpo, lxCombFectrans, lxCombFmodifw, lxCombSaltafw, lxCombSmodifw, lxCombUmodifw, lxCombHmodifw, lxCombZadsfw, lxCombValtafw, lxCombVmodifw, lxCombUaltafw, lxCombDescfw, lxCombCotll, lxCombHoraimpo, lxCombBdaltafw, lxCombHoraexpo, lxCombBdmodifw, lxCombEsttrans, lxCombHaltafw, lxCombCoart, lxCombCocod, lxCombCocol, lxCombPresupuest, lxCombCorigprepa, lxCombCorigpreco, lxCombPreparado, lxCombCorigpresu, lxCombSolcompra, lxCombPrecompra, lxCombCorigsolco, lxCombCorigsenia, lxCombReqcompra, lxCombSeniado, lxCombCorigreqco, lxCombCorigpedid, lxCombCocant, lxCombCorigpedco, lxCombPedcompra, lxCombPedido, lxCombMinrepo, lxCombCorig, lxCombMaxrepo, lxCombEntregapen, lxCombCorigentre
				lxCombFecimpo =  .Fechaimpo			lxCombFaltafw =  .Fechaaltafw			lxCombFecexpo =  .Fechaexpo			lxCombFectrans =  .Fechatransferencia			lxCombFmodifw =  .Fechamodificacionfw			lxCombSaltafw =  .Seriealtafw			lxCombSmodifw =  .Seriemodificacionfw			lxCombUmodifw =  .Usuariomodificacionfw			lxCombHmodifw =  .Horamodificacionfw			lxCombZadsfw =  .Zadsfw			lxCombValtafw =  .Versionaltafw			lxCombVmodifw =  .Versionmodificacionfw			lxCombUaltafw =  .Usuarioaltafw			lxCombDescfw =  .Descripcionfw			lxCombCotll =  .Talle			lxCombHoraimpo =  .Horaimpo			lxCombBdaltafw =  .Basededatosaltafw			lxCombHoraexpo =  .Horaexpo			lxCombBdmodifw =  .Basededatosmodificacionfw			lxCombEsttrans =  .Estadotransferencia			lxCombHaltafw =  .Horaaltafw			lxCombCoart =  upper( .Articulo_PK ) 			lxCombCocod =  .Codigo			lxCombCocol =  upper( .Color_PK ) 			lxCombPresupuest =  .Presupuestado			lxCombCorigprepa =  .Preparadooriginal			lxCombCorigpreco =  .Precompraoriginal			lxCombPreparado =  .Preparado			lxCombCorigpresu =  .Presupuestadooriginal			lxCombSolcompra =  .Solcompra			lxCombPrecompra =  .Precompra			lxCombCorigsolco =  .Solcompraoriginal			lxCombCorigsenia =  .Seniadooriginal			lxCombReqcompra =  .Reqcompra			lxCombSeniado =  .Seniado			lxCombCorigreqco =  .Reqcompraoriginal			lxCombCorigpedid =  .Pedidooriginal			lxCombCocant =  .Cantidad			lxCombCorigpedco =  .Pedcompraoriginal			lxCombPedcompra =  .Pedcompra			lxCombPedido =  .Pedido			lxCombMinrepo =  .Minreposicion			lxCombCorig =  .Cantidadoriginal			lxCombMaxrepo =  .Maxreposicion			lxCombEntregapen =  .Entregapen			lxCombCorigentre =  .Entregapenoriginal
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  0 != .oEntidad.PRESUPUESTADO or  .oEntidad.oAtributosAuditoria.PREPARADOOriginal != .oEntidad.PREPARADOOriginal or  .oEntidad.oAtributosAuditoria.PRECOMPRAOriginal != .oEntidad.PRECOMPRAOriginal or  0 != .oEntidad.PREPARADO or  .oEntidad.oAtributosAuditoria.PRESUPUESTADOOriginal != .oEntidad.PRESUPUESTADOOriginal or  0 != .oEntidad.SOLCOMPRA or  0 != .oEntidad.PRECOMPRA or  .oEntidad.oAtributosAuditoria.SOLCOMPRAOriginal != .oEntidad.SOLCOMPRAOriginal or  .oEntidad.oAtributosAuditoria.SENIADOOriginal != .oEntidad.SENIADOOriginal or  0 != .oEntidad.REQCOMPRA or  0 != .oEntidad.SENIADO or  .oEntidad.oAtributosAuditoria.REQCOMPRAOriginal != .oEntidad.REQCOMPRAOriginal or  .oEntidad.oAtributosAuditoria.PEDIDOOriginal != .oEntidad.PEDIDOOriginal or  0 != .oEntidad.Cantidad or  .oEntidad.oAtributosAuditoria.PEDCOMPRAOriginal != .oEntidad.PEDCOMPRAOriginal or  0 != .oEntidad.PEDCOMPRA or  0 != .oEntidad.PEDIDO or  .oEntidad.oAtributosAuditoria.CantidadOriginal != .oEntidad.CantidadOriginal or  0 != .oEntidad.EntregaPen or  .oEntidad.oAtributosAuditoria.EntregaPenOriginal != .oEntidad.EntregaPenOriginal )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Cocod" = ] + lcValorClavePrimariaString  + [ and  COMB.COCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COMB set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCombFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCombFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCombFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCombFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCombFmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCombSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCombSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCombUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCombHmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCombZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCombValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCombVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCombUaltafw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxCombDescfw ) + "'">>, "Cotll" = <<"'" + this.FormatearTextoSql( lxCombCotll ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCombHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCombBdaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCombHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCombBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCombEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCombHaltafw ) + "'">>, "Coart" = <<"'" + this.FormatearTextoSql( lxCombCoart ) + "'">>, "Cocod" = <<"'" + this.FormatearTextoSql( lxCombCocod ) + "'">>, "Cocol" = <<"'" + this.FormatearTextoSql( lxCombCocol ) + "'">>, "Presupuest" = Presupuest + ( <<lxCombPresupuest>> ), "Corigprepa" = <<lxCombCorigprepa>>, "Corigpreco" = <<lxCombCorigpreco>>, "Preparado" = Preparado + ( <<lxCombPreparado>> ), "Corigpresu" = <<lxCombCorigpresu>>, "Solcompra" = Solcompra + ( <<lxCombSolcompra>> ), "Precompra" = Precompra + ( <<lxCombPrecompra>> ), "Corigsolco" = <<lxCombCorigsolco>>, "Corigsenia" = <<lxCombCorigsenia>>, "Reqcompra" = Reqcompra + ( <<lxCombReqcompra>> ), "Seniado" = Seniado + ( <<lxCombSeniado>> ), "Corigreqco" = <<lxCombCorigreqco>>, "Corigpedid" = <<lxCombCorigpedid>>, "Cocant" = Cocant + ( <<lxCombCocant>> ), "Corigpedco" = <<lxCombCorigpedco>>, "Pedcompra" = Pedcompra + ( <<lxCombPedcompra>> ), "Pedido" = Pedido + ( <<lxCombPedido>> ), "Minrepo" = <<lxCombMinrepo>>, "Corig" = <<lxCombCorig>>, "Maxrepo" = <<lxCombMaxrepo>>, "Entregapen" = Entregapen + ( <<lxCombEntregapen>> ), "Corigentre" = <<lxCombCorigentre>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMB' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
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

			lcFiltro = ["Cocod" = ] + lcValorClavePrimariaString  + [ and  COMB.COCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.COMB where ' + lcFiltro )
			loColeccion.cTabla = 'COMB' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMB where  COMB.COCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMB where COCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMB.COCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCOMBCOTLL as variant, lxCOMBCOART as variant, lxCOMBCOCOL as variant, lxCOMBPRESUPUEST as variant, lxCOMBcOrigPREPA as variant, lxCOMBcOrigPRECO as variant, lxCOMBPREPARADO as variant, lxCOMBcOrigPRESU as variant, lxCOMBSOLCOMPRA as variant, lxCOMBPRECOMPRA as variant, lxCOMBcOrigSOLCO as variant, lxCOMBcOrigSENIA as variant, lxCOMBREQCOMPRA as variant, lxCOMBSENIADO as variant, lxCOMBcOrigREQCO as variant, lxCOMBcOrigPEDID as variant, lxCOMBCOCANT as variant, lxCOMBcOrigPEDCO as variant, lxCOMBPEDCOMPRA as variant, lxCOMBPEDIDO as variant, lxCOMBCORIG as variant, lxCOMBEntregaPen as variant, lxCOMBcOrigEntre as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKCOMBINACION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMB Where  COART = ] + "'" + this.FormatearTextoSql( &lcCursor..COART      ) + "'" + [ and COCOL = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOL      ) + "'" + [ and COTLL = ] + "'" + this.FormatearTextoSql( &lcCursor..COTLL      ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..COCOD
				if lxValorClavePK == curSeek.COCOD or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.COCOD and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.COCOD
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						local llInsertarAuditoria as boolean
						llInsertarAuditoria = (  iif( isnull( 0 != &lcCursor..PRESUPUEST ), .F., 0 != &lcCursor..PRESUPUEST ) or  iif( isnull( curSeek.cOrigPREPA != &lcCursor..cOrigPREPA ), .F., curSeek.cOrigPREPA != &lcCursor..cOrigPREPA ) or  iif( isnull( curSeek.cOrigPRECO != &lcCursor..cOrigPRECO ), .F., curSeek.cOrigPRECO != &lcCursor..cOrigPRECO ) or  iif( isnull( 0 != &lcCursor..PREPARADO ), .F., 0 != &lcCursor..PREPARADO ) or  iif( isnull( curSeek.cOrigPRESU != &lcCursor..cOrigPRESU ), .F., curSeek.cOrigPRESU != &lcCursor..cOrigPRESU ) or  iif( isnull( 0 != &lcCursor..SOLCOMPRA ), .F., 0 != &lcCursor..SOLCOMPRA ) or  iif( isnull( 0 != &lcCursor..PRECOMPRA ), .F., 0 != &lcCursor..PRECOMPRA ) or  iif( isnull( curSeek.cOrigSOLCO != &lcCursor..cOrigSOLCO ), .F., curSeek.cOrigSOLCO != &lcCursor..cOrigSOLCO ) or  iif( isnull( curSeek.cOrigSENIA != &lcCursor..cOrigSENIA ), .F., curSeek.cOrigSENIA != &lcCursor..cOrigSENIA ) or  iif( isnull( 0 != &lcCursor..REQCOMPRA ), .F., 0 != &lcCursor..REQCOMPRA ) or  iif( isnull( 0 != &lcCursor..SENIADO ), .F., 0 != &lcCursor..SENIADO ) or  iif( isnull( curSeek.cOrigREQCO != &lcCursor..cOrigREQCO ), .F., curSeek.cOrigREQCO != &lcCursor..cOrigREQCO ) or  iif( isnull( curSeek.cOrigPEDID != &lcCursor..cOrigPEDID ), .F., curSeek.cOrigPEDID != &lcCursor..cOrigPEDID ) or  iif( isnull( 0 != &lcCursor..COCANT ), .F., 0 != &lcCursor..COCANT ) or  iif( isnull( curSeek.cOrigPEDCO != &lcCursor..cOrigPEDCO ), .F., curSeek.cOrigPEDCO != &lcCursor..cOrigPEDCO ) or  iif( isnull( 0 != &lcCursor..PEDCOMPRA ), .F., 0 != &lcCursor..PEDCOMPRA ) or  iif( isnull( 0 != &lcCursor..PEDIDO ), .F., 0 != &lcCursor..PEDIDO ) or  iif( isnull( curSeek.CORIG != &lcCursor..CORIG ), .F., curSeek.CORIG != &lcCursor..CORIG ) or  iif( isnull( 0 != &lcCursor..EntregaPen ), .F., 0 != &lcCursor..EntregaPen ) or  iif( isnull( curSeek.cOrigEntre != &lcCursor..cOrigEntre ), .F., curSeek.cOrigEntre != &lcCursor..cOrigEntre ) )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMB set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, COTLL = ] + "'" + this.FormatearTextoSql( &lcCursor..COTLL ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, COART = ] + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'"+ [, COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'"+ [, COCOL = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'"+ [, PRESUPUEST = ZooLogic.COMB.PRESUPUEST + ] + transform( &lcCursor..PRESUPUEST )+ [, cOrigPREPA = ] + transform( &lcCursor..cOrigPREPA )+ [, cOrigPRECO = ] + transform( &lcCursor..cOrigPRECO )+ [, PREPARADO = ZooLogic.COMB.PREPARADO + ] + transform( &lcCursor..PREPARADO )+ [, cOrigPRESU = ] + transform( &lcCursor..cOrigPRESU )+ [, SOLCOMPRA = ZooLogic.COMB.SOLCOMPRA + ] + transform( &lcCursor..SOLCOMPRA )+ [, PRECOMPRA = ZooLogic.COMB.PRECOMPRA + ] + transform( &lcCursor..PRECOMPRA )+ [, cOrigSOLCO = ] + transform( &lcCursor..cOrigSOLCO )+ [, cOrigSENIA = ] + transform( &lcCursor..cOrigSENIA )+ [, REQCOMPRA = ZooLogic.COMB.REQCOMPRA + ] + transform( &lcCursor..REQCOMPRA )+ [, SENIADO = ZooLogic.COMB.SENIADO + ] + transform( &lcCursor..SENIADO )+ [, cOrigREQCO = ] + transform( &lcCursor..cOrigREQCO )+ [, cOrigPEDID = ] + transform( &lcCursor..cOrigPEDID )+ [, COCANT = ZooLogic.COMB.COCANT + ] + transform( &lcCursor..COCANT )+ [, cOrigPEDCO = ] + transform( &lcCursor..cOrigPEDCO )+ [, PEDCOMPRA = ZooLogic.COMB.PEDCOMPRA + ] + transform( &lcCursor..PEDCOMPRA )+ [, PEDIDO = ZooLogic.COMB.PEDIDO + ] + transform( &lcCursor..PEDIDO )+ [, CORIG = ] + transform( &lcCursor..CORIG )+ [, EntregaPen = ZooLogic.COMB.EntregaPen + ] + transform( &lcCursor..EntregaPen )+ [, cOrigEntre = ] + transform( &lcCursor..cOrigEntre ) + [ Where COCOD = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
						if llInsertarAuditoria
							lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
							this.oConexion.EjecutarSql( lcSentencia )
						EndIf
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.COMB Where COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FALTAFW, FECEXPO, FECTRANS, FMODIFW, SALTAFW, SMODIFW, UMODIFW, HMODIFW, ZADSFW, VALTAFW, VMODIFW, UALTAFW, DescFW, COTLL, HORAIMPO, BDALTAFW, HORAEXPO, BDMODIFW, ESTTRANS, HALTAFW, COART, COCOD, COCOL, PRESUPUEST, cOrigPREPA, cOrigPRECO, PREPARADO, cOrigPRESU, SOLCOMPRA, PRECOMPRA, cOrigSOLCO, cOrigSENIA, REQCOMPRA, SENIADO, cOrigREQCO, cOrigPEDID, COCANT, cOrigPEDCO, PEDCOMPRA, PEDIDO, CORIG, EntregaPen, cOrigEntre
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..COTLL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'" + ',' + transform( &lcCursor..PRESUPUEST ) + ',' + transform( &lcCursor..cOrigPREPA ) + ',' + transform( &lcCursor..cOrigPRECO ) + ',' + transform( &lcCursor..PREPARADO ) + ',' + transform( &lcCursor..cOrigPRESU )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..SOLCOMPRA ) + ',' + transform( &lcCursor..PRECOMPRA ) + ',' + transform( &lcCursor..cOrigSOLCO ) + ',' + transform( &lcCursor..cOrigSENIA ) + ',' + transform( &lcCursor..REQCOMPRA ) + ',' + transform( &lcCursor..SENIADO ) + ',' + transform( &lcCursor..cOrigREQCO ) + ',' + transform( &lcCursor..cOrigPEDID ) + ',' + transform( &lcCursor..COCANT ) + ',' + transform( &lcCursor..cOrigPEDCO )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..PEDCOMPRA ) + ',' + transform( &lcCursor..PEDIDO ) + ',' + transform( &lcCursor..CORIG ) + ',' + transform( &lcCursor..EntregaPen ) + ',' + transform( &lcCursor..cOrigEntre )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.COMB ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
					this.oConexion.EjecutarSql( lcSentencia )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKCOMBINACION'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( COCOD C (18) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Artículo: ' + transform( &tcCursor..COART      )
		lcRetorno = lcRetorno + ' - Color: ' + transform( &tcCursor..COCOL      )
		lcRetorno = lcRetorno + ' - Talle: ' + transform( &tcCursor..COTLL      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'STOCKCOMBINACION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'STOCKCOMBINACION_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COMB')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'STOCKCOMBINACION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..COCOD
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..COART ) or isnull( &lcCursor..COCOL ) or isnull( &lcCursor..COTLL )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad STOCKCOMBINACION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKCOMBINACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,COCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( COCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,COART + COCOL + COTLL as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( COART + COCOL + COTLL, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKCOMBINACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMB') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMB
Create Table ZooLogic.TablaTrabajo_COMB ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"descfw" char( 200 )  null, 
"cotll" char( 3 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"coart" char( 13 )  null, 
"cocod" char( 18 )  null, 
"cocol" char( 2 )  null, 
"presupuest" numeric( 9, 0 )  null, 
"corigprepa" numeric( 9, 0 )  null, 
"corigpreco" numeric( 9, 0 )  null, 
"preparado" numeric( 9, 0 )  null, 
"corigpresu" numeric( 9, 0 )  null, 
"solcompra" numeric( 9, 0 )  null, 
"precompra" numeric( 9, 0 )  null, 
"corigsolco" numeric( 9, 0 )  null, 
"corigsenia" numeric( 9, 0 )  null, 
"reqcompra" numeric( 9, 0 )  null, 
"seniado" numeric( 9, 0 )  null, 
"corigreqco" numeric( 9, 0 )  null, 
"corigpedid" numeric( 9, 0 )  null, 
"cocant" numeric( 9, 0 )  null, 
"corigpedco" numeric( 9, 0 )  null, 
"pedcompra" numeric( 9, 0 )  null, 
"pedido" numeric( 9, 0 )  null, 
"minrepo" numeric( 9, 0 )  null, 
"corig" numeric( 9, 0 )  null, 
"maxrepo" numeric( 15, 2 )  null, 
"entregapen" numeric( 15, 2 )  null, 
"corigentre" numeric( 15, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COMB' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COMB' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'STOCKCOMBINACION'
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
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('cotll','cotll')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('coart','coart')
			.AgregarMapeo('cocod','cocod')
			.AgregarMapeo('cocol','cocol')
			.AgregarMapeo('presupuest','presupuest')
			.AgregarMapeo('corigprepa','corigprepa')
			.AgregarMapeo('corigpreco','corigpreco')
			.AgregarMapeo('preparado','preparado')
			.AgregarMapeo('corigpresu','corigpresu')
			.AgregarMapeo('solcompra','solcompra')
			.AgregarMapeo('precompra','precompra')
			.AgregarMapeo('corigsolco','corigsolco')
			.AgregarMapeo('corigsenia','corigsenia')
			.AgregarMapeo('reqcompra','reqcompra')
			.AgregarMapeo('seniado','seniado')
			.AgregarMapeo('corigreqco','corigreqco')
			.AgregarMapeo('corigpedid','corigpedid')
			.AgregarMapeo('cocant','cocant')
			.AgregarMapeo('corigpedco','corigpedco')
			.AgregarMapeo('pedcompra','pedcompra')
			.AgregarMapeo('pedido','pedido')
			.AgregarMapeo('minrepo','minrepo')
			.AgregarMapeo('corig','corig')
			.AgregarMapeo('maxrepo','maxrepo')
			.AgregarMapeo('entregapen','entregapen')
			.AgregarMapeo('corigentre','corigentre')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COMB'
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
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string
		lcCabecera1 = "replace( newId(),'-','1' )"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera9 = iif( .F., 1, 0 )
		
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				insert into ZooLogic.ADT_COMB ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","COTLL","COART","COCOD","COCOL","Presupuest","Corigprepa","Corigpreco","Preparado","Corigpresu","Solcompra","Precompra","Corigsolco","Corigsenia","Reqcompra","Seniado","Corigreqco","Corigpedid","Cocant","Corigpedco","Pedcompra","Pedido","Corig","Entregapen","Corigentre" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Cotll,d.Coart,d.Cocod,d.Cocol,Isnull( d.Presupuest,t.Presupuest),Isnull( t.PREPARADO,t.Corigprepa),Isnull( t.PRECOMPRA,t.Corigpreco),Isnull( d.Preparado,t.Preparado),Isnull( t.PRESUPUEST,t.Corigpresu),Isnull( d.Solcompra,t.Solcompra),Isnull( d.Precompra,t.Precompra),Isnull( t.SOLCOMPRA,t.Corigsolco),Isnull( t.SENIADO,t.Corigsenia),Isnull( d.Reqcompra,t.Reqcompra),Isnull( d.Seniado,t.Seniado),Isnull( t.REQCOMPRA,t.Corigreqco),Isnull( t.PEDIDO,t.Corigpedid),Isnull( d.Cocant,t.Cocant),Isnull( t.PEDCOMPRA,t.Corigpedco),Isnull( d.Pedcompra,t.Pedcompra),Isnull( d.Pedido,t.Pedido),Isnull( t.COCANT,t.Corig),Isnull( d.Entregapen,t.Entregapen),Isnull( t.EntregaPen,t.Corigentre)
						from ZooLogic.COMB t inner join deleted d 
							 on t.COCOD = d.COCOD
							 and  t.COART = d.COART
							 and  t.COCOL = d.COCOL
							 and  t.COTLL = d.COTLL
					where ( d.PRESUPUEST is not null and d.PRESUPUEST <> t.PRESUPUEST ) or ( d.cOrigPREPA is not null and d.cOrigPREPA <> t.cOrigPREPA ) or ( d.cOrigPRECO is not null and d.cOrigPRECO <> t.cOrigPRECO ) or ( d.PREPARADO is not null and d.PREPARADO <> t.PREPARADO ) or ( d.cOrigPRESU is not null and d.cOrigPRESU <> t.cOrigPRESU ) or ( d.SOLCOMPRA is not null and d.SOLCOMPRA <> t.SOLCOMPRA ) or ( d.PRECOMPRA is not null and d.PRECOMPRA <> t.PRECOMPRA ) or ( d.cOrigSOLCO is not null and d.cOrigSOLCO <> t.cOrigSOLCO ) or ( d.cOrigSENIA is not null and d.cOrigSENIA <> t.cOrigSENIA ) or ( d.REQCOMPRA is not null and d.REQCOMPRA <> t.REQCOMPRA ) or ( d.SENIADO is not null and d.SENIADO <> t.SENIADO ) or ( d.cOrigREQCO is not null and d.cOrigREQCO <> t.cOrigREQCO ) or ( d.cOrigPEDID is not null and d.cOrigPEDID <> t.cOrigPEDID ) or ( d.COCANT is not null and d.COCANT <> t.COCANT ) or ( d.cOrigPEDCO is not null and d.cOrigPEDCO <> t.cOrigPEDCO ) or ( d.PEDCOMPRA is not null and d.PEDCOMPRA <> t.PEDCOMPRA ) or ( d.PEDIDO is not null and d.PEDIDO <> t.PEDIDO ) or ( d.CORIG is not null and d.CORIG <> t.CORIG ) or ( d.EntregaPen is not null and d.EntregaPen <> t.EntregaPen ) or ( d.cOrigEntre is not null and d.cOrigEntre <> t.cOrigEntre )
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.COTLL = isnull( d.COTLL, t.COTLL ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.COART = isnull( d.COART, t.COART ),t.COCOD = isnull( d.COCOD, t.COCOD ),t.COCOL = isnull( d.COCOL, t.COCOL ),t.PRESUPUEST = isnull( d.PRESUPUEST, t.PRESUPUEST ),t.CORIGPREPA = isnull( d.CORIGPREPA, t.CORIGPREPA ),t.CORIGPRECO = isnull( d.CORIGPRECO, t.CORIGPRECO ),t.PREPARADO = isnull( d.PREPARADO, t.PREPARADO ),t.CORIGPRESU = isnull( d.CORIGPRESU, t.CORIGPRESU ),t.SOLCOMPRA = isnull( d.SOLCOMPRA, t.SOLCOMPRA ),t.PRECOMPRA = isnull( d.PRECOMPRA, t.PRECOMPRA ),t.CORIGSOLCO = isnull( d.CORIGSOLCO, t.CORIGSOLCO ),t.CORIGSENIA = isnull( d.CORIGSENIA, t.CORIGSENIA ),t.REQCOMPRA = isnull( d.REQCOMPRA, t.REQCOMPRA ),t.SENIADO = isnull( d.SENIADO, t.SENIADO ),t.CORIGREQCO = isnull( d.CORIGREQCO, t.CORIGREQCO ),t.CORIGPEDID = isnull( d.CORIGPEDID, t.CORIGPEDID ),t.COCANT = isnull( d.COCANT, t.COCANT ),t.CORIGPEDCO = isnull( d.CORIGPEDCO, t.CORIGPEDCO ),t.PEDCOMPRA = isnull( d.PEDCOMPRA, t.PEDCOMPRA ),t.PEDIDO = isnull( d.PEDIDO, t.PEDIDO ),t.MINREPO = isnull( d.MINREPO, t.MINREPO ),t.CORIG = isnull( d.CORIG, t.CORIG ),t.MAXREPO = isnull( d.MAXREPO, t.MAXREPO ),t.ENTREGAPEN = isnull( d.ENTREGAPEN, t.ENTREGAPEN ),t.CORIGENTRE = isnull( d.CORIGENTRE, t.CORIGENTRE )
					from ZooLogic.COMB t inner join deleted d 
							 on t.COCOD = d.COCOD
							 and  t.COART = d.COART
							 and  t.COCOL = d.COCOL
							 and  t.COTLL = d.COTLL
				-- Fin Updates
				insert into ZooLogic.ADT_COMB ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","COTLL","COART","COCOD","COCOL","Presupuest","Corigprepa","Corigpreco","Preparado","Corigpresu","Solcompra","Precompra","Corigsolco","Corigsenia","Reqcompra","Seniado","Corigreqco","Corigpedid","Cocant","Corigpedco","Pedcompra","Pedido","Corig","Entregapen","Corigentre" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Cotll,d.Coart,d.Cocod,d.Cocol,isnull( d.PRESUPUEST,0),isnull( d.CORIGPREPA,0),isnull( d.CORIGPRECO,0),isnull( d.PREPARADO,0),isnull( d.CORIGPRESU,0),isnull( d.SOLCOMPRA,0),isnull( d.PRECOMPRA,0),isnull( d.CORIGSOLCO,0),isnull( d.CORIGSENIA,0),isnull( d.REQCOMPRA,0),isnull( d.SENIADO,0),isnull( d.CORIGREQCO,0),isnull( d.CORIGPEDID,0),isnull( d.COCANT,0),isnull( d.CORIGPEDCO,0),isnull( d.PEDCOMPRA,0),isnull( d.PEDIDO,0),isnull( d.CORIG,0),isnull( d.ENTREGAPEN,0),isnull( d.CORIGENTRE,0)
						From deleted d left join ZooLogic.COMB pk 
							 on d.COCOD = pk.COCOD
						 left join ZooLogic.COMB cc 
							 on  d.COART = cc.COART
							 and  d.COCOL = cc.COCOL
							 and  d.COTLL = cc.COTLL
						Where pk.COCOD Is Null 
							 and cc.COART Is Null 
							 and cc.COCOL Is Null 
							 and cc.COTLL Is Null 
				insert into ZooLogic.COMB(Fecimpo,Faltafw,Fecexpo,Fectrans,Fmodifw,Saltafw,Smodifw,Umodifw,Hmodifw,Zadsfw,Valtafw,Vmodifw,Ualtafw,Descfw,Cotll,Horaimpo,Bdaltafw,Horaexpo,Bdmodifw,Esttrans,Haltafw,Coart,Cocod,Cocol,Presupuest,Corigprepa,Corigpreco,Preparado,Corigpresu,Solcompra,Precompra,Corigsolco,Corigsenia,Reqcompra,Seniado,Corigreqco,Corigpedid,Cocant,Corigpedco,Pedcompra,Pedido,Minrepo,Corig,Maxrepo,Entregapen,Corigentre)
					Select isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.DESCFW,''),isnull( d.COTLL,''),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.COART,''),isnull( d.COCOD,''),isnull( d.COCOL,''),isnull( d.PRESUPUEST,0),isnull( d.CORIGPREPA,0),isnull( d.CORIGPRECO,0),isnull( d.PREPARADO,0),isnull( d.CORIGPRESU,0),isnull( d.SOLCOMPRA,0),isnull( d.PRECOMPRA,0),isnull( d.CORIGSOLCO,0),isnull( d.CORIGSENIA,0),isnull( d.REQCOMPRA,0),isnull( d.SENIADO,0),isnull( d.CORIGREQCO,0),isnull( d.CORIGPEDID,0),isnull( d.COCANT,0),isnull( d.CORIGPEDCO,0),isnull( d.PEDCOMPRA,0),isnull( d.PEDIDO,0),isnull( d.MINREPO,0),isnull( d.CORIG,0),isnull( d.MAXREPO,0),isnull( d.ENTREGAPEN,0),isnull( d.CORIGENTRE,0)
						From deleted d left join ZooLogic.COMB pk 
							 on d.COCOD = pk.COCOD
						 left join ZooLogic.COMB cc 
							 on  d.COART = cc.COART
							 and  d.COCOL = cc.COCOL
							 and  d.COTLL = cc.COTLL
						Where pk.COCOD Is Null 
							 and cc.COART Is Null 
							 and cc.COCOL Is Null 
							 and cc.COTLL Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ARTÍCULO ' + cast( d.COART as Varchar(13) ) + ', COLOR ' + cast( d.COCOL as Varchar(2) ) + ', TALLE ' + cast( d.COTLL as Varchar(3) ) + '','La clave principal no es la esperada'
					from ZooLogic.COMB t inner join deleted d 
							on   t.COART = d.COART
							 and  t.COCOL = d.COCOL
							 and  t.COTLL = d.COTLL
						left join deleted h 
							 on t.COCOD = h.COCOD
							 where h.COCOD is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: ARTÍCULO ' + cast( d.COART as Varchar(13) ) + ', COLOR ' + cast( d.COCOL as Varchar(2) ) + ', TALLE ' + cast( d.COTLL as Varchar(3) ) + '','La clave principal a importar ya existe'
					from ZooLogic.COMB t inner join deleted d 
							 on t.COCOD = d.COCOD
						left join deleted h 
							on   t.COART = h.COART
							 and   t.COCOL = h.COCOL
							 and   t.COTLL = h.COTLL
							where   h.COART is null 
							 and   h.COCOL is null 
							 and   h.COTLL is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMB') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMB
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_STOCKCOMBINACION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKCOMBINACION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKCOMBINACION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKCOMBINACION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKCOMBINACION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_STOCKCOMBINACION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_STOCKCOMBINACION.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_STOCKCOMBINACION.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_STOCKCOMBINACION.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_STOCKCOMBINACION.Horamodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_STOCKCOMBINACION.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_STOCKCOMBINACION.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_STOCKCOMBINACION.Usuarioaltafw, [] )
					.Descripcionfw = nvl( c_STOCKCOMBINACION.Descripcionfw, [] )
					.Talle = nvl( c_STOCKCOMBINACION.Talle, [] )
					.Horaimpo = nvl( c_STOCKCOMBINACION.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_STOCKCOMBINACION.Basededatosaltafw, [] )
					.Horaexpo = nvl( c_STOCKCOMBINACION.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_STOCKCOMBINACION.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_STOCKCOMBINACION.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_STOCKCOMBINACION.Horaaltafw, [] )
					.Articulo_PK =  nvl( c_STOCKCOMBINACION.Articulo, [] )
					.Codigo = nvl( c_STOCKCOMBINACION.Codigo, [] )
					.Color_PK =  nvl( c_STOCKCOMBINACION.Color, [] )
					.Presupuestado = nvl( c_STOCKCOMBINACION.Presupuestado, 0 )
					.Preparadooriginal = nvl( c_STOCKCOMBINACION.Preparadooriginal, 0 )
					.Precompraoriginal = nvl( c_STOCKCOMBINACION.Precompraoriginal, 0 )
					.Preparado = nvl( c_STOCKCOMBINACION.Preparado, 0 )
					.Presupuestadooriginal = nvl( c_STOCKCOMBINACION.Presupuestadooriginal, 0 )
					.Solcompra = nvl( c_STOCKCOMBINACION.Solcompra, 0 )
					.Precompra = nvl( c_STOCKCOMBINACION.Precompra, 0 )
					.Solcompraoriginal = nvl( c_STOCKCOMBINACION.Solcompraoriginal, 0 )
					.Seniadooriginal = nvl( c_STOCKCOMBINACION.Seniadooriginal, 0 )
					.Reqcompra = nvl( c_STOCKCOMBINACION.Reqcompra, 0 )
					.Seniado = nvl( c_STOCKCOMBINACION.Seniado, 0 )
					.Reqcompraoriginal = nvl( c_STOCKCOMBINACION.Reqcompraoriginal, 0 )
					.Pedidooriginal = nvl( c_STOCKCOMBINACION.Pedidooriginal, 0 )
					.Cantidad = nvl( c_STOCKCOMBINACION.Cantidad, 0 )
					.Pedcompraoriginal = nvl( c_STOCKCOMBINACION.Pedcompraoriginal, 0 )
					.Pedcompra = nvl( c_STOCKCOMBINACION.Pedcompra, 0 )
					.Pedido = nvl( c_STOCKCOMBINACION.Pedido, 0 )
					.Minreposicion = nvl( c_STOCKCOMBINACION.Minreposicion, 0 )
					.Cantidadoriginal = nvl( c_STOCKCOMBINACION.Cantidadoriginal, 0 )
					.Maxreposicion = nvl( c_STOCKCOMBINACION.Maxreposicion, 0 )
					.Entregapen = nvl( c_STOCKCOMBINACION.Entregapen, 0 )
					.Entregapenoriginal = nvl( c_STOCKCOMBINACION.Entregapenoriginal, 0 )
					Select c_STOCKCOMBINACION
					scatter name This.oEntidad.oAtributosAuditoria
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
	*-----------------------------------------------------------------------------------------
	function ObtenerSentenciasInsertAuditoria( tcCursor as string ) as String
		if empty( tcCursor )
			local lcDescripcionFW as string
			lcDescripcionFW = this.oEntidad.DescripcionFW
		else
			local lcDescripcionFW as string
			lcDescripcionFW = &tcCursor..DescFW
		endif
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string;
		, lcCabecera10 as string
		lcCabecera1 = "'" + this.FormatearTextoSql( goLibrerias.ObtenerGuidPk() ) + "'"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( lcDescripcionFW ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera9 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera10 = iif( .F., 1, 0 )
		
		local lxValorClavePrimaria as variant
		if empty( tcCursor )
			lxValorClavePrimaria = this.oEntidad.CODIGO
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string, lcEntidad8 as string, lcEntidad9 as string, lcEntidad10 as string;
			, lcEntidad11 as string;
			, lcEntidad12 as string;
			, lcEntidad13 as string;
			, lcEntidad14 as string;
			, lcEntidad15 as string;
			, lcEntidad16 as string;
			, lcEntidad17 as string;
			, lcEntidad18 as string;
			, lcEntidad19 as string;
			, lcEntidad20 as string;
			, lcEntidad21 as string;
			, lcEntidad22 as string;
			, lcEntidad23 as string;
			, lcEntidad24 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( this.oEntidad.Talle ) + "'"
			lcEntidad2 = "'" + this.FormatearTextoSql( this.oEntidad.Articulo_pk ) + "'"
			lcEntidad3 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad4 = "'" + this.FormatearTextoSql( this.oEntidad.Color_pk ) + "'"
			lcEntidad5 = transform( this.oEntidad.Presupuestado )
			lcEntidad6 = transform( this.oEntidad.Preparadooriginal )
			lcEntidad7 = transform( this.oEntidad.Precompraoriginal )
			lcEntidad8 = transform( this.oEntidad.Preparado )
			lcEntidad9 = transform( this.oEntidad.Presupuestadooriginal )
			lcEntidad10 = transform( this.oEntidad.Solcompra )
			lcEntidad11 = transform( this.oEntidad.Precompra )
			lcEntidad12 = transform( this.oEntidad.Solcompraoriginal )
			lcEntidad13 = transform( this.oEntidad.Seniadooriginal )
			lcEntidad14 = transform( this.oEntidad.Reqcompra )
			lcEntidad15 = transform( this.oEntidad.Seniado )
			lcEntidad16 = transform( this.oEntidad.Reqcompraoriginal )
			lcEntidad17 = transform( this.oEntidad.Pedidooriginal )
			lcEntidad18 = transform( this.oEntidad.Cantidad )
			lcEntidad19 = transform( this.oEntidad.Pedcompraoriginal )
			lcEntidad20 = transform( this.oEntidad.Pedcompra )
			lcEntidad21 = transform( this.oEntidad.Pedido )
			lcEntidad22 = transform( this.oEntidad.Cantidadoriginal )
			lcEntidad23 = transform( this.oEntidad.Entregapen )
			lcEntidad24 = transform( this.oEntidad.Entregapenoriginal )
			
		else
			lxValorClavePrimaria = &tcCursor..COCOD
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string, lcEntidad8 as string, lcEntidad9 as string, lcEntidad10 as string;
			, lcEntidad11 as string;
			, lcEntidad12 as string;
			, lcEntidad13 as string;
			, lcEntidad14 as string;
			, lcEntidad15 as string;
			, lcEntidad16 as string;
			, lcEntidad17 as string;
			, lcEntidad18 as string;
			, lcEntidad19 as string;
			, lcEntidad20 as string;
			, lcEntidad21 as string;
			, lcEntidad22 as string;
			, lcEntidad23 as string;
			, lcEntidad24 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( &tcCursor..Cotll ) + "'"
			lcEntidad2 = "'" + this.FormatearTextoSql( &tcCursor..Coart ) + "'"
			lcEntidad3 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad4 = "'" + this.FormatearTextoSql( &tcCursor..Cocol ) + "'"
			lcEntidad5 = transform( &tcCursor..Presupuest )
			lcEntidad6 = transform( &tcCursor..Corigprepa )
			lcEntidad7 = transform( &tcCursor..Corigpreco )
			lcEntidad8 = transform( &tcCursor..Preparado )
			lcEntidad9 = transform( &tcCursor..Corigpresu )
			lcEntidad10 = transform( &tcCursor..Solcompra )
			lcEntidad11 = transform( &tcCursor..Precompra )
			lcEntidad12 = transform( &tcCursor..Corigsolco )
			lcEntidad13 = transform( &tcCursor..Corigsenia )
			lcEntidad14 = transform( &tcCursor..Reqcompra )
			lcEntidad15 = transform( &tcCursor..Seniado )
			lcEntidad16 = transform( &tcCursor..Corigreqco )
			lcEntidad17 = transform( &tcCursor..Corigpedid )
			lcEntidad18 = transform( &tcCursor..Cocant )
			lcEntidad19 = transform( &tcCursor..Corigpedco )
			lcEntidad20 = transform( &tcCursor..Pedcompra )
			lcEntidad21 = transform( &tcCursor..Pedido )
			lcEntidad22 = transform( &tcCursor..Corig )
			lcEntidad23 = transform( &tcCursor..Entregapen )
			lcEntidad24 = transform( &tcCursor..Corigentre )
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_COMB ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","COTLL","COART","COCOD","COCOL","Presupuest","Corigprepa","Corigpreco","Preparado","Corigpresu","Solcompra","Precompra","Corigsolco","Corigsenia","Reqcompra","Seniado","Corigreqco","Corigpedid","Cocant","Corigpedco","Pedcompra","Pedido","Corig","Entregapen","Corigentre" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>>, <<lcEntidad4>>, <<lcEntidad5>>, <<lcEntidad6>>, <<lcEntidad7>>, <<lcEntidad8>>, <<lcEntidad9>>, <<lcEntidad10>>, <<lcEntidad11>>, <<lcEntidad12>>, <<lcEntidad13>>, <<lcEntidad14>>, <<lcEntidad15>>, <<lcEntidad16>>, <<lcEntidad17>>, <<lcEntidad18>>, <<lcEntidad19>>, <<lcEntidad20>>, <<lcEntidad21>>, <<lcEntidad22>>, <<lcEntidad23>>, <<lcEntidad24>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_STOCKCOMBINACION.CODIGO
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
		return c_STOCKCOMBINACION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMB' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "COCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,COCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    COCOD from (
							select * 
								from ZooLogic.COMB 
								Where   COMB.COCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMB", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "COCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descfw" as "Descripcionfw", "Cotll" as "Talle", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Coart" as "Articulo", "Cocod" as "Codigo", "Cocol" as "Color", "Presupuest" as "Presupuestado", "Corigprepa" as "Preparadooriginal", "Corigpreco" as "Precompraoriginal", "Preparado" as "Preparado", "Corigpresu" as "Presupuestadooriginal", "Solcompra" as "Solcompra", "Precompra" as "Precompra", "Corigsolco" as "Solcompraoriginal", "Corigsenia" as "Seniadooriginal", "Reqcompra" as "Reqcompra", "Seniado" as "Seniado", "Corigreqco" as "Reqcompraoriginal", "Corigpedid" as "Pedidooriginal", "Cocant" as "Cantidad", "Corigpedco" as "Pedcompraoriginal", "Pedcompra" as "Pedcompra", "Pedido" as "Pedido", "Minrepo" as "Minreposicion", "Corig" as "Cantidadoriginal", "Maxrepo" as "Maxreposicion", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMB 
								Where   COMB.COCOD != ''
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
	Tabla = 'COMB'
	Filtro = " COMB.COCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMB.COCOD != ''"
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
	<row entidad="STOCKCOMBINACION                        " atributo="FECHAIMPO                               " tabla="COMB           " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="FECHAALTAFW                             " tabla="COMB           " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="FECHAEXPO                               " tabla="COMB           " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="FECHATRANSFERENCIA                      " tabla="COMB           " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="FECHAMODIFICACIONFW                     " tabla="COMB           " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="SERIEALTAFW                             " tabla="COMB           " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="SERIEMODIFICACIONFW                     " tabla="COMB           " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="USUARIOMODIFICACIONFW                   " tabla="COMB           " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="HORAMODIFICACIONFW                      " tabla="COMB           " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="ZADSFW                                  " tabla="COMB           " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="VERSIONALTAFW                           " tabla="COMB           " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="VERSIONMODIFICACIONFW                   " tabla="COMB           " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="USUARIOALTAFW                           " tabla="COMB           " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="DESCRIPCIONFW                           " tabla="COMB           " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="TALLE                                   " tabla="COMB           " campo="COTLL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Talle                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="HORAIMPO                                " tabla="COMB           " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="BASEDEDATOSALTAFW                       " tabla="COMB           " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="DESCRIPCIONCOMPROBANTE                  " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="HORAEXPO                                " tabla="COMB           " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMB           " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="ESTADOTRANSFERENCIA                     " tabla="COMB           " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="HORAALTAFW                              " tabla="COMB           " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="ARTICULO                                " tabla="COMB           " campo="COART     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="CODIGO                                  " tabla="COMB           " campo="COCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="18" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="COLOR                                   " tabla="COMB           " campo="COCOL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PRESUPUESTADO                           " tabla="COMB           " campo="PRESUPUEST" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="PRESUPUESTADO                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PREPARADOORIGINAL                       " tabla="COMB           " campo="CORIGPREPA" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="cOrigPREPARADO                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PRECOMPRAORIGINAL                       " tabla="COMB           " campo="CORIGPRECO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="cOrigPRECOMPRA                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PREPARADO                               " tabla="COMB           " campo="PREPARADO " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="PREPARADO                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PRESUPUESTADOORIGINAL                   " tabla="COMB           " campo="CORIGPRESU" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="cOrigPRESUPUESTADO                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="SOLCOMPRA                               " tabla="COMB           " campo="SOLCOMPRA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="SOLCOMPRA                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PRECOMPRA                               " tabla="COMB           " campo="PRECOMPRA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="PRECOMPRA                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="SOLCOMPRAORIGINAL                       " tabla="COMB           " campo="CORIGSOLCO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="cOrigSOLCOMPRA                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="SENIADOORIGINAL                         " tabla="COMB           " campo="CORIGSENIA" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="cOrigSENIADO                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="REQCOMPRA                               " tabla="COMB           " campo="REQCOMPRA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="REQCOMPRA                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="SENIADO                                 " tabla="COMB           " campo="SENIADO   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="SENIADO                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="REQCOMPRAORIGINAL                       " tabla="COMB           " campo="CORIGREQCO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="cOrigREQCOMPRA                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PEDIDOORIGINAL                          " tabla="COMB           " campo="CORIGPEDID" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="cOrigPEDIDO                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="CANTIDAD                                " tabla="COMB           " campo="COCANT    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Cantidad en stock                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PEDCOMPRAORIGINAL                       " tabla="COMB           " campo="CORIGPEDCO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="cOrigPEDCOMPRA                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PEDCOMPRA                               " tabla="COMB           " campo="PEDCOMPRA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="PEDCOMPRA                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="PEDIDO                                  " tabla="COMB           " campo="PEDIDO    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="PEDIDO                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="DIFERENCIAENTRESTOCKYREPOSICION         " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Diferencia entre stock y reposicion                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="DIFERENCIAENTRESTOCKYCANTIDADCOMB       " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Diferencia entre stock y cantidad en combinaciones                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="MINREPOSICION                           " tabla="COMB           " campo="MINREPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Mínimo reposición                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="CANTIDADORIGINAL                        " tabla="COMB           " campo="CORIG     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Cantidad Original                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="MAXREPOSICION                           " tabla="COMB           " campo="MAXREPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Máximo reposición                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="ENTREGAPEN                              " tabla="COMB           " campo="ENTREGAPEN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entrega pendiente                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="STOCKCOMBINACION                        " atributo="ENTREGAPENORIGINAL                      " tabla="COMB           " campo="CORIGENTRE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entrega pendiente original                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On COMB.COART = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On COMB.COCOL = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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