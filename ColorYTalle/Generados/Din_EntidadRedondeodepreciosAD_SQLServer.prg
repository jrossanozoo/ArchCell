
define class Din_EntidadREDONDEODEPRECIOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REDONDEODEPRECIOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_REDPK'
	cTablaPrincipal = 'REDO'
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
			local  lxRedoFecimpo, lxRedoFectrans, lxRedoFmodifw, lxRedoFaltafw, lxRedoFecexpo, lxRedoHoraexpo, lxRedoHaltafw, lxRedoHoraimpo, lxRedoHmodifw, lxRedoSmodifw, lxRedoSaltafw, lxRedoUmodifw, lxRedoZadsfw, lxRedoValtafw, lxRedoBdaltafw, lxRedoVmodifw, lxRedoBdmodifw, lxRedoEsttrans, lxRedoUaltafw, lxRedoTipagrupub, lxRedoTimestamp, lxRedoCodigo, lxRedoRedopre, lxRedoRedotcent, lxRedoRedoent, lxRedoRedotent, lxRedoDescrip, lxRedoRobs, lxRedoRtabla, lxRedoRnormal
				lxRedoFecimpo =  .Fechaimpo			lxRedoFectrans =  .Fechatransferencia			lxRedoFmodifw =  .Fechamodificacionfw			lxRedoFaltafw =  .Fechaaltafw			lxRedoFecexpo =  .Fechaexpo			lxRedoHoraexpo =  .Horaexpo			lxRedoHaltafw =  .Horaaltafw			lxRedoHoraimpo =  .Horaimpo			lxRedoHmodifw =  .Horamodificacionfw			lxRedoSmodifw =  .Seriemodificacionfw			lxRedoSaltafw =  .Seriealtafw			lxRedoUmodifw =  .Usuariomodificacionfw			lxRedoZadsfw =  .Zadsfw			lxRedoValtafw =  .Versionaltafw			lxRedoBdaltafw =  .Basededatosaltafw			lxRedoVmodifw =  .Versionmodificacionfw			lxRedoBdmodifw =  .Basededatosmodificacionfw			lxRedoEsttrans =  .Estadotransferencia			lxRedoUaltafw =  .Usuarioaltafw			lxRedoTipagrupub =  .Tipoagrupamientopublicaciones			lxRedoTimestamp = goLibrerias.ObtenerTimestamp()			lxRedoCodigo =  .Codigo			lxRedoRedopre =  .Habilitaredonearprecios			lxRedoRedotcent =  .Habilitaredondeartermcentavos			lxRedoRedoent =  .Habilitaredondearnormal			lxRedoRedotent =  .Habilitaredondeartermenteros			lxRedoDescrip =  .Descripcion			lxRedoRobs =  .Observacion			lxRedoRtabla =  .Redondeoportabla			lxRedoRnormal =  .Redondeonormal
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRedoCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.REDO ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Horaexpo","Haltafw","Horaimpo","Hmodifw","Smodifw","Saltafw","Umodifw","Zadsfw","Valtafw","Bdaltafw","Vmodifw","Bdmodifw","Esttrans","Ualtafw","Tipagrupub","Timestamp","Codigo","Redopre","Redotcent","Redoent","Redotent","Descrip","Robs","Rtabla","Rnormal" ) values ( <<"'" + this.ConvertirDateSql( lxRedoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRedoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRedoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRedoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRedoFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoUaltafw ) + "'" >>, <<lxRedoTipagrupub >>, <<lxRedoTimestamp >>, <<"'" + this.FormatearTextoSql( lxRedoCodigo ) + "'" >>, <<iif( lxRedoRedopre, 1, 0 ) >>, <<iif( lxRedoRedotcent, 1, 0 ) >>, <<iif( lxRedoRedoent, 1, 0 ) >>, <<iif( lxRedoRedotent, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxRedoDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoRobs ) + "'" >>, <<lxRedoRtabla >>, <<lxRedoRnormal >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.detPrueba
				if this.oEntidad.detPrueba.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxPrecio = loItem.Precio
					lxResultado = loItem.Resultado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoPrueba("NROITEM","codigo","precio","result" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxPrecio>>, <<lxResultado>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubRED("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorCentavo
				if this.oEntidad.DetRedondeoPorCentavo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminacioncaracter = loItem.Terminacioncaracter
					lxDesde = loItem.Desde
					lxHasta = loItem.Hasta
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					lxTerminacion = loItem.Terminacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorCent("NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTerminacioncaracter ) + "'">>, <<lxDesde>>, <<lxHasta>>, <<lxDesdeprecio>>, <<lxHastaprecio>>, <<lxTerminacion>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorEntero
				if this.oEntidad.DetRedondeoPorEntero.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminacioncaracter = loItem.Terminacioncaracter
					lxDesde = loItem.Desde
					lxHasta = loItem.Hasta
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					lxTerminacion = loItem.Terminacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorEnt("NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTerminacioncaracter ) + "'">>, <<lxDesde>>, <<lxHasta>>, <<lxDesdeprecio>>, <<lxHastaprecio>>, <<lxTerminacion>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorTabla
				if this.oEntidad.DetRedondeoPorTabla.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxRedondearen = loItem.Redondearen
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorTabla("NROITEM","codigo","RedEn","DesdePre","HastaPre" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxRedondearen>>, <<lxDesdeprecio>>, <<lxHastaprecio>> ) 
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
		this.oEntidad.Timestamp = lxRedoTimestamp
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
			local  lxRedoFecimpo, lxRedoFectrans, lxRedoFmodifw, lxRedoFaltafw, lxRedoFecexpo, lxRedoHoraexpo, lxRedoHaltafw, lxRedoHoraimpo, lxRedoHmodifw, lxRedoSmodifw, lxRedoSaltafw, lxRedoUmodifw, lxRedoZadsfw, lxRedoValtafw, lxRedoBdaltafw, lxRedoVmodifw, lxRedoBdmodifw, lxRedoEsttrans, lxRedoUaltafw, lxRedoTipagrupub, lxRedoTimestamp, lxRedoCodigo, lxRedoRedopre, lxRedoRedotcent, lxRedoRedoent, lxRedoRedotent, lxRedoDescrip, lxRedoRobs, lxRedoRtabla, lxRedoRnormal
				lxRedoFecimpo =  .Fechaimpo			lxRedoFectrans =  .Fechatransferencia			lxRedoFmodifw =  .Fechamodificacionfw			lxRedoFaltafw =  .Fechaaltafw			lxRedoFecexpo =  .Fechaexpo			lxRedoHoraexpo =  .Horaexpo			lxRedoHaltafw =  .Horaaltafw			lxRedoHoraimpo =  .Horaimpo			lxRedoHmodifw =  .Horamodificacionfw			lxRedoSmodifw =  .Seriemodificacionfw			lxRedoSaltafw =  .Seriealtafw			lxRedoUmodifw =  .Usuariomodificacionfw			lxRedoZadsfw =  .Zadsfw			lxRedoValtafw =  .Versionaltafw			lxRedoBdaltafw =  .Basededatosaltafw			lxRedoVmodifw =  .Versionmodificacionfw			lxRedoBdmodifw =  .Basededatosmodificacionfw			lxRedoEsttrans =  .Estadotransferencia			lxRedoUaltafw =  .Usuarioaltafw			lxRedoTipagrupub =  .Tipoagrupamientopublicaciones			lxRedoTimestamp = goLibrerias.ObtenerTimestamp()			lxRedoCodigo =  .Codigo			lxRedoRedopre =  .Habilitaredonearprecios			lxRedoRedotcent =  .Habilitaredondeartermcentavos			lxRedoRedoent =  .Habilitaredondearnormal			lxRedoRedotent =  .Habilitaredondeartermenteros			lxRedoDescrip =  .Descripcion			lxRedoRobs =  .Observacion			lxRedoRtabla =  .Redondeoportabla			lxRedoRnormal =  .Redondeonormal
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.REDO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRedoFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxRedoFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxRedoFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRedoFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxRedoFecexpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRedoHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRedoHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRedoHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRedoHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRedoSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRedoSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRedoUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRedoZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRedoValtafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRedoBdaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRedoVmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRedoBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRedoEsttrans ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRedoUaltafw ) + "'">>,"Tipagrupub" = <<lxRedoTipagrupub>>,"Timestamp" = <<lxRedoTimestamp>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxRedoCodigo ) + "'">>,"Redopre" = <<iif( lxRedoRedopre, 1, 0 )>>,"Redotcent" = <<iif( lxRedoRedotcent, 1, 0 )>>,"Redoent" = <<iif( lxRedoRedoent, 1, 0 )>>,"Redotent" = <<iif( lxRedoRedotent, 1, 0 )>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxRedoDescrip ) + "'">>,"Robs" = <<"'" + this.FormatearTextoSql( lxRedoRobs ) + "'">>,"Rtabla" = <<lxRedoRtabla>>,"Rnormal" = <<lxRedoRnormal>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxRedoCodigo ) + "'">> and  REDO.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.redoPrueba where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubRED where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.redoDetPorCent where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.redoDetPorEnt where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.redoDetPorTabla where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.detPrueba
				if this.oEntidad.detPrueba.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxPrecio = loItem.Precio
					lxResultado = loItem.Resultado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoPrueba("NROITEM","codigo","precio","result" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxPrecio>>, <<lxResultado>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubRED("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorCentavo
				if this.oEntidad.DetRedondeoPorCentavo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminacioncaracter = loItem.Terminacioncaracter
					lxDesde = loItem.Desde
					lxHasta = loItem.Hasta
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					lxTerminacion = loItem.Terminacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorCent("NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTerminacioncaracter ) + "'">>, <<lxDesde>>, <<lxHasta>>, <<lxDesdeprecio>>, <<lxHastaprecio>>, <<lxTerminacion>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorEntero
				if this.oEntidad.DetRedondeoPorEntero.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminacioncaracter = loItem.Terminacioncaracter
					lxDesde = loItem.Desde
					lxHasta = loItem.Hasta
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					lxTerminacion = loItem.Terminacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorEnt("NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTerminacioncaracter ) + "'">>, <<lxDesde>>, <<lxHasta>>, <<lxDesdeprecio>>, <<lxHastaprecio>>, <<lxTerminacion>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorTabla
				if this.oEntidad.DetRedondeoPorTabla.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxRedondearen = loItem.Redondearen
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorTabla("NROITEM","codigo","RedEn","DesdePre","HastaPre" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxRedondearen>>, <<lxDesdeprecio>>, <<lxHastaprecio>> ) 
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
		this.oEntidad.Timestamp = lxRedoTimestamp
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValidarTimestamp() as void
		Local lnTimestamp as integer
		if !this.oEntidad.lEsSubentidad
			lnTimestamp = this.ObtenerTimestampActual()
			if this.oEntidad.Timestamp = lnTimestamp 
			else 
				local loEx as Object
				loEx = Newobject( 'ZooException', 'ZooException.prg' )
				With loEx
					.Message = 'Error al intentar Grabar'
					.Details = 'No se puede grabar, el registro ha cambiado'
					.Grabar()
					.Throw()
				endwith
			endif
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ZooLogic.REDO where " + this.ConvertirFuncionesSql( " REDO.CODIGO != ''" ) )
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
			Local lxRedoCodigo
			lxRedoCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Codigo" as "Codigo", "Redopre" as "Habilitaredonearprecios", "Redotcent" as "Habilitaredondeartermcentavos", "Redoent" as "Habilitaredondearnormal", "Redotent" as "Habilitaredondeartermenteros", "Descrip" as "Descripcion", "Robs" as "Observacion", "Rtabla" as "Redondeoportabla", "Rnormal" as "Redondeonormal" from ZooLogic.REDO where "Codigo" = <<"'" + this.FormatearTextoSql( lxRedoCodigo ) + "'">> and  REDO.CODIGO != ''
			endtext
			use in select('c_REDONDEODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REDONDEODEPRECIOS', set( 'Datasession' ) )

			if reccount( 'c_REDONDEODEPRECIOS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Precio" as "Precio", "Result" as "Resultado" from ZooLogic.redoPrueba where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_detPrueba')
			this.oConexion.EjecutarSql( lcSentencia, 'c_detPrueba', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_detPrueba
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubRED where Codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorCent where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorCentavo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorCentavo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorCentavo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorEnt where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorEntero')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorEntero', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorEntero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Reden" as "Redondearen", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio" from ZooLogic.redoDetPorTabla where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorTabla')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorTabla', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorTabla
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxRedoCodigo as Variant
		llRetorno = .t.
		lxRedoCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.REDO where "Codigo" = <<"'" + this.FormatearTextoSql( lxRedoCodigo ) + "'">> and  REDO.CODIGO != ''
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
				lcOrden =  .codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Codigo" as "Codigo", "Redopre" as "Habilitaredonearprecios", "Redotcent" as "Habilitaredondeartermcentavos", "Redoent" as "Habilitaredondearnormal", "Redotent" as "Habilitaredondeartermenteros", "Descrip" as "Descripcion", "Robs" as "Observacion", "Rtabla" as "Redondeoportabla", "Rnormal" as "Redondeonormal" from ZooLogic.REDO where  REDO.CODIGO != '' order by codigo
			endtext
			use in select('c_REDONDEODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REDONDEODEPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Precio" as "Precio", "Result" as "Resultado" from ZooLogic.redoPrueba where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_detPrueba')
			this.oConexion.EjecutarSql( lcSentencia, 'c_detPrueba', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_detPrueba
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubRED where Codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorCent where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorCentavo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorCentavo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorCentavo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorEnt where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorEntero')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorEntero', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorEntero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Reden" as "Redondearen", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio" from ZooLogic.redoDetPorTabla where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorTabla')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorTabla', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorTabla
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
				lcOrden =  .codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Codigo" as "Codigo", "Redopre" as "Habilitaredonearprecios", "Redotcent" as "Habilitaredondeartermcentavos", "Redoent" as "Habilitaredondearnormal", "Redotent" as "Habilitaredondeartermenteros", "Descrip" as "Descripcion", "Robs" as "Observacion", "Rtabla" as "Redondeoportabla", "Rnormal" as "Redondeonormal" from ZooLogic.REDO where  funciones.padr( codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REDO.CODIGO != '' order by codigo
			endtext
			use in select('c_REDONDEODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REDONDEODEPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Precio" as "Precio", "Result" as "Resultado" from ZooLogic.redoPrueba where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_detPrueba')
			this.oConexion.EjecutarSql( lcSentencia, 'c_detPrueba', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_detPrueba
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubRED where Codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorCent where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorCentavo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorCentavo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorCentavo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorEnt where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorEntero')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorEntero', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorEntero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Reden" as "Redondearen", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio" from ZooLogic.redoDetPorTabla where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorTabla')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorTabla', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorTabla
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
				lcOrden =  .codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Codigo" as "Codigo", "Redopre" as "Habilitaredonearprecios", "Redotcent" as "Habilitaredondeartermcentavos", "Redoent" as "Habilitaredondearnormal", "Redotent" as "Habilitaredondeartermenteros", "Descrip" as "Descripcion", "Robs" as "Observacion", "Rtabla" as "Redondeoportabla", "Rnormal" as "Redondeonormal" from ZooLogic.REDO where  funciones.padr( codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REDO.CODIGO != '' order by codigo desc
			endtext
			use in select('c_REDONDEODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REDONDEODEPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Precio" as "Precio", "Result" as "Resultado" from ZooLogic.redoPrueba where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_detPrueba')
			this.oConexion.EjecutarSql( lcSentencia, 'c_detPrueba', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_detPrueba
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubRED where Codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorCent where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorCentavo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorCentavo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorCentavo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorEnt where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorEntero')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorEntero', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorEntero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Reden" as "Redondearen", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio" from ZooLogic.redoDetPorTabla where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorTabla')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorTabla', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorTabla
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
				lcOrden =  .codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Codigo" as "Codigo", "Redopre" as "Habilitaredonearprecios", "Redotcent" as "Habilitaredondeartermcentavos", "Redoent" as "Habilitaredondearnormal", "Redotent" as "Habilitaredondeartermenteros", "Descrip" as "Descripcion", "Robs" as "Observacion", "Rtabla" as "Redondeoportabla", "Rnormal" as "Redondeonormal" from ZooLogic.REDO where  REDO.CODIGO != '' order by codigo desc
			endtext
			use in select('c_REDONDEODEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REDONDEODEPRECIOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Precio" as "Precio", "Result" as "Resultado" from ZooLogic.redoPrueba where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_detPrueba')
			this.oConexion.EjecutarSql( lcSentencia, 'c_detPrueba', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_detPrueba
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubRED where Codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorCent where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorCentavo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorCentavo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorCentavo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion" from ZooLogic.redoDetPorEnt where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorEntero')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorEntero', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorEntero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Reden" as "Redondearen", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio" from ZooLogic.redoDetPorTabla where codigo = <<"'" + this.FormatearTextoSql( c_REDONDEODEPRECIOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetRedondeoPorTabla')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetRedondeoPorTabla', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetRedondeoPorTabla
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Horaexpo,Haltafw,Horaimpo,Hmodifw,Smodifw,Saltafw,U" + ;
"modifw,Zadsfw,Valtafw,Bdaltafw,Vmodifw,Bdmodifw,Esttrans,Ualtafw,Tipagrupub,Timestamp,Codigo,Redopre" + ;
",Redotcent,Redoent,Redotent,Descrip,Robs,Rtabla,Rnormal" + ;
" from ZooLogic.REDO where  REDO.CODIGO != '' and " + lcFiltro )
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
			local  lxRedoFecimpo, lxRedoFectrans, lxRedoFmodifw, lxRedoFaltafw, lxRedoFecexpo, lxRedoHoraexpo, lxRedoHaltafw, lxRedoHoraimpo, lxRedoHmodifw, lxRedoSmodifw, lxRedoSaltafw, lxRedoUmodifw, lxRedoZadsfw, lxRedoValtafw, lxRedoBdaltafw, lxRedoVmodifw, lxRedoBdmodifw, lxRedoEsttrans, lxRedoUaltafw, lxRedoTipagrupub, lxRedoTimestamp, lxRedoCodigo, lxRedoRedopre, lxRedoRedotcent, lxRedoRedoent, lxRedoRedotent, lxRedoDescrip, lxRedoRobs, lxRedoRtabla, lxRedoRnormal
				lxRedoFecimpo = ctod( '  /  /    ' )			lxRedoFectrans = ctod( '  /  /    ' )			lxRedoFmodifw = ctod( '  /  /    ' )			lxRedoFaltafw = ctod( '  /  /    ' )			lxRedoFecexpo = ctod( '  /  /    ' )			lxRedoHoraexpo = []			lxRedoHaltafw = []			lxRedoHoraimpo = []			lxRedoHmodifw = []			lxRedoSmodifw = []			lxRedoSaltafw = []			lxRedoUmodifw = []			lxRedoZadsfw = []			lxRedoValtafw = []			lxRedoBdaltafw = []			lxRedoVmodifw = []			lxRedoBdmodifw = []			lxRedoEsttrans = []			lxRedoUaltafw = []			lxRedoTipagrupub = 0			lxRedoTimestamp = goLibrerias.ObtenerTimestamp()			lxRedoCodigo = []			lxRedoRedopre = .F.			lxRedoRedotcent = .F.			lxRedoRedoent = .F.			lxRedoRedotent = .F.			lxRedoDescrip = []			lxRedoRobs = []			lxRedoRtabla = 0			lxRedoRnormal = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.redoPrueba where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubRED where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.redoDetPorCent where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.redoDetPorEnt where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.redoDetPorTabla where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.REDO where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REDO' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REDO.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Codigo" as "Codigo", "Redopre" as "Habilitaredonearprecios", "Redotcent" as "Habilitaredondeartermcentavos", "Redoent" as "Habilitaredondearnormal", "Redotent" as "Habilitaredondeartermenteros", "Descrip" as "Descripcion", "Robs" as "Observacion", "Rtabla" as "Redondeoportabla", "Rnormal" as "Redondeonormal"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REDO', '', tnTope )
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
	Function ObtenerDatosDetalledetPrueba( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REDOPRUEBA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Precio" as "Precio", "Result" as "Resultado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalledetPrueba( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'redoPrueba', 'detPrueba', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalledetPrueba( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalledetPrueba( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBRED.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAgruPubliDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubRED', 'AgruPubliDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAgruPubliDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetRedondeoPorCentavo( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REDODETPORCENT.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetRedondeoPorCentavo( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'redoDetPorCent', 'DetRedondeoPorCentavo', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetRedondeoPorCentavo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetRedondeoPorCentavo( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetRedondeoPorEntero( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REDODETPORENT.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Termialfa" as "Terminacioncaracter", "Desde" as "Desde", "Hasta" as "Hasta", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio", "Termi" as "Terminacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetRedondeoPorEntero( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'redoDetPorEnt', 'DetRedondeoPorEntero', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetRedondeoPorEntero( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetRedondeoPorEntero( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetRedondeoPorTabla( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  REDODETPORTABLA.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Reden" as "Redondearen", "Desdepre" as "Desdeprecio", "Hastapre" as "Hastaprecio"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetRedondeoPorTabla( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'redoDetPorTabla', 'DetRedondeoPorTabla', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetRedondeoPorTabla( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetRedondeoPorTabla( lcAtributo )
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
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'HABILITAREDONEARPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDOPRE AS HABILITAREDONEARPRECIOS'
				Case lcAtributo == 'HABILITAREDONDEARTERMCENTAVOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDOTCENT AS HABILITAREDONDEARTERMCENTAVOS'
				Case lcAtributo == 'HABILITAREDONDEARNORMAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDOENT AS HABILITAREDONDEARNORMAL'
				Case lcAtributo == 'HABILITAREDONDEARTERMENTEROS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDOTENT AS HABILITAREDONDEARTERMENTEROS'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ROBS AS OBSERVACION'
				Case lcAtributo == 'REDONDEOPORTABLA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RTABLA AS REDONDEOPORTABLA'
				Case lcAtributo == 'REDONDEONORMAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RNORMAL AS REDONDEONORMAL'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalledetPrueba( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'PRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIO AS PRECIO'
				Case lcAtributo == 'RESULTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESULT AS RESULTADO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'AGRUPAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUP AS AGRUPAMIENTO'
				Case lcAtributo == 'AGRUPAMIENTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUPDES AS AGRUPAMIENTODETALLE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetRedondeoPorCentavo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TERMINACIONCARACTER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TERMIALFA AS TERMINACIONCARACTER'
				Case lcAtributo == 'DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESDE AS DESDE'
				Case lcAtributo == 'HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HASTA AS HASTA'
				Case lcAtributo == 'DESDEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESDEPRE AS DESDEPRECIO'
				Case lcAtributo == 'HASTAPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HASTAPRE AS HASTAPRECIO'
				Case lcAtributo == 'TERMINACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TERMI AS TERMINACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetRedondeoPorEntero( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TERMINACIONCARACTER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TERMIALFA AS TERMINACIONCARACTER'
				Case lcAtributo == 'DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESDE AS DESDE'
				Case lcAtributo == 'HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HASTA AS HASTA'
				Case lcAtributo == 'DESDEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESDEPRE AS DESDEPRECIO'
				Case lcAtributo == 'HASTAPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HASTAPRE AS HASTAPRECIO'
				Case lcAtributo == 'TERMINACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TERMI AS TERMINACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetRedondeoPorTabla( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'REDONDEAREN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDEN AS REDONDEAREN'
				Case lcAtributo == 'DESDEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESDEPRE AS DESDEPRECIO'
				Case lcAtributo == 'HASTAPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HASTAPRE AS HASTAPRECIO'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITAREDONEARPRECIOS'
				lcCampo = 'REDOPRE'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITAREDONDEARTERMCENTAVOS'
				lcCampo = 'REDOTCENT'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITAREDONDEARNORMAL'
				lcCampo = 'REDOENT'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITAREDONDEARTERMENTEROS'
				lcCampo = 'REDOTENT'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'ROBS'
			Case upper( alltrim( tcAtributo ) ) == 'REDONDEOPORTABLA'
				lcCampo = 'RTABLA'
			Case upper( alltrim( tcAtributo ) ) == 'REDONDEONORMAL'
				lcCampo = 'RNORMAL'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalledetPrueba( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIO'
				lcCampo = 'PRECIO'
			Case upper( alltrim( tcAtributo ) ) == 'RESULTADO'
				lcCampo = 'RESULT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAgruPubliDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTO'
				lcCampo = 'AGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTODETALLE'
				lcCampo = 'AGRUPDES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetRedondeoPorCentavo( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TERMINACIONCARACTER'
				lcCampo = 'TERMIALFA'
			Case upper( alltrim( tcAtributo ) ) == 'DESDE'
				lcCampo = 'DESDE'
			Case upper( alltrim( tcAtributo ) ) == 'HASTA'
				lcCampo = 'HASTA'
			Case upper( alltrim( tcAtributo ) ) == 'DESDEPRECIO'
				lcCampo = 'DESDEPRE'
			Case upper( alltrim( tcAtributo ) ) == 'HASTAPRECIO'
				lcCampo = 'HASTAPRE'
			Case upper( alltrim( tcAtributo ) ) == 'TERMINACION'
				lcCampo = 'TERMI'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetRedondeoPorEntero( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TERMINACIONCARACTER'
				lcCampo = 'TERMIALFA'
			Case upper( alltrim( tcAtributo ) ) == 'DESDE'
				lcCampo = 'DESDE'
			Case upper( alltrim( tcAtributo ) ) == 'HASTA'
				lcCampo = 'HASTA'
			Case upper( alltrim( tcAtributo ) ) == 'DESDEPRECIO'
				lcCampo = 'DESDEPRE'
			Case upper( alltrim( tcAtributo ) ) == 'HASTAPRECIO'
				lcCampo = 'HASTAPRE'
			Case upper( alltrim( tcAtributo ) ) == 'TERMINACION'
				lcCampo = 'TERMI'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetRedondeoPorTabla( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'REDONDEAREN'
				lcCampo = 'REDEN'
			Case upper( alltrim( tcAtributo ) ) == 'DESDEPRECIO'
				lcCampo = 'DESDEPRE'
			Case upper( alltrim( tcAtributo ) ) == 'HASTAPRECIO'
				lcCampo = 'HASTAPRE'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETPRUEBA'
			lcRetorno = 'REDOPRUEBA'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBRED'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETREDONDEOPORCENTAVO'
			lcRetorno = 'REDODETPORCENT'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETREDONDEOPORENTERO'
			lcRetorno = 'REDODETPORENT'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETREDONDEOPORTABLA'
			lcRetorno = 'REDODETPORTABLA'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxRedoFecimpo, lxRedoFectrans, lxRedoFmodifw, lxRedoFaltafw, lxRedoFecexpo, lxRedoHoraexpo, lxRedoHaltafw, lxRedoHoraimpo, lxRedoHmodifw, lxRedoSmodifw, lxRedoSaltafw, lxRedoUmodifw, lxRedoZadsfw, lxRedoValtafw, lxRedoBdaltafw, lxRedoVmodifw, lxRedoBdmodifw, lxRedoEsttrans, lxRedoUaltafw, lxRedoTipagrupub, lxRedoTimestamp, lxRedoCodigo, lxRedoRedopre, lxRedoRedotcent, lxRedoRedoent, lxRedoRedotent, lxRedoDescrip, lxRedoRobs, lxRedoRtabla, lxRedoRnormal
				lxRedoFecimpo =  .Fechaimpo			lxRedoFectrans =  .Fechatransferencia			lxRedoFmodifw =  .Fechamodificacionfw			lxRedoFaltafw =  .Fechaaltafw			lxRedoFecexpo =  .Fechaexpo			lxRedoHoraexpo =  .Horaexpo			lxRedoHaltafw =  .Horaaltafw			lxRedoHoraimpo =  .Horaimpo			lxRedoHmodifw =  .Horamodificacionfw			lxRedoSmodifw =  .Seriemodificacionfw			lxRedoSaltafw =  .Seriealtafw			lxRedoUmodifw =  .Usuariomodificacionfw			lxRedoZadsfw =  .Zadsfw			lxRedoValtafw =  .Versionaltafw			lxRedoBdaltafw =  .Basededatosaltafw			lxRedoVmodifw =  .Versionmodificacionfw			lxRedoBdmodifw =  .Basededatosmodificacionfw			lxRedoEsttrans =  .Estadotransferencia			lxRedoUaltafw =  .Usuarioaltafw			lxRedoTipagrupub =  .Tipoagrupamientopublicaciones			lxRedoTimestamp = goLibrerias.ObtenerTimestamp()			lxRedoCodigo =  .Codigo			lxRedoRedopre =  .Habilitaredonearprecios			lxRedoRedotcent =  .Habilitaredondeartermcentavos			lxRedoRedoent =  .Habilitaredondearnormal			lxRedoRedotent =  .Habilitaredondeartermenteros			lxRedoDescrip =  .Descripcion			lxRedoRobs =  .Observacion			lxRedoRtabla =  .Redondeoportabla			lxRedoRnormal =  .Redondeonormal
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.REDO ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Horaexpo","Haltafw","Horaimpo","Hmodifw","Smodifw","Saltafw","Umodifw","Zadsfw","Valtafw","Bdaltafw","Vmodifw","Bdmodifw","Esttrans","Ualtafw","Tipagrupub","Timestamp","Codigo","Redopre","Redotcent","Redoent","Redotent","Descrip","Robs","Rtabla","Rnormal" ) values ( <<"'" + this.ConvertirDateSql( lxRedoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRedoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRedoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRedoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRedoFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoUaltafw ) + "'" >>, <<lxRedoTipagrupub >>, <<lxRedoTimestamp >>, <<"'" + this.FormatearTextoSql( lxRedoCodigo ) + "'" >>, <<iif( lxRedoRedopre, 1, 0 ) >>, <<iif( lxRedoRedotcent, 1, 0 ) >>, <<iif( lxRedoRedoent, 1, 0 ) >>, <<iif( lxRedoRedotent, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxRedoDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRedoRobs ) + "'" >>, <<lxRedoRtabla >>, <<lxRedoRnormal >> )
		endtext
		loColeccion.cTabla = 'REDO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.detPrueba
				if this.oEntidad.detPrueba.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxPrecio = loItem.Precio
					lxResultado = loItem.Resultado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoPrueba("NROITEM","codigo","precio","result" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxPrecio>>, <<lxResultado>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubRED("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorCentavo
				if this.oEntidad.DetRedondeoPorCentavo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminacioncaracter = loItem.Terminacioncaracter
					lxDesde = loItem.Desde
					lxHasta = loItem.Hasta
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					lxTerminacion = loItem.Terminacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorCent("NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTerminacioncaracter ) + "'">>, <<lxDesde>>, <<lxHasta>>, <<lxDesdeprecio>>, <<lxHastaprecio>>, <<lxTerminacion>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorEntero
				if this.oEntidad.DetRedondeoPorEntero.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminacioncaracter = loItem.Terminacioncaracter
					lxDesde = loItem.Desde
					lxHasta = loItem.Hasta
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					lxTerminacion = loItem.Terminacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorEnt("NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTerminacioncaracter ) + "'">>, <<lxDesde>>, <<lxHasta>>, <<lxDesdeprecio>>, <<lxHastaprecio>>, <<lxTerminacion>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorTabla
				if this.oEntidad.DetRedondeoPorTabla.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxRedondearen = loItem.Redondearen
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorTabla("NROITEM","codigo","RedEn","DesdePre","HastaPre" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxRedondearen>>, <<lxDesdeprecio>>, <<lxHastaprecio>> ) 
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
			local  lxRedoFecimpo, lxRedoFectrans, lxRedoFmodifw, lxRedoFaltafw, lxRedoFecexpo, lxRedoHoraexpo, lxRedoHaltafw, lxRedoHoraimpo, lxRedoHmodifw, lxRedoSmodifw, lxRedoSaltafw, lxRedoUmodifw, lxRedoZadsfw, lxRedoValtafw, lxRedoBdaltafw, lxRedoVmodifw, lxRedoBdmodifw, lxRedoEsttrans, lxRedoUaltafw, lxRedoTipagrupub, lxRedoTimestamp, lxRedoCodigo, lxRedoRedopre, lxRedoRedotcent, lxRedoRedoent, lxRedoRedotent, lxRedoDescrip, lxRedoRobs, lxRedoRtabla, lxRedoRnormal
				lxRedoFecimpo =  .Fechaimpo			lxRedoFectrans =  .Fechatransferencia			lxRedoFmodifw =  .Fechamodificacionfw			lxRedoFaltafw =  .Fechaaltafw			lxRedoFecexpo =  .Fechaexpo			lxRedoHoraexpo =  .Horaexpo			lxRedoHaltafw =  .Horaaltafw			lxRedoHoraimpo =  .Horaimpo			lxRedoHmodifw =  .Horamodificacionfw			lxRedoSmodifw =  .Seriemodificacionfw			lxRedoSaltafw =  .Seriealtafw			lxRedoUmodifw =  .Usuariomodificacionfw			lxRedoZadsfw =  .Zadsfw			lxRedoValtafw =  .Versionaltafw			lxRedoBdaltafw =  .Basededatosaltafw			lxRedoVmodifw =  .Versionmodificacionfw			lxRedoBdmodifw =  .Basededatosmodificacionfw			lxRedoEsttrans =  .Estadotransferencia			lxRedoUaltafw =  .Usuarioaltafw			lxRedoTipagrupub =  .Tipoagrupamientopublicaciones			lxRedoTimestamp = goLibrerias.ObtenerTimestamp()			lxRedoCodigo =  .Codigo			lxRedoRedopre =  .Habilitaredonearprecios			lxRedoRedotcent =  .Habilitaredondeartermcentavos			lxRedoRedoent =  .Habilitaredondearnormal			lxRedoRedotent =  .Habilitaredondeartermenteros			lxRedoDescrip =  .Descripcion			lxRedoRobs =  .Observacion			lxRedoRtabla =  .Redondeoportabla			lxRedoRnormal =  .Redondeonormal
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REDO.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.REDO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRedoFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxRedoFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRedoFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRedoFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRedoFecexpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRedoHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRedoHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRedoHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRedoHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRedoSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRedoSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRedoUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRedoZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRedoValtafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRedoBdaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRedoVmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRedoBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRedoEsttrans ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRedoUaltafw ) + "'">>, "Tipagrupub" = <<lxRedoTipagrupub>>, "Timestamp" = <<lxRedoTimestamp>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxRedoCodigo ) + "'">>, "Redopre" = <<iif( lxRedoRedopre, 1, 0 )>>, "Redotcent" = <<iif( lxRedoRedotcent, 1, 0 )>>, "Redoent" = <<iif( lxRedoRedoent, 1, 0 )>>, "Redotent" = <<iif( lxRedoRedotent, 1, 0 )>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxRedoDescrip ) + "'">>, "Robs" = <<"'" + this.FormatearTextoSql( lxRedoRobs ) + "'">>, "Rtabla" = <<lxRedoRtabla>>, "Rnormal" = <<lxRedoRnormal>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REDO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.redoPrueba where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubRED where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.redoDetPorCent where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.redoDetPorEnt where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.redoDetPorTabla where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.detPrueba
				if this.oEntidad.detPrueba.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxPrecio = loItem.Precio
					lxResultado = loItem.Resultado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoPrueba("NROITEM","codigo","precio","result" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxPrecio>>, <<lxResultado>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubRED("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorCentavo
				if this.oEntidad.DetRedondeoPorCentavo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminacioncaracter = loItem.Terminacioncaracter
					lxDesde = loItem.Desde
					lxHasta = loItem.Hasta
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					lxTerminacion = loItem.Terminacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorCent("NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTerminacioncaracter ) + "'">>, <<lxDesde>>, <<lxHasta>>, <<lxDesdeprecio>>, <<lxHastaprecio>>, <<lxTerminacion>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorEntero
				if this.oEntidad.DetRedondeoPorEntero.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTerminacioncaracter = loItem.Terminacioncaracter
					lxDesde = loItem.Desde
					lxHasta = loItem.Hasta
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					lxTerminacion = loItem.Terminacion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorEnt("NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTerminacioncaracter ) + "'">>, <<lxDesde>>, <<lxHasta>>, <<lxDesdeprecio>>, <<lxHastaprecio>>, <<lxTerminacion>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetRedondeoPorTabla
				if this.oEntidad.DetRedondeoPorTabla.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxRedondearen = loItem.Redondearen
					lxDesdeprecio = loItem.Desdeprecio
					lxHastaprecio = loItem.Hastaprecio
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.redoDetPorTabla("NROITEM","codigo","RedEn","DesdePre","HastaPre" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxRedondearen>>, <<lxDesdeprecio>>, <<lxHastaprecio>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  REDO.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.REDO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.redoPrueba where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubRED where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.redoDetPorCent where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.redoDetPorEnt where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.redoDetPorTabla where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'REDO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.REDO where  REDO.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.REDO where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  REDO.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REDONDEODEPRECIOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.REDO Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.REDO set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, redopre = ] + Transform( iif( &lcCursor..redopre, 1, 0 ))+ [, redotCent = ] + Transform( iif( &lcCursor..redotCent, 1, 0 ))+ [, redoent = ] + Transform( iif( &lcCursor..redoent, 1, 0 ))+ [, redotEnt = ] + Transform( iif( &lcCursor..redotEnt, 1, 0 ))+ [, descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'"+ [, robs = ] + "'" + this.FormatearTextoSql( &lcCursor..robs ) + "'"+ [, rtabla = ] + transform( &lcCursor..rtabla )+ [, rnormal = ] + transform( &lcCursor..rnormal ) + [ Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, HORAEXPO, HALTAFW, HORAIMPO, HMODIFW, SMODIFW, SALTAFW, UMODIFW, ZADSFW, VALTAFW, BDALTAFW, VMODIFW, BDMODIFW, ESTTRANS, UALTAFW, tipagrupub, TIMESTAMP, codigo, redopre, redotCent, redoent, redotEnt, descrip, robs, rtabla, rnormal
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + ',' + Transform( iif( &lcCursor..redopre, 1, 0 )) + ',' + Transform( iif( &lcCursor..redotCent, 1, 0 )) + ',' + Transform( iif( &lcCursor..redoent, 1, 0 )) + ',' + Transform( iif( &lcCursor..redotEnt, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..robs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..rtabla ) + ',' + transform( &lcCursor..rnormal )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.REDO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REDONDEODEPRECIOS'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.redoPrueba Where codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubRED Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.redoDetPorCent Where codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.redoDetPorEnt Where codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.redoDetPorTabla Where codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPRUEBAREDONDEO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","codigo","precio","result"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.redoPrueba ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + transform( cDetallesExistentes.precio     ) + ',' + transform( cDetallesExistentes.result     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICRED'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubRED ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMREDONDEOCENTAVOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.redoDetPorCent ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.termialfa  ) + "'" + ',' + transform( cDetallesExistentes.desde      ) + ',' + transform( cDetallesExistentes.hasta      ) + ',' + transform( cDetallesExistentes.desdepre   ) + ',' + transform( cDetallesExistentes.hastapre   ) + ',' + transform( cDetallesExistentes.termi      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMREDONDEOENTEROS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","codigo","termialfa","desde","hasta","desdepre","hastapre","termi"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.redoDetPorEnt ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.termialfa  ) + "'" + ',' + transform( cDetallesExistentes.desde      ) + ',' + transform( cDetallesExistentes.hasta      ) + ',' + transform( cDetallesExistentes.desdepre   ) + ',' + transform( cDetallesExistentes.hastapre   ) + ',' + transform( cDetallesExistentes.termi      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMREDONDEOTABLA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","codigo","RedEn","DesdePre","HastaPre"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.redoDetPorTabla ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + transform( cDetallesExistentes.RedEn      ) + ',' + transform( cDetallesExistentes.DesdePre   ) + ',' + transform( cDetallesExistentes.HastaPre   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'REDONDEODEPRECIOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REDONDEODEPRECIOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REDONDEODEPRECIOS_ROBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPRUEBAREDONDEO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICRED'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMREDONDEOCENTAVOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMREDONDEOENTEROS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMREDONDEOTABLA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_redo')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REDONDEODEPRECIOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REDONDEODEPRECIOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REDONDEODEPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REDONDEODEPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_redo') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_redo
Create Table ZooLogic.TablaTrabajo_redo ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"ualtafw" char( 100 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"codigo" char( 10 )  null, 
"redopre" bit  null, 
"redotcent" bit  null, 
"redoent" bit  null, 
"redotent" bit  null, 
"descrip" char( 100 )  null, 
"robs" varchar(max)  null, 
"rtabla" numeric( 2, 0 )  null, 
"rnormal" numeric( 2, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_redo' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_redo' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REDONDEODEPRECIOS'
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
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('redopre','redopre')
			.AgregarMapeo('redotcent','redotcent')
			.AgregarMapeo('redoent','redoent')
			.AgregarMapeo('redotent','redotent')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('robs','robs')
			.AgregarMapeo('rtabla','rtabla')
			.AgregarMapeo('rnormal','rnormal')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_redo'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.REDOPRE = isnull( d.REDOPRE, t.REDOPRE ),t.REDOTCENT = isnull( d.REDOTCENT, t.REDOTCENT ),t.REDOENT = isnull( d.REDOENT, t.REDOENT ),t.REDOTENT = isnull( d.REDOTENT, t.REDOTENT ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.ROBS = isnull( d.ROBS, t.ROBS ),t.RTABLA = isnull( d.RTABLA, t.RTABLA ),t.RNORMAL = isnull( d.RNORMAL, t.RNORMAL )
					from ZooLogic.REDO t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ZooLogic.REDO(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Horaexpo,Haltafw,Horaimpo,Hmodifw,Smodifw,Saltafw,Umodifw,Zadsfw,Valtafw,Bdaltafw,Vmodifw,Bdmodifw,Esttrans,Ualtafw,Tipagrupub,Timestamp,Codigo,Redopre,Redotcent,Redoent,Redotent,Descrip,Robs,Rtabla,Rnormal)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.BDALTAFW,''),isnull( d.VMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.UALTAFW,''),isnull( d.TIPAGRUPUB,0),isnull( d.TIMESTAMP,0),isnull( d.CODIGO,''),isnull( d.REDOPRE,0),isnull( d.REDOTCENT,0),isnull( d.REDOENT,0),isnull( d.REDOTENT,0),isnull( d.DESCRIP,''),isnull( d.ROBS,''),isnull( d.RTABLA,0),isnull( d.RNORMAL,0)
						From deleted d left join ZooLogic.REDO pk 
							 on d.codigo = pk.codigo
						Where pk.codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_redoPrueba( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REDO_redoPrueba
ON ZooLogic.TablaTrabajo_REDO_redoPrueba
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.PRECIO = isnull( d.PRECIO, t.PRECIO ),
t.RESULT = isnull( d.RESULT, t.RESULT )
from ZooLogic.redoPrueba t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.redoPrueba
( 
"NROITEM",
"CODIGO",
"PRECIO",
"RESULT"
 )
Select 
d.NROITEM,
d.CODIGO,
d.PRECIO,
d.RESULT
From deleted d left join ZooLogic.redoPrueba pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubRED( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REDO_AgruPubRED
ON ZooLogic.TablaTrabajo_REDO_AgruPubRED
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubRED t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubRED
( 
"NROITEM",
"CODIGO",
"AGRUP",
"AGRUPDES"
 )
Select 
d.NROITEM,
d.CODIGO,
d.AGRUP,
d.AGRUPDES
From deleted d left join ZooLogic.AgruPubRED pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_redoDetPorCent( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REDO_redoDetPorCent
ON ZooLogic.TablaTrabajo_REDO_redoDetPorCent
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.TERMIALFA = isnull( d.TERMIALFA, t.TERMIALFA ),
t.DESDE = isnull( d.DESDE, t.DESDE ),
t.HASTA = isnull( d.HASTA, t.HASTA ),
t.DESDEPRE = isnull( d.DESDEPRE, t.DESDEPRE ),
t.HASTAPRE = isnull( d.HASTAPRE, t.HASTAPRE ),
t.TERMI = isnull( d.TERMI, t.TERMI )
from ZooLogic.redoDetPorCent t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.redoDetPorCent
( 
"NROITEM",
"CODIGO",
"TERMIALFA",
"DESDE",
"HASTA",
"DESDEPRE",
"HASTAPRE",
"TERMI"
 )
Select 
d.NROITEM,
d.CODIGO,
d.TERMIALFA,
d.DESDE,
d.HASTA,
d.DESDEPRE,
d.HASTAPRE,
d.TERMI
From deleted d left join ZooLogic.redoDetPorCent pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_redoDetPorEnt( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REDO_redoDetPorEnt
ON ZooLogic.TablaTrabajo_REDO_redoDetPorEnt
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.TERMIALFA = isnull( d.TERMIALFA, t.TERMIALFA ),
t.DESDE = isnull( d.DESDE, t.DESDE ),
t.HASTA = isnull( d.HASTA, t.HASTA ),
t.DESDEPRE = isnull( d.DESDEPRE, t.DESDEPRE ),
t.HASTAPRE = isnull( d.HASTAPRE, t.HASTAPRE ),
t.TERMI = isnull( d.TERMI, t.TERMI )
from ZooLogic.redoDetPorEnt t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.redoDetPorEnt
( 
"NROITEM",
"CODIGO",
"TERMIALFA",
"DESDE",
"HASTA",
"DESDEPRE",
"HASTAPRE",
"TERMI"
 )
Select 
d.NROITEM,
d.CODIGO,
d.TERMIALFA,
d.DESDE,
d.HASTA,
d.DESDEPRE,
d.HASTAPRE,
d.TERMI
From deleted d left join ZooLogic.redoDetPorEnt pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_redoDetPorTabla( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_REDO_redoDetPorTabla
ON ZooLogic.TablaTrabajo_REDO_redoDetPorTabla
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.REDEN = isnull( d.REDEN, t.REDEN ),
t.DESDEPRE = isnull( d.DESDEPRE, t.DESDEPRE ),
t.HASTAPRE = isnull( d.HASTAPRE, t.HASTAPRE )
from ZooLogic.redoDetPorTabla t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.redoDetPorTabla
( 
"NROITEM",
"CODIGO",
"REDEN",
"DESDEPRE",
"HASTAPRE"
 )
Select 
d.NROITEM,
d.CODIGO,
d.REDEN,
d.DESDEPRE,
d.HASTAPRE
From deleted d left join ZooLogic.redoDetPorTabla pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_redo') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_redo
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REDONDEODEPRECIOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REDONDEODEPRECIOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REDONDEODEPRECIOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REDONDEODEPRECIOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REDONDEODEPRECIOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REDONDEODEPRECIOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_REDONDEODEPRECIOS.Horaexpo, [] )
					.Horaaltafw = nvl( c_REDONDEODEPRECIOS.Horaaltafw, [] )
					.Horaimpo = nvl( c_REDONDEODEPRECIOS.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_REDONDEODEPRECIOS.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_REDONDEODEPRECIOS.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_REDONDEODEPRECIOS.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_REDONDEODEPRECIOS.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_REDONDEODEPRECIOS.Versionaltafw, [] )
					.Basededatosaltafw = nvl( c_REDONDEODEPRECIOS.Basededatosaltafw, [] )
					.Versionmodificacionfw = nvl( c_REDONDEODEPRECIOS.Versionmodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_REDONDEODEPRECIOS.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_REDONDEODEPRECIOS.Estadotransferencia, [] )
					.Usuarioaltafw = nvl( c_REDONDEODEPRECIOS.Usuarioaltafw, [] )
					.Tipoagrupamientopublicaciones = nvl( c_REDONDEODEPRECIOS.Tipoagrupamientopublicaciones, 0 )
					.Timestamp = nvl( c_REDONDEODEPRECIOS.Timestamp, 0 )
					.Codigo = nvl( c_REDONDEODEPRECIOS.Codigo, [] )
					.Detprueba.Limpiar()
					.Detprueba.SetearEsNavegacion( .lProcesando )
					.Detprueba.Cargar()
					.Habilitaredonearprecios = nvl( c_REDONDEODEPRECIOS.Habilitaredonearprecios, .F. )
					.Habilitaredondeartermcentavos = nvl( c_REDONDEODEPRECIOS.Habilitaredondeartermcentavos, .F. )
					.Habilitaredondearnormal = nvl( c_REDONDEODEPRECIOS.Habilitaredondearnormal, .F. )
					.Habilitaredondeartermenteros = nvl( c_REDONDEODEPRECIOS.Habilitaredondeartermenteros, .F. )
					.Descripcion = nvl( c_REDONDEODEPRECIOS.Descripcion, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Redondeoportabla = nvl( c_REDONDEODEPRECIOS.Redondeoportabla, 0 )
					.Redondeonormal = nvl( c_REDONDEODEPRECIOS.Redondeonormal, 0 )
					.Detredondeoporcentavo.Limpiar()
					.Detredondeoporcentavo.SetearEsNavegacion( .lProcesando )
					.Detredondeoporcentavo.Cargar()
					.Detredondeoporentero.Limpiar()
					.Detredondeoporentero.SetearEsNavegacion( .lProcesando )
					.Detredondeoporentero.Cargar()
					.Detredondeoportabla.Limpiar()
					.Detredondeoportabla.SetearEsNavegacion( .lProcesando )
					.Detredondeoportabla.Cargar()
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
		
		loDetalle = this.oEntidad.detPrueba
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

		loDetalle = this.oEntidad.AgruPubliDetalle
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

		loDetalle = this.oEntidad.DetRedondeoPorCentavo
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

		loDetalle = this.oEntidad.DetRedondeoPorEntero
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

		loDetalle = this.oEntidad.DetRedondeoPorTabla
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
		return c_REDONDEODEPRECIOS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.REDO' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    codigo from (
							select * 
								from ZooLogic.REDO 
								Where   REDO.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REDO", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Ualtafw" as "Usuarioaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Codigo" as "Codigo", "Redopre" as "Habilitaredonearprecios", "Redotcent" as "Habilitaredondeartermcentavos", "Redoent" as "Habilitaredondearnormal", "Redotent" as "Habilitaredondeartermenteros", "Descrip" as "Descripcion", "Robs" as "Observacion", "Rtabla" as "Redondeoportabla", "Rnormal" as "Redondeonormal"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.REDO 
								Where   REDO.CODIGO != ''
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
	Tabla = 'REDO'
	Filtro = " REDO.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REDO.CODIGO != ''"
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
	<row entidad="REDONDEODEPRECIOS                       " atributo="FECHAIMPO                               " tabla="REDO           " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="FECHATRANSFERENCIA                      " tabla="REDO           " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="FECHAMODIFICACIONFW                     " tabla="REDO           " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="FECHAALTAFW                             " tabla="REDO           " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="FECHAEXPO                               " tabla="REDO           " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="HORAEXPO                                " tabla="REDO           " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="HORAALTAFW                              " tabla="REDO           " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="HORAIMPO                                " tabla="REDO           " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="HORAMODIFICACIONFW                      " tabla="REDO           " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="SERIEMODIFICACIONFW                     " tabla="REDO           " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="SERIEALTAFW                             " tabla="REDO           " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="USUARIOMODIFICACIONFW                   " tabla="REDO           " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="ZADSFW                                  " tabla="REDO           " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="VERSIONALTAFW                           " tabla="REDO           " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="BASEDEDATOSALTAFW                       " tabla="REDO           " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="VERSIONMODIFICACIONFW                   " tabla="REDO           " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REDO           " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="ESTADOTRANSFERENCIA                     " tabla="REDO           " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="USUARIOALTAFW                           " tabla="REDO           " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="REDO           " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="TIMESTAMP                               " tabla="REDO           " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="CODIGO                                  " tabla="REDO           " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="DETPRUEBA                               " tabla="REDOPRUEBA     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Detalle                                                                                                                                                         " dominio="DETALLEITEMPRUEBAREDONDEO     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="HABILITAREDONEARPRECIOS                 " tabla="REDO           " campo="REDOPRE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="201" etiqueta="Aplicar redondeo montos                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="HABILITAREDONDEARTERMCENTAVOS           " tabla="REDO           " campo="REDOTCENT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="202" etiqueta="Aplicar redondeo enteros                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="HABILITAREDONDEARNORMAL                 " tabla="REDO           " campo="REDOENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="203" etiqueta="Aplicar redondeo entero                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="HABILITAREDONDEARTERMENTEROS            " tabla="REDO           " campo="REDOTENT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="204" etiqueta="Aplicar redondeo centavos                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="DESCRIPCION                             " tabla="REDO           " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="205" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="OBSERVACION                             " tabla="REDO           " campo="ROBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBRED     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICRED    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="REDONDEOPORTABLA                        " tabla="REDO           " campo="RTABLA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="207" etiqueta="Redondeo por monto                                                                                                                                              " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="REDONDEONORMAL                          " tabla="REDO           " campo="RNORMAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="208" etiqueta="Redondeo a entero                                                                                                                                               " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="DETREDONDEOPORCENTAVO                   " tabla="REDODETPORCENT " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="Detalle redondeo centavos                                                                                                                                       " dominio="DETALLEITEMREDONDEOCENTAVOS   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="DETREDONDEOPORENTERO                    " tabla="REDODETPORENT  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="Detalle redondeo enteros                                                                                                                                        " dominio="DETALLEITEMREDONDEOENTEROS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="DETREDONDEOPORTABLA                     " tabla="REDODETPORTABLA" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="211" etiqueta="Detalle redondeo montos                                                                                                                                         " dominio="DETALLEITEMREDONDEOTABLA      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
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