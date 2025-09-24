
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
			local  lxAdt_combFecimpo, lxAdt_combFectrans, lxAdt_combFmodifw, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combAdt_fecha, lxAdt_combHoraimpo, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combEsttrans, lxAdt_combHaltafw, lxAdt_combBdmodifw, lxAdt_combBdaltafw, lxAdt_combSaltafw, lxAdt_combUaltafw, lxAdt_combAdt_ent, lxAdt_combAdt_comp, lxAdt_combAdt_serie, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combAdt_hora, lxAdt_combAdt_vers, lxAdt_combValtafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combSmodifw, lxAdt_combCorigsenia, lxAdt_combPreparado, lxAdt_combEntregapen, lxAdt_combSeniado, lxAdt_combEntranorig, lxAdt_combEntransito, lxAdt_combCocant, lxAdt_combCorig, lxAdt_combPedcomp, lxAdt_combCorigentre, lxAdt_combCorigpedco, lxAdt_combCorigpresu, lxAdt_combCorigprepa, lxAdt_combPresupuest, lxAdt_combPedido, lxAdt_combCorigpedid, lxAdt_combAdt_ext, lxAdt_combCoart, lxAdt_combTalle, lxAdt_combCocod, lxAdt_combCocol, lxAdt_combAdt_cod
				lxAdt_combFecimpo =  .Fechaimpo			lxAdt_combFectrans =  .Fechatransferencia			lxAdt_combFmodifw =  .Fechamodificacionfw			lxAdt_combFaltafw =  .Fechaaltafw			lxAdt_combFecexpo =  .Fechaexpo			lxAdt_combAdt_fecha =  .Adt_fecha			lxAdt_combHoraimpo =  .Horaimpo			lxAdt_combHmodifw =  .Horamodificacionfw			lxAdt_combHoraexpo =  .Horaexpo			lxAdt_combEsttrans =  .Estadotransferencia			lxAdt_combHaltafw =  .Horaaltafw			lxAdt_combBdmodifw =  .Basededatosmodificacionfw			lxAdt_combBdaltafw =  .Basededatosaltafw			lxAdt_combSaltafw =  .Seriealtafw			lxAdt_combUaltafw =  .Usuarioaltafw			lxAdt_combAdt_ent =  .Adt_ent			lxAdt_combAdt_comp =  .Adt_comp			lxAdt_combAdt_serie =  .Adt_serie			lxAdt_combAdt_usr =  .Adt_usr			lxAdt_combAdt_adn =  .Adt_adn			lxAdt_combAdt_hora =  .Adt_hora			lxAdt_combAdt_vers =  .Adt_vers			lxAdt_combValtafw =  .Versionaltafw			lxAdt_combUmodifw =  .Usuariomodificacionfw			lxAdt_combVmodifw =  .Versionmodificacionfw			lxAdt_combZadsfw =  .Zadsfw			lxAdt_combSmodifw =  .Seriemodificacionfw			lxAdt_combCorigsenia =  .Seniadooriginal			lxAdt_combPreparado =  .Preparado			lxAdt_combEntregapen =  .Entregapen			lxAdt_combSeniado =  .Seniado			lxAdt_combEntranorig =  .Entransitooriginal			lxAdt_combEntransito =  .Entransito			lxAdt_combCocant =  .Cantidad			lxAdt_combCorig =  .Cantidadoriginal			lxAdt_combPedcomp =  .Pedcomp			lxAdt_combCorigentre =  .Entregapenoriginal			lxAdt_combCorigpedco =  .Pedcomporiginal			lxAdt_combCorigpresu =  .Presupuestadooriginal			lxAdt_combCorigprepa =  .Preparadooriginal			lxAdt_combPresupuest =  .Presupuestado			lxAdt_combPedido =  .Pedido			lxAdt_combCorigpedid =  .Pedidooriginal			lxAdt_combAdt_ext =  .Adt_ext			lxAdt_combCoart =  upper( .Articulo_PK ) 			lxAdt_combTalle =  upper( .Talle_PK ) 			lxAdt_combCocod =  upper( .Codigo_PK ) 			lxAdt_combCocol =  upper( .Color_PK ) 			lxAdt_combAdt_cod =  .Adt_cod
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
				insert into ZooLogic.ADT_COMB ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Adt_fecha","Horaimpo","Hmodifw","Horaexpo","Esttrans","Haltafw","Bdmodifw","Bdaltafw","Saltafw","Ualtafw","Adt_ent","Adt_comp","Adt_serie","Adt_usr","Adt_adn","Adt_hora","Adt_vers","Valtafw","Umodifw","Vmodifw","Zadsfw","Smodifw","Corigsenia","Preparado","Entregapen","Seniado","Entranorig","Entransito","Cocant","Corig","Pedcomp","Corigentre","Corigpedco","Corigpresu","Corigprepa","Presupuest","Pedido","Corigpedid","Adt_ext","Coart","Talle","Cocod","Cocol","Adt_cod" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_combFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combAdt_fecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combSmodifw ) + "'" >>, <<lxAdt_combCorigsenia >>, <<lxAdt_combPreparado >>, <<lxAdt_combEntregapen >>, <<lxAdt_combSeniado >>, <<lxAdt_combEntranorig >>, <<lxAdt_combEntransito >>, <<lxAdt_combCocant >>, <<lxAdt_combCorig >>, <<lxAdt_combPedcomp >>, <<lxAdt_combCorigentre >>, <<lxAdt_combCorigpedco >>, <<lxAdt_combCorigpresu >>, <<lxAdt_combCorigprepa >>, <<lxAdt_combPresupuest >>, <<lxAdt_combPedido >>, <<lxAdt_combCorigpedid >>, <<iif( lxAdt_combAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_combCoart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCocol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'" >> )
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
			local  lxAdt_combFecimpo, lxAdt_combFectrans, lxAdt_combFmodifw, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combAdt_fecha, lxAdt_combHoraimpo, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combEsttrans, lxAdt_combHaltafw, lxAdt_combBdmodifw, lxAdt_combBdaltafw, lxAdt_combSaltafw, lxAdt_combUaltafw, lxAdt_combAdt_ent, lxAdt_combAdt_comp, lxAdt_combAdt_serie, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combAdt_hora, lxAdt_combAdt_vers, lxAdt_combValtafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combSmodifw, lxAdt_combCorigsenia, lxAdt_combPreparado, lxAdt_combEntregapen, lxAdt_combSeniado, lxAdt_combEntranorig, lxAdt_combEntransito, lxAdt_combCocant, lxAdt_combCorig, lxAdt_combPedcomp, lxAdt_combCorigentre, lxAdt_combCorigpedco, lxAdt_combCorigpresu, lxAdt_combCorigprepa, lxAdt_combPresupuest, lxAdt_combPedido, lxAdt_combCorigpedid, lxAdt_combAdt_ext, lxAdt_combCoart, lxAdt_combTalle, lxAdt_combCocod, lxAdt_combCocol, lxAdt_combAdt_cod
				lxAdt_combFecimpo =  .Fechaimpo			lxAdt_combFectrans =  .Fechatransferencia			lxAdt_combFmodifw =  .Fechamodificacionfw			lxAdt_combFaltafw =  .Fechaaltafw			lxAdt_combFecexpo =  .Fechaexpo			lxAdt_combAdt_fecha =  .Adt_fecha			lxAdt_combHoraimpo =  .Horaimpo			lxAdt_combHmodifw =  .Horamodificacionfw			lxAdt_combHoraexpo =  .Horaexpo			lxAdt_combEsttrans =  .Estadotransferencia			lxAdt_combHaltafw =  .Horaaltafw			lxAdt_combBdmodifw =  .Basededatosmodificacionfw			lxAdt_combBdaltafw =  .Basededatosaltafw			lxAdt_combSaltafw =  .Seriealtafw			lxAdt_combUaltafw =  .Usuarioaltafw			lxAdt_combAdt_ent =  .Adt_ent			lxAdt_combAdt_comp =  .Adt_comp			lxAdt_combAdt_serie =  .Adt_serie			lxAdt_combAdt_usr =  .Adt_usr			lxAdt_combAdt_adn =  .Adt_adn			lxAdt_combAdt_hora =  .Adt_hora			lxAdt_combAdt_vers =  .Adt_vers			lxAdt_combValtafw =  .Versionaltafw			lxAdt_combUmodifw =  .Usuariomodificacionfw			lxAdt_combVmodifw =  .Versionmodificacionfw			lxAdt_combZadsfw =  .Zadsfw			lxAdt_combSmodifw =  .Seriemodificacionfw			lxAdt_combCorigsenia =  .Seniadooriginal			lxAdt_combPreparado =  .Preparado			lxAdt_combEntregapen =  .Entregapen			lxAdt_combSeniado =  .Seniado			lxAdt_combEntranorig =  .Entransitooriginal			lxAdt_combEntransito =  .Entransito			lxAdt_combCocant =  .Cantidad			lxAdt_combCorig =  .Cantidadoriginal			lxAdt_combPedcomp =  .Pedcomp			lxAdt_combCorigentre =  .Entregapenoriginal			lxAdt_combCorigpedco =  .Pedcomporiginal			lxAdt_combCorigpresu =  .Presupuestadooriginal			lxAdt_combCorigprepa =  .Preparadooriginal			lxAdt_combPresupuest =  .Presupuestado			lxAdt_combPedido =  .Pedido			lxAdt_combCorigpedid =  .Pedidooriginal			lxAdt_combAdt_ext =  .Adt_ext			lxAdt_combCoart =  upper( .Articulo_PK ) 			lxAdt_combTalle =  upper( .Talle_PK ) 			lxAdt_combCocod =  upper( .Codigo_PK ) 			lxAdt_combCocol =  upper( .Color_PK ) 			lxAdt_combAdt_cod =  .Adt_cod
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ADT_COD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ADT_COMB set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_combFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_combFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_combFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_combFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_combFecexpo ) + "'">>,"Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_combAdt_fecha ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_combHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_combHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_combEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combBdaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_combUaltafw ) + "'">>,"Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_ent ) + "'">>,"Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_comp ) + "'">>,"Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_serie ) + "'">>,"Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_usr ) + "'">>,"Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_adn ) + "'">>,"Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_hora ) + "'">>,"Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_vers ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_combValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_combZadsfw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combSmodifw ) + "'">>,"Corigsenia" = <<lxAdt_combCorigsenia>>,"Preparado" = <<lxAdt_combPreparado>>,"Entregapen" = <<lxAdt_combEntregapen>>,"Seniado" = <<lxAdt_combSeniado>>,"Entranorig" = <<lxAdt_combEntranorig>>,"Entransito" = <<lxAdt_combEntransito>>,"Cocant" = <<lxAdt_combCocant>>,"Corig" = <<lxAdt_combCorig>>,"Pedcomp" = <<lxAdt_combPedcomp>>,"Corigentre" = <<lxAdt_combCorigentre>>,"Corigpedco" = <<lxAdt_combCorigpedco>>,"Corigpresu" = <<lxAdt_combCorigpresu>>,"Corigprepa" = <<lxAdt_combCorigprepa>>,"Presupuest" = <<lxAdt_combPresupuest>>,"Pedido" = <<lxAdt_combPedido>>,"Corigpedid" = <<lxAdt_combCorigpedid>>,"Adt_ext" = <<iif( lxAdt_combAdt_ext, 1, 0 )>>,"Coart" = <<"'" + this.FormatearTextoSql( lxAdt_combCoart ) + "'">>,"Talle" = <<"'" + this.FormatearTextoSql( lxAdt_combTalle ) + "'">>,"Cocod" = <<"'" + this.FormatearTextoSql( lxAdt_combCocod ) + "'">>,"Cocol" = <<"'" + this.FormatearTextoSql( lxAdt_combCocol ) + "'">>,"Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'">> where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'">> and  ADT_COMB.ADT_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Adt_ent" as "Adt_ent", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Corigsenia" as "Seniadooriginal", "Preparado" as "Preparado", "Entregapen" as "Entregapen", "Seniado" as "Seniado", "Entranorig" as "Entransitooriginal", "Entransito" as "Entransito", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal", "Pedcomp" as "Pedcomp", "Corigentre" as "Entregapenoriginal", "Corigpedco" as "Pedcomporiginal", "Corigpresu" as "Presupuestadooriginal", "Corigprepa" as "Preparadooriginal", "Presupuest" as "Presupuestado", "Pedido" as "Pedido", "Corigpedid" as "Pedidooriginal", "Adt_ext" as "Adt_ext", "Coart" as "Articulo", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_COMB where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'">> and  ADT_COMB.ADT_COD != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Adt_ent" as "Adt_ent", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Corigsenia" as "Seniadooriginal", "Preparado" as "Preparado", "Entregapen" as "Entregapen", "Seniado" as "Seniado", "Entranorig" as "Entransitooriginal", "Entransito" as "Entransito", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal", "Pedcomp" as "Pedcomp", "Corigentre" as "Entregapenoriginal", "Corigpedco" as "Pedcomporiginal", "Corigpresu" as "Presupuestadooriginal", "Corigprepa" as "Preparadooriginal", "Presupuest" as "Presupuestado", "Pedido" as "Pedido", "Corigpedid" as "Pedidooriginal", "Adt_ext" as "Adt_ext", "Coart" as "Articulo", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_COMB where  ADT_COMB.ADT_COD != '' order by FALTAFW,HALTAFW
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Adt_ent" as "Adt_ent", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Corigsenia" as "Seniadooriginal", "Preparado" as "Preparado", "Entregapen" as "Entregapen", "Seniado" as "Seniado", "Entranorig" as "Entransitooriginal", "Entransito" as "Entransito", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal", "Pedcomp" as "Pedcomp", "Corigentre" as "Entregapenoriginal", "Corigpedco" as "Pedcomporiginal", "Corigpresu" as "Presupuestadooriginal", "Corigprepa" as "Preparadooriginal", "Presupuest" as "Presupuestado", "Pedido" as "Pedido", "Corigpedid" as "Pedidooriginal", "Adt_ext" as "Adt_ext", "Coart" as "Articulo", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_COMB where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_COMB.ADT_COD != '' order by FALTAFW,HALTAFW
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Adt_ent" as "Adt_ent", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Corigsenia" as "Seniadooriginal", "Preparado" as "Preparado", "Entregapen" as "Entregapen", "Seniado" as "Seniado", "Entranorig" as "Entransitooriginal", "Entransito" as "Entransito", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal", "Pedcomp" as "Pedcomp", "Corigentre" as "Entregapenoriginal", "Corigpedco" as "Pedcomporiginal", "Corigpresu" as "Presupuestadooriginal", "Corigprepa" as "Preparadooriginal", "Presupuest" as "Presupuestado", "Pedido" as "Pedido", "Corigpedid" as "Pedidooriginal", "Adt_ext" as "Adt_ext", "Coart" as "Articulo", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_COMB where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_COMB.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Adt_ent" as "Adt_ent", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Corigsenia" as "Seniadooriginal", "Preparado" as "Preparado", "Entregapen" as "Entregapen", "Seniado" as "Seniado", "Entranorig" as "Entransitooriginal", "Entransito" as "Entransito", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal", "Pedcomp" as "Pedcomp", "Corigentre" as "Entregapenoriginal", "Corigpedco" as "Pedcomporiginal", "Corigpresu" as "Presupuestadooriginal", "Corigprepa" as "Preparadooriginal", "Presupuest" as "Presupuestado", "Pedido" as "Pedido", "Corigpedid" as "Pedidooriginal", "Adt_ext" as "Adt_ext", "Coart" as "Articulo", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_COMB where  ADT_COMB.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Adt_fecha,Horaimpo,Hmodifw,Horaexpo,Esttrans,Haltaf" + ;
"w,Bdmodifw,Bdaltafw,Saltafw,Ualtafw,Adt_ent,Adt_comp,Adt_serie,Adt_usr,Adt_adn,Adt_hora,Adt_vers,Val" + ;
"tafw,Umodifw,Vmodifw,Zadsfw,Smodifw,Corigsenia,Preparado,Entregapen,Seniado,Entranorig,Entransito,Co" + ;
"cant,Corig,Pedcomp,Corigentre,Corigpedco,Corigpresu,Corigprepa,Presupuest,Pedido,Corigpedid,Adt_ext," + ;
"Coart,Talle,Cocod,Cocol,Adt_cod" + ;
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
			local  lxAdt_combFecimpo, lxAdt_combFectrans, lxAdt_combFmodifw, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combAdt_fecha, lxAdt_combHoraimpo, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combEsttrans, lxAdt_combHaltafw, lxAdt_combBdmodifw, lxAdt_combBdaltafw, lxAdt_combSaltafw, lxAdt_combUaltafw, lxAdt_combAdt_ent, lxAdt_combAdt_comp, lxAdt_combAdt_serie, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combAdt_hora, lxAdt_combAdt_vers, lxAdt_combValtafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combSmodifw, lxAdt_combCorigsenia, lxAdt_combPreparado, lxAdt_combEntregapen, lxAdt_combSeniado, lxAdt_combEntranorig, lxAdt_combEntransito, lxAdt_combCocant, lxAdt_combCorig, lxAdt_combPedcomp, lxAdt_combCorigentre, lxAdt_combCorigpedco, lxAdt_combCorigpresu, lxAdt_combCorigprepa, lxAdt_combPresupuest, lxAdt_combPedido, lxAdt_combCorigpedid, lxAdt_combAdt_ext, lxAdt_combCoart, lxAdt_combTalle, lxAdt_combCocod, lxAdt_combCocol, lxAdt_combAdt_cod
				lxAdt_combFecimpo = ctod( '  /  /    ' )			lxAdt_combFectrans = ctod( '  /  /    ' )			lxAdt_combFmodifw = ctod( '  /  /    ' )			lxAdt_combFaltafw = ctod( '  /  /    ' )			lxAdt_combFecexpo = ctod( '  /  /    ' )			lxAdt_combAdt_fecha = ctod( '  /  /    ' )			lxAdt_combHoraimpo = []			lxAdt_combHmodifw = []			lxAdt_combHoraexpo = []			lxAdt_combEsttrans = []			lxAdt_combHaltafw = []			lxAdt_combBdmodifw = []			lxAdt_combBdaltafw = []			lxAdt_combSaltafw = []			lxAdt_combUaltafw = []			lxAdt_combAdt_ent = []			lxAdt_combAdt_comp = []			lxAdt_combAdt_serie = []			lxAdt_combAdt_usr = []			lxAdt_combAdt_adn = []			lxAdt_combAdt_hora = []			lxAdt_combAdt_vers = []			lxAdt_combValtafw = []			lxAdt_combUmodifw = []			lxAdt_combVmodifw = []			lxAdt_combZadsfw = []			lxAdt_combSmodifw = []			lxAdt_combCorigsenia = 0			lxAdt_combPreparado = 0			lxAdt_combEntregapen = 0			lxAdt_combSeniado = 0			lxAdt_combEntranorig = 0			lxAdt_combEntransito = 0			lxAdt_combCocant = 0			lxAdt_combCorig = 0			lxAdt_combPedcomp = 0			lxAdt_combCorigentre = 0			lxAdt_combCorigpedco = 0			lxAdt_combCorigpresu = 0			lxAdt_combCorigprepa = 0			lxAdt_combPresupuest = 0			lxAdt_combPedido = 0			lxAdt_combCorigpedid = 0			lxAdt_combAdt_ext = .F.			lxAdt_combCoart = []			lxAdt_combTalle = []			lxAdt_combCocod = []			lxAdt_combCocol = []			lxAdt_combAdt_cod = []
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
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Adt_ent" as "Adt_ent", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Corigsenia" as "Seniadooriginal", "Preparado" as "Preparado", "Entregapen" as "Entregapen", "Seniado" as "Seniado", "Entranorig" as "Entransitooriginal", "Entransito" as "Entransito", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal", "Pedcomp" as "Pedcomp", "Corigentre" as "Entregapenoriginal", "Corigpedco" as "Pedcomporiginal", "Corigpresu" as "Presupuestadooriginal", "Corigprepa" as "Preparadooriginal", "Presupuest" as "Presupuestado", "Pedido" as "Pedido", "Corigpedid" as "Pedidooriginal", "Adt_ext" as "Adt_ext", "Coart" as "Articulo", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color", "Adt_cod" as "Adt_cod"
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'ADT_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_FECHA AS ADT_FECHA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ADT_ENT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ENT AS ADT_ENT'
				Case lcAtributo == 'ADT_COMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COMP AS ADT_COMP'
				Case lcAtributo == 'ADT_SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_SERIE AS ADT_SERIE'
				Case lcAtributo == 'ADT_USR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_USR AS ADT_USR'
				Case lcAtributo == 'ADT_ADN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ADN AS ADT_ADN'
				Case lcAtributo == 'ADT_HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_HORA AS ADT_HORA'
				Case lcAtributo == 'ADT_VERS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_VERS AS ADT_VERS'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SENIADOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGSENIA AS SENIADOORIGINAL'
				Case lcAtributo == 'PREPARADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PREPARADO AS PREPARADO'
				Case lcAtributo == 'ENTREGAPEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTREGAPEN AS ENTREGAPEN'
				Case lcAtributo == 'SENIADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIADO AS SENIADO'
				Case lcAtributo == 'ENTRANSITOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTRANORIG AS ENTRANSITOORIGINAL'
				Case lcAtributo == 'ENTRANSITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTRANSITO AS ENTRANSITO'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCANT AS CANTIDAD'
				Case lcAtributo == 'CANTIDADORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIG AS CANTIDADORIGINAL'
				Case lcAtributo == 'PEDCOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEDCOMP AS PEDCOMP'
				Case lcAtributo == 'ENTREGAPENORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGENTRE AS ENTREGAPENORIGINAL'
				Case lcAtributo == 'PEDCOMPORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPEDCO AS PEDCOMPORIGINAL'
				Case lcAtributo == 'PRESUPUESTADOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPRESU AS PRESUPUESTADOORIGINAL'
				Case lcAtributo == 'PREPARADOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPREPA AS PREPARADOORIGINAL'
				Case lcAtributo == 'PRESUPUESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRESUPUEST AS PRESUPUESTADO'
				Case lcAtributo == 'PEDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PEDIDO AS PEDIDO'
				Case lcAtributo == 'PEDIDOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIGPEDID AS PEDIDOORIGINAL'
				Case lcAtributo == 'ADT_EXT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_EXT AS ADT_EXT'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COART AS ARTICULO'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOD AS CODIGO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOL AS COLOR'
				Case lcAtributo == 'ADT_COD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COD AS ADT_COD'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_FECHA'
				lcCampo = 'ADT_FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ENT'
				lcCampo = 'ADT_ENT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COMP'
				lcCampo = 'ADT_COMP'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_SERIE'
				lcCampo = 'ADT_SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_USR'
				lcCampo = 'ADT_USR'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ADN'
				lcCampo = 'ADT_ADN'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_HORA'
				lcCampo = 'ADT_HORA'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_VERS'
				lcCampo = 'ADT_VERS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SENIADOORIGINAL'
				lcCampo = 'CORIGSENIA'
			Case upper( alltrim( tcAtributo ) ) == 'PREPARADO'
				lcCampo = 'PREPARADO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPEN'
				lcCampo = 'ENTREGAPEN'
			Case upper( alltrim( tcAtributo ) ) == 'SENIADO'
				lcCampo = 'SENIADO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTRANSITOORIGINAL'
				lcCampo = 'ENTRANORIG'
			Case upper( alltrim( tcAtributo ) ) == 'ENTRANSITO'
				lcCampo = 'ENTRANSITO'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'COCANT'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADORIGINAL'
				lcCampo = 'CORIG'
			Case upper( alltrim( tcAtributo ) ) == 'PEDCOMP'
				lcCampo = 'PEDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPENORIGINAL'
				lcCampo = 'CORIGENTRE'
			Case upper( alltrim( tcAtributo ) ) == 'PEDCOMPORIGINAL'
				lcCampo = 'CORIGPEDCO'
			Case upper( alltrim( tcAtributo ) ) == 'PRESUPUESTADOORIGINAL'
				lcCampo = 'CORIGPRESU'
			Case upper( alltrim( tcAtributo ) ) == 'PREPARADOORIGINAL'
				lcCampo = 'CORIGPREPA'
			Case upper( alltrim( tcAtributo ) ) == 'PRESUPUESTADO'
				lcCampo = 'PRESUPUEST'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDO'
				lcCampo = 'PEDIDO'
			Case upper( alltrim( tcAtributo ) ) == 'PEDIDOORIGINAL'
				lcCampo = 'CORIGPEDID'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_EXT'
				lcCampo = 'ADT_EXT'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'COART'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COCOD'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'COCOL'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COD'
				lcCampo = 'ADT_COD'
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
			local  lxAdt_combFecimpo, lxAdt_combFectrans, lxAdt_combFmodifw, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combAdt_fecha, lxAdt_combHoraimpo, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combEsttrans, lxAdt_combHaltafw, lxAdt_combBdmodifw, lxAdt_combBdaltafw, lxAdt_combSaltafw, lxAdt_combUaltafw, lxAdt_combAdt_ent, lxAdt_combAdt_comp, lxAdt_combAdt_serie, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combAdt_hora, lxAdt_combAdt_vers, lxAdt_combValtafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combSmodifw, lxAdt_combCorigsenia, lxAdt_combPreparado, lxAdt_combEntregapen, lxAdt_combSeniado, lxAdt_combEntranorig, lxAdt_combEntransito, lxAdt_combCocant, lxAdt_combCorig, lxAdt_combPedcomp, lxAdt_combCorigentre, lxAdt_combCorigpedco, lxAdt_combCorigpresu, lxAdt_combCorigprepa, lxAdt_combPresupuest, lxAdt_combPedido, lxAdt_combCorigpedid, lxAdt_combAdt_ext, lxAdt_combCoart, lxAdt_combTalle, lxAdt_combCocod, lxAdt_combCocol, lxAdt_combAdt_cod
				lxAdt_combFecimpo =  .Fechaimpo			lxAdt_combFectrans =  .Fechatransferencia			lxAdt_combFmodifw =  .Fechamodificacionfw			lxAdt_combFaltafw =  .Fechaaltafw			lxAdt_combFecexpo =  .Fechaexpo			lxAdt_combAdt_fecha =  .Adt_fecha			lxAdt_combHoraimpo =  .Horaimpo			lxAdt_combHmodifw =  .Horamodificacionfw			lxAdt_combHoraexpo =  .Horaexpo			lxAdt_combEsttrans =  .Estadotransferencia			lxAdt_combHaltafw =  .Horaaltafw			lxAdt_combBdmodifw =  .Basededatosmodificacionfw			lxAdt_combBdaltafw =  .Basededatosaltafw			lxAdt_combSaltafw =  .Seriealtafw			lxAdt_combUaltafw =  .Usuarioaltafw			lxAdt_combAdt_ent =  .Adt_ent			lxAdt_combAdt_comp =  .Adt_comp			lxAdt_combAdt_serie =  .Adt_serie			lxAdt_combAdt_usr =  .Adt_usr			lxAdt_combAdt_adn =  .Adt_adn			lxAdt_combAdt_hora =  .Adt_hora			lxAdt_combAdt_vers =  .Adt_vers			lxAdt_combValtafw =  .Versionaltafw			lxAdt_combUmodifw =  .Usuariomodificacionfw			lxAdt_combVmodifw =  .Versionmodificacionfw			lxAdt_combZadsfw =  .Zadsfw			lxAdt_combSmodifw =  .Seriemodificacionfw			lxAdt_combCorigsenia =  .Seniadooriginal			lxAdt_combPreparado =  .Preparado			lxAdt_combEntregapen =  .Entregapen			lxAdt_combSeniado =  .Seniado			lxAdt_combEntranorig =  .Entransitooriginal			lxAdt_combEntransito =  .Entransito			lxAdt_combCocant =  .Cantidad			lxAdt_combCorig =  .Cantidadoriginal			lxAdt_combPedcomp =  .Pedcomp			lxAdt_combCorigentre =  .Entregapenoriginal			lxAdt_combCorigpedco =  .Pedcomporiginal			lxAdt_combCorigpresu =  .Presupuestadooriginal			lxAdt_combCorigprepa =  .Preparadooriginal			lxAdt_combPresupuest =  .Presupuestado			lxAdt_combPedido =  .Pedido			lxAdt_combCorigpedid =  .Pedidooriginal			lxAdt_combAdt_ext =  .Adt_ext			lxAdt_combCoart =  upper( .Articulo_PK ) 			lxAdt_combTalle =  upper( .Talle_PK ) 			lxAdt_combCocod =  upper( .Codigo_PK ) 			lxAdt_combCocol =  upper( .Color_PK ) 			lxAdt_combAdt_cod =  .Adt_cod
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ADT_COMB ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Adt_fecha","Horaimpo","Hmodifw","Horaexpo","Esttrans","Haltafw","Bdmodifw","Bdaltafw","Saltafw","Ualtafw","Adt_ent","Adt_comp","Adt_serie","Adt_usr","Adt_adn","Adt_hora","Adt_vers","Valtafw","Umodifw","Vmodifw","Zadsfw","Smodifw","Corigsenia","Preparado","Entregapen","Seniado","Entranorig","Entransito","Cocant","Corig","Pedcomp","Corigentre","Corigpedco","Corigpresu","Corigprepa","Presupuest","Pedido","Corigpedid","Adt_ext","Coart","Talle","Cocod","Cocol","Adt_cod" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_combFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_combAdt_fecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combSmodifw ) + "'" >>, <<lxAdt_combCorigsenia >>, <<lxAdt_combPreparado >>, <<lxAdt_combEntregapen >>, <<lxAdt_combSeniado >>, <<lxAdt_combEntranorig >>, <<lxAdt_combEntransito >>, <<lxAdt_combCocant >>, <<lxAdt_combCorig >>, <<lxAdt_combPedcomp >>, <<lxAdt_combCorigentre >>, <<lxAdt_combCorigpedco >>, <<lxAdt_combCorigpresu >>, <<lxAdt_combCorigprepa >>, <<lxAdt_combPresupuest >>, <<lxAdt_combPedido >>, <<lxAdt_combCorigpedid >>, <<iif( lxAdt_combAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_combCoart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combCocol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'" >> )
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
			local  lxAdt_combFecimpo, lxAdt_combFectrans, lxAdt_combFmodifw, lxAdt_combFaltafw, lxAdt_combFecexpo, lxAdt_combAdt_fecha, lxAdt_combHoraimpo, lxAdt_combHmodifw, lxAdt_combHoraexpo, lxAdt_combEsttrans, lxAdt_combHaltafw, lxAdt_combBdmodifw, lxAdt_combBdaltafw, lxAdt_combSaltafw, lxAdt_combUaltafw, lxAdt_combAdt_ent, lxAdt_combAdt_comp, lxAdt_combAdt_serie, lxAdt_combAdt_usr, lxAdt_combAdt_adn, lxAdt_combAdt_hora, lxAdt_combAdt_vers, lxAdt_combValtafw, lxAdt_combUmodifw, lxAdt_combVmodifw, lxAdt_combZadsfw, lxAdt_combSmodifw, lxAdt_combCorigsenia, lxAdt_combPreparado, lxAdt_combEntregapen, lxAdt_combSeniado, lxAdt_combEntranorig, lxAdt_combEntransito, lxAdt_combCocant, lxAdt_combCorig, lxAdt_combPedcomp, lxAdt_combCorigentre, lxAdt_combCorigpedco, lxAdt_combCorigpresu, lxAdt_combCorigprepa, lxAdt_combPresupuest, lxAdt_combPedido, lxAdt_combCorigpedid, lxAdt_combAdt_ext, lxAdt_combCoart, lxAdt_combTalle, lxAdt_combCocod, lxAdt_combCocol, lxAdt_combAdt_cod
				lxAdt_combFecimpo =  .Fechaimpo			lxAdt_combFectrans =  .Fechatransferencia			lxAdt_combFmodifw =  .Fechamodificacionfw			lxAdt_combFaltafw =  .Fechaaltafw			lxAdt_combFecexpo =  .Fechaexpo			lxAdt_combAdt_fecha =  .Adt_fecha			lxAdt_combHoraimpo =  .Horaimpo			lxAdt_combHmodifw =  .Horamodificacionfw			lxAdt_combHoraexpo =  .Horaexpo			lxAdt_combEsttrans =  .Estadotransferencia			lxAdt_combHaltafw =  .Horaaltafw			lxAdt_combBdmodifw =  .Basededatosmodificacionfw			lxAdt_combBdaltafw =  .Basededatosaltafw			lxAdt_combSaltafw =  .Seriealtafw			lxAdt_combUaltafw =  .Usuarioaltafw			lxAdt_combAdt_ent =  .Adt_ent			lxAdt_combAdt_comp =  .Adt_comp			lxAdt_combAdt_serie =  .Adt_serie			lxAdt_combAdt_usr =  .Adt_usr			lxAdt_combAdt_adn =  .Adt_adn			lxAdt_combAdt_hora =  .Adt_hora			lxAdt_combAdt_vers =  .Adt_vers			lxAdt_combValtafw =  .Versionaltafw			lxAdt_combUmodifw =  .Usuariomodificacionfw			lxAdt_combVmodifw =  .Versionmodificacionfw			lxAdt_combZadsfw =  .Zadsfw			lxAdt_combSmodifw =  .Seriemodificacionfw			lxAdt_combCorigsenia =  .Seniadooriginal			lxAdt_combPreparado =  .Preparado			lxAdt_combEntregapen =  .Entregapen			lxAdt_combSeniado =  .Seniado			lxAdt_combEntranorig =  .Entransitooriginal			lxAdt_combEntransito =  .Entransito			lxAdt_combCocant =  .Cantidad			lxAdt_combCorig =  .Cantidadoriginal			lxAdt_combPedcomp =  .Pedcomp			lxAdt_combCorigentre =  .Entregapenoriginal			lxAdt_combCorigpedco =  .Pedcomporiginal			lxAdt_combCorigpresu =  .Presupuestadooriginal			lxAdt_combCorigprepa =  .Preparadooriginal			lxAdt_combPresupuest =  .Presupuestado			lxAdt_combPedido =  .Pedido			lxAdt_combCorigpedid =  .Pedidooriginal			lxAdt_combAdt_ext =  .Adt_ext			lxAdt_combCoart =  upper( .Articulo_PK ) 			lxAdt_combTalle =  upper( .Talle_PK ) 			lxAdt_combCocod =  upper( .Codigo_PK ) 			lxAdt_combCocol =  upper( .Color_PK ) 			lxAdt_combAdt_cod =  .Adt_cod
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_COMB.ADT_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ADT_COMB set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_combFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_combFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_combFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_combFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_combFecexpo ) + "'">>, "Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_combAdt_fecha ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_combHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_combHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_combEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combBdaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_combSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_combUaltafw ) + "'">>, "Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_ent ) + "'">>, "Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_comp ) + "'">>, "Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_serie ) + "'">>, "Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_usr ) + "'">>, "Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_adn ) + "'">>, "Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_hora ) + "'">>, "Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_vers ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_combValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_combZadsfw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_combSmodifw ) + "'">>, "Corigsenia" = <<lxAdt_combCorigsenia>>, "Preparado" = <<lxAdt_combPreparado>>, "Entregapen" = <<lxAdt_combEntregapen>>, "Seniado" = <<lxAdt_combSeniado>>, "Entranorig" = <<lxAdt_combEntranorig>>, "Entransito" = <<lxAdt_combEntransito>>, "Cocant" = <<lxAdt_combCocant>>, "Corig" = <<lxAdt_combCorig>>, "Pedcomp" = <<lxAdt_combPedcomp>>, "Corigentre" = <<lxAdt_combCorigentre>>, "Corigpedco" = <<lxAdt_combCorigpedco>>, "Corigpresu" = <<lxAdt_combCorigpresu>>, "Corigprepa" = <<lxAdt_combCorigprepa>>, "Presupuest" = <<lxAdt_combPresupuest>>, "Pedido" = <<lxAdt_combPedido>>, "Corigpedid" = <<lxAdt_combCorigpedid>>, "Adt_ext" = <<iif( lxAdt_combAdt_ext, 1, 0 )>>, "Coart" = <<"'" + this.FormatearTextoSql( lxAdt_combCoart ) + "'">>, "Talle" = <<"'" + this.FormatearTextoSql( lxAdt_combTalle ) + "'">>, "Cocod" = <<"'" + this.FormatearTextoSql( lxAdt_combCocod ) + "'">>, "Cocol" = <<"'" + this.FormatearTextoSql( lxAdt_combCocol ) + "'">>, "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_combAdt_cod ) + "'">> where << lcFiltro >>
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
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ADT_COMB set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ADT_Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ADT_Ent = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"+ [, ADT_Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"+ [, ADT_Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"+ [, ADT_Usr = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'"+ [, ADT_ADN = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"+ [, ADT_Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"+ [, ADT_Vers = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, cOrigSENIA = ] + transform( &lcCursor..cOrigSENIA )+ [, PREPARADO = ] + transform( &lcCursor..PREPARADO )+ [, EntregaPen = ] + transform( &lcCursor..EntregaPen )+ [, SENIADO = ] + transform( &lcCursor..SENIADO )+ [, EnTranOrig = ] + transform( &lcCursor..EnTranOrig )+ [, EnTransito = ] + transform( &lcCursor..EnTransito )+ [, COCANT = ] + transform( &lcCursor..COCANT )+ [, CORIG = ] + transform( &lcCursor..CORIG )+ [, PEDCOMP = ] + transform( &lcCursor..PEDCOMP )+ [, cOrigEntre = ] + transform( &lcCursor..cOrigEntre )+ [, cOrigPEDCO = ] + transform( &lcCursor..cOrigPEDCO )+ [, cOrigPRESU = ] + transform( &lcCursor..cOrigPRESU )+ [, cOrigPREPA = ] + transform( &lcCursor..cOrigPREPA )+ [, PRESUPUEST = ] + transform( &lcCursor..PRESUPUEST )+ [, PEDIDO = ] + transform( &lcCursor..PEDIDO )+ [, cOrigPEDID = ] + transform( &lcCursor..cOrigPEDID )+ [, ADT_Ext = ] + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))+ [, COART = ] + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'"+ [, Talle = ] + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'"+ [, COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'"+ [, COCOL = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'"+ [, ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" + [ Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, ADT_Fecha, HORAIMPO, HMODIFW, HORAEXPO, ESTTRANS, HALTAFW, BDMODIFW, BDALTAFW, SALTAFW, UALTAFW, ADT_Ent, ADT_Comp, ADT_Serie, ADT_Usr, ADT_ADN, ADT_Hora, ADT_Vers, VALTAFW, UMODIFW, VMODIFW, ZADSFW, SMODIFW, cOrigSENIA, PREPARADO, EntregaPen, SENIADO, EnTranOrig, EnTransito, COCANT, CORIG, PEDCOMP, cOrigEntre, cOrigPEDCO, cOrigPRESU, cOrigPREPA, PRESUPUEST, PEDIDO, cOrigPEDID, ADT_Ext, COART, Talle, COCOD, COCOL, ADT_Cod
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + transform( &lcCursor..cOrigSENIA )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..PREPARADO ) + ',' + transform( &lcCursor..EntregaPen ) + ',' + transform( &lcCursor..SENIADO ) + ',' + transform( &lcCursor..EnTranOrig ) + ',' + transform( &lcCursor..EnTransito ) + ',' + transform( &lcCursor..COCANT ) + ',' + transform( &lcCursor..CORIG ) + ',' + transform( &lcCursor..PEDCOMP ) + ',' + transform( &lcCursor..cOrigEntre ) + ',' + transform( &lcCursor..cOrigPEDCO )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..cOrigPRESU ) + ',' + transform( &lcCursor..cOrigPREPA ) + ',' + transform( &lcCursor..PRESUPUEST ) + ',' + transform( &lcCursor..PEDIDO ) + ',' + transform( &lcCursor..cOrigPEDID ) + ',' + Transform( iif( &lcCursor..ADT_Ext, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'"
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
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  ADT_Fecha 
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
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"adt_fecha" datetime  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"adt_ent" char( 40 )  null, 
"adt_comp" char( 254 )  null, 
"adt_serie" char( 20 )  null, 
"adt_usr" char( 100 )  null, 
"adt_adn" char( 10 )  null, 
"adt_hora" char( 8 )  null, 
"adt_vers" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"smodifw" char( 7 )  null, 
"corigsenia" numeric( 15, 2 )  null, 
"preparado" numeric( 15, 2 )  null, 
"entregapen" numeric( 15, 2 )  null, 
"seniado" numeric( 15, 2 )  null, 
"entranorig" numeric( 15, 2 )  null, 
"entransito" numeric( 15, 2 )  null, 
"cocant" numeric( 15, 2 )  null, 
"corig" numeric( 15, 2 )  null, 
"pedcomp" numeric( 15, 2 )  null, 
"corigentre" numeric( 15, 2 )  null, 
"corigpedco" numeric( 15, 2 )  null, 
"corigpresu" numeric( 15, 2 )  null, 
"corigprepa" numeric( 15, 2 )  null, 
"presupuest" numeric( 15, 2 )  null, 
"pedido" numeric( 15, 2 )  null, 
"corigpedid" numeric( 15, 2 )  null, 
"adt_ext" bit  null, 
"coart" char( 15 )  null, 
"talle" char( 5 )  null, 
"cocod" char( 26 )  null, 
"cocol" char( 6 )  null, 
"adt_cod" char( 38 )  null )
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
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('adt_fecha','adt_fecha')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('adt_ent','adt_ent')
			.AgregarMapeo('adt_comp','adt_comp')
			.AgregarMapeo('adt_serie','adt_serie')
			.AgregarMapeo('adt_usr','adt_usr')
			.AgregarMapeo('adt_adn','adt_adn')
			.AgregarMapeo('adt_hora','adt_hora')
			.AgregarMapeo('adt_vers','adt_vers')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('corigsenia','corigsenia')
			.AgregarMapeo('preparado','preparado')
			.AgregarMapeo('entregapen','entregapen')
			.AgregarMapeo('seniado','seniado')
			.AgregarMapeo('entranorig','entranorig')
			.AgregarMapeo('entransito','entransito')
			.AgregarMapeo('cocant','cocant')
			.AgregarMapeo('corig','corig')
			.AgregarMapeo('pedcomp','pedcomp')
			.AgregarMapeo('corigentre','corigentre')
			.AgregarMapeo('corigpedco','corigpedco')
			.AgregarMapeo('corigpresu','corigpresu')
			.AgregarMapeo('corigprepa','corigprepa')
			.AgregarMapeo('presupuest','presupuest')
			.AgregarMapeo('pedido','pedido')
			.AgregarMapeo('corigpedid','corigpedid')
			.AgregarMapeo('adt_ext','adt_ext')
			.AgregarMapeo('coart','coart')
			.AgregarMapeo('talle','talle')
			.AgregarMapeo('cocod','cocod')
			.AgregarMapeo('cocol','cocol')
			.AgregarMapeo('adt_cod','adt_cod')
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.ADT_FECHA = isnull( d.ADT_FECHA, t.ADT_FECHA ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ADT_ENT = isnull( d.ADT_ENT, t.ADT_ENT ),t.ADT_COMP = isnull( d.ADT_COMP, t.ADT_COMP ),t.ADT_SERIE = isnull( d.ADT_SERIE, t.ADT_SERIE ),t.ADT_USR = isnull( d.ADT_USR, t.ADT_USR ),t.ADT_ADN = isnull( d.ADT_ADN, t.ADT_ADN ),t.ADT_HORA = isnull( d.ADT_HORA, t.ADT_HORA ),t.ADT_VERS = isnull( d.ADT_VERS, t.ADT_VERS ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.CORIGSENIA = isnull( d.CORIGSENIA, t.CORIGSENIA ),t.PREPARADO = isnull( d.PREPARADO, t.PREPARADO ),t.ENTREGAPEN = isnull( d.ENTREGAPEN, t.ENTREGAPEN ),t.SENIADO = isnull( d.SENIADO, t.SENIADO ),t.ENTRANORIG = isnull( d.ENTRANORIG, t.ENTRANORIG ),t.ENTRANSITO = isnull( d.ENTRANSITO, t.ENTRANSITO ),t.COCANT = isnull( d.COCANT, t.COCANT ),t.CORIG = isnull( d.CORIG, t.CORIG ),t.PEDCOMP = isnull( d.PEDCOMP, t.PEDCOMP ),t.CORIGENTRE = isnull( d.CORIGENTRE, t.CORIGENTRE ),t.CORIGPEDCO = isnull( d.CORIGPEDCO, t.CORIGPEDCO ),t.CORIGPRESU = isnull( d.CORIGPRESU, t.CORIGPRESU ),t.CORIGPREPA = isnull( d.CORIGPREPA, t.CORIGPREPA ),t.PRESUPUEST = isnull( d.PRESUPUEST, t.PRESUPUEST ),t.PEDIDO = isnull( d.PEDIDO, t.PEDIDO ),t.CORIGPEDID = isnull( d.CORIGPEDID, t.CORIGPEDID ),t.ADT_EXT = isnull( d.ADT_EXT, t.ADT_EXT ),t.COART = isnull( d.COART, t.COART ),t.TALLE = isnull( d.TALLE, t.TALLE ),t.COCOD = isnull( d.COCOD, t.COCOD ),t.COCOL = isnull( d.COCOL, t.COCOL ),t.ADT_COD = isnull( d.ADT_COD, t.ADT_COD )
					from ZooLogic.ADT_COMB t inner join deleted d 
							 on t.ADT_Cod = d.ADT_Cod
				-- Fin Updates
				insert into ZooLogic.ADT_COMB(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Adt_fecha,Horaimpo,Hmodifw,Horaexpo,Esttrans,Haltafw,Bdmodifw,Bdaltafw,Saltafw,Ualtafw,Adt_ent,Adt_comp,Adt_serie,Adt_usr,Adt_adn,Adt_hora,Adt_vers,Valtafw,Umodifw,Vmodifw,Zadsfw,Smodifw,Corigsenia,Preparado,Entregapen,Seniado,Entranorig,Entransito,Cocant,Corig,Pedcomp,Corigentre,Corigpedco,Corigpresu,Corigprepa,Presupuest,Pedido,Corigpedid,Adt_ext,Coart,Talle,Cocod,Cocol,Adt_cod)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.ADT_FECHA,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.ADT_ENT,''),isnull( d.ADT_COMP,''),isnull( d.ADT_SERIE,''),isnull( d.ADT_USR,''),isnull( d.ADT_ADN,''),isnull( d.ADT_HORA,''),isnull( d.ADT_VERS,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.SMODIFW,''),isnull( d.CORIGSENIA,0),isnull( d.PREPARADO,0),isnull( d.ENTREGAPEN,0),isnull( d.SENIADO,0),isnull( d.ENTRANORIG,0),isnull( d.ENTRANSITO,0),isnull( d.COCANT,0),isnull( d.CORIG,0),isnull( d.PEDCOMP,0),isnull( d.CORIGENTRE,0),isnull( d.CORIGPEDCO,0),isnull( d.CORIGPRESU,0),isnull( d.CORIGPREPA,0),isnull( d.PRESUPUEST,0),isnull( d.PEDIDO,0),isnull( d.CORIGPEDID,0),isnull( d.ADT_EXT,0),isnull( d.COART,''),isnull( d.TALLE,''),isnull( d.COCOD,''),isnull( d.COCOL,''),isnull( d.ADT_COD,'')
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
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Adt_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKCOMBINACION.Adt_fecha, ctod( '  /  /    ' ) ) )
					.Horaimpo = nvl( c_ADT_STOCKCOMBINACION.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_ADT_STOCKCOMBINACION.Horaexpo, [] )
					.Estadotransferencia = nvl( c_ADT_STOCKCOMBINACION.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_ADT_STOCKCOMBINACION.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_ADT_STOCKCOMBINACION.Basededatosaltafw, [] )
					.Seriealtafw = nvl( c_ADT_STOCKCOMBINACION.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_ADT_STOCKCOMBINACION.Usuarioaltafw, [] )
					.Adt_ent = nvl( c_ADT_STOCKCOMBINACION.Adt_ent, [] )
					.Adt_comp = nvl( c_ADT_STOCKCOMBINACION.Adt_comp, [] )
					.Adt_serie = nvl( c_ADT_STOCKCOMBINACION.Adt_serie, [] )
					.Adt_usr = nvl( c_ADT_STOCKCOMBINACION.Adt_usr, [] )
					.Adt_adn = nvl( c_ADT_STOCKCOMBINACION.Adt_adn, [] )
					.Adt_hora = nvl( c_ADT_STOCKCOMBINACION.Adt_hora, [] )
					.Adt_vers = nvl( c_ADT_STOCKCOMBINACION.Adt_vers, [] )
					.Versionaltafw = nvl( c_ADT_STOCKCOMBINACION.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriemodificacionfw = nvl( c_ADT_STOCKCOMBINACION.Seriemodificacionfw, [] )
					.Seniadooriginal = nvl( c_ADT_STOCKCOMBINACION.Seniadooriginal, 0 )
					.Preparado = nvl( c_ADT_STOCKCOMBINACION.Preparado, 0 )
					.Entregapen = nvl( c_ADT_STOCKCOMBINACION.Entregapen, 0 )
					.Seniado = nvl( c_ADT_STOCKCOMBINACION.Seniado, 0 )
					.Entransitooriginal = nvl( c_ADT_STOCKCOMBINACION.Entransitooriginal, 0 )
					.Entransito = nvl( c_ADT_STOCKCOMBINACION.Entransito, 0 )
					.Cantidad = nvl( c_ADT_STOCKCOMBINACION.Cantidad, 0 )
					.Cantidadoriginal = nvl( c_ADT_STOCKCOMBINACION.Cantidadoriginal, 0 )
					.Pedcomp = nvl( c_ADT_STOCKCOMBINACION.Pedcomp, 0 )
					.Entregapenoriginal = nvl( c_ADT_STOCKCOMBINACION.Entregapenoriginal, 0 )
					.Pedcomporiginal = nvl( c_ADT_STOCKCOMBINACION.Pedcomporiginal, 0 )
					.Presupuestadooriginal = nvl( c_ADT_STOCKCOMBINACION.Presupuestadooriginal, 0 )
					.Preparadooriginal = nvl( c_ADT_STOCKCOMBINACION.Preparadooriginal, 0 )
					.Presupuestado = nvl( c_ADT_STOCKCOMBINACION.Presupuestado, 0 )
					.Pedido = nvl( c_ADT_STOCKCOMBINACION.Pedido, 0 )
					.Pedidooriginal = nvl( c_ADT_STOCKCOMBINACION.Pedidooriginal, 0 )
					.Adt_ext = nvl( c_ADT_STOCKCOMBINACION.Adt_ext, .F. )
					.Articulo_PK =  nvl( c_ADT_STOCKCOMBINACION.Articulo, [] )
					.Talle_PK =  nvl( c_ADT_STOCKCOMBINACION.Talle, [] )
					.Codigo_PK =  nvl( c_ADT_STOCKCOMBINACION.Codigo, [] )
					.Color_PK =  nvl( c_ADT_STOCKCOMBINACION.Color, [] )
					.Adt_cod = nvl( c_ADT_STOCKCOMBINACION.Adt_cod, [] )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Adt_ent" as "Adt_ent", "Adt_comp" as "Adt_comp", "Adt_serie" as "Adt_serie", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Corigsenia" as "Seniadooriginal", "Preparado" as "Preparado", "Entregapen" as "Entregapen", "Seniado" as "Seniado", "Entranorig" as "Entransitooriginal", "Entransito" as "Entransito", "Cocant" as "Cantidad", "Corig" as "Cantidadoriginal", "Pedcomp" as "Pedcomp", "Corigentre" as "Entregapenoriginal", "Corigpedco" as "Pedcomporiginal", "Corigpresu" as "Presupuestadooriginal", "Corigprepa" as "Preparadooriginal", "Presupuest" as "Presupuestado", "Pedido" as "Pedido", "Corigpedid" as "Pedidooriginal", "Adt_ext" as "Adt_ext", "Coart" as "Articulo", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color", "Adt_cod" as "Adt_cod"
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
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="FECHATRANSFERENCIA                      " tabla="ADT_COMB       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="FECHAMODIFICACIONFW                     " tabla="ADT_COMB       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="FECHAALTAFW                             " tabla="ADT_COMB       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="FECHAEXPO                               " tabla="ADT_COMB       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_FECHA                               " tabla="ADT_COMB       " campo="ADT_FECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="HORAIMPO                                " tabla="ADT_COMB       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="HORAMODIFICACIONFW                      " tabla="ADT_COMB       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="HORAEXPO                                " tabla="ADT_COMB       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ESTADOTRANSFERENCIA                     " tabla="ADT_COMB       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="HORAALTAFW                              " tabla="ADT_COMB       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ADT_COMB       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="BASEDEDATOSALTAFW                       " tabla="ADT_COMB       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SERIEALTAFW                             " tabla="ADT_COMB       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="USUARIOALTAFW                           " tabla="ADT_COMB       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_ENT                                 " tabla="ADT_COMB       " campo="ADT_ENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_COMP                                " tabla="ADT_COMB       " campo="ADT_COMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_SERIE                               " tabla="ADT_COMB       " campo="ADT_SERIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_USR                                 " tabla="ADT_COMB       " campo="ADT_USR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_ADN                                 " tabla="ADT_COMB       " campo="ADT_ADN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="ADN                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_HORA                                " tabla="ADT_COMB       " campo="ADT_HORA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_VERS                                " tabla="ADT_COMB       " campo="ADT_VERS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="VERSIONALTAFW                           " tabla="ADT_COMB       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="USUARIOMODIFICACIONFW                   " tabla="ADT_COMB       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="VERSIONMODIFICACIONFW                   " tabla="ADT_COMB       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ZADSFW                                  " tabla="ADT_COMB       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SERIEMODIFICACIONFW                     " tabla="ADT_COMB       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SENIADOORIGINAL                         " tabla="ADT_COMB       " campo="CORIGSENIA" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="cOrigSENIADO                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PREPARADO                               " tabla="ADT_COMB       " campo="PREPARADO " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="PREPARADO                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ENTREGAPEN                              " tabla="ADT_COMB       " campo="ENTREGAPEN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entrega posterior en facturas                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="SENIADO                                 " tabla="ADT_COMB       " campo="SENIADO   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="SENIADO                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ENTRANSITOORIGINAL                      " tabla="ADT_COMB       " campo="ENTRANORIG" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cantidad en tránsito original                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ENTRANSITO                              " tabla="ADT_COMB       " campo="ENTRANSITO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Cantidad en tránsito                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="CANTIDAD                                " tabla="ADT_COMB       " campo="COCANT    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Cantidad en stock                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="CANTIDADORIGINAL                        " tabla="ADT_COMB       " campo="CORIG     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cantidad original                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PEDCOMP                                 " tabla="ADT_COMB       " campo="PEDCOMP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="PEDCOMP                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ENTREGAPENORIGINAL                      " tabla="ADT_COMB       " campo="CORIGENTRE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entrega posterior en facturas original                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PEDCOMPORIGINAL                         " tabla="ADT_COMB       " campo="CORIGPEDCO" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="cOrigPEDCOMP                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PRESUPUESTADOORIGINAL                   " tabla="ADT_COMB       " campo="CORIGPRESU" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="cOrigPRESUPUESTADO                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PREPARADOORIGINAL                       " tabla="ADT_COMB       " campo="CORIGPREPA" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="cOrigPREPARADO                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PRESUPUESTADO                           " tabla="ADT_COMB       " campo="PRESUPUEST" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="PRESUPUESTADO                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PEDIDO                                  " tabla="ADT_COMB       " campo="PEDIDO    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="PEDIDO                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="PEDIDOORIGINAL                          " tabla="ADT_COMB       " campo="CORIGPEDID" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="cOrigPEDIDO                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_EXT                                 " tabla="ADT_COMB       " campo="ADT_EXT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Información remota                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ARTICULO                                " tabla="ADT_COMB       " campo="COART     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="TALLE                                   " tabla="ADT_COMB       " campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Talle                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="CODIGO                                  " tabla="ADT_COMB       " campo="COCOD     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="Stockcombinacion                        " tipodato="C         " longitud="26" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Stock combinación                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="COLOR                                   " tabla="ADT_COMB       " campo="COCOL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKCOMBINACION                    " atributo="ADT_COD                                 " tabla="ADT_COMB       " campo="ADT_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="443" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On ADT_COMB.COART = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On ADT_COMB.TALLE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="447" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On ADT_COMB.COCOL = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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