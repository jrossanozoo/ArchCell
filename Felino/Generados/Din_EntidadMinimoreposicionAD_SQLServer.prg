
define class Din_EntidadMINIMOREPOSICIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MINIMOREPOSICION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_MINPK'
	cTablaPrincipal = 'MINREPO'
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
			local  lxMinrepoFecexpo, lxMinrepoFmodifw, lxMinrepoFecimpo, lxMinrepoFaltafw, lxMinrepoFectrans, lxMinrepoTimestamp, lxMinrepoUmodifw, lxMinrepoSmodifw, lxMinrepoUaltafw, lxMinrepoVmodifw, lxMinrepoDescfw, lxMinrepoSaltafw, lxMinrepoZadsfw, lxMinrepoValtafw, lxMinrepoHoraexpo, lxMinrepoHmodifw, lxMinrepoBdmodifw, lxMinrepoHaltafw, lxMinrepoBdaltafw, lxMinrepoEsttrans, lxMinrepoHoraimpo, lxMinrepoCodigo, lxMinrepoMobs, lxMinrepoFecha, lxMinrepoNumero, lxMinrepoFechavig
				lxMinrepoFecexpo =  .Fechaexpo			lxMinrepoFmodifw =  .Fechamodificacionfw			lxMinrepoFecimpo =  .Fechaimpo			lxMinrepoFaltafw =  .Fechaaltafw			lxMinrepoFectrans =  .Fechatransferencia			lxMinrepoTimestamp = goLibrerias.ObtenerTimestamp()			lxMinrepoUmodifw =  .Usuariomodificacionfw			lxMinrepoSmodifw =  .Seriemodificacionfw			lxMinrepoUaltafw =  .Usuarioaltafw			lxMinrepoVmodifw =  .Versionmodificacionfw			lxMinrepoDescfw =  .Descripcionfw			lxMinrepoSaltafw =  .Seriealtafw			lxMinrepoZadsfw =  .Zadsfw			lxMinrepoValtafw =  .Versionaltafw			lxMinrepoHoraexpo =  .Horaexpo			lxMinrepoHmodifw =  .Horamodificacionfw			lxMinrepoBdmodifw =  .Basededatosmodificacionfw			lxMinrepoHaltafw =  .Horaaltafw			lxMinrepoBdaltafw =  .Basededatosaltafw			lxMinrepoEsttrans =  .Estadotransferencia			lxMinrepoHoraimpo =  .Horaimpo			lxMinrepoCodigo =  .Codigo			lxMinrepoMobs =  .Observacion			lxMinrepoFecha =  .Fecha			lxMinrepoNumero =  .Numero			lxMinrepoFechavig =  .Vigencia
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxMinrepoCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MINREPO ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Timestamp","Umodifw","Smodifw","Ualtafw","Vmodifw","Descfw","Saltafw","Zadsfw","Valtafw","Horaexpo","Hmodifw","Bdmodifw","Haltafw","Bdaltafw","Esttrans","Horaimpo","Codigo","Mobs","Fecha","Numero","Fechavig" ) values ( <<"'" + this.ConvertirDateSql( lxMinrepoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFectrans ) + "'" >>, <<lxMinrepoTimestamp >>, <<"'" + this.FormatearTextoSql( lxMinrepoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoMobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFecha ) + "'" >>, <<lxMinrepoNumero >>, <<"'" + this.ConvertirDateSql( lxMinrepoFechavig ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MinRepo
				if this.oEntidad.MinRepo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidadactual = loItem.Cantidadactual
					lxCantidad = loItem.Cantidad
					lxMaxactual = loItem.Maxactual
					lxMaxnuevo = loItem.Maxnuevo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MINREPODET("CODIGO","NROITEM","COMP","CodArt","DescArt","CodCol","DescCol","CodTal","CantActual","Cantidad","MaxActual","MaxNuevo" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidadactual>>, <<lxCantidad>>, <<lxMaxactual>>, <<lxMaxnuevo>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
			dodefault()
			local lxCodigo
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			this.oSP.ActualizarMinimoReposicion(lxCodigo)
			local lxCodigo, lxFechaAltaFW, lxFechaModificacionFW, lxHoraAltaFW, lxHoraModificacionFW, lxUsuarioAltaFW, lxUsuarioModificacionFW, lxSerieAltaFW, lxSerieModificacionFW, lxBaseDeDatosAltaFW, lxBaseDeDatosModificacionFW, lxDescripcionFW
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			lxFechaAltaFW = this.oEntidad.FechaAltaFW
			lxFechaModificacionFW = this.oEntidad.FechaModificacionFW
			if empty( this.oEntidad.HoraAltaFW )
				lxHoraAltaFW = null
			else
				lxHoraAltaFW = this.oEntidad.HoraAltaFW
			endif
			if empty( this.oEntidad.HoraModificacionFW )
				lxHoraModificacionFW = null
			else
				lxHoraModificacionFW = this.oEntidad.HoraModificacionFW
			endif
			if empty( this.oEntidad.UsuarioAltaFW )
				lxUsuarioAltaFW = null
			else
				lxUsuarioAltaFW = this.oEntidad.UsuarioAltaFW
			endif
			if empty( this.oEntidad.UsuarioModificacionFW )
				lxUsuarioModificacionFW = null
			else
				lxUsuarioModificacionFW = this.oEntidad.UsuarioModificacionFW
			endif
			if empty( this.oEntidad.SerieAltaFW )
				lxSerieAltaFW = null
			else
				lxSerieAltaFW = this.oEntidad.SerieAltaFW
			endif
			if empty( this.oEntidad.SerieModificacionFW )
				lxSerieModificacionFW = null
			else
				lxSerieModificacionFW = this.oEntidad.SerieModificacionFW
			endif
			if empty( this.oEntidad.BaseDeDatosAltaFW )
				lxBaseDeDatosAltaFW = null
			else
				lxBaseDeDatosAltaFW = this.oEntidad.BaseDeDatosAltaFW
			endif
			if empty( this.oEntidad.BaseDeDatosModificacionFW )
				lxBaseDeDatosModificacionFW = null
			else
				lxBaseDeDatosModificacionFW = this.oEntidad.BaseDeDatosModificacionFW
			endif
			if empty( this.oEntidad.DescripcionFW )
				lxDescripcionFW = null
			else
				lxDescripcionFW = this.oEntidad.DescripcionFW
			endif
			this.oSP.InsertarMinimoReposicion(lxCodigo, lxFechaAltaFW, lxFechaModificacionFW, lxHoraAltaFW, lxHoraModificacionFW, lxUsuarioAltaFW, lxUsuarioModificacionFW, lxSerieAltaFW, lxSerieModificacionFW, lxBaseDeDatosAltaFW, lxBaseDeDatosModificacionFW, lxDescripcionFW)
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
		this.oEntidad.Timestamp = lxMinrepoTimestamp
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
			local  lxMinrepoFecexpo, lxMinrepoFmodifw, lxMinrepoFecimpo, lxMinrepoFaltafw, lxMinrepoFectrans, lxMinrepoTimestamp, lxMinrepoUmodifw, lxMinrepoSmodifw, lxMinrepoUaltafw, lxMinrepoVmodifw, lxMinrepoDescfw, lxMinrepoSaltafw, lxMinrepoZadsfw, lxMinrepoValtafw, lxMinrepoHoraexpo, lxMinrepoHmodifw, lxMinrepoBdmodifw, lxMinrepoHaltafw, lxMinrepoBdaltafw, lxMinrepoEsttrans, lxMinrepoHoraimpo, lxMinrepoCodigo, lxMinrepoMobs, lxMinrepoFecha, lxMinrepoNumero, lxMinrepoFechavig
				lxMinrepoFecexpo =  .Fechaexpo			lxMinrepoFmodifw =  .Fechamodificacionfw			lxMinrepoFecimpo =  .Fechaimpo			lxMinrepoFaltafw =  .Fechaaltafw			lxMinrepoFectrans =  .Fechatransferencia			lxMinrepoTimestamp = goLibrerias.ObtenerTimestamp()			lxMinrepoUmodifw =  .Usuariomodificacionfw			lxMinrepoSmodifw =  .Seriemodificacionfw			lxMinrepoUaltafw =  .Usuarioaltafw			lxMinrepoVmodifw =  .Versionmodificacionfw			lxMinrepoDescfw =  .Descripcionfw			lxMinrepoSaltafw =  .Seriealtafw			lxMinrepoZadsfw =  .Zadsfw			lxMinrepoValtafw =  .Versionaltafw			lxMinrepoHoraexpo =  .Horaexpo			lxMinrepoHmodifw =  .Horamodificacionfw			lxMinrepoBdmodifw =  .Basededatosmodificacionfw			lxMinrepoHaltafw =  .Horaaltafw			lxMinrepoBdaltafw =  .Basededatosaltafw			lxMinrepoEsttrans =  .Estadotransferencia			lxMinrepoHoraimpo =  .Horaimpo			lxMinrepoCodigo =  .Codigo			lxMinrepoMobs =  .Observacion			lxMinrepoFecha =  .Fecha			lxMinrepoNumero =  .Numero			lxMinrepoFechavig =  .Vigencia
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
				update ZooLogic.MINREPO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMinrepoFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxMinrepoFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxMinrepoFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxMinrepoFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxMinrepoFectrans ) + "'">>,"Timestamp" = <<lxMinrepoTimestamp>>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxMinrepoUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoVmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxMinrepoDescfw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxMinrepoSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxMinrepoZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxMinrepoValtafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxMinrepoHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxMinrepoHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMinrepoBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxMinrepoEsttrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxMinrepoHoraimpo ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxMinrepoCodigo ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxMinrepoMobs ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxMinrepoFecha ) + "'">>,"Numero" = <<lxMinrepoNumero>>,"Fechavig" = <<"'" + this.ConvertirDateSql( lxMinrepoFechavig ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxMinrepoCodigo ) + "'">> and  MINREPO.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MINREPODET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MinRepo
				if this.oEntidad.MinRepo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidadactual = loItem.Cantidadactual
					lxCantidad = loItem.Cantidad
					lxMaxactual = loItem.Maxactual
					lxMaxnuevo = loItem.Maxnuevo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MINREPODET("CODIGO","NROITEM","COMP","CodArt","DescArt","CodCol","DescCol","CodTal","CantActual","Cantidad","MaxActual","MaxNuevo" ) values ( <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidadactual>>, <<lxCantidad>>, <<lxMaxactual>>, <<lxMaxnuevo>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
			dodefault()
			local lxCodigo
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			this.oSP.ActualizarMinimoReposicion(lxCodigo)
			local lxCodigo, lxFechaAltaFW, lxFechaModificacionFW, lxHoraAltaFW, lxHoraModificacionFW, lxUsuarioAltaFW, lxUsuarioModificacionFW, lxSerieAltaFW, lxSerieModificacionFW, lxBaseDeDatosAltaFW, lxBaseDeDatosModificacionFW, lxDescripcionFW
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			lxFechaAltaFW = this.oEntidad.FechaAltaFW
			lxFechaModificacionFW = this.oEntidad.FechaModificacionFW
			if empty( this.oEntidad.HoraAltaFW )
				lxHoraAltaFW = null
			else
				lxHoraAltaFW = this.oEntidad.HoraAltaFW
			endif
			if empty( this.oEntidad.HoraModificacionFW )
				lxHoraModificacionFW = null
			else
				lxHoraModificacionFW = this.oEntidad.HoraModificacionFW
			endif
			if empty( this.oEntidad.UsuarioAltaFW )
				lxUsuarioAltaFW = null
			else
				lxUsuarioAltaFW = this.oEntidad.UsuarioAltaFW
			endif
			if empty( this.oEntidad.UsuarioModificacionFW )
				lxUsuarioModificacionFW = null
			else
				lxUsuarioModificacionFW = this.oEntidad.UsuarioModificacionFW
			endif
			if empty( this.oEntidad.SerieAltaFW )
				lxSerieAltaFW = null
			else
				lxSerieAltaFW = this.oEntidad.SerieAltaFW
			endif
			if empty( this.oEntidad.SerieModificacionFW )
				lxSerieModificacionFW = null
			else
				lxSerieModificacionFW = this.oEntidad.SerieModificacionFW
			endif
			if empty( this.oEntidad.BaseDeDatosAltaFW )
				lxBaseDeDatosAltaFW = null
			else
				lxBaseDeDatosAltaFW = this.oEntidad.BaseDeDatosAltaFW
			endif
			if empty( this.oEntidad.BaseDeDatosModificacionFW )
				lxBaseDeDatosModificacionFW = null
			else
				lxBaseDeDatosModificacionFW = this.oEntidad.BaseDeDatosModificacionFW
			endif
			if empty( this.oEntidad.DescripcionFW )
				lxDescripcionFW = null
			else
				lxDescripcionFW = this.oEntidad.DescripcionFW
			endif
			this.oSP.InsertarMinimoReposicion(lxCodigo, lxFechaAltaFW, lxFechaModificacionFW, lxHoraAltaFW, lxHoraModificacionFW, lxUsuarioAltaFW, lxUsuarioModificacionFW, lxSerieAltaFW, lxSerieModificacionFW, lxBaseDeDatosAltaFW, lxBaseDeDatosModificacionFW, lxDescripcionFW)
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
		this.oEntidad.Timestamp = lxMinrepoTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.MINREPO where " + this.ConvertirFuncionesSql( " MINREPO.CODIGO != ''" ) )
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
			Local lxMinrepoCodigo
			lxMinrepoCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fecha" as "Fecha", "Numero" as "Numero", "Fechavig" as "Vigencia" from ZooLogic.MINREPO where "Codigo" = <<"'" + this.FormatearTextoSql( lxMinrepoCodigo ) + "'">> and  MINREPO.CODIGO != ''
			endtext
			use in select('c_MINIMOREPOSICION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MINIMOREPOSICION', set( 'Datasession' ) )

			if reccount( 'c_MINIMOREPOSICION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Codcol" as "Color", "Desccol" as "Colordetalle", "Codtal" as "Talle", "Cantactual" as "Cantidadactual", "Cantidad" as "Cantidad", "Maxactual" as "Maxactual", "Maxnuevo" as "Maxnuevo" from ZooLogic.MINREPODET where CODIGO = <<"'" + this.FormatearTextoSql( c_MINIMOREPOSICION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MinRepo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MinRepo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MinRepo
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxMinrepoCodigo as Variant
		llRetorno = .t.
		lxMinrepoCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MINREPO where "Codigo" = <<"'" + this.FormatearTextoSql( lxMinrepoCodigo ) + "'">> and  MINREPO.CODIGO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fecha" as "Fecha", "Numero" as "Numero", "Fechavig" as "Vigencia" from ZooLogic.MINREPO where  MINREPO.CODIGO != '' order by CODIGO
			endtext
			use in select('c_MINIMOREPOSICION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MINIMOREPOSICION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Codcol" as "Color", "Desccol" as "Colordetalle", "Codtal" as "Talle", "Cantactual" as "Cantidadactual", "Cantidad" as "Cantidad", "Maxactual" as "Maxactual", "Maxnuevo" as "Maxnuevo" from ZooLogic.MINREPODET where CODIGO = <<"'" + this.FormatearTextoSql( c_MINIMOREPOSICION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MinRepo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MinRepo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MinRepo
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fecha" as "Fecha", "Numero" as "Numero", "Fechavig" as "Vigencia" from ZooLogic.MINREPO where  funciones.padr( CODIGO, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MINREPO.CODIGO != '' order by CODIGO
			endtext
			use in select('c_MINIMOREPOSICION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MINIMOREPOSICION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Codcol" as "Color", "Desccol" as "Colordetalle", "Codtal" as "Talle", "Cantactual" as "Cantidadactual", "Cantidad" as "Cantidad", "Maxactual" as "Maxactual", "Maxnuevo" as "Maxnuevo" from ZooLogic.MINREPODET where CODIGO = <<"'" + this.FormatearTextoSql( c_MINIMOREPOSICION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MinRepo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MinRepo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MinRepo
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fecha" as "Fecha", "Numero" as "Numero", "Fechavig" as "Vigencia" from ZooLogic.MINREPO where  funciones.padr( CODIGO, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MINREPO.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_MINIMOREPOSICION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MINIMOREPOSICION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Codcol" as "Color", "Desccol" as "Colordetalle", "Codtal" as "Talle", "Cantactual" as "Cantidadactual", "Cantidad" as "Cantidad", "Maxactual" as "Maxactual", "Maxnuevo" as "Maxnuevo" from ZooLogic.MINREPODET where CODIGO = <<"'" + this.FormatearTextoSql( c_MINIMOREPOSICION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MinRepo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MinRepo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MinRepo
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fecha" as "Fecha", "Numero" as "Numero", "Fechavig" as "Vigencia" from ZooLogic.MINREPO where  MINREPO.CODIGO != '' order by CODIGO desc
			endtext
			use in select('c_MINIMOREPOSICION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MINIMOREPOSICION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Codigo" as "Codigo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Codcol" as "Color", "Desccol" as "Colordetalle", "Codtal" as "Talle", "Cantactual" as "Cantidadactual", "Cantidad" as "Cantidad", "Maxactual" as "Maxactual", "Maxnuevo" as "Maxnuevo" from ZooLogic.MINREPODET where CODIGO = <<"'" + this.FormatearTextoSql( c_MINIMOREPOSICION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_MinRepo')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MinRepo', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_MinRepo
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Timestamp,Umodifw,Smodifw,Ualtafw,Vmodifw,Descfw,Sa" + ;
"ltafw,Zadsfw,Valtafw,Horaexpo,Hmodifw,Bdmodifw,Haltafw,Bdaltafw,Esttrans,Horaimpo,Codigo,Mobs,Fecha," + ;
"Numero,Fechavig" + ;
" from ZooLogic.MINREPO where  MINREPO.CODIGO != '' and " + lcFiltro )
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
			local  lxMinrepoFecexpo, lxMinrepoFmodifw, lxMinrepoFecimpo, lxMinrepoFaltafw, lxMinrepoFectrans, lxMinrepoTimestamp, lxMinrepoUmodifw, lxMinrepoSmodifw, lxMinrepoUaltafw, lxMinrepoVmodifw, lxMinrepoDescfw, lxMinrepoSaltafw, lxMinrepoZadsfw, lxMinrepoValtafw, lxMinrepoHoraexpo, lxMinrepoHmodifw, lxMinrepoBdmodifw, lxMinrepoHaltafw, lxMinrepoBdaltafw, lxMinrepoEsttrans, lxMinrepoHoraimpo, lxMinrepoCodigo, lxMinrepoMobs, lxMinrepoFecha, lxMinrepoNumero, lxMinrepoFechavig
				lxMinrepoFecexpo = ctod( '  /  /    ' )			lxMinrepoFmodifw = ctod( '  /  /    ' )			lxMinrepoFecimpo = ctod( '  /  /    ' )			lxMinrepoFaltafw = ctod( '  /  /    ' )			lxMinrepoFectrans = ctod( '  /  /    ' )			lxMinrepoTimestamp = goLibrerias.ObtenerTimestamp()			lxMinrepoUmodifw = []			lxMinrepoSmodifw = []			lxMinrepoUaltafw = []			lxMinrepoVmodifw = []			lxMinrepoDescfw = []			lxMinrepoSaltafw = []			lxMinrepoZadsfw = []			lxMinrepoValtafw = []			lxMinrepoHoraexpo = []			lxMinrepoHmodifw = []			lxMinrepoBdmodifw = []			lxMinrepoHaltafw = []			lxMinrepoBdaltafw = []			lxMinrepoEsttrans = []			lxMinrepoHoraimpo = []			lxMinrepoCodigo = []			lxMinrepoMobs = []			lxMinrepoFecha = ctod( '  /  /    ' )			lxMinrepoNumero = 0			lxMinrepoFechavig = ctod( '  /  /    ' )
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.MINREPODET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MINREPO where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MINREPO' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MINREPO.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fecha" as "Fecha", "Numero" as "Numero", "Fechavig" as "Vigencia"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MINREPO', '', tnTope )
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
	Function ObtenerDatosDetalleMinRepo( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  MINREPODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Codigo" as "Codigo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Codart" as "Articulo", "Descart" as "Articulodetalle", "Codcol" as "Color", "Desccol" as "Colordetalle", "Codtal" as "Talle", "Cantactual" as "Cantidadactual", "Cantidad" as "Cantidad", "Maxactual" as "Maxactual", "Maxnuevo" as "Maxnuevo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleMinRepo( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MINREPODET', 'MinRepo', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleMinRepo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleMinRepo( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBSERVACION'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'VIGENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVIG AS VIGENCIA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleMinRepo( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODART AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCART AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOL AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCCOL AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTAL AS TALLE'
				Case lcAtributo == 'CANTIDADACTUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTACTUAL AS CANTIDADACTUAL'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'MAXACTUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAXACTUAL AS MAXACTUAL'
				Case lcAtributo == 'MAXNUEVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAXNUEVO AS MAXNUEVO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIA'
				lcCampo = 'FECHAVIG'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleMinRepo( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'CODART'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DESCART'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOL'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'DESCCOL'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTAL'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADACTUAL'
				lcCampo = 'CANTACTUAL'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'MAXACTUAL'
				lcCampo = 'MAXACTUAL'
			Case upper( alltrim( tcAtributo ) ) == 'MAXNUEVO'
				lcCampo = 'MAXNUEVO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'MINREPO'
			lcRetorno = 'MINREPODET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxMinrepoFecexpo, lxMinrepoFmodifw, lxMinrepoFecimpo, lxMinrepoFaltafw, lxMinrepoFectrans, lxMinrepoTimestamp, lxMinrepoUmodifw, lxMinrepoSmodifw, lxMinrepoUaltafw, lxMinrepoVmodifw, lxMinrepoDescfw, lxMinrepoSaltafw, lxMinrepoZadsfw, lxMinrepoValtafw, lxMinrepoHoraexpo, lxMinrepoHmodifw, lxMinrepoBdmodifw, lxMinrepoHaltafw, lxMinrepoBdaltafw, lxMinrepoEsttrans, lxMinrepoHoraimpo, lxMinrepoCodigo, lxMinrepoMobs, lxMinrepoFecha, lxMinrepoNumero, lxMinrepoFechavig
				lxMinrepoFecexpo =  .Fechaexpo			lxMinrepoFmodifw =  .Fechamodificacionfw			lxMinrepoFecimpo =  .Fechaimpo			lxMinrepoFaltafw =  .Fechaaltafw			lxMinrepoFectrans =  .Fechatransferencia			lxMinrepoTimestamp = goLibrerias.ObtenerTimestamp()			lxMinrepoUmodifw =  .Usuariomodificacionfw			lxMinrepoSmodifw =  .Seriemodificacionfw			lxMinrepoUaltafw =  .Usuarioaltafw			lxMinrepoVmodifw =  .Versionmodificacionfw			lxMinrepoDescfw =  .Descripcionfw			lxMinrepoSaltafw =  .Seriealtafw			lxMinrepoZadsfw =  .Zadsfw			lxMinrepoValtafw =  .Versionaltafw			lxMinrepoHoraexpo =  .Horaexpo			lxMinrepoHmodifw =  .Horamodificacionfw			lxMinrepoBdmodifw =  .Basededatosmodificacionfw			lxMinrepoHaltafw =  .Horaaltafw			lxMinrepoBdaltafw =  .Basededatosaltafw			lxMinrepoEsttrans =  .Estadotransferencia			lxMinrepoHoraimpo =  .Horaimpo			lxMinrepoCodigo =  .Codigo			lxMinrepoMobs =  .Observacion			lxMinrepoFecha =  .Fecha			lxMinrepoNumero =  .Numero			lxMinrepoFechavig =  .Vigencia
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MINREPO ( "Fecexpo","Fmodifw","Fecimpo","Faltafw","Fectrans","Timestamp","Umodifw","Smodifw","Ualtafw","Vmodifw","Descfw","Saltafw","Zadsfw","Valtafw","Horaexpo","Hmodifw","Bdmodifw","Haltafw","Bdaltafw","Esttrans","Horaimpo","Codigo","Mobs","Fecha","Numero","Fechavig" ) values ( <<"'" + this.ConvertirDateSql( lxMinrepoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFectrans ) + "'" >>, <<lxMinrepoTimestamp >>, <<"'" + this.FormatearTextoSql( lxMinrepoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMinrepoMobs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMinrepoFecha ) + "'" >>, <<lxMinrepoNumero >>, <<"'" + this.ConvertirDateSql( lxMinrepoFechavig ) + "'" >> )
		endtext
		loColeccion.cTabla = 'MINREPO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MinRepo
				if this.oEntidad.MinRepo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidadactual = loItem.Cantidadactual
					lxCantidad = loItem.Cantidad
					lxMaxactual = loItem.Maxactual
					lxMaxnuevo = loItem.Maxnuevo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MINREPODET("CODIGO","NROITEM","COMP","CodArt","DescArt","CodCol","DescCol","CodTal","CantActual","Cantidad","MaxActual","MaxNuevo" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidadactual>>, <<lxCantidad>>, <<lxMaxactual>>, <<lxMaxnuevo>> ) 
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
			local  lxMinrepoFecexpo, lxMinrepoFmodifw, lxMinrepoFecimpo, lxMinrepoFaltafw, lxMinrepoFectrans, lxMinrepoTimestamp, lxMinrepoUmodifw, lxMinrepoSmodifw, lxMinrepoUaltafw, lxMinrepoVmodifw, lxMinrepoDescfw, lxMinrepoSaltafw, lxMinrepoZadsfw, lxMinrepoValtafw, lxMinrepoHoraexpo, lxMinrepoHmodifw, lxMinrepoBdmodifw, lxMinrepoHaltafw, lxMinrepoBdaltafw, lxMinrepoEsttrans, lxMinrepoHoraimpo, lxMinrepoCodigo, lxMinrepoMobs, lxMinrepoFecha, lxMinrepoNumero, lxMinrepoFechavig
				lxMinrepoFecexpo =  .Fechaexpo			lxMinrepoFmodifw =  .Fechamodificacionfw			lxMinrepoFecimpo =  .Fechaimpo			lxMinrepoFaltafw =  .Fechaaltafw			lxMinrepoFectrans =  .Fechatransferencia			lxMinrepoTimestamp = goLibrerias.ObtenerTimestamp()			lxMinrepoUmodifw =  .Usuariomodificacionfw			lxMinrepoSmodifw =  .Seriemodificacionfw			lxMinrepoUaltafw =  .Usuarioaltafw			lxMinrepoVmodifw =  .Versionmodificacionfw			lxMinrepoDescfw =  .Descripcionfw			lxMinrepoSaltafw =  .Seriealtafw			lxMinrepoZadsfw =  .Zadsfw			lxMinrepoValtafw =  .Versionaltafw			lxMinrepoHoraexpo =  .Horaexpo			lxMinrepoHmodifw =  .Horamodificacionfw			lxMinrepoBdmodifw =  .Basededatosmodificacionfw			lxMinrepoHaltafw =  .Horaaltafw			lxMinrepoBdaltafw =  .Basededatosaltafw			lxMinrepoEsttrans =  .Estadotransferencia			lxMinrepoHoraimpo =  .Horaimpo			lxMinrepoCodigo =  .Codigo			lxMinrepoMobs =  .Observacion			lxMinrepoFecha =  .Fecha			lxMinrepoNumero =  .Numero			lxMinrepoFechavig =  .Vigencia
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MINREPO.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.MINREPO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMinrepoFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxMinrepoFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMinrepoFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxMinrepoFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxMinrepoFectrans ) + "'">>, "Timestamp" = <<lxMinrepoTimestamp>>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxMinrepoUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoVmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxMinrepoDescfw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxMinrepoSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxMinrepoZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxMinrepoValtafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxMinrepoHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMinrepoBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxMinrepoHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMinrepoBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxMinrepoEsttrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxMinrepoHoraimpo ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxMinrepoCodigo ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxMinrepoMobs ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxMinrepoFecha ) + "'">>, "Numero" = <<lxMinrepoNumero>>, "Fechavig" = <<"'" + this.ConvertirDateSql( lxMinrepoFechavig ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MINREPO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.MINREPODET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.MinRepo
				if this.oEntidad.MinRepo.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxCantidadactual = loItem.Cantidadactual
					lxCantidad = loItem.Cantidad
					lxMaxactual = loItem.Maxactual
					lxMaxnuevo = loItem.Maxnuevo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.MINREPODET("CODIGO","NROITEM","COMP","CodArt","DescArt","CodCol","DescCol","CodTal","CantActual","Cantidad","MaxActual","MaxNuevo" ) values ( << lcValorClavePrimariaString >>, <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxCantidadactual>>, <<lxCantidad>>, <<lxMaxactual>>, <<lxMaxnuevo>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MINREPO.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.MINREPO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.MINREPODET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'MINREPO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MINREPO where  MINREPO.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MINREPO where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  MINREPO.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MINIMOREPOSICION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MINREPO Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.MINREPO set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, FECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, FECHAVIG = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FMODIFW, FECIMPO, FALTAFW, FECTRANS, TIMESTAMP, UMODIFW, SMODIFW, UALTAFW, VMODIFW, DescFW, SALTAFW, ZADSFW, VALTAFW, HORAEXPO, HMODIFW, BDMODIFW, HALTAFW, BDALTAFW, ESTTRANS, HORAIMPO, CODIGO, MObs, FECHA, Numero, FECHAVIG
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHA ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.MINREPO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MINIMOREPOSICION'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.MINREPODET Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMMINIMOREPOSICION'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"CODIGO","NROITEM","COMP","CodArt","DescArt","CodCol","DescCol","CodTal","CantActual","Cantidad","MaxActual","MaxNuevo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.MINREPODET ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodArt     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescArt    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodCol     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescCol    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodTal     ) + "'" + ',' + transform( cDetallesExistentes.CantActual ) + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + transform( cDetallesExistentes.MaxActual  ) + ',' + transform( cDetallesExistentes.MaxNuevo   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Identificador: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'MINIMOREPOSICION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MINIMOREPOSICION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MINIMOREPOSICION_MOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMMINIMOREPOSICION'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MINREPO')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MINIMOREPOSICION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MINIMOREPOSICION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MINIMOREPOSICION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MINIMOREPOSICION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECHA     
		* Validar ANTERIORES A 1/1/1753  FECHAVIG  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MINREPO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MINREPO
Create Table ZooLogic.TablaTrabajo_MINREPO ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaimpo" char( 8 )  null, 
"codigo" char( 20 )  null, 
"mobs" varchar(max)  null, 
"fecha" datetime  null, 
"numero" numeric( 8, 0 )  null, 
"fechavig" datetime  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MINREPO' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MINREPO' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MINIMOREPOSICION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('fechavig','fechavig')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MINREPO'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.FECHAVIG = isnull( d.FECHAVIG, t.FECHAVIG )
					from ZooLogic.MINREPO t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.MINREPO(Fecexpo,Fmodifw,Fecimpo,Faltafw,Fectrans,Timestamp,Umodifw,Smodifw,Ualtafw,Vmodifw,Descfw,Saltafw,Zadsfw,Valtafw,Horaexpo,Hmodifw,Bdmodifw,Haltafw,Bdaltafw,Esttrans,Horaimpo,Codigo,Mobs,Fecha,Numero,Fechavig)
					Select isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.DESCFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAIMPO,''),isnull( d.CODIGO,''),isnull( d.MOBS,''),isnull( d.FECHA,''),isnull( d.NUMERO,0),isnull( d.FECHAVIG,'')
						From deleted d left join ZooLogic.MINREPO pk 
							 on d.CODIGO = pk.CODIGO
						Where pk.CODIGO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_MINREPODET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_MINREPO_MINREPODET
ON ZooLogic.TablaTrabajo_MINREPO_MINREPODET
AFTER DELETE
As
Begin
Update t Set 
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.CODART = isnull( d.CODART, t.CODART ),
t.DESCART = isnull( d.DESCART, t.DESCART ),
t.CODCOL = isnull( d.CODCOL, t.CODCOL ),
t.DESCCOL = isnull( d.DESCCOL, t.DESCCOL ),
t.CODTAL = isnull( d.CODTAL, t.CODTAL ),
t.CANTACTUAL = isnull( d.CANTACTUAL, t.CANTACTUAL ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.MAXACTUAL = isnull( d.MAXACTUAL, t.MAXACTUAL ),
t.MAXNUEVO = isnull( d.MAXNUEVO, t.MAXNUEVO )
from ZooLogic.MINREPODET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.MINREPODET
( 
"CODIGO",
"NROITEM",
"COMP",
"CODART",
"DESCART",
"CODCOL",
"DESCCOL",
"CODTAL",
"CANTACTUAL",
"CANTIDAD",
"MAXACTUAL",
"MAXNUEVO"
 )
Select 
d.CODIGO,
d.NROITEM,
d.COMP,
d.CODART,
d.DESCART,
d.CODCOL,
d.DESCCOL,
d.CODTAL,
d.CANTACTUAL,
d.CANTIDAD,
d.MAXACTUAL,
d.MAXNUEVO
From deleted d left join ZooLogic.MINREPODET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MINREPO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MINREPO
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MINIMOREPOSICION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MINIMOREPOSICION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MINIMOREPOSICION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MINIMOREPOSICION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MINIMOREPOSICION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MINIMOREPOSICION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_MINIMOREPOSICION.Timestamp, 0 )
					.Usuariomodificacionfw = nvl( c_MINIMOREPOSICION.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_MINIMOREPOSICION.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_MINIMOREPOSICION.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_MINIMOREPOSICION.Versionmodificacionfw, [] )
					.Descripcionfw = nvl( c_MINIMOREPOSICION.Descripcionfw, [] )
					.Seriealtafw = nvl( c_MINIMOREPOSICION.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_MINIMOREPOSICION.Versionaltafw, [] )
					.Horaexpo = nvl( c_MINIMOREPOSICION.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_MINIMOREPOSICION.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_MINIMOREPOSICION.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_MINIMOREPOSICION.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_MINIMOREPOSICION.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_MINIMOREPOSICION.Estadotransferencia, [] )
					.Horaimpo = nvl( c_MINIMOREPOSICION.Horaimpo, [] )
					.Minrepo.Limpiar()
					.Minrepo.SetearEsNavegacion( .lProcesando )
					.Minrepo.Cargar()
					.Codigo = nvl( c_MINIMOREPOSICION.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_MINIMOREPOSICION.Fecha, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_MINIMOREPOSICION.Numero, 0 )
					.Vigencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MINIMOREPOSICION.Vigencia, ctod( '  /  /    ' ) ) )
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
		
		loDetalle = this.oEntidad.MinRepo
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
		return c_MINIMOREPOSICION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MINREPO' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.MINREPO 
								Where   MINREPO.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MINREPO", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Codigo" as "Codigo", "Mobs" as "Observacion", "Fecha" as "Fecha", "Numero" as "Numero", "Fechavig" as "Vigencia"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MINREPO 
								Where   MINREPO.CODIGO != ''
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
	Tabla = 'MINREPO'
	Filtro = " MINREPO.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MINREPO.CODIGO != ''"
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
	<row entidad="MINIMOREPOSICION                        " atributo="FECHAEXPO                               " tabla="MINREPO        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="FECHAMODIFICACIONFW                     " tabla="MINREPO        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="FECHAIMPO                               " tabla="MINREPO        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="FECHAALTAFW                             " tabla="MINREPO        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="FECHATRANSFERENCIA                      " tabla="MINREPO        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="TIMESTAMP                               " tabla="MINREPO        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="USUARIOMODIFICACIONFW                   " tabla="MINREPO        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="SERIEMODIFICACIONFW                     " tabla="MINREPO        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="USUARIOALTAFW                           " tabla="MINREPO        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="VERSIONMODIFICACIONFW                   " tabla="MINREPO        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="DESCRIPCIONFW                           " tabla="MINREPO        " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="SERIEALTAFW                             " tabla="MINREPO        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="ZADSFW                                  " tabla="MINREPO        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="VERSIONALTAFW                           " tabla="MINREPO        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="HORAEXPO                                " tabla="MINREPO        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="HORAMODIFICACIONFW                      " tabla="MINREPO        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MINREPO        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="HORAALTAFW                              " tabla="MINREPO        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="BASEDEDATOSALTAFW                       " tabla="MINREPO        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="ESTADOTRANSFERENCIA                     " tabla="MINREPO        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="HORAIMPO                                " tabla="MINREPO        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="MINREPO                                 " tabla="MINREPODET     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Combinaciones                                                                                                                                                   " dominio="DETALLEITEMMINIMOREPOSICION   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="CODIGO                                  " tabla="MINREPO        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Identificador                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="OBSERVACION                             " tabla="MINREPO        " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="FECHA                                   " tabla="MINREPO        " campo="FECHA     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="202" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="NUMERO                                  " tabla="MINREPO        " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MINIMOREPOSICION                        " atributo="VIGENCIA                                " tabla="MINREPO        " campo="FECHAVIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="203" etiqueta="Vigencia desde                                                                                                                                                  " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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