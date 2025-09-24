
define class Din_EntidadEXPOAGRUPADASAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_EXPOAGRUPADAS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [clasehook]
	cExpresionCCPorCampos = [#tabla#.clasehook]
	cTagClaveCandidata = '_EXACC'
	cTagClavePk = '_EXAPK'
	cTablaPrincipal = 'EXPOAGRUP'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'ORGANIZACION'
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'ORGANIZACION'
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
			local  lxExpoagrupFecexpo, lxExpoagrupFectrans, lxExpoagrupFecimpo, lxExpoagrupFaltafw, lxExpoagrupFmodifw, lxExpoagrupClasehook, lxExpoagrupTimestamp, lxExpoagrupBloqreg, lxExpoagrupSmodifw, lxExpoagrupUaltafw, lxExpoagrupValtafw, lxExpoagrupZadsfw, lxExpoagrupSaltafw, lxExpoagrupVmodifw, lxExpoagrupUmodifw, lxExpoagrupHoraexpo, lxExpoagrupHmodifw, lxExpoagrupEsttrans, lxExpoagrupHaltafw, lxExpoagrupBdaltafw, lxExpoagrupBdmodifw, lxExpoagrupHoraimpo, lxExpoagrupCobs, lxExpoagrupCategoria, lxExpoagrupCodigo, lxExpoagrupFavorito, lxExpoagrupFiltrafec
				lxExpoagrupFecexpo =  .Fechaexpo			lxExpoagrupFectrans =  .Fechatransferencia			lxExpoagrupFecimpo =  .Fechaimpo			lxExpoagrupFaltafw =  .Fechaaltafw			lxExpoagrupFmodifw =  .Fechamodificacionfw			lxExpoagrupClasehook =  .Clasehook			lxExpoagrupTimestamp = goLibrerias.ObtenerTimestamp()			lxExpoagrupBloqreg =  .Bloquearregistro			lxExpoagrupSmodifw =  .Seriemodificacionfw			lxExpoagrupUaltafw =  .Usuarioaltafw			lxExpoagrupValtafw =  .Versionaltafw			lxExpoagrupZadsfw =  .Zadsfw			lxExpoagrupSaltafw =  .Seriealtafw			lxExpoagrupVmodifw =  .Versionmodificacionfw			lxExpoagrupUmodifw =  .Usuariomodificacionfw			lxExpoagrupHoraexpo =  .Horaexpo			lxExpoagrupHmodifw =  .Horamodificacionfw			lxExpoagrupEsttrans =  .Estadotransferencia			lxExpoagrupHaltafw =  .Horaaltafw			lxExpoagrupBdaltafw =  .Basededatosaltafw			lxExpoagrupBdmodifw =  .Basededatosmodificacionfw			lxExpoagrupHoraimpo =  .Horaimpo			lxExpoagrupCobs =  .Obs			lxExpoagrupCategoria =  .Categoria			lxExpoagrupCodigo =  .Codigo			lxExpoagrupFavorito =  .Favorito			lxExpoagrupFiltrafec =  .Filtrafecha
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxExpoagrupCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.EXPOAGRUP ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Clasehook","Timestamp","Bloqreg","Smodifw","Ualtafw","Valtafw","Zadsfw","Saltafw","Vmodifw","Umodifw","Horaexpo","Hmodifw","Esttrans","Haltafw","Bdaltafw","Bdmodifw","Horaimpo","Cobs","Categoria","Codigo","Favorito","Filtrafec" ) values ( <<"'" + this.ConvertirDateSql( lxExpoagrupFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxExpoagrupFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxExpoagrupFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxExpoagrupFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxExpoagrupFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupClasehook ) + "'" >>, <<lxExpoagrupTimestamp >>, <<iif( lxExpoagrupBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxExpoagrupSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupCobs ) + "'" >>, <<lxExpoagrupCategoria >>, <<"'" + this.FormatearTextoSql( lxExpoagrupCodigo ) + "'" >>, <<iif( lxExpoagrupFavorito, 1, 0 ) >>, <<iif( lxExpoagrupFiltrafec, 1, 0 ) >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Disenos
				if this.oEntidad.Disenos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxDiseno_PK = loItem.Diseno_PK
					lxDisenodetalle = loItem.Disenodetalle
					lxAtributofecha = loItem.Atributofecha
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.ExpoAgrupItem("NROITEM","BLOQREG","iCod","diseno","disDet","atrFecha" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDiseno_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDisenodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributofecha ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxExpoagrupTimestamp
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
			local  lxExpoagrupFecexpo, lxExpoagrupFectrans, lxExpoagrupFecimpo, lxExpoagrupFaltafw, lxExpoagrupFmodifw, lxExpoagrupClasehook, lxExpoagrupTimestamp, lxExpoagrupBloqreg, lxExpoagrupSmodifw, lxExpoagrupUaltafw, lxExpoagrupValtafw, lxExpoagrupZadsfw, lxExpoagrupSaltafw, lxExpoagrupVmodifw, lxExpoagrupUmodifw, lxExpoagrupHoraexpo, lxExpoagrupHmodifw, lxExpoagrupEsttrans, lxExpoagrupHaltafw, lxExpoagrupBdaltafw, lxExpoagrupBdmodifw, lxExpoagrupHoraimpo, lxExpoagrupCobs, lxExpoagrupCategoria, lxExpoagrupCodigo, lxExpoagrupFavorito, lxExpoagrupFiltrafec
				lxExpoagrupFecexpo =  .Fechaexpo			lxExpoagrupFectrans =  .Fechatransferencia			lxExpoagrupFecimpo =  .Fechaimpo			lxExpoagrupFaltafw =  .Fechaaltafw			lxExpoagrupFmodifw =  .Fechamodificacionfw			lxExpoagrupClasehook =  .Clasehook			lxExpoagrupTimestamp = goLibrerias.ObtenerTimestamp()			lxExpoagrupBloqreg =  .Bloquearregistro			lxExpoagrupSmodifw =  .Seriemodificacionfw			lxExpoagrupUaltafw =  .Usuarioaltafw			lxExpoagrupValtafw =  .Versionaltafw			lxExpoagrupZadsfw =  .Zadsfw			lxExpoagrupSaltafw =  .Seriealtafw			lxExpoagrupVmodifw =  .Versionmodificacionfw			lxExpoagrupUmodifw =  .Usuariomodificacionfw			lxExpoagrupHoraexpo =  .Horaexpo			lxExpoagrupHmodifw =  .Horamodificacionfw			lxExpoagrupEsttrans =  .Estadotransferencia			lxExpoagrupHaltafw =  .Horaaltafw			lxExpoagrupBdaltafw =  .Basededatosaltafw			lxExpoagrupBdmodifw =  .Basededatosmodificacionfw			lxExpoagrupHoraimpo =  .Horaimpo			lxExpoagrupCobs =  .Obs			lxExpoagrupCategoria =  .Categoria			lxExpoagrupCodigo =  .Codigo			lxExpoagrupFavorito =  .Favorito			lxExpoagrupFiltrafec =  .Filtrafecha
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
				update ORGANIZACION.EXPOAGRUP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxExpoagrupFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxExpoagrupFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxExpoagrupFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxExpoagrupFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxExpoagrupFmodifw ) + "'">>,"Clasehook" = <<"'" + this.FormatearTextoSql( lxExpoagrupClasehook ) + "'">>,"Timestamp" = <<lxExpoagrupTimestamp>>,"Bloqreg" = <<iif( lxExpoagrupBloqreg, 1, 0 )>>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxExpoagrupZadsfw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupUmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxExpoagrupHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxExpoagrupEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxExpoagrupHoraimpo ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxExpoagrupCobs ) + "'">>,"Categoria" = <<lxExpoagrupCategoria>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxExpoagrupCodigo ) + "'">>,"Favorito" = <<iif( lxExpoagrupFavorito, 1, 0 )>>,"Filtrafec" = <<iif( lxExpoagrupFiltrafec, 1, 0 )>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxExpoagrupCodigo ) + "'">> and  EXPOAGRUP.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.ExpoAgrupItem where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Disenos
				if this.oEntidad.Disenos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxDiseno_PK = loItem.Diseno_PK
					lxDisenodetalle = loItem.Disenodetalle
					lxAtributofecha = loItem.Atributofecha
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.ExpoAgrupItem("NROITEM","BLOQREG","iCod","diseno","disDet","atrFecha" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDiseno_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDisenodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributofecha ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxExpoagrupTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ORGANIZACION.EXPOAGRUP where " + this.ConvertirFuncionesSql( " EXPOAGRUP.CODIGO != ''" ) )
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
			Local lxExpoagrupCodigo
			lxExpoagrupCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Clasehook" as "Clasehook", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Cobs" as "Obs", "Categoria" as "Categoria", "Codigo" as "Codigo", "Favorito" as "Favorito", "Filtrafec" as "Filtrafecha" from ORGANIZACION.EXPOAGRUP where "Codigo" = <<"'" + this.FormatearTextoSql( lxExpoagrupCodigo ) + "'">> and  EXPOAGRUP.CODIGO != ''
			endtext
			use in select('c_EXPOAGRUPADAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EXPOAGRUPADAS', set( 'Datasession' ) )

			if reccount( 'c_EXPOAGRUPADAS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Diseno" as "Diseno", "Disdet" as "Disenodetalle", "Atrfecha" as "Atributofecha" from ORGANIZACION.ExpoAgrupItem where iCod = <<"'" + this.FormatearTextoSql( c_EXPOAGRUPADAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Disenos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Disenos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Disenos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxExpoAgrupclasehook As Variant
			lxExpoAgrupclasehook = .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Clasehook" as "Clasehook", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Cobs" as "Obs", "Categoria" as "Categoria", "Codigo" as "Codigo", "Favorito" as "Favorito", "Filtrafec" as "Filtrafecha" from ORGANIZACION.EXPOAGRUP where  EXPOAGRUP.CODIGO != '' And clasehook = <<"'" + this.FormatearTextoSql( lxExpoAgrupclasehook ) + "'">>
			endtext
			use in select('c_EXPOAGRUPADAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EXPOAGRUPADAS', set( 'Datasession' ) )
			if reccount( 'c_EXPOAGRUPADAS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Diseno" as "Diseno", "Disdet" as "Disenodetalle", "Atrfecha" as "Atributofecha" from ORGANIZACION.ExpoAgrupItem where iCod = <<"'" + this.FormatearTextoSql( c_EXPOAGRUPADAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Disenos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Disenos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Disenos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxExpoagrupCodigo as Variant
		llRetorno = .t.
		lxExpoagrupCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.EXPOAGRUP where "Codigo" = <<"'" + this.FormatearTextoSql( lxExpoagrupCodigo ) + "'">> and  EXPOAGRUP.CODIGO != ''
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
				lcOrden =  .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Clasehook" as "Clasehook", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Cobs" as "Obs", "Categoria" as "Categoria", "Codigo" as "Codigo", "Favorito" as "Favorito", "Filtrafec" as "Filtrafecha" from ORGANIZACION.EXPOAGRUP where  EXPOAGRUP.CODIGO != '' order by clasehook
			endtext
			use in select('c_EXPOAGRUPADAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EXPOAGRUPADAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Diseno" as "Diseno", "Disdet" as "Disenodetalle", "Atrfecha" as "Atributofecha" from ORGANIZACION.ExpoAgrupItem where iCod = <<"'" + this.FormatearTextoSql( c_EXPOAGRUPADAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Disenos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Disenos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Disenos
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
				lcOrden =  .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Clasehook" as "Clasehook", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Cobs" as "Obs", "Categoria" as "Categoria", "Codigo" as "Codigo", "Favorito" as "Favorito", "Filtrafec" as "Filtrafecha" from ORGANIZACION.EXPOAGRUP where  funciones.padr( clasehook, 100, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  EXPOAGRUP.CODIGO != '' order by clasehook
			endtext
			use in select('c_EXPOAGRUPADAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EXPOAGRUPADAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Diseno" as "Diseno", "Disdet" as "Disenodetalle", "Atrfecha" as "Atributofecha" from ORGANIZACION.ExpoAgrupItem where iCod = <<"'" + this.FormatearTextoSql( c_EXPOAGRUPADAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Disenos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Disenos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Disenos
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
				lcOrden =  .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Clasehook" as "Clasehook", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Cobs" as "Obs", "Categoria" as "Categoria", "Codigo" as "Codigo", "Favorito" as "Favorito", "Filtrafec" as "Filtrafecha" from ORGANIZACION.EXPOAGRUP where  funciones.padr( clasehook, 100, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  EXPOAGRUP.CODIGO != '' order by clasehook desc
			endtext
			use in select('c_EXPOAGRUPADAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EXPOAGRUPADAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Diseno" as "Diseno", "Disdet" as "Disenodetalle", "Atrfecha" as "Atributofecha" from ORGANIZACION.ExpoAgrupItem where iCod = <<"'" + this.FormatearTextoSql( c_EXPOAGRUPADAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Disenos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Disenos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Disenos
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
				lcOrden =  .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Clasehook" as "Clasehook", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Cobs" as "Obs", "Categoria" as "Categoria", "Codigo" as "Codigo", "Favorito" as "Favorito", "Filtrafec" as "Filtrafecha" from ORGANIZACION.EXPOAGRUP where  EXPOAGRUP.CODIGO != '' order by clasehook desc
			endtext
			use in select('c_EXPOAGRUPADAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EXPOAGRUPADAS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Diseno" as "Diseno", "Disdet" as "Disenodetalle", "Atrfecha" as "Atributofecha" from ORGANIZACION.ExpoAgrupItem where iCod = <<"'" + this.FormatearTextoSql( c_EXPOAGRUPADAS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Disenos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Disenos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Disenos
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Clasehook,Timestamp,Bloqreg,Smodifw,Ualtafw,Valtafw" + ;
",Zadsfw,Saltafw,Vmodifw,Umodifw,Horaexpo,Hmodifw,Esttrans,Haltafw,Bdaltafw,Bdmodifw,Horaimpo,Cobs,Ca" + ;
"tegoria,Codigo,Favorito,Filtrafec" + ;
" from ORGANIZACION.EXPOAGRUP where  EXPOAGRUP.CODIGO != '' and " + lcFiltro )
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
			local  lxExpoagrupFecexpo, lxExpoagrupFectrans, lxExpoagrupFecimpo, lxExpoagrupFaltafw, lxExpoagrupFmodifw, lxExpoagrupClasehook, lxExpoagrupTimestamp, lxExpoagrupBloqreg, lxExpoagrupSmodifw, lxExpoagrupUaltafw, lxExpoagrupValtafw, lxExpoagrupZadsfw, lxExpoagrupSaltafw, lxExpoagrupVmodifw, lxExpoagrupUmodifw, lxExpoagrupHoraexpo, lxExpoagrupHmodifw, lxExpoagrupEsttrans, lxExpoagrupHaltafw, lxExpoagrupBdaltafw, lxExpoagrupBdmodifw, lxExpoagrupHoraimpo, lxExpoagrupCobs, lxExpoagrupCategoria, lxExpoagrupCodigo, lxExpoagrupFavorito, lxExpoagrupFiltrafec
				lxExpoagrupFecexpo = ctod( '  /  /    ' )			lxExpoagrupFectrans = ctod( '  /  /    ' )			lxExpoagrupFecimpo = ctod( '  /  /    ' )			lxExpoagrupFaltafw = ctod( '  /  /    ' )			lxExpoagrupFmodifw = ctod( '  /  /    ' )			lxExpoagrupClasehook = []			lxExpoagrupTimestamp = goLibrerias.ObtenerTimestamp()			lxExpoagrupBloqreg = .F.			lxExpoagrupSmodifw = []			lxExpoagrupUaltafw = []			lxExpoagrupValtafw = []			lxExpoagrupZadsfw = []			lxExpoagrupSaltafw = []			lxExpoagrupVmodifw = []			lxExpoagrupUmodifw = []			lxExpoagrupHoraexpo = []			lxExpoagrupHmodifw = []			lxExpoagrupEsttrans = []			lxExpoagrupHaltafw = []			lxExpoagrupBdaltafw = []			lxExpoagrupBdmodifw = []			lxExpoagrupHoraimpo = []			lxExpoagrupCobs = []			lxExpoagrupCategoria = 0			lxExpoagrupCodigo = []			lxExpoagrupFavorito = .F.			lxExpoagrupFiltrafec = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.ExpoAgrupItem where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.EXPOAGRUP where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'EXPOAGRUP' + '_' + tcCampo
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
		lcWhere = " Where  EXPOAGRUP.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Clasehook" as "Clasehook", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Cobs" as "Obs", "Categoria" as "Categoria", "Codigo" as "Codigo", "Favorito" as "Favorito", "Filtrafec" as "Filtrafecha"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'EXPOAGRUP', '', tnTope )
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
	Function ObtenerDatosDetalleDisenos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  EXPOAGRUPITEM.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Diseno" as "Diseno", "Disdet" as "Disenodetalle", "Atrfecha" as "Atributofecha"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDisenos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ExpoAgrupItem', 'Disenos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDisenos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDisenos( lcAtributo )
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
				Case lcAtributo == 'CLASEHOOK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASEHOOK AS CLASEHOOK'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBS'
				Case lcAtributo == 'CATEGORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATEGORIA AS CATEGORIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FAVORITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAVORITO AS FAVORITO'
				Case lcAtributo == 'FILTRAFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FILTRAFEC AS FILTRAFECHA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDisenos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOD AS CODIGO'
				Case lcAtributo == 'DISENO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISENO AS DISENO'
				Case lcAtributo == 'DISENODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISDET AS DISENODETALLE'
				Case lcAtributo == 'ATRIBUTOFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ATRFECHA AS ATRIBUTOFECHA'
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
			Case upper( alltrim( tcAtributo ) ) == 'CLASEHOOK'
				lcCampo = 'CLASEHOOK'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGORIA'
				lcCampo = 'CATEGORIA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FAVORITO'
				lcCampo = 'FAVORITO'
			Case upper( alltrim( tcAtributo ) ) == 'FILTRAFECHA'
				lcCampo = 'FILTRAFEC'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDisenos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ICOD'
			Case upper( alltrim( tcAtributo ) ) == 'DISENO'
				lcCampo = 'DISENO'
			Case upper( alltrim( tcAtributo ) ) == 'DISENODETALLE'
				lcCampo = 'DISDET'
			Case upper( alltrim( tcAtributo ) ) == 'ATRIBUTOFECHA'
				lcCampo = 'ATRFECHA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DISENOS'
			lcRetorno = 'EXPOAGRUPITEM'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxExpoagrupFecexpo, lxExpoagrupFectrans, lxExpoagrupFecimpo, lxExpoagrupFaltafw, lxExpoagrupFmodifw, lxExpoagrupClasehook, lxExpoagrupTimestamp, lxExpoagrupBloqreg, lxExpoagrupSmodifw, lxExpoagrupUaltafw, lxExpoagrupValtafw, lxExpoagrupZadsfw, lxExpoagrupSaltafw, lxExpoagrupVmodifw, lxExpoagrupUmodifw, lxExpoagrupHoraexpo, lxExpoagrupHmodifw, lxExpoagrupEsttrans, lxExpoagrupHaltafw, lxExpoagrupBdaltafw, lxExpoagrupBdmodifw, lxExpoagrupHoraimpo, lxExpoagrupCobs, lxExpoagrupCategoria, lxExpoagrupCodigo, lxExpoagrupFavorito, lxExpoagrupFiltrafec
				lxExpoagrupFecexpo =  .Fechaexpo			lxExpoagrupFectrans =  .Fechatransferencia			lxExpoagrupFecimpo =  .Fechaimpo			lxExpoagrupFaltafw =  .Fechaaltafw			lxExpoagrupFmodifw =  .Fechamodificacionfw			lxExpoagrupClasehook =  .Clasehook			lxExpoagrupTimestamp = goLibrerias.ObtenerTimestamp()			lxExpoagrupBloqreg =  .Bloquearregistro			lxExpoagrupSmodifw =  .Seriemodificacionfw			lxExpoagrupUaltafw =  .Usuarioaltafw			lxExpoagrupValtafw =  .Versionaltafw			lxExpoagrupZadsfw =  .Zadsfw			lxExpoagrupSaltafw =  .Seriealtafw			lxExpoagrupVmodifw =  .Versionmodificacionfw			lxExpoagrupUmodifw =  .Usuariomodificacionfw			lxExpoagrupHoraexpo =  .Horaexpo			lxExpoagrupHmodifw =  .Horamodificacionfw			lxExpoagrupEsttrans =  .Estadotransferencia			lxExpoagrupHaltafw =  .Horaaltafw			lxExpoagrupBdaltafw =  .Basededatosaltafw			lxExpoagrupBdmodifw =  .Basededatosmodificacionfw			lxExpoagrupHoraimpo =  .Horaimpo			lxExpoagrupCobs =  .Obs			lxExpoagrupCategoria =  .Categoria			lxExpoagrupCodigo =  .Codigo			lxExpoagrupFavorito =  .Favorito			lxExpoagrupFiltrafec =  .Filtrafecha
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.EXPOAGRUP ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Clasehook","Timestamp","Bloqreg","Smodifw","Ualtafw","Valtafw","Zadsfw","Saltafw","Vmodifw","Umodifw","Horaexpo","Hmodifw","Esttrans","Haltafw","Bdaltafw","Bdmodifw","Horaimpo","Cobs","Categoria","Codigo","Favorito","Filtrafec" ) values ( <<"'" + this.ConvertirDateSql( lxExpoagrupFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxExpoagrupFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxExpoagrupFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxExpoagrupFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxExpoagrupFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupClasehook ) + "'" >>, <<lxExpoagrupTimestamp >>, <<iif( lxExpoagrupBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxExpoagrupSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxExpoagrupCobs ) + "'" >>, <<lxExpoagrupCategoria >>, <<"'" + this.FormatearTextoSql( lxExpoagrupCodigo ) + "'" >>, <<iif( lxExpoagrupFavorito, 1, 0 ) >>, <<iif( lxExpoagrupFiltrafec, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'EXPOAGRUP' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Disenos
				if this.oEntidad.Disenos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxDiseno_PK = loItem.Diseno_PK
					lxDisenodetalle = loItem.Disenodetalle
					lxAtributofecha = loItem.Atributofecha
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.ExpoAgrupItem("NROITEM","BLOQREG","iCod","diseno","disDet","atrFecha" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDiseno_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDisenodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributofecha ) + "'">> ) 
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
			local  lxExpoagrupFecexpo, lxExpoagrupFectrans, lxExpoagrupFecimpo, lxExpoagrupFaltafw, lxExpoagrupFmodifw, lxExpoagrupClasehook, lxExpoagrupTimestamp, lxExpoagrupBloqreg, lxExpoagrupSmodifw, lxExpoagrupUaltafw, lxExpoagrupValtafw, lxExpoagrupZadsfw, lxExpoagrupSaltafw, lxExpoagrupVmodifw, lxExpoagrupUmodifw, lxExpoagrupHoraexpo, lxExpoagrupHmodifw, lxExpoagrupEsttrans, lxExpoagrupHaltafw, lxExpoagrupBdaltafw, lxExpoagrupBdmodifw, lxExpoagrupHoraimpo, lxExpoagrupCobs, lxExpoagrupCategoria, lxExpoagrupCodigo, lxExpoagrupFavorito, lxExpoagrupFiltrafec
				lxExpoagrupFecexpo =  .Fechaexpo			lxExpoagrupFectrans =  .Fechatransferencia			lxExpoagrupFecimpo =  .Fechaimpo			lxExpoagrupFaltafw =  .Fechaaltafw			lxExpoagrupFmodifw =  .Fechamodificacionfw			lxExpoagrupClasehook =  .Clasehook			lxExpoagrupTimestamp = goLibrerias.ObtenerTimestamp()			lxExpoagrupBloqreg =  .Bloquearregistro			lxExpoagrupSmodifw =  .Seriemodificacionfw			lxExpoagrupUaltafw =  .Usuarioaltafw			lxExpoagrupValtafw =  .Versionaltafw			lxExpoagrupZadsfw =  .Zadsfw			lxExpoagrupSaltafw =  .Seriealtafw			lxExpoagrupVmodifw =  .Versionmodificacionfw			lxExpoagrupUmodifw =  .Usuariomodificacionfw			lxExpoagrupHoraexpo =  .Horaexpo			lxExpoagrupHmodifw =  .Horamodificacionfw			lxExpoagrupEsttrans =  .Estadotransferencia			lxExpoagrupHaltafw =  .Horaaltafw			lxExpoagrupBdaltafw =  .Basededatosaltafw			lxExpoagrupBdmodifw =  .Basededatosmodificacionfw			lxExpoagrupHoraimpo =  .Horaimpo			lxExpoagrupCobs =  .Obs			lxExpoagrupCategoria =  .Categoria			lxExpoagrupCodigo =  .Codigo			lxExpoagrupFavorito =  .Favorito			lxExpoagrupFiltrafec =  .Filtrafecha
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  EXPOAGRUP.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.EXPOAGRUP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxExpoagrupFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxExpoagrupFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxExpoagrupFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxExpoagrupFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxExpoagrupFmodifw ) + "'">>, "Clasehook" = <<"'" + this.FormatearTextoSql( lxExpoagrupClasehook ) + "'">>, "Timestamp" = <<lxExpoagrupTimestamp>>, "Bloqreg" = <<iif( lxExpoagrupBloqreg, 1, 0 )>>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxExpoagrupZadsfw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupUmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxExpoagrupHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxExpoagrupEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxExpoagrupBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxExpoagrupBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxExpoagrupHoraimpo ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxExpoagrupCobs ) + "'">>, "Categoria" = <<lxExpoagrupCategoria>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxExpoagrupCodigo ) + "'">>, "Favorito" = <<iif( lxExpoagrupFavorito, 1, 0 )>>, "Filtrafec" = <<iif( lxExpoagrupFiltrafec, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'EXPOAGRUP' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ORGANIZACION.ExpoAgrupItem where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Disenos
				if this.oEntidad.Disenos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxDiseno_PK = loItem.Diseno_PK
					lxDisenodetalle = loItem.Disenodetalle
					lxAtributofecha = loItem.Atributofecha
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.ExpoAgrupItem("NROITEM","BLOQREG","iCod","diseno","disDet","atrFecha" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDiseno_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDisenodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributofecha ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  EXPOAGRUP.CODIGO != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.EXPOAGRUP where ' + lcFiltro )
			loColeccion.Agregar([delete from ORGANIZACION.ExpoAgrupItem where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'EXPOAGRUP' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.EXPOAGRUP where  EXPOAGRUP.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.EXPOAGRUP where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  EXPOAGRUP.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxExpoAgrupclasehook as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'EXPOAGRUPADAS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.EXPOAGRUP Where  clasehook = ] + "'" + this.FormatearTextoSql( &lcCursor..clasehook  ) + "'", 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.EXPOAGRUP set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, clasehook = ] + "'" + this.FormatearTextoSql( &lcCursor..clasehook ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"+ [, categoria = ] + transform( &lcCursor..categoria )+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, favorito = ] + Transform( iif( &lcCursor..favorito, 1, 0 ))+ [, filtrafec = ] + Transform( iif( &lcCursor..filtrafec, 1, 0 )) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ORGANIZACION.EXPOAGRUP Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, clasehook, TIMESTAMP, BLOQREG, SMODIFW, UALTAFW, VALTAFW, ZADSFW, SALTAFW, VMODIFW, UMODIFW, HORAEXPO, HMODIFW, ESTTRANS, HALTAFW, BDALTAFW, BDMODIFW, HORAIMPO, cObs, categoria, Codigo, favorito, filtrafec
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..clasehook ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'" + ',' + transform( &lcCursor..categoria ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + Transform( iif( &lcCursor..favorito, 1, 0 )) + ',' + Transform( iif( &lcCursor..filtrafec, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ORGANIZACION.EXPOAGRUP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'EXPOAGRUPADAS'
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
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.ExpoAgrupItem Where iCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMEXPOAGRUPADAS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","iCod","diseno","disDet","atrFecha"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.ExpoAgrupItem ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.diseno     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.disDet     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.atrFecha   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Clase hook: ' + transform( &tcCursor..clasehook  )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'EXPOAGRUPADAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'EXPOAGRUPADAS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'EXPOAGRUPADAS_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMEXPOAGRUPADAS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_ExpoAgrup')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'EXPOAGRUPADAS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..clasehook )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad EXPOAGRUPADAS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'EXPOAGRUPADAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,clasehook as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( clasehook, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'EXPOAGRUPADAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_ExpoAgrup') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_ExpoAgrup
Create Table ORGANIZACION.TablaTrabajo_ExpoAgrup ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"clasehook" char( 100 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"bloqreg" bit  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"cobs" varchar(max)  null, 
"categoria" numeric( 2, 0 )  null, 
"codigo" char( 20 )  null, 
"favorito" bit  null, 
"filtrafec" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ExpoAgrup' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ExpoAgrup' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'EXPOAGRUPADAS'
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
			.AgregarMapeo('clasehook','clasehook')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('categoria','categoria')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('favorito','favorito')
			.AgregarMapeo('filtrafec','filtrafec')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_ExpoAgrup'
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
			CREATE TRIGGER ORGANIZACION.DELETE_<<lcTabla>>
				ON ORGANIZACION.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.CLASEHOOK = isnull( d.CLASEHOOK, t.CLASEHOOK ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.COBS = isnull( d.COBS, t.COBS ),t.CATEGORIA = isnull( d.CATEGORIA, t.CATEGORIA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FAVORITO = isnull( d.FAVORITO, t.FAVORITO ),t.FILTRAFEC = isnull( d.FILTRAFEC, t.FILTRAFEC )
					from ORGANIZACION.EXPOAGRUP t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.clasehook = d.clasehook
				-- Fin Updates
				insert into ORGANIZACION.EXPOAGRUP(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Clasehook,Timestamp,Bloqreg,Smodifw,Ualtafw,Valtafw,Zadsfw,Saltafw,Vmodifw,Umodifw,Horaexpo,Hmodifw,Esttrans,Haltafw,Bdaltafw,Bdmodifw,Horaimpo,Cobs,Categoria,Codigo,Favorito,Filtrafec)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.CLASEHOOK,''),isnull( d.TIMESTAMP,0),isnull( d.BLOQREG,0),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.COBS,''),isnull( d.CATEGORIA,0),isnull( d.CODIGO,''),isnull( d.FAVORITO,0),isnull( d.FILTRAFEC,0)
						From deleted d left join ORGANIZACION.EXPOAGRUP pk 
							 on d.Codigo = pk.Codigo
						 left join ORGANIZACION.EXPOAGRUP cc 
							 on  d.clasehook = cc.clasehook
						Where pk.Codigo Is Null 
							 and cc.clasehook Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CLASE HOOK ' + cast( d.clasehook as Varchar(100) ) + '','La clave principal no es la esperada'
					from ORGANIZACION.EXPOAGRUP t inner join deleted d 
							on   t.clasehook = d.clasehook
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CLASE HOOK ' + cast( d.clasehook as Varchar(100) ) + '','La clave principal a importar ya existe'
					from ORGANIZACION.EXPOAGRUP t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.clasehook = h.clasehook
							where   h.clasehook is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ExpoAgrupItem( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_EXPOAGRUP_ExpoAgrupItem
ON ORGANIZACION.TablaTrabajo_EXPOAGRUP_ExpoAgrupItem
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.DISENO = isnull( d.DISENO, t.DISENO ),
t.DISDET = isnull( d.DISDET, t.DISDET ),
t.ATRFECHA = isnull( d.ATRFECHA, t.ATRFECHA )
from ORGANIZACION.ExpoAgrupItem t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.ExpoAgrupItem
( 
"NROITEM",
"BLOQREG",
"ICOD",
"DISENO",
"DISDET",
"ATRFECHA"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.ICOD,
d.DISENO,
d.DISDET,
d.ATRFECHA
From deleted d left join ORGANIZACION.ExpoAgrupItem pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_ExpoAgrup') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_ExpoAgrup
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_EXPOAGRUPADAS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_EXPOAGRUPADAS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_EXPOAGRUPADAS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_EXPOAGRUPADAS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_EXPOAGRUPADAS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_EXPOAGRUPADAS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Clasehook = nvl( c_EXPOAGRUPADAS.Clasehook, [] )
					.Timestamp = nvl( c_EXPOAGRUPADAS.Timestamp, 0 )
					.Bloquearregistro = nvl( c_EXPOAGRUPADAS.Bloquearregistro, .F. )
					.Seriemodificacionfw = nvl( c_EXPOAGRUPADAS.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_EXPOAGRUPADAS.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_EXPOAGRUPADAS.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriealtafw = nvl( c_EXPOAGRUPADAS.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_EXPOAGRUPADAS.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_EXPOAGRUPADAS.Usuariomodificacionfw, [] )
					.Horaexpo = nvl( c_EXPOAGRUPADAS.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_EXPOAGRUPADAS.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_EXPOAGRUPADAS.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_EXPOAGRUPADAS.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_EXPOAGRUPADAS.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_EXPOAGRUPADAS.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_EXPOAGRUPADAS.Horaimpo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Categoria = nvl( c_EXPOAGRUPADAS.Categoria, 0 )
					.Codigo = nvl( c_EXPOAGRUPADAS.Codigo, [] )
					.Favorito = nvl( c_EXPOAGRUPADAS.Favorito, .F. )
					.Filtrafecha = nvl( c_EXPOAGRUPADAS.Filtrafecha, .F. )
					.Disenos.Limpiar()
					.Disenos.SetearEsNavegacion( .lProcesando )
					.Disenos.Cargar()
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
			lxRetorno = c_EXPOAGRUPADAS.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.Disenos
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
		return c_EXPOAGRUPADAS.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.EXPOAGRUP' )
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
								from ORGANIZACION.EXPOAGRUP 
								Where   EXPOAGRUP.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "EXPOAGRUP", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Clasehook" as "Clasehook", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Cobs" as "Obs", "Categoria" as "Categoria", "Codigo" as "Codigo", "Favorito" as "Favorito", "Filtrafec" as "Filtrafecha"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.EXPOAGRUP 
								Where   EXPOAGRUP.CODIGO != ''
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
	Tabla = 'EXPOAGRUP'
	Filtro = " EXPOAGRUP.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " EXPOAGRUP.CODIGO != ''"
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
	<row entidad="EXPOAGRUPADAS                           " atributo="FECHAEXPO                               " tabla="EXPOAGRUP      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="FECHATRANSFERENCIA                      " tabla="EXPOAGRUP      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="FECHAIMPO                               " tabla="EXPOAGRUP      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="FECHAALTAFW                             " tabla="EXPOAGRUP      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="FECHAMODIFICACIONFW                     " tabla="EXPOAGRUP      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="CLASEHOOK                               " tabla="EXPOAGRUP      " campo="CLASEHOOK " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Clase hook                                                                                                                                                      " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="TIMESTAMP                               " tabla="EXPOAGRUP      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="BLOQUEARREGISTRO                        " tabla="EXPOAGRUP      " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="SERIEMODIFICACIONFW                     " tabla="EXPOAGRUP      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="USUARIOALTAFW                           " tabla="EXPOAGRUP      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="VERSIONALTAFW                           " tabla="EXPOAGRUP      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="ZADSFW                                  " tabla="EXPOAGRUP      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="SERIEALTAFW                             " tabla="EXPOAGRUP      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="VERSIONMODIFICACIONFW                   " tabla="EXPOAGRUP      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="USUARIOMODIFICACIONFW                   " tabla="EXPOAGRUP      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="HORAEXPO                                " tabla="EXPOAGRUP      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="HORAMODIFICACIONFW                      " tabla="EXPOAGRUP      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="ESTADOTRANSFERENCIA                     " tabla="EXPOAGRUP      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="HORAALTAFW                              " tabla="EXPOAGRUP      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="BASEDEDATOSALTAFW                       " tabla="EXPOAGRUP      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="EXPOAGRUP      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="HORAIMPO                                " tabla="EXPOAGRUP      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="OBS                                     " tabla="EXPOAGRUP      " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="CATEGORIA                               " tabla="EXPOAGRUP      " campo="CATEGORIA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="201" etiqueta="Categoría                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="CODIGO                                  " tabla="EXPOAGRUP      " campo="CODIGO    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="FAVORITO                                " tabla="EXPOAGRUP      " campo="FAVORITO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="202" etiqueta="Favorito                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="FILTRAFECHA                             " tabla="EXPOAGRUP      " campo="FILTRAFEC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Filtra por fecha                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EXPOAGRUPADAS                           " atributo="DISENOS                                 " tabla="EXPOAGRUPITEM  " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Diseños                                                                                                                                                         " dominio="DETALLEITEMEXPOAGRUPADAS      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
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