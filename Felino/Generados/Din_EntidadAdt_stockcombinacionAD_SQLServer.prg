
define class Din_EntidadADT_STOCKCOMBINACIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ADT_STOCKCOMBINACION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AUD012PK'
	cTablaPrincipal = 'ADT_COMB'
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
			local  lxAdt_combFecimpo, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combFmodifw, lxAdt_combAdt_fecha, lxAdt_combFectrans, lxAdt_combCorigprepa, lxAdt_combPreparado, lxAdt_combCorigpedid, lxAdt_combCorigpreco, lxAdt_combPrecompra, lxAdt_combCorigpresu, lxAdt_combCorigsenia, lxAdt_combSolcompra, lxAdt_combCorigsolco, lxAdt_combSeniado, lxAdt_combPedido, lxAdt_combReqcompra, lxAdt_combCorigreqco, lxAdt_combPresupuest, lxAdt_combCorig, lxAdt_combCorigpedco, lxAdt_combCocant, lxAdt_combEntregapen, lxAdt_combCorigentre, lxAdt_combPedcompra, lxAdt_combAdt_ext, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combHoraimpo, lxAdt_combHaltafw, lxAdt_combSaltafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combAdt_hora, lxAdt_combValtafw, lxAdt_combSmodifw, lxAdt_combUaltafw, lxAdt_combEsttrans, lxAdt_combAdt_serie, lxAdt_combAdt_vers, lxAdt_combCotll, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combBdaltafw, lxAdt_combBdmodifw, lxAdt_combAdt_comp, lxAdt_combAdt_ent, lxAdt_combAdt_cod, lxAdt_combCocol, lxAdt_combCocod, lxAdt_combCoart
				lxAdt_combFecimpo =  .Fechaimpo			lxAdt_combFaltafw =  .Fechaaltafw			lxAdt_combFecexpo =  .Fechaexpo			lxAdt_combFmodifw =  .Fechamodificacionfw			lxAdt_combAdt_fecha =  .Adt_fecha			lxAdt_combFectrans =  .Fechatransferencia			lxAdt_combCorigprepa =  .Preparadooriginal			lxAdt_combPreparado =  .Preparado			lxAdt_combCorigpedid =  .Pedidooriginal			lxAdt_combCorigpreco =  .Precompraoriginal			lxAdt_combPrecompra =  .Precompra			lxAdt_combCorigpresu =  .Presupuestadooriginal			lxAdt_combCorigsenia =  .Seniadooriginal			lxAdt_combSolcompra =  .Solcompra			lxAdt_combCorigsolco =  .Solcompraoriginal			lxAdt_combSeniado =  .Seniado			lxAdt_combPedido =  .Pedido			lxAdt_combReqcompra =  .Reqcompra			lxAdt_combCorigreqco =  .Reqcompraoriginal			lxAdt_combPresupuest =  .Presupuestado			lxAdt_combCorig =  .Cantidadoriginal			lxAdt_combCorigpedco =  .Pedcompraoriginal			lxAdt_combCocant =  .Cantidad			lxAdt_combEntregapen =  .Entregapen			lxAdt_combCorigentre =  .Entregapenoriginal			lxAdt_combPedcompra =  .Pedcompra			lxAdt_combAdt_ext =  .Adt_ext			lxAdt_combHmodifw =  .Horamodificacionfw			lxAdt_combHoraexpo =  .Horaexpo			lxAdt_combHoraimpo =  .Horaimpo			lxAdt_combHaltafw =  .Horaaltafw			lxAdt_combSaltafw =  .Seriealtafw			lxAdt_combUmodifw =  .Usuariomodificacionfw			lxAdt_combVmodifw =  .Versionmodificacionfw			lxAdt_combZadsfw =  .Zadsfw			lxAdt_combAdt_hora =  .Adt_hora			lxAdt_combValtafw =  .Versionaltafw			lxAdt_combSmodifw =  .Seriemodificacionfw			lxAdt_combUaltafw =  .Usuarioaltafw			lxAdt_combEsttrans =  .Estadotransferencia			lxAdt_combAdt_serie =  .Adt_serie			lxAdt_combAdt_vers =  .Adt_vers			lxAdt_combCotll =  .Talle			lxAdt_combAdt_usr =  .Adt_usr			lxAdt_combAdt_adn =  .Adt_adn			lxAdt_combBdaltafw =  .Basededatosaltafw			lxAdt_combBdmodifw =  .Basededatosmodificacionfw			lxAdt_combAdt_comp =  .Adt_comp			lxAdt_combAdt_ent =  .Adt_ent			lxAdt_combAdt_cod =  .Adt_cod			lxAdt_combCocol =  upper( .Color_PK ) 			lxAdt_combCocod =  upper( .Codigo_PK ) 			lxAdt_combCoart =  upper( .Articulo_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAdt_combAdt_cod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_COMB ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Adt_fecha","Fectrans","Corigprepa","Preparado","Corigpedid","Corigpreco","Precompra","Corigpresu","Corigsenia","Solcompra","Corigsolco","Seniado","Pedido","Reqcompra","Corigreqco","Presupuest","Corig","Corigpedco","Cocant","Entregapen","Corigentre","Pedcompra","Adt_ext","Hmodifw","Horaexpo","Horaimpo","Haltafw","Saltafw","Umodifw","Vmodifw","Zadsfw","Adt_hora","Valtafw","Smodifw","Ualtafw","Esttrans","Adt_serie","Adt_vers","Cotll","Adt_usr","Adt_adn","Bdaltafw","Bdmodifw","Adt_comp","Adt_ent","Adt_cod","Cocol","Cocod","Coart" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_combFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFectrans ) + "'" >>, <<lxAdt_combCorigprepa >>, <<lxAdt_combPreparado >>, <<lxAdt_combCorigpedid >>, <<lxAdt_combCorigpreco >>, <<lxAdt_combPrecompra >>, <<lxAdt_combCorigpresu >>, <<lxAdt_combCorigsenia >>, <<lxAdt_combSolcompra >>, <<lxAdt_combCorigsolco >>, <<lxAdt_combSeniado >>, <<lxAdt_combPedido >>, <<lxAdt_combReqcompra >>, <<lxAdt_combCorigreqco >>, <<lxAdt_combPresupuest >>, <<lxAdt_combCorig >>, <<lxAdt_combCorigpedco >>, <<lxAdt_combCocant >>, <<lxAdt_combEntregapen >>, <<lxAdt_combCorigentre >>, <<lxAdt_combPedcompra >>, <<iif( lxAdt_combAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_combHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCotll ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCocol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCoart ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
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
		return this.oEntidad.ADT_COD
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxAdt_combFecimpo, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combFmodifw, lxAdt_combAdt_fecha, lxAdt_combFectrans, lxAdt_combCorigprepa, lxAdt_combPreparado, lxAdt_combCorigpedid, lxAdt_combCorigpreco, lxAdt_combPrecompra, lxAdt_combCorigpresu, lxAdt_combCorigsenia, lxAdt_combSolcompra, lxAdt_combCorigsolco, lxAdt_combSeniado, lxAdt_combPedido, lxAdt_combReqcompra, lxAdt_combCorigreqco, lxAdt_combPresupuest, lxAdt_combCorig, lxAdt_combCorigpedco, lxAdt_combCocant, lxAdt_combEntregapen, lxAdt_combCorigentre, lxAdt_combPedcompra, lxAdt_combAdt_ext, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combHoraimpo, lxAdt_combHaltafw, lxAdt_combSaltafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combAdt_hora, lxAdt_combValtafw, lxAdt_combSmodifw, lxAdt_combUaltafw, lxAdt_combEsttrans, lxAdt_combAdt_serie, lxAdt_combAdt_vers, lxAdt_combCotll, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combBdaltafw, lxAdt_combBdmodifw, lxAdt_combAdt_comp, lxAdt_combAdt_ent, lxAdt_combAdt_cod, lxAdt_combCocol, lxAdt_combCocod, lxAdt_combCoart
				lxAdt_combFecimpo =  .Fechaimpo			lxAdt_combFaltafw =  .Fechaaltafw			lxAdt_combFecexpo =  .Fechaexpo			lxAdt_combFmodifw =  .Fechamodificacionfw			lxAdt_combAdt_fecha =  .Adt_fecha			lxAdt_combFectrans =  .Fechatransferencia			lxAdt_combCorigprepa =  .Preparadooriginal			lxAdt_combPreparado =  .Preparado			lxAdt_combCorigpedid =  .Pedidooriginal			lxAdt_combCorigpreco =  .Precompraoriginal			lxAdt_combPrecompra =  .Precompra			lxAdt_combCorigpresu =  .Presupuestadooriginal			lxAdt_combCorigsenia =  .Seniadooriginal			lxAdt_combSolcompra =  .Solcompra			lxAdt_combCorigsolco =  .Solcompraoriginal			lxAdt_combSeniado =  .Seniado			lxAdt_combPedido =  .Pedido			lxAdt_combReqcompra =  .Reqcompra			lxAdt_combCorigreqco =  .Reqcompraoriginal			lxAdt_combPresupuest =  .Presupuestado			lxAdt_combCorig =  .Cantidadoriginal			lxAdt_combCorigpedco =  .Pedcompraoriginal			lxAdt_combCocant =  .Cantidad			lxAdt_combEntregapen =  .Entregapen			lxAdt_combCorigentre =  .Entregapenoriginal			lxAdt_combPedcompra =  .Pedcompra			lxAdt_combAdt_ext =  .Adt_ext			lxAdt_combHmodifw =  .Horamodificacionfw			lxAdt_combHoraexpo =  .Horaexpo			lxAdt_combHoraimpo =  .Horaimpo			lxAdt_combHaltafw =  .Horaaltafw			lxAdt_combSaltafw =  .Seriealtafw			lxAdt_combUmodifw =  .Usuariomodificacionfw			lxAdt_combVmodifw =  .Versionmodificacionfw			lxAdt_combZadsfw =  .Zadsfw			lxAdt_combAdt_hora =  .Adt_hora			lxAdt_combValtafw =  .Versionaltafw			lxAdt_combSmodifw =  .Seriemodificacionfw			lxAdt_combUaltafw =  .Usuarioaltafw			lxAdt_combEsttrans =  .Estadotransferencia			lxAdt_combAdt_serie =  .Adt_serie			lxAdt_combAdt_vers =  .Adt_vers			lxAdt_combCotll =  .Talle			lxAdt_combAdt_usr =  .Adt_usr			lxAdt_combAdt_adn =  .Adt_adn			lxAdt_combBdaltafw =  .Basededatosaltafw			lxAdt_combBdmodifw =  .Basededatosmodificacionfw			lxAdt_combAdt_comp =  .Adt_comp			lxAdt_combAdt_ent =  .Adt_ent			lxAdt_combAdt_cod =  .Adt_cod			lxAdt_combCocol =  upper( .Color_PK ) 			lxAdt_combCocod =  upper( .Codigo_PK ) 			lxAdt_combCoart =  upper( .Articulo_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ADT_COD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ADT_COMB set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_combFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_combFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_combFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_combFmodifw ) + "'">>,"Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_combAdt_fecha ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_combFectrans ) + "'">>,"Corigprepa" = <<lxAdt_combCorigprepa>>,"Preparado" = <<lxAdt_combPreparado>>,"Corigpedid" = <<lxAdt_combCorigpedid>>,"Corigpreco" = <<lxAdt_combCorigpreco>>,"Precompra" = <<lxAdt_combPrecompra>>,"Corigpresu" = <<lxAdt_combCorigpresu>>,"Corigsenia" = <<lxAdt_combCorigsenia>>,"Solcompra" = <<lxAdt_combSolcompra>>,"Corigsolco" = <<lxAdt_combCorigsolco>>,"Seniado" = <<lxAdt_combSeniado>>,"Pedido" = <<lxAdt_combPedido>>,"Reqcompra" = <<lxAdt_combReqcompra>>,"Corigreqco" = <<lxAdt_combCorigreqco>>,"Presupuest" = <<lxAdt_combPresupuest>>,"Corig" = <<lxAdt_combCorig>>,"Corigpedco" = <<lxAdt_combCorigpedco>>,"Cocant" = <<lxAdt_combCocant>>,"Entregapen" = <<lxAdt_combEntregapen>>,"Corigentre" = <<lxAdt_combCorigentre>>,"Pedcompra" = <<lxAdt_combPedcompra>>,"Adt_ext" = <<iif( lxAdt_combAdt_ext, 1, 0 )>>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_combHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_combHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combHaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_combZadsfw ) + "'">>,"Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_hora ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_combValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_combUaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_combEsttrans ) + "'">>,"Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_serie ) + "'">>,"Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_vers ) + "'">>,"Cotll" = <<"'" + this.FormatearTextoSql( lxAdt_combCotll ) + "'">>,"Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_usr ) + "'">>,"Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_adn ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combBdmodifw ) + "'">>,"Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_comp ) + "'">>,"Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_ent ) + "'">>,"Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'">>,"Cocol" = <<"'" + this.FormatearTextoSql( lxAdt_combCocol ) + "'">>,"Cocod" = <<"'" + this.FormatearTextoSql( lxAdt_combCocod ) + "'">>,"Coart" = <<"'" + this.FormatearTextoSql( lxAdt_combCoart ) + "'">> where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'">> and  ADT_COMB.ADT_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ADT_Cod from ZooLogic.ADT_COMB where " + this.ConvertirFuncionesSql( " ADT_COMB.ADT_COD != ''" ) )
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
			Local lxAdt_combAdt_cod
			lxAdt_combAdt_cod = .Adt_cod

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Adt_fecha" as "Adt_fecha", "Fectrans" as "Fechatransferencia", "Corigprepa" as "Preparadooriginal", "Preparado" as "Preparado", "Corigpedid" as "Pedidooriginal", "Corigpreco" as "Precompraoriginal", "Precompra" as "Precompra", "Corigpresu" as "Presupuestadooriginal", "Corigsenia" as "Seniadooriginal", "Solcompra" as "Solcompra", "Corigsolco" as "Solcompraoriginal", "Seniado" as "Seniado", "Pedido" as "Pedido", "Reqcompra" as "Reqcompra", "Corigreqco" as "Reqcompraoriginal", "Presupuest" as "Presupuestado", "Corig" as "Cantidadoriginal", "Corigpedco" as "Pedcompraoriginal", "Cocant" as "Cantidad", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal", "Pedcompra" as "Pedcompra", "Adt_ext" as "Adt_ext", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Adt_hora" as "Adt_hora", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Cotll" as "Talle", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_comp" as "Adt_comp", "Adt_ent" as "Adt_ent", "Adt_cod" as "Adt_cod", "Cocol" as "Color", "Cocod" as "Codigo", "Coart" as "Articulo" from ZooLogic.ADT_COMB where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'">> and  ADT_COMB.ADT_COD != ''
			endtext
			use in select('c_ADT_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKCOMBINACION', set( 'Datasession' ) )

			if reccount( 'c_ADT_STOCKCOMBINACION' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAdt_combAdt_cod as Variant
		llRetorno = .t.
		lxAdt_combAdt_cod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ADT_COMB where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'">> and  ADT_COMB.ADT_COD != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Adt_fecha" as "Adt_fecha", "Fectrans" as "Fechatransferencia", "Corigprepa" as "Preparadooriginal", "Preparado" as "Preparado", "Corigpedid" as "Pedidooriginal", "Corigpreco" as "Precompraoriginal", "Precompra" as "Precompra", "Corigpresu" as "Presupuestadooriginal", "Corigsenia" as "Seniadooriginal", "Solcompra" as "Solcompra", "Corigsolco" as "Solcompraoriginal", "Seniado" as "Seniado", "Pedido" as "Pedido", "Reqcompra" as "Reqcompra", "Corigreqco" as "Reqcompraoriginal", "Presupuest" as "Presupuestado", "Corig" as "Cantidadoriginal", "Corigpedco" as "Pedcompraoriginal", "Cocant" as "Cantidad", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal", "Pedcompra" as "Pedcompra", "Adt_ext" as "Adt_ext", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Adt_hora" as "Adt_hora", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Cotll" as "Talle", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_comp" as "Adt_comp", "Adt_ent" as "Adt_ent", "Adt_cod" as "Adt_cod", "Cocol" as "Color", "Cocod" as "Codigo", "Coart" as "Articulo" from ZooLogic.ADT_COMB where  ADT_COMB.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKCOMBINACION', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Adt_fecha" as "Adt_fecha", "Fectrans" as "Fechatransferencia", "Corigprepa" as "Preparadooriginal", "Preparado" as "Preparado", "Corigpedid" as "Pedidooriginal", "Corigpreco" as "Precompraoriginal", "Precompra" as "Precompra", "Corigpresu" as "Presupuestadooriginal", "Corigsenia" as "Seniadooriginal", "Solcompra" as "Solcompra", "Corigsolco" as "Solcompraoriginal", "Seniado" as "Seniado", "Pedido" as "Pedido", "Reqcompra" as "Reqcompra", "Corigreqco" as "Reqcompraoriginal", "Presupuest" as "Presupuestado", "Corig" as "Cantidadoriginal", "Corigpedco" as "Pedcompraoriginal", "Cocant" as "Cantidad", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal", "Pedcompra" as "Pedcompra", "Adt_ext" as "Adt_ext", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Adt_hora" as "Adt_hora", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Cotll" as "Talle", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_comp" as "Adt_comp", "Adt_ent" as "Adt_ent", "Adt_cod" as "Adt_cod", "Cocol" as "Color", "Cocod" as "Codigo", "Coart" as "Articulo" from ZooLogic.ADT_COMB where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_COMB.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKCOMBINACION', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Adt_fecha" as "Adt_fecha", "Fectrans" as "Fechatransferencia", "Corigprepa" as "Preparadooriginal", "Preparado" as "Preparado", "Corigpedid" as "Pedidooriginal", "Corigpreco" as "Precompraoriginal", "Precompra" as "Precompra", "Corigpresu" as "Presupuestadooriginal", "Corigsenia" as "Seniadooriginal", "Solcompra" as "Solcompra", "Corigsolco" as "Solcompraoriginal", "Seniado" as "Seniado", "Pedido" as "Pedido", "Reqcompra" as "Reqcompra", "Corigreqco" as "Reqcompraoriginal", "Presupuest" as "Presupuestado", "Corig" as "Cantidadoriginal", "Corigpedco" as "Pedcompraoriginal", "Cocant" as "Cantidad", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal", "Pedcompra" as "Pedcompra", "Adt_ext" as "Adt_ext", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Adt_hora" as "Adt_hora", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Cotll" as "Talle", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_comp" as "Adt_comp", "Adt_ent" as "Adt_ent", "Adt_cod" as "Adt_cod", "Cocol" as "Color", "Cocod" as "Codigo", "Coart" as "Articulo" from ZooLogic.ADT_COMB where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_COMB.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKCOMBINACION', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Adt_fecha" as "Adt_fecha", "Fectrans" as "Fechatransferencia", "Corigprepa" as "Preparadooriginal", "Preparado" as "Preparado", "Corigpedid" as "Pedidooriginal", "Corigpreco" as "Precompraoriginal", "Precompra" as "Precompra", "Corigpresu" as "Presupuestadooriginal", "Corigsenia" as "Seniadooriginal", "Solcompra" as "Solcompra", "Corigsolco" as "Solcompraoriginal", "Seniado" as "Seniado", "Pedido" as "Pedido", "Reqcompra" as "Reqcompra", "Corigreqco" as "Reqcompraoriginal", "Presupuest" as "Presupuestado", "Corig" as "Cantidadoriginal", "Corigpedco" as "Pedcompraoriginal", "Cocant" as "Cantidad", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal", "Pedcompra" as "Pedcompra", "Adt_ext" as "Adt_ext", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Adt_hora" as "Adt_hora", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Cotll" as "Talle", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_comp" as "Adt_comp", "Adt_ent" as "Adt_ent", "Adt_cod" as "Adt_cod", "Cocol" as "Color", "Cocod" as "Codigo", "Coart" as "Articulo" from ZooLogic.ADT_COMB where  ADT_COMB.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_STOCKCOMBINACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKCOMBINACION', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Faltafw,Fecexpo,Fmodifw,Adt_fecha,Fectrans,Corigprepa,Preparado,Corigpedid,Corigprec" + ;
"o,Precompra,Corigpresu,Corigsenia,Solcompra,Corigsolco,Seniado,Pedido,Reqcompra,Corigreqco,Presupues" + ;
"t,Corig,Corigpedco,Cocant,Entregapen,Corigentre,Pedcompra,Adt_ext,Hmodifw,Horaexpo,Horaimpo,Haltafw," + ;
"Saltafw,Umodifw,Vmodifw,Zadsfw,Adt_hora,Valtafw,Smodifw,Ualtafw,Esttrans,Adt_serie,Adt_vers,Cotll,Ad" + ;
"t_usr,Adt_adn,Bdaltafw,Bdmodifw,Adt_comp,Adt_ent,Adt_cod,Cocol,Cocod,Coart" + ;
" from ZooLogic.ADT_COMB where  ADT_COMB.ADT_COD != '' and " + lcFiltro )
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
			local  lxAdt_combFecimpo, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combFmodifw, lxAdt_combAdt_fecha, lxAdt_combFectrans, lxAdt_combCorigprepa, lxAdt_combPreparado, lxAdt_combCorigpedid, lxAdt_combCorigpreco, lxAdt_combPrecompra, lxAdt_combCorigpresu, lxAdt_combCorigsenia, lxAdt_combSolcompra, lxAdt_combCorigsolco, lxAdt_combSeniado, lxAdt_combPedido, lxAdt_combReqcompra, lxAdt_combCorigreqco, lxAdt_combPresupuest, lxAdt_combCorig, lxAdt_combCorigpedco, lxAdt_combCocant, lxAdt_combEntregapen, lxAdt_combCorigentre, lxAdt_combPedcompra, lxAdt_combAdt_ext, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combHoraimpo, lxAdt_combHaltafw, lxAdt_combSaltafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combAdt_hora, lxAdt_combValtafw, lxAdt_combSmodifw, lxAdt_combUaltafw, lxAdt_combEsttrans, lxAdt_combAdt_serie, lxAdt_combAdt_vers, lxAdt_combCotll, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combBdaltafw, lxAdt_combBdmodifw, lxAdt_combAdt_comp, lxAdt_combAdt_ent, lxAdt_combAdt_cod, lxAdt_combCocol, lxAdt_combCocod, lxAdt_combCoart
				lxAdt_combFecimpo = ctod( '  /  /    ' )			lxAdt_combFaltafw = ctod( '  /  /    ' )			lxAdt_combFecexpo = ctod( '  /  /    ' )			lxAdt_combFmodifw = ctod( '  /  /    ' )			lxAdt_combAdt_fecha = ctod( '  /  /    ' )			lxAdt_combFectrans = ctod( '  /  /    ' )			lxAdt_combCorigprepa = 0			lxAdt_combPreparado = 0			lxAdt_combCorigpedid = 0			lxAdt_combCorigpreco = 0			lxAdt_combPrecompra = 0			lxAdt_combCorigpresu = 0			lxAdt_combCorigsenia = 0			lxAdt_combSolcompra = 0			lxAdt_combCorigsolco = 0			lxAdt_combSeniado = 0			lxAdt_combPedido = 0			lxAdt_combReqcompra = 0			lxAdt_combCorigreqco = 0			lxAdt_combPresupuest = 0			lxAdt_combCorig = 0			lxAdt_combCorigpedco = 0			lxAdt_combCocant = 0			lxAdt_combEntregapen = 0			lxAdt_combCorigentre = 0			lxAdt_combPedcompra = 0			lxAdt_combAdt_ext = .F.			lxAdt_combHmodifw = []			lxAdt_combHoraexpo = []			lxAdt_combHoraimpo = []			lxAdt_combHaltafw = []			lxAdt_combSaltafw = []			lxAdt_combUmodifw = []			lxAdt_combVmodifw = []			lxAdt_combZadsfw = []			lxAdt_combAdt_hora = []			lxAdt_combValtafw = []			lxAdt_combSmodifw = []			lxAdt_combUaltafw = []			lxAdt_combEsttrans = []			lxAdt_combAdt_serie = []			lxAdt_combAdt_vers = []			lxAdt_combCotll = []			lxAdt_combAdt_usr = []			lxAdt_combAdt_adn = []			lxAdt_combBdaltafw = []			lxAdt_combBdmodifw = []			lxAdt_combAdt_comp = []			lxAdt_combAdt_ent = []			lxAdt_combAdt_cod = []			lxAdt_combCocol = []			lxAdt_combCocod = []			lxAdt_combCoart = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ADT_COMB where "ADT_Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ADT_COMB' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where ADT_Cod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(ADT_Cod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ADT_COMB.ADT_COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Adt_fecha" as "Adt_fecha", "Fectrans" as "Fechatransferencia", "Corigprepa" as "Preparadooriginal", "Preparado" as "Preparado", "Corigpedid" as "Pedidooriginal", "Corigpreco" as "Precompraoriginal", "Precompra" as "Precompra", "Corigpresu" as "Presupuestadooriginal", "Corigsenia" as "Seniadooriginal", "Solcompra" as "Solcompra", "Corigsolco" as "Solcompraoriginal", "Seniado" as "Seniado", "Pedido" as "Pedido", "Reqcompra" as "Reqcompra", "Corigreqco" as "Reqcompraoriginal", "Presupuest" as "Presupuestado", "Corig" as "Cantidadoriginal", "Corigpedco" as "Pedcompraoriginal", "Cocant" as "Cantidad", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal", "Pedcompra" as "Pedcompra", "Adt_ext" as "Adt_ext", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Adt_hora" as "Adt_hora", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Cotll" as "Talle", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_comp" as "Adt_comp", "Adt_ent" as "Adt_ent", "Adt_cod" as "Adt_cod", "Cocol" as "Color", "Cocod" as "Codigo", "Coart" as "Articulo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ADT_COMB', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'ADT_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_FECHA AS ADT_FECHA'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'PREPARADOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPREPA AS PREPARADOORIGINAL'
				Case lcAtributo == 'PREPARADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PREPARADO AS PREPARADO'
				Case lcAtributo == 'PEDIDOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPEDID AS PEDIDOORIGINAL'
				Case lcAtributo == 'PRECOMPRAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPRECO AS PRECOMPRAORIGINAL'
				Case lcAtributo == 'PRECOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECOMPRA AS PRECOMPRA'
				Case lcAtributo == 'PRESUPUESTADOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPRESU AS PRESUPUESTADOORIGINAL'
				Case lcAtributo == 'SENIADOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGSENIA AS SENIADOORIGINAL'
				Case lcAtributo == 'SOLCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SOLCOMPRA AS SOLCOMPRA'
				Case lcAtributo == 'SOLCOMPRAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGSOLCO AS SOLCOMPRAORIGINAL'
				Case lcAtributo == 'SENIADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIADO AS SENIADO'
				Case lcAtributo == 'PEDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEDIDO AS PEDIDO'
				Case lcAtributo == 'REQCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REQCOMPRA AS REQCOMPRA'
				Case lcAtributo == 'REQCOMPRAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGREQCO AS REQCOMPRAORIGINAL'
				Case lcAtributo == 'PRESUPUESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRESUPUEST AS PRESUPUESTADO'
				Case lcAtributo == 'CANTIDADORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIG AS CANTIDADORIGINAL'
				Case lcAtributo == 'PEDCOMPRAORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPEDCO AS PEDCOMPRAORIGINAL'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCANT AS CANTIDAD'
				Case lcAtributo == 'ENTREGAPEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTREGAPEN AS ENTREGAPEN'
				Case lcAtributo == 'ENTREGAPENORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGENTRE AS ENTREGAPENORIGINAL'
				Case lcAtributo == 'PEDCOMPRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEDCOMPRA AS PEDCOMPRA'
				Case lcAtributo == 'ADT_EXT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_EXT AS ADT_EXT'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ADT_HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_HORA AS ADT_HORA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'ADT_SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_SERIE AS ADT_SERIE'
				Case lcAtributo == 'ADT_VERS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_VERS AS ADT_VERS'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTLL AS TALLE'
				Case lcAtributo == 'ADT_USR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_USR AS ADT_USR'
				Case lcAtributo == 'ADT_ADN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ADN AS ADT_ADN'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ADT_COMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COMP AS ADT_COMP'
				Case lcAtributo == 'ADT_ENT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ENT AS ADT_ENT'
				Case lcAtributo == 'ADT_COD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COD AS ADT_COD'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOL AS COLOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOD AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COART AS ARTICULO'
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
			Case upper( alltrim( tcAtributo ) ) == 'ADT_FECHA'
				lcCampo = 'ADT_FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'PREPARADOORIGINAL'
				lcCampo = 'CORIGPREPA'
			Case upper( alltrim( tcAtributo ) ) == 'PREPARADO'
				lcCampo = 'PREPARADO'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDOORIGINAL'
				lcCampo = 'CORIGPEDID'
			Case upper( alltrim( tcAtributo ) ) == 'PRECOMPRAORIGINAL'
				lcCampo = 'CORIGPRECO'
			Case upper( alltrim( tcAtributo ) ) == 'PRECOMPRA'
				lcCampo = 'PRECOMPRA'
			Case upper( alltrim( tcAtributo ) ) == 'PRESUPUESTADOORIGINAL'
				lcCampo = 'CORIGPRESU'
			Case upper( alltrim( tcAtributo ) ) == 'SENIADOORIGINAL'
				lcCampo = 'CORIGSENIA'
			Case upper( alltrim( tcAtributo ) ) == 'SOLCOMPRA'
				lcCampo = 'SOLCOMPRA'
			Case upper( alltrim( tcAtributo ) ) == 'SOLCOMPRAORIGINAL'
				lcCampo = 'CORIGSOLCO'
			Case upper( alltrim( tcAtributo ) ) == 'SENIADO'
				lcCampo = 'SENIADO'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDO'
				lcCampo = 'PEDIDO'
			Case upper( alltrim( tcAtributo ) ) == 'REQCOMPRA'
				lcCampo = 'REQCOMPRA'
			Case upper( alltrim( tcAtributo ) ) == 'REQCOMPRAORIGINAL'
				lcCampo = 'CORIGREQCO'
			Case upper( alltrim( tcAtributo ) ) == 'PRESUPUESTADO'
				lcCampo = 'PRESUPUEST'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADORIGINAL'
				lcCampo = 'CORIG'
			Case upper( alltrim( tcAtributo ) ) == 'PEDCOMPRAORIGINAL'
				lcCampo = 'CORIGPEDCO'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'COCANT'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPEN'
				lcCampo = 'ENTREGAPEN'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPENORIGINAL'
				lcCampo = 'CORIGENTRE'
			Case upper( alltrim( tcAtributo ) ) == 'PEDCOMPRA'
				lcCampo = 'PEDCOMPRA'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_EXT'
				lcCampo = 'ADT_EXT'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_HORA'
				lcCampo = 'ADT_HORA'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_SERIE'
				lcCampo = 'ADT_SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_VERS'
				lcCampo = 'ADT_VERS'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'COTLL'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_USR'
				lcCampo = 'ADT_USR'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ADN'
				lcCampo = 'ADT_ADN'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COMP'
				lcCampo = 'ADT_COMP'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ENT'
				lcCampo = 'ADT_ENT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COD'
				lcCampo = 'ADT_COD'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'COCOL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COCOD'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'COART'
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
			local  lxAdt_combFecimpo, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combFmodifw, lxAdt_combAdt_fecha, lxAdt_combFectrans, lxAdt_combCorigprepa, lxAdt_combPreparado, lxAdt_combCorigpedid, lxAdt_combCorigpreco, lxAdt_combPrecompra, lxAdt_combCorigpresu, lxAdt_combCorigsenia, lxAdt_combSolcompra, lxAdt_combCorigsolco, lxAdt_combSeniado, lxAdt_combPedido, lxAdt_combReqcompra, lxAdt_combCorigreqco, lxAdt_combPresupuest, lxAdt_combCorig, lxAdt_combCorigpedco, lxAdt_combCocant, lxAdt_combEntregapen, lxAdt_combCorigentre, lxAdt_combPedcompra, lxAdt_combAdt_ext, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combHoraimpo, lxAdt_combHaltafw, lxAdt_combSaltafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combAdt_hora, lxAdt_combValtafw, lxAdt_combSmodifw, lxAdt_combUaltafw, lxAdt_combEsttrans, lxAdt_combAdt_serie, lxAdt_combAdt_vers, lxAdt_combCotll, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combBdaltafw, lxAdt_combBdmodifw, lxAdt_combAdt_comp, lxAdt_combAdt_ent, lxAdt_combAdt_cod, lxAdt_combCocol, lxAdt_combCocod, lxAdt_combCoart
				lxAdt_combFecimpo =  .Fechaimpo			lxAdt_combFaltafw =  .Fechaaltafw			lxAdt_combFecexpo =  .Fechaexpo			lxAdt_combFmodifw =  .Fechamodificacionfw			lxAdt_combAdt_fecha =  .Adt_fecha			lxAdt_combFectrans =  .Fechatransferencia			lxAdt_combCorigprepa =  .Preparadooriginal			lxAdt_combPreparado =  .Preparado			lxAdt_combCorigpedid =  .Pedidooriginal			lxAdt_combCorigpreco =  .Precompraoriginal			lxAdt_combPrecompra =  .Precompra			lxAdt_combCorigpresu =  .Presupuestadooriginal			lxAdt_combCorigsenia =  .Seniadooriginal			lxAdt_combSolcompra =  .Solcompra			lxAdt_combCorigsolco =  .Solcompraoriginal			lxAdt_combSeniado =  .Seniado			lxAdt_combPedido =  .Pedido			lxAdt_combReqcompra =  .Reqcompra			lxAdt_combCorigreqco =  .Reqcompraoriginal			lxAdt_combPresupuest =  .Presupuestado			lxAdt_combCorig =  .Cantidadoriginal			lxAdt_combCorigpedco =  .Pedcompraoriginal			lxAdt_combCocant =  .Cantidad			lxAdt_combEntregapen =  .Entregapen			lxAdt_combCorigentre =  .Entregapenoriginal			lxAdt_combPedcompra =  .Pedcompra			lxAdt_combAdt_ext =  .Adt_ext			lxAdt_combHmodifw =  .Horamodificacionfw			lxAdt_combHoraexpo =  .Horaexpo			lxAdt_combHoraimpo =  .Horaimpo			lxAdt_combHaltafw =  .Horaaltafw			lxAdt_combSaltafw =  .Seriealtafw			lxAdt_combUmodifw =  .Usuariomodificacionfw			lxAdt_combVmodifw =  .Versionmodificacionfw			lxAdt_combZadsfw =  .Zadsfw			lxAdt_combAdt_hora =  .Adt_hora			lxAdt_combValtafw =  .Versionaltafw			lxAdt_combSmodifw =  .Seriemodificacionfw			lxAdt_combUaltafw =  .Usuarioaltafw			lxAdt_combEsttrans =  .Estadotransferencia			lxAdt_combAdt_serie =  .Adt_serie			lxAdt_combAdt_vers =  .Adt_vers			lxAdt_combCotll =  .Talle			lxAdt_combAdt_usr =  .Adt_usr			lxAdt_combAdt_adn =  .Adt_adn			lxAdt_combBdaltafw =  .Basededatosaltafw			lxAdt_combBdmodifw =  .Basededatosmodificacionfw			lxAdt_combAdt_comp =  .Adt_comp			lxAdt_combAdt_ent =  .Adt_ent			lxAdt_combAdt_cod =  .Adt_cod			lxAdt_combCocol =  upper( .Color_PK ) 			lxAdt_combCocod =  upper( .Codigo_PK ) 			lxAdt_combCoart =  upper( .Articulo_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ADT_COMB ( "Fecimpo","Faltafw","Fecexpo","Fmodifw","Adt_fecha","Fectrans","Corigprepa","Preparado","Corigpedid","Corigpreco","Precompra","Corigpresu","Corigsenia","Solcompra","Corigsolco","Seniado","Pedido","Reqcompra","Corigreqco","Presupuest","Corig","Corigpedco","Cocant","Entregapen","Corigentre","Pedcompra","Adt_ext","Hmodifw","Horaexpo","Horaimpo","Haltafw","Saltafw","Umodifw","Vmodifw","Zadsfw","Adt_hora","Valtafw","Smodifw","Ualtafw","Esttrans","Adt_serie","Adt_vers","Cotll","Adt_usr","Adt_adn","Bdaltafw","Bdmodifw","Adt_comp","Adt_ent","Adt_cod","Cocol","Cocod","Coart" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_combFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFectrans ) + "'" >>, <<lxAdt_combCorigprepa >>, <<lxAdt_combPreparado >>, <<lxAdt_combCorigpedid >>, <<lxAdt_combCorigpreco >>, <<lxAdt_combPrecompra >>, <<lxAdt_combCorigpresu >>, <<lxAdt_combCorigsenia >>, <<lxAdt_combSolcompra >>, <<lxAdt_combCorigsolco >>, <<lxAdt_combSeniado >>, <<lxAdt_combPedido >>, <<lxAdt_combReqcompra >>, <<lxAdt_combCorigreqco >>, <<lxAdt_combPresupuest >>, <<lxAdt_combCorig >>, <<lxAdt_combCorigpedco >>, <<lxAdt_combCocant >>, <<lxAdt_combEntregapen >>, <<lxAdt_combCorigentre >>, <<lxAdt_combPedcompra >>, <<iif( lxAdt_combAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_combHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCotll ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCocol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCoart ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ADT_COMB' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAdt_combFecimpo, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combFmodifw, lxAdt_combAdt_fecha, lxAdt_combFectrans, lxAdt_combCorigprepa, lxAdt_combPreparado, lxAdt_combCorigpedid, lxAdt_combCorigpreco, lxAdt_combPrecompra, lxAdt_combCorigpresu, lxAdt_combCorigsenia, lxAdt_combSolcompra, lxAdt_combCorigsolco, lxAdt_combSeniado, lxAdt_combPedido, lxAdt_combReqcompra, lxAdt_combCorigreqco, lxAdt_combPresupuest, lxAdt_combCorig, lxAdt_combCorigpedco, lxAdt_combCocant, lxAdt_combEntregapen, lxAdt_combCorigentre, lxAdt_combPedcompra, lxAdt_combAdt_ext, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combHoraimpo, lxAdt_combHaltafw, lxAdt_combSaltafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combAdt_hora, lxAdt_combValtafw, lxAdt_combSmodifw, lxAdt_combUaltafw, lxAdt_combEsttrans, lxAdt_combAdt_serie, lxAdt_combAdt_vers, lxAdt_combCotll, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combBdaltafw, lxAdt_combBdmodifw, lxAdt_combAdt_comp, lxAdt_combAdt_ent, lxAdt_combAdt_cod, lxAdt_combCocol, lxAdt_combCocod, lxAdt_combCoart
				lxAdt_combFecimpo =  .Fechaimpo			lxAdt_combFaltafw =  .Fechaaltafw			lxAdt_combFecexpo =  .Fechaexpo			lxAdt_combFmodifw =  .Fechamodificacionfw			lxAdt_combAdt_fecha =  .Adt_fecha			lxAdt_combFectrans =  .Fechatransferencia			lxAdt_combCorigprepa =  .Preparadooriginal			lxAdt_combPreparado =  .Preparado			lxAdt_combCorigpedid =  .Pedidooriginal			lxAdt_combCorigpreco =  .Precompraoriginal			lxAdt_combPrecompra =  .Precompra			lxAdt_combCorigpresu =  .Presupuestadooriginal			lxAdt_combCorigsenia =  .Seniadooriginal			lxAdt_combSolcompra =  .Solcompra			lxAdt_combCorigsolco =  .Solcompraoriginal			lxAdt_combSeniado =  .Seniado			lxAdt_combPedido =  .Pedido			lxAdt_combReqcompra =  .Reqcompra			lxAdt_combCorigreqco =  .Reqcompraoriginal			lxAdt_combPresupuest =  .Presupuestado			lxAdt_combCorig =  .Cantidadoriginal			lxAdt_combCorigpedco =  .Pedcompraoriginal			lxAdt_combCocant =  .Cantidad			lxAdt_combEntregapen =  .Entregapen			lxAdt_combCorigentre =  .Entregapenoriginal			lxAdt_combPedcompra =  .Pedcompra			lxAdt_combAdt_ext =  .Adt_ext			lxAdt_combHmodifw =  .Horamodificacionfw			lxAdt_combHoraexpo =  .Horaexpo			lxAdt_combHoraimpo =  .Horaimpo			lxAdt_combHaltafw =  .Horaaltafw			lxAdt_combSaltafw =  .Seriealtafw			lxAdt_combUmodifw =  .Usuariomodificacionfw			lxAdt_combVmodifw =  .Versionmodificacionfw			lxAdt_combZadsfw =  .Zadsfw			lxAdt_combAdt_hora =  .Adt_hora			lxAdt_combValtafw =  .Versionaltafw			lxAdt_combSmodifw =  .Seriemodificacionfw			lxAdt_combUaltafw =  .Usuarioaltafw			lxAdt_combEsttrans =  .Estadotransferencia			lxAdt_combAdt_serie =  .Adt_serie			lxAdt_combAdt_vers =  .Adt_vers			lxAdt_combCotll =  .Talle			lxAdt_combAdt_usr =  .Adt_usr			lxAdt_combAdt_adn =  .Adt_adn			lxAdt_combBdaltafw =  .Basededatosaltafw			lxAdt_combBdmodifw =  .Basededatosmodificacionfw			lxAdt_combAdt_comp =  .Adt_comp			lxAdt_combAdt_ent =  .Adt_ent			lxAdt_combAdt_cod =  .Adt_cod			lxAdt_combCocol =  upper( .Color_PK ) 			lxAdt_combCocod =  upper( .Codigo_PK ) 			lxAdt_combCoart =  upper( .Articulo_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_COMB.ADT_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ADT_COMB set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_combFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_combFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_combFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_combFmodifw ) + "'">>, "Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_combAdt_fecha ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_combFectrans ) + "'">>, "Corigprepa" = <<lxAdt_combCorigprepa>>, "Preparado" = <<lxAdt_combPreparado>>, "Corigpedid" = <<lxAdt_combCorigpedid>>, "Corigpreco" = <<lxAdt_combCorigpreco>>, "Precompra" = <<lxAdt_combPrecompra>>, "Corigpresu" = <<lxAdt_combCorigpresu>>, "Corigsenia" = <<lxAdt_combCorigsenia>>, "Solcompra" = <<lxAdt_combSolcompra>>, "Corigsolco" = <<lxAdt_combCorigsolco>>, "Seniado" = <<lxAdt_combSeniado>>, "Pedido" = <<lxAdt_combPedido>>, "Reqcompra" = <<lxAdt_combReqcompra>>, "Corigreqco" = <<lxAdt_combCorigreqco>>, "Presupuest" = <<lxAdt_combPresupuest>>, "Corig" = <<lxAdt_combCorig>>, "Corigpedco" = <<lxAdt_combCorigpedco>>, "Cocant" = <<lxAdt_combCocant>>, "Entregapen" = <<lxAdt_combEntregapen>>, "Corigentre" = <<lxAdt_combCorigentre>>, "Pedcompra" = <<lxAdt_combPedcompra>>, "Adt_ext" = <<iif( lxAdt_combAdt_ext, 1, 0 )>>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_combHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_combHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combHaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_combZadsfw ) + "'">>, "Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_hora ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_combValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_combUaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_combEsttrans ) + "'">>, "Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_serie ) + "'">>, "Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_vers ) + "'">>, "Cotll" = <<"'" + this.FormatearTextoSql( lxAdt_combCotll ) + "'">>, "Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_usr ) + "'">>, "Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_adn ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combBdmodifw ) + "'">>, "Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_comp ) + "'">>, "Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_ent ) + "'">>, "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'">>, "Cocol" = <<"'" + this.FormatearTextoSql( lxAdt_combCocol ) + "'">>, "Cocod" = <<"'" + this.FormatearTextoSql( lxAdt_combCocod ) + "'">>, "Coart" = <<"'" + this.FormatearTextoSql( lxAdt_combCoart ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ADT_COMB' 
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
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_COMB.ADT_COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ADT_COMB where ' + lcFiltro )
			loColeccion.cTabla = 'ADT_COMB' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ADT_COMB where  ADT_COMB.ADT_COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ADT_COMB where ADT_Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.ADT_COD ) + "'"+ " and  ADT_COMB.ADT_COD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKCOMBINACION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ADT_COMB Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ADT_COMB set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, ADT_Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, cOrigPREPA = ] + transform( &lcCursor..cOrigPREPA )+ [, PREPARADO = ] + transform( &lcCursor..PREPARADO )+ [, cOrigPEDID = ] + transform( &lcCursor..cOrigPEDID )+ [, cOrigPRECO = ] + transform( &lcCursor..cOrigPRECO )+ [, PRECOMPRA = ] + transform( &lcCursor..PRECOMPRA )+ [, cOrigPRESU = ] + transform( &lcCursor..cOrigPRESU )+ [, cOrigSENIA = ] + transform( &lcCursor..cOrigSENIA )+ [, SOLCOMPRA = ] + transform( &lcCursor..SOLCOMPRA )+ [, cOrigSOLCO = ] + transform( &lcCursor..cOrigSOLCO )+ [, SENIADO = ] + transform( &lcCursor..SENIADO )+ [, PEDIDO = ] + transform( &lcCursor..PEDIDO )+ [, REQCOMPRA = ] + transform( &lcCursor..REQCOMPRA )+ [, cOrigREQCO = ] + transform( &lcCursor..cOrigREQCO )+ [, PRESUPUEST = ] + transform( &lcCursor..PRESUPUEST )+ [, CORIG = ] + transform( &lcCursor..CORIG )+ [, cOrigPEDCO = ] + transform( &lcCursor..cOrigPEDCO )+ [, COCANT = ] + transform( &lcCursor..COCANT )+ [, EntregaPen = ] + transform( &lcCursor..EntregaPen )+ [, cOrigEntre = ] + transform( &lcCursor..cOrigEntre )+ [, PEDCOMPRA = ] + transform( &lcCursor..PEDCOMPRA )+ [, ADT_Ext = ] + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ADT_Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ADT_Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"+ [, ADT_Vers = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"+ [, COTLL = ] + "'" + this.FormatearTextoSql( &lcCursor..COTLL ) + "'"+ [, ADT_Usr = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'"+ [, ADT_ADN = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ADT_Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"+ [, ADT_Ent = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"+ [, ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'"+ [, COCOL = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'"+ [, COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'"+ [, COART = ] + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'" + [ Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FALTAFW, FECEXPO, FMODIFW, ADT_Fecha, FECTRANS, cOrigPREPA, PREPARADO, cOrigPEDID, cOrigPRECO, PRECOMPRA, cOrigPRESU, cOrigSENIA, SOLCOMPRA, cOrigSOLCO, SENIADO, PEDIDO, REQCOMPRA, cOrigREQCO, PRESUPUEST, CORIG, cOrigPEDCO, COCANT, EntregaPen, cOrigEntre, PEDCOMPRA, ADT_Ext, HMODIFW, HORAEXPO, HORAIMPO, HALTAFW, SALTAFW, UMODIFW, VMODIFW, ZADSFW, ADT_Hora, VALTAFW, SMODIFW, UALTAFW, ESTTRANS, ADT_Serie, ADT_Vers, COTLL, ADT_Usr, ADT_ADN, BDALTAFW, BDMODIFW, ADT_Comp, ADT_Ent, ADT_Cod, COCOL, COCOD, COART
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..cOrigPREPA )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..PREPARADO ) + ',' + transform( &lcCursor..cOrigPEDID ) + ',' + transform( &lcCursor..cOrigPRECO ) + ',' + transform( &lcCursor..PRECOMPRA ) + ',' + transform( &lcCursor..cOrigPRESU ) + ',' + transform( &lcCursor..cOrigSENIA ) + ',' + transform( &lcCursor..SOLCOMPRA ) + ',' + transform( &lcCursor..cOrigSOLCO ) + ',' + transform( &lcCursor..SENIADO ) + ',' + transform( &lcCursor..PEDIDO )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..REQCOMPRA ) + ',' + transform( &lcCursor..cOrigREQCO ) + ',' + transform( &lcCursor..PRESUPUEST ) + ',' + transform( &lcCursor..CORIG ) + ',' + transform( &lcCursor..cOrigPEDCO ) + ',' + transform( &lcCursor..COCANT ) + ',' + transform( &lcCursor..EntregaPen ) + ',' + transform( &lcCursor..cOrigEntre ) + ',' + transform( &lcCursor..PEDCOMPRA ) + ',' + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COTLL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ADT_COMB ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKCOMBINACION'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( ADT_Cod C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..ADT_Cod    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ADT_STOCKCOMBINACION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ADT_STOCKCOMBINACION_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ADT_COMB')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ADT_STOCKCOMBINACION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ADT_Cod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ADT_STOCKCOMBINACION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKCOMBINACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,ADT_Cod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( ADT_Cod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKCOMBINACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  ADT_Fecha 
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_COMB') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_COMB
Create Table ZooLogic.TablaTrabajo_ADT_COMB ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"adt_fecha" datetime  null, 
"fectrans" datetime  null, 
"corigprepa" numeric( 9, 0 )  null, 
"preparado" numeric( 9, 0 )  null, 
"corigpedid" numeric( 9, 0 )  null, 
"corigpreco" numeric( 9, 0 )  null, 
"precompra" numeric( 9, 0 )  null, 
"corigpresu" numeric( 9, 0 )  null, 
"corigsenia" numeric( 9, 0 )  null, 
"solcompra" numeric( 9, 0 )  null, 
"corigsolco" numeric( 9, 0 )  null, 
"seniado" numeric( 9, 0 )  null, 
"pedido" numeric( 9, 0 )  null, 
"reqcompra" numeric( 9, 0 )  null, 
"corigreqco" numeric( 9, 0 )  null, 
"presupuest" numeric( 9, 0 )  null, 
"corig" numeric( 9, 0 )  null, 
"corigpedco" numeric( 9, 0 )  null, 
"cocant" numeric( 9, 0 )  null, 
"entregapen" numeric( 15, 2 )  null, 
"corigentre" numeric( 15, 2 )  null, 
"pedcompra" numeric( 9, 0 )  null, 
"adt_ext" bit  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"adt_hora" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"adt_serie" char( 20 )  null, 
"adt_vers" char( 13 )  null, 
"cotll" char( 3 )  null, 
"adt_usr" char( 100 )  null, 
"adt_adn" char( 10 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"adt_comp" char( 254 )  null, 
"adt_ent" char( 40 )  null, 
"adt_cod" char( 38 )  null, 
"cocol" char( 2 )  null, 
"cocod" char( 18 )  null, 
"coart" char( 13 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ADT_COMB' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ADT_COMB' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKCOMBINACION'
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
			.AgregarMapeo('adt_fecha','adt_fecha')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('corigprepa','corigprepa')
			.AgregarMapeo('preparado','preparado')
			.AgregarMapeo('corigpedid','corigpedid')
			.AgregarMapeo('corigpreco','corigpreco')
			.AgregarMapeo('precompra','precompra')
			.AgregarMapeo('corigpresu','corigpresu')
			.AgregarMapeo('corigsenia','corigsenia')
			.AgregarMapeo('solcompra','solcompra')
			.AgregarMapeo('corigsolco','corigsolco')
			.AgregarMapeo('seniado','seniado')
			.AgregarMapeo('pedido','pedido')
			.AgregarMapeo('reqcompra','reqcompra')
			.AgregarMapeo('corigreqco','corigreqco')
			.AgregarMapeo('presupuest','presupuest')
			.AgregarMapeo('corig','corig')
			.AgregarMapeo('corigpedco','corigpedco')
			.AgregarMapeo('cocant','cocant')
			.AgregarMapeo('entregapen','entregapen')
			.AgregarMapeo('corigentre','corigentre')
			.AgregarMapeo('pedcompra','pedcompra')
			.AgregarMapeo('adt_ext','adt_ext')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('adt_hora','adt_hora')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('adt_serie','adt_serie')
			.AgregarMapeo('adt_vers','adt_vers')
			.AgregarMapeo('cotll','cotll')
			.AgregarMapeo('adt_usr','adt_usr')
			.AgregarMapeo('adt_adn','adt_adn')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('adt_comp','adt_comp')
			.AgregarMapeo('adt_ent','adt_ent')
			.AgregarMapeo('adt_cod','adt_cod')
			.AgregarMapeo('cocol','cocol')
			.AgregarMapeo('cocod','cocod')
			.AgregarMapeo('coart','coart')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ADT_COMB'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.ADT_FECHA = isnull( d.ADT_FECHA, t.ADT_FECHA ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.CORIGPREPA = isnull( d.CORIGPREPA, t.CORIGPREPA ),t.PREPARADO = isnull( d.PREPARADO, t.PREPARADO ),t.CORIGPEDID = isnull( d.CORIGPEDID, t.CORIGPEDID ),t.CORIGPRECO = isnull( d.CORIGPRECO, t.CORIGPRECO ),t.PRECOMPRA = isnull( d.PRECOMPRA, t.PRECOMPRA ),t.CORIGPRESU = isnull( d.CORIGPRESU, t.CORIGPRESU ),t.CORIGSENIA = isnull( d.CORIGSENIA, t.CORIGSENIA ),t.SOLCOMPRA = isnull( d.SOLCOMPRA, t.SOLCOMPRA ),t.CORIGSOLCO = isnull( d.CORIGSOLCO, t.CORIGSOLCO ),t.SENIADO = isnull( d.SENIADO, t.SENIADO ),t.PEDIDO = isnull( d.PEDIDO, t.PEDIDO ),t.REQCOMPRA = isnull( d.REQCOMPRA, t.REQCOMPRA ),t.CORIGREQCO = isnull( d.CORIGREQCO, t.CORIGREQCO ),t.PRESUPUEST = isnull( d.PRESUPUEST, t.PRESUPUEST ),t.CORIG = isnull( d.CORIG, t.CORIG ),t.CORIGPEDCO = isnull( d.CORIGPEDCO, t.CORIGPEDCO ),t.COCANT = isnull( d.COCANT, t.COCANT ),t.ENTREGAPEN = isnull( d.ENTREGAPEN, t.ENTREGAPEN ),t.CORIGENTRE = isnull( d.CORIGENTRE, t.CORIGENTRE ),t.PEDCOMPRA = isnull( d.PEDCOMPRA, t.PEDCOMPRA ),t.ADT_EXT = isnull( d.ADT_EXT, t.ADT_EXT ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ADT_HORA = isnull( d.ADT_HORA, t.ADT_HORA ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.ADT_SERIE = isnull( d.ADT_SERIE, t.ADT_SERIE ),t.ADT_VERS = isnull( d.ADT_VERS, t.ADT_VERS ),t.COTLL = isnull( d.COTLL, t.COTLL ),t.ADT_USR = isnull( d.ADT_USR, t.ADT_USR ),t.ADT_ADN = isnull( d.ADT_ADN, t.ADT_ADN ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ADT_COMP = isnull( d.ADT_COMP, t.ADT_COMP ),t.ADT_ENT = isnull( d.ADT_ENT, t.ADT_ENT ),t.ADT_COD = isnull( d.ADT_COD, t.ADT_COD ),t.COCOL = isnull( d.COCOL, t.COCOL ),t.COCOD = isnull( d.COCOD, t.COCOD ),t.COART = isnull( d.COART, t.COART )
					from ZooLogic.ADT_COMB t inner join deleted d 
							 on t.ADT_Cod = d.ADT_Cod
				-- Fin Updates
				insert into ZooLogic.ADT_COMB(Fecimpo,Faltafw,Fecexpo,Fmodifw,Adt_fecha,Fectrans,Corigprepa,Preparado,Corigpedid,Corigpreco,Precompra,Corigpresu,Corigsenia,Solcompra,Corigsolco,Seniado,Pedido,Reqcompra,Corigreqco,Presupuest,Corig,Corigpedco,Cocant,Entregapen,Corigentre,Pedcompra,Adt_ext,Hmodifw,Horaexpo,Horaimpo,Haltafw,Saltafw,Umodifw,Vmodifw,Zadsfw,Adt_hora,Valtafw,Smodifw,Ualtafw,Esttrans,Adt_serie,Adt_vers,Cotll,Adt_usr,Adt_adn,Bdaltafw,Bdmodifw,Adt_comp,Adt_ent,Adt_cod,Cocol,Cocod,Coart)
					Select isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.ADT_FECHA,''),isnull( d.FECTRANS,''),isnull( d.CORIGPREPA,0),isnull( d.PREPARADO,0),isnull( d.CORIGPEDID,0),isnull( d.CORIGPRECO,0),isnull( d.PRECOMPRA,0),isnull( d.CORIGPRESU,0),isnull( d.CORIGSENIA,0),isnull( d.SOLCOMPRA,0),isnull( d.CORIGSOLCO,0),isnull( d.SENIADO,0),isnull( d.PEDIDO,0),isnull( d.REQCOMPRA,0),isnull( d.CORIGREQCO,0),isnull( d.PRESUPUEST,0),isnull( d.CORIG,0),isnull( d.CORIGPEDCO,0),isnull( d.COCANT,0),isnull( d.ENTREGAPEN,0),isnull( d.CORIGENTRE,0),isnull( d.PEDCOMPRA,0),isnull( d.ADT_EXT,0),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.ADT_HORA,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.ADT_SERIE,''),isnull( d.ADT_VERS,''),isnull( d.COTLL,''),isnull( d.ADT_USR,''),isnull( d.ADT_ADN,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ADT_COMP,''),isnull( d.ADT_ENT,''),isnull( d.ADT_COD,''),isnull( d.COCOL,''),isnull( d.COCOD,''),isnull( d.COART,'')
						From deleted d left join ZooLogic.ADT_COMB pk 
							 on d.ADT_Cod = pk.ADT_Cod
						Where pk.ADT_Cod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_COMB') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_COMB
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ADT_STOCKCOMBINACION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Adt_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Adt_fecha, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Preparadooriginal = nvl( c_ADT_STOCKCOMBINACION.Preparadooriginal, 0 )
					.Preparado = nvl( c_ADT_STOCKCOMBINACION.Preparado, 0 )
					.Pedidooriginal = nvl( c_ADT_STOCKCOMBINACION.Pedidooriginal, 0 )
					.Precompraoriginal = nvl( c_ADT_STOCKCOMBINACION.Precompraoriginal, 0 )
					.Precompra = nvl( c_ADT_STOCKCOMBINACION.Precompra, 0 )
					.Presupuestadooriginal = nvl( c_ADT_STOCKCOMBINACION.Presupuestadooriginal, 0 )
					.Seniadooriginal = nvl( c_ADT_STOCKCOMBINACION.Seniadooriginal, 0 )
					.Solcompra = nvl( c_ADT_STOCKCOMBINACION.Solcompra, 0 )
					.Solcompraoriginal = nvl( c_ADT_STOCKCOMBINACION.Solcompraoriginal, 0 )
					.Seniado = nvl( c_ADT_STOCKCOMBINACION.Seniado, 0 )
					.Pedido = nvl( c_ADT_STOCKCOMBINACION.Pedido, 0 )
					.Reqcompra = nvl( c_ADT_STOCKCOMBINACION.Reqcompra, 0 )
					.Reqcompraoriginal = nvl( c_ADT_STOCKCOMBINACION.Reqcompraoriginal, 0 )
					.Presupuestado = nvl( c_ADT_STOCKCOMBINACION.Presupuestado, 0 )
					.Cantidadoriginal = nvl( c_ADT_STOCKCOMBINACION.Cantidadoriginal, 0 )
					.Pedcompraoriginal = nvl( c_ADT_STOCKCOMBINACION.Pedcompraoriginal, 0 )
					.Cantidad = nvl( c_ADT_STOCKCOMBINACION.Cantidad, 0 )
					.Entregapen = nvl( c_ADT_STOCKCOMBINACION.Entregapen, 0 )
					.Entregapenoriginal = nvl( c_ADT_STOCKCOMBINACION.Entregapenoriginal, 0 )
					.Pedcompra = nvl( c_ADT_STOCKCOMBINACION.Pedcompra, 0 )
					.Adt_ext = nvl( c_ADT_STOCKCOMBINACION.Adt_ext, .F. )
					.Horamodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_ADT_STOCKCOMBINACION.Horaexpo, [] )
					.Horaimpo = nvl( c_ADT_STOCKCOMBINACION.Horaimpo, [] )
					.Horaaltafw = nvl( c_ADT_STOCKCOMBINACION.Horaaltafw, [] )
					.Seriealtafw = nvl( c_ADT_STOCKCOMBINACION.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Adt_hora = nvl( c_ADT_STOCKCOMBINACION.Adt_hora, [] )
					.Versionaltafw = nvl( c_ADT_STOCKCOMBINACION.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_ADT_STOCKCOMBINACION.Usuarioaltafw, [] )
					.Estadotransferencia = nvl( c_ADT_STOCKCOMBINACION.Estadotransferencia, [] )
					.Adt_serie = nvl( c_ADT_STOCKCOMBINACION.Adt_serie, [] )
					.Adt_vers = nvl( c_ADT_STOCKCOMBINACION.Adt_vers, [] )
					.Talle = nvl( c_ADT_STOCKCOMBINACION.Talle, [] )
					.Adt_usr = nvl( c_ADT_STOCKCOMBINACION.Adt_usr, [] )
					.Adt_adn = nvl( c_ADT_STOCKCOMBINACION.Adt_adn, [] )
					.Basededatosaltafw = nvl( c_ADT_STOCKCOMBINACION.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Basededatosmodificacionfw, [] )
					.Adt_comp = nvl( c_ADT_STOCKCOMBINACION.Adt_comp, [] )
					.Adt_ent = nvl( c_ADT_STOCKCOMBINACION.Adt_ent, [] )
					.Adt_cod = nvl( c_ADT_STOCKCOMBINACION.Adt_cod, [] )
					.Color_PK =  nvl( c_ADT_STOCKCOMBINACION.Color, [] )
					.Codigo_PK =  nvl( c_ADT_STOCKCOMBINACION.Codigo, [] )
					.Articulo_PK =  nvl( c_ADT_STOCKCOMBINACION.Articulo, [] )
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
		return c_ADT_STOCKCOMBINACION.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.ADT_COMB' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ADT_Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,ADT_Cod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    ADT_Cod from (
							select * 
								from ZooLogic.ADT_COMB 
								Where   ADT_COMB.ADT_COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ADT_COMB", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ADT_Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Adt_fecha" as "Adt_fecha", "Fectrans" as "Fechatransferencia", "Corigprepa" as "Preparadooriginal", "Preparado" as "Preparado", "Corigpedid" as "Pedidooriginal", "Corigpreco" as "Precompraoriginal", "Precompra" as "Precompra", "Corigpresu" as "Presupuestadooriginal", "Corigsenia" as "Seniadooriginal", "Solcompra" as "Solcompra", "Corigsolco" as "Solcompraoriginal", "Seniado" as "Seniado", "Pedido" as "Pedido", "Reqcompra" as "Reqcompra", "Corigreqco" as "Reqcompraoriginal", "Presupuest" as "Presupuestado", "Corig" as "Cantidadoriginal", "Corigpedco" as "Pedcompraoriginal", "Cocant" as "Cantidad", "Entregapen" as "Entregapen", "Corigentre" as "Entregapenoriginal", "Pedcompra" as "Pedcompra", "Adt_ext" as "Adt_ext", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Adt_hora" as "Adt_hora", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Cotll" as "Talle", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_comp" as "Adt_comp", "Adt_ent" as "Adt_ent", "Adt_cod" as "Adt_cod", "Cocol" as "Color", "Cocod" as "Codigo", "Coart" as "Articulo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ADT_COMB 
								Where   ADT_COMB.ADT_COD != ''
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
	Tabla = 'ADT_COMB'
	Filtro = " ADT_COMB.ADT_COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ADT_COMB.ADT_COD != ''"
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
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="FECHAIMPO                               " tabla="ADT_COMB       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="FECHAALTAFW                             " tabla="ADT_COMB       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="FECHAEXPO                               " tabla="ADT_COMB       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="FECHAMODIFICACIONFW                     " tabla="ADT_COMB       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_FECHA                               " tabla="ADT_COMB       " campo="ADT_FECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="FECHATRANSFERENCIA                      " tabla="ADT_COMB       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PREPARADOORIGINAL                       " tabla="ADT_COMB       " campo="CORIGPREPA" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="cOrigPREPARADO                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PREPARADO                               " tabla="ADT_COMB       " campo="PREPARADO " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="PREPARADO                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PEDIDOORIGINAL                          " tabla="ADT_COMB       " campo="CORIGPEDID" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="cOrigPEDIDO                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PRECOMPRAORIGINAL                       " tabla="ADT_COMB       " campo="CORIGPRECO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="cOrigPRECOMPRA                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PRECOMPRA                               " tabla="ADT_COMB       " campo="PRECOMPRA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="PRECOMPRA                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PRESUPUESTADOORIGINAL                   " tabla="ADT_COMB       " campo="CORIGPRESU" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="cOrigPRESUPUESTADO                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SENIADOORIGINAL                         " tabla="ADT_COMB       " campo="CORIGSENIA" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="cOrigSENIADO                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SOLCOMPRA                               " tabla="ADT_COMB       " campo="SOLCOMPRA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="SOLCOMPRA                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SOLCOMPRAORIGINAL                       " tabla="ADT_COMB       " campo="CORIGSOLCO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="cOrigSOLCOMPRA                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SENIADO                                 " tabla="ADT_COMB       " campo="SENIADO   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="SENIADO                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PEDIDO                                  " tabla="ADT_COMB       " campo="PEDIDO    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="PEDIDO                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="REQCOMPRA                               " tabla="ADT_COMB       " campo="REQCOMPRA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="REQCOMPRA                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="REQCOMPRAORIGINAL                       " tabla="ADT_COMB       " campo="CORIGREQCO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="cOrigREQCOMPRA                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PRESUPUESTADO                           " tabla="ADT_COMB       " campo="PRESUPUEST" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="PRESUPUESTADO                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="CANTIDADORIGINAL                        " tabla="ADT_COMB       " campo="CORIG     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Cantidad Original                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PEDCOMPRAORIGINAL                       " tabla="ADT_COMB       " campo="CORIGPEDCO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="cOrigPEDCOMPRA                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="CANTIDAD                                " tabla="ADT_COMB       " campo="COCANT    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Cantidad en stock                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ENTREGAPEN                              " tabla="ADT_COMB       " campo="ENTREGAPEN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entrega pendiente                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ENTREGAPENORIGINAL                      " tabla="ADT_COMB       " campo="CORIGENTRE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entrega pendiente original                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PEDCOMPRA                               " tabla="ADT_COMB       " campo="PEDCOMPRA " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="PEDCOMPRA                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_EXT                                 " tabla="ADT_COMB       " campo="ADT_EXT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Información remota                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="HORAMODIFICACIONFW                      " tabla="ADT_COMB       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="HORAEXPO                                " tabla="ADT_COMB       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="HORAIMPO                                " tabla="ADT_COMB       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="HORAALTAFW                              " tabla="ADT_COMB       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SERIEALTAFW                             " tabla="ADT_COMB       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="USUARIOMODIFICACIONFW                   " tabla="ADT_COMB       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="VERSIONMODIFICACIONFW                   " tabla="ADT_COMB       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ZADSFW                                  " tabla="ADT_COMB       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_HORA                                " tabla="ADT_COMB       " campo="ADT_HORA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="VERSIONALTAFW                           " tabla="ADT_COMB       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SERIEMODIFICACIONFW                     " tabla="ADT_COMB       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="USUARIOALTAFW                           " tabla="ADT_COMB       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ESTADOTRANSFERENCIA                     " tabla="ADT_COMB       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_SERIE                               " tabla="ADT_COMB       " campo="ADT_SERIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_VERS                                " tabla="ADT_COMB       " campo="ADT_VERS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="TALLE                                   " tabla="ADT_COMB       " campo="COTLL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Talle                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_USR                                 " tabla="ADT_COMB       " campo="ADT_USR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_ADN                                 " tabla="ADT_COMB       " campo="ADT_ADN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="ADN                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="BASEDEDATOSALTAFW                       " tabla="ADT_COMB       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ADT_COMB       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_COMP                                " tabla="ADT_COMB       " campo="ADT_COMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_ENT                                 " tabla="ADT_COMB       " campo="ADT_ENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_COD                                 " tabla="ADT_COMB       " campo="ADT_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="COLOR                                   " tabla="ADT_COMB       " campo="COCOL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="CODIGO                                  " tabla="ADT_COMB       " campo="COCOD     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="STOCKCOMBINACION                        " tipodato="C         " longitud="18" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Stock combinacion                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ARTICULO                                " tabla="ADT_COMB       " campo="COART     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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