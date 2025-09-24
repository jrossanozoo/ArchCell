
define class Din_EntidadFILTRARSTOCKYPRECIOCMVAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_FILTRARSTOCKYPRECIOCMV'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_FSPPK'
	cTablaPrincipal = 'CMVFILTROSTPRE'
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
			local  lxCmvfiltrostpreFecexpo, lxCmvfiltrostpreFectrans, lxCmvfiltrostpreFecimpo, lxCmvfiltrostpreFaltafw, lxCmvfiltrostpreFmodifw, lxCmvfiltrostpreSmodifw, lxCmvfiltrostpreSaltafw, lxCmvfiltrostpreUaltafw, lxCmvfiltrostpreZadsfw, lxCmvfiltrostpreUmodifw, lxCmvfiltrostpreValtafw, lxCmvfiltrostpreHmodifw, lxCmvfiltrostpreVmodifw, lxCmvfiltrostpreHaltafw, lxCmvfiltrostpreHoraimpo, lxCmvfiltrostpreEsttrans, lxCmvfiltrostpreBdaltafw, lxCmvfiltrostpreHoraexpo, lxCmvfiltrostpreBdmodifw, lxCmvfiltrostpreCodigo, lxCmvfiltrostpreFchdesde, lxCmvfiltrostpreFchhasta, lxCmvfiltrostpreEjercicio, lxCmvfiltrostpreBase, lxCmvfiltrostpreObs
				lxCmvfiltrostpreFecexpo =  .Fechaexpo			lxCmvfiltrostpreFectrans =  .Fechatransferencia			lxCmvfiltrostpreFecimpo =  .Fechaimpo			lxCmvfiltrostpreFaltafw =  .Fechaaltafw			lxCmvfiltrostpreFmodifw =  .Fechamodificacionfw			lxCmvfiltrostpreSmodifw =  .Seriemodificacionfw			lxCmvfiltrostpreSaltafw =  .Seriealtafw			lxCmvfiltrostpreUaltafw =  .Usuarioaltafw			lxCmvfiltrostpreZadsfw =  .Zadsfw			lxCmvfiltrostpreUmodifw =  .Usuariomodificacionfw			lxCmvfiltrostpreValtafw =  .Versionaltafw			lxCmvfiltrostpreHmodifw =  .Horamodificacionfw			lxCmvfiltrostpreVmodifw =  .Versionmodificacionfw			lxCmvfiltrostpreHaltafw =  .Horaaltafw			lxCmvfiltrostpreHoraimpo =  .Horaimpo			lxCmvfiltrostpreEsttrans =  .Estadotransferencia			lxCmvfiltrostpreBdaltafw =  .Basededatosaltafw			lxCmvfiltrostpreHoraexpo =  .Horaexpo			lxCmvfiltrostpreBdmodifw =  .Basededatosmodificacionfw			lxCmvfiltrostpreCodigo =  .Codigo			lxCmvfiltrostpreFchdesde =  .Fechadesde			lxCmvfiltrostpreFchhasta =  .Fechahasta			lxCmvfiltrostpreEjercicio =  .Ejercicio_PK 			lxCmvfiltrostpreBase =  .Basededatos			lxCmvfiltrostpreObs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCmvfiltrostpreCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CMVFILTROSTPRE ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Smodifw","Saltafw","Ualtafw","Zadsfw","Umodifw","Valtafw","Hmodifw","Vmodifw","Haltafw","Horaimpo","Esttrans","Bdaltafw","Horaexpo","Bdmodifw","Codigo","Fchdesde","Fchhasta","Ejercicio","Base","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFchdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFchhasta ) + "'" >>, <<lxCmvfiltrostpreEjercicio >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreObs ) + "'" >> )
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
			local  lxCmvfiltrostpreFecexpo, lxCmvfiltrostpreFectrans, lxCmvfiltrostpreFecimpo, lxCmvfiltrostpreFaltafw, lxCmvfiltrostpreFmodifw, lxCmvfiltrostpreSmodifw, lxCmvfiltrostpreSaltafw, lxCmvfiltrostpreUaltafw, lxCmvfiltrostpreZadsfw, lxCmvfiltrostpreUmodifw, lxCmvfiltrostpreValtafw, lxCmvfiltrostpreHmodifw, lxCmvfiltrostpreVmodifw, lxCmvfiltrostpreHaltafw, lxCmvfiltrostpreHoraimpo, lxCmvfiltrostpreEsttrans, lxCmvfiltrostpreBdaltafw, lxCmvfiltrostpreHoraexpo, lxCmvfiltrostpreBdmodifw, lxCmvfiltrostpreCodigo, lxCmvfiltrostpreFchdesde, lxCmvfiltrostpreFchhasta, lxCmvfiltrostpreEjercicio, lxCmvfiltrostpreBase, lxCmvfiltrostpreObs
				lxCmvfiltrostpreFecexpo =  .Fechaexpo			lxCmvfiltrostpreFectrans =  .Fechatransferencia			lxCmvfiltrostpreFecimpo =  .Fechaimpo			lxCmvfiltrostpreFaltafw =  .Fechaaltafw			lxCmvfiltrostpreFmodifw =  .Fechamodificacionfw			lxCmvfiltrostpreSmodifw =  .Seriemodificacionfw			lxCmvfiltrostpreSaltafw =  .Seriealtafw			lxCmvfiltrostpreUaltafw =  .Usuarioaltafw			lxCmvfiltrostpreZadsfw =  .Zadsfw			lxCmvfiltrostpreUmodifw =  .Usuariomodificacionfw			lxCmvfiltrostpreValtafw =  .Versionaltafw			lxCmvfiltrostpreHmodifw =  .Horamodificacionfw			lxCmvfiltrostpreVmodifw =  .Versionmodificacionfw			lxCmvfiltrostpreHaltafw =  .Horaaltafw			lxCmvfiltrostpreHoraimpo =  .Horaimpo			lxCmvfiltrostpreEsttrans =  .Estadotransferencia			lxCmvfiltrostpreBdaltafw =  .Basededatosaltafw			lxCmvfiltrostpreHoraexpo =  .Horaexpo			lxCmvfiltrostpreBdmodifw =  .Basededatosmodificacionfw			lxCmvfiltrostpreCodigo =  .Codigo			lxCmvfiltrostpreFchdesde =  .Fechadesde			lxCmvfiltrostpreFchhasta =  .Fechahasta			lxCmvfiltrostpreEjercicio =  .Ejercicio_PK 			lxCmvfiltrostpreBase =  .Basededatos			lxCmvfiltrostpreObs =  .Obs
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CMVFILTROSTPRE set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreUaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreValtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreVmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBdaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBdmodifw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreCodigo ) + "'">>,"Fchdesde" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFchdesde ) + "'">>,"Fchhasta" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFchhasta ) + "'">>,"Ejercicio" = <<lxCmvfiltrostpreEjercicio>>,"Base" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBase ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreObs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreCodigo ) + "'">> and  CMVFILTROSTPRE.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.CMVFILTROSTPRE where " + this.ConvertirFuncionesSql( " CMVFILTROSTPRE.CODIGO != ''" ) )
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
			Local lxCmvfiltrostpreCodigo
			lxCmvfiltrostpreCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Obs" as "Obs" from ZooLogic.CMVFILTROSTPRE where "Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreCodigo ) + "'">> and  CMVFILTROSTPRE.CODIGO != ''
			endtext
			use in select('c_FILTRARSTOCKYPRECIOCMV')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARSTOCKYPRECIOCMV', set( 'Datasession' ) )

			if reccount( 'c_FILTRARSTOCKYPRECIOCMV' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCmvfiltrostpreCodigo as Variant
		llRetorno = .t.
		lxCmvfiltrostpreCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CMVFILTROSTPRE where "Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreCodigo ) + "'">> and  CMVFILTROSTPRE.CODIGO != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Obs" as "Obs" from ZooLogic.CMVFILTROSTPRE where  CMVFILTROSTPRE.CODIGO != '' order by Codigo
			endtext
			use in select('c_FILTRARSTOCKYPRECIOCMV')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARSTOCKYPRECIOCMV', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Obs" as "Obs" from ZooLogic.CMVFILTROSTPRE where  funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CMVFILTROSTPRE.CODIGO != '' order by Codigo
			endtext
			use in select('c_FILTRARSTOCKYPRECIOCMV')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARSTOCKYPRECIOCMV', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Obs" as "Obs" from ZooLogic.CMVFILTROSTPRE where  funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CMVFILTROSTPRE.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_FILTRARSTOCKYPRECIOCMV')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARSTOCKYPRECIOCMV', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Obs" as "Obs" from ZooLogic.CMVFILTROSTPRE where  CMVFILTROSTPRE.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_FILTRARSTOCKYPRECIOCMV')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FILTRARSTOCKYPRECIOCMV', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Smodifw,Saltafw,Ualtafw,Zadsfw,Umodifw,Valtafw,Hmod" + ;
"ifw,Vmodifw,Haltafw,Horaimpo,Esttrans,Bdaltafw,Horaexpo,Bdmodifw,Codigo,Fchdesde,Fchhasta,Ejercicio," + ;
"Base,Obs" + ;
" from ZooLogic.CMVFILTROSTPRE where  CMVFILTROSTPRE.CODIGO != '' and " + lcFiltro )
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
			local  lxCmvfiltrostpreFecexpo, lxCmvfiltrostpreFectrans, lxCmvfiltrostpreFecimpo, lxCmvfiltrostpreFaltafw, lxCmvfiltrostpreFmodifw, lxCmvfiltrostpreSmodifw, lxCmvfiltrostpreSaltafw, lxCmvfiltrostpreUaltafw, lxCmvfiltrostpreZadsfw, lxCmvfiltrostpreUmodifw, lxCmvfiltrostpreValtafw, lxCmvfiltrostpreHmodifw, lxCmvfiltrostpreVmodifw, lxCmvfiltrostpreHaltafw, lxCmvfiltrostpreHoraimpo, lxCmvfiltrostpreEsttrans, lxCmvfiltrostpreBdaltafw, lxCmvfiltrostpreHoraexpo, lxCmvfiltrostpreBdmodifw, lxCmvfiltrostpreCodigo, lxCmvfiltrostpreFchdesde, lxCmvfiltrostpreFchhasta, lxCmvfiltrostpreEjercicio, lxCmvfiltrostpreBase, lxCmvfiltrostpreObs
				lxCmvfiltrostpreFecexpo = ctod( '  /  /    ' )			lxCmvfiltrostpreFectrans = ctod( '  /  /    ' )			lxCmvfiltrostpreFecimpo = ctod( '  /  /    ' )			lxCmvfiltrostpreFaltafw = ctod( '  /  /    ' )			lxCmvfiltrostpreFmodifw = ctod( '  /  /    ' )			lxCmvfiltrostpreSmodifw = []			lxCmvfiltrostpreSaltafw = []			lxCmvfiltrostpreUaltafw = []			lxCmvfiltrostpreZadsfw = []			lxCmvfiltrostpreUmodifw = []			lxCmvfiltrostpreValtafw = []			lxCmvfiltrostpreHmodifw = []			lxCmvfiltrostpreVmodifw = []			lxCmvfiltrostpreHaltafw = []			lxCmvfiltrostpreHoraimpo = []			lxCmvfiltrostpreEsttrans = []			lxCmvfiltrostpreBdaltafw = []			lxCmvfiltrostpreHoraexpo = []			lxCmvfiltrostpreBdmodifw = []			lxCmvfiltrostpreCodigo = []			lxCmvfiltrostpreFchdesde = ctod( '  /  /    ' )			lxCmvfiltrostpreFchhasta = ctod( '  /  /    ' )			lxCmvfiltrostpreEjercicio = 0			lxCmvfiltrostpreBase = []			lxCmvfiltrostpreObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CMVFILTROSTPRE where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CMVFILTROSTPRE' + '_' + tcCampo
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
		lcWhere = " Where  CMVFILTROSTPRE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Obs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CMVFILTROSTPRE', '', tnTope )
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
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCHDESDE AS FECHADESDE'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCHHASTA AS FECHAHASTA'
				Case lcAtributo == 'EJERCICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EJERCICIO AS EJERCICIO'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASE AS BASEDEDATOS'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
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
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FCHDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FCHHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'EJERCICIO'
				lcCampo = 'EJERCICIO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASE'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
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
			local  lxCmvfiltrostpreFecexpo, lxCmvfiltrostpreFectrans, lxCmvfiltrostpreFecimpo, lxCmvfiltrostpreFaltafw, lxCmvfiltrostpreFmodifw, lxCmvfiltrostpreSmodifw, lxCmvfiltrostpreSaltafw, lxCmvfiltrostpreUaltafw, lxCmvfiltrostpreZadsfw, lxCmvfiltrostpreUmodifw, lxCmvfiltrostpreValtafw, lxCmvfiltrostpreHmodifw, lxCmvfiltrostpreVmodifw, lxCmvfiltrostpreHaltafw, lxCmvfiltrostpreHoraimpo, lxCmvfiltrostpreEsttrans, lxCmvfiltrostpreBdaltafw, lxCmvfiltrostpreHoraexpo, lxCmvfiltrostpreBdmodifw, lxCmvfiltrostpreCodigo, lxCmvfiltrostpreFchdesde, lxCmvfiltrostpreFchhasta, lxCmvfiltrostpreEjercicio, lxCmvfiltrostpreBase, lxCmvfiltrostpreObs
				lxCmvfiltrostpreFecexpo =  .Fechaexpo			lxCmvfiltrostpreFectrans =  .Fechatransferencia			lxCmvfiltrostpreFecimpo =  .Fechaimpo			lxCmvfiltrostpreFaltafw =  .Fechaaltafw			lxCmvfiltrostpreFmodifw =  .Fechamodificacionfw			lxCmvfiltrostpreSmodifw =  .Seriemodificacionfw			lxCmvfiltrostpreSaltafw =  .Seriealtafw			lxCmvfiltrostpreUaltafw =  .Usuarioaltafw			lxCmvfiltrostpreZadsfw =  .Zadsfw			lxCmvfiltrostpreUmodifw =  .Usuariomodificacionfw			lxCmvfiltrostpreValtafw =  .Versionaltafw			lxCmvfiltrostpreHmodifw =  .Horamodificacionfw			lxCmvfiltrostpreVmodifw =  .Versionmodificacionfw			lxCmvfiltrostpreHaltafw =  .Horaaltafw			lxCmvfiltrostpreHoraimpo =  .Horaimpo			lxCmvfiltrostpreEsttrans =  .Estadotransferencia			lxCmvfiltrostpreBdaltafw =  .Basededatosaltafw			lxCmvfiltrostpreHoraexpo =  .Horaexpo			lxCmvfiltrostpreBdmodifw =  .Basededatosmodificacionfw			lxCmvfiltrostpreCodigo =  .Codigo			lxCmvfiltrostpreFchdesde =  .Fechadesde			lxCmvfiltrostpreFchhasta =  .Fechahasta			lxCmvfiltrostpreEjercicio =  .Ejercicio_PK 			lxCmvfiltrostpreBase =  .Basededatos			lxCmvfiltrostpreObs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CMVFILTROSTPRE ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Smodifw","Saltafw","Ualtafw","Zadsfw","Umodifw","Valtafw","Hmodifw","Vmodifw","Haltafw","Horaimpo","Esttrans","Bdaltafw","Horaexpo","Bdmodifw","Codigo","Fchdesde","Fchhasta","Ejercicio","Base","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFchdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFchhasta ) + "'" >>, <<lxCmvfiltrostpreEjercicio >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CMVFILTROSTPRE' 
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
			local  lxCmvfiltrostpreFecexpo, lxCmvfiltrostpreFectrans, lxCmvfiltrostpreFecimpo, lxCmvfiltrostpreFaltafw, lxCmvfiltrostpreFmodifw, lxCmvfiltrostpreSmodifw, lxCmvfiltrostpreSaltafw, lxCmvfiltrostpreUaltafw, lxCmvfiltrostpreZadsfw, lxCmvfiltrostpreUmodifw, lxCmvfiltrostpreValtafw, lxCmvfiltrostpreHmodifw, lxCmvfiltrostpreVmodifw, lxCmvfiltrostpreHaltafw, lxCmvfiltrostpreHoraimpo, lxCmvfiltrostpreEsttrans, lxCmvfiltrostpreBdaltafw, lxCmvfiltrostpreHoraexpo, lxCmvfiltrostpreBdmodifw, lxCmvfiltrostpreCodigo, lxCmvfiltrostpreFchdesde, lxCmvfiltrostpreFchhasta, lxCmvfiltrostpreEjercicio, lxCmvfiltrostpreBase, lxCmvfiltrostpreObs
				lxCmvfiltrostpreFecexpo =  .Fechaexpo			lxCmvfiltrostpreFectrans =  .Fechatransferencia			lxCmvfiltrostpreFecimpo =  .Fechaimpo			lxCmvfiltrostpreFaltafw =  .Fechaaltafw			lxCmvfiltrostpreFmodifw =  .Fechamodificacionfw			lxCmvfiltrostpreSmodifw =  .Seriemodificacionfw			lxCmvfiltrostpreSaltafw =  .Seriealtafw			lxCmvfiltrostpreUaltafw =  .Usuarioaltafw			lxCmvfiltrostpreZadsfw =  .Zadsfw			lxCmvfiltrostpreUmodifw =  .Usuariomodificacionfw			lxCmvfiltrostpreValtafw =  .Versionaltafw			lxCmvfiltrostpreHmodifw =  .Horamodificacionfw			lxCmvfiltrostpreVmodifw =  .Versionmodificacionfw			lxCmvfiltrostpreHaltafw =  .Horaaltafw			lxCmvfiltrostpreHoraimpo =  .Horaimpo			lxCmvfiltrostpreEsttrans =  .Estadotransferencia			lxCmvfiltrostpreBdaltafw =  .Basededatosaltafw			lxCmvfiltrostpreHoraexpo =  .Horaexpo			lxCmvfiltrostpreBdmodifw =  .Basededatosmodificacionfw			lxCmvfiltrostpreCodigo =  .Codigo			lxCmvfiltrostpreFchdesde =  .Fechadesde			lxCmvfiltrostpreFchhasta =  .Fechahasta			lxCmvfiltrostpreEjercicio =  .Ejercicio_PK 			lxCmvfiltrostpreBase =  .Basededatos			lxCmvfiltrostpreObs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CMVFILTROSTPRE.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CMVFILTROSTPRE set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreUaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreValtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreVmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBdaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBdmodifw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreCodigo ) + "'">>, "Fchdesde" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFchdesde ) + "'">>, "Fchhasta" = <<"'" + this.ConvertirDateSql( lxCmvfiltrostpreFchhasta ) + "'">>, "Ejercicio" = <<lxCmvfiltrostpreEjercicio>>, "Base" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreBase ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCmvfiltrostpreObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CMVFILTROSTPRE' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CMVFILTROSTPRE.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CMVFILTROSTPRE where ' + lcFiltro )
			loColeccion.cTabla = 'CMVFILTROSTPRE' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CMVFILTROSTPRE where  CMVFILTROSTPRE.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CMVFILTROSTPRE where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CMVFILTROSTPRE.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARSTOCKYPRECIOCMV'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CMVFILTROSTPRE Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CMVFILTROSTPRE set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, FchDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FchDesde ) + "'"+ [, FchHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FchHasta ) + "'"+ [, Ejercicio = ] + transform( &lcCursor..Ejercicio )+ [, Base = ] + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, SMODIFW, SALTAFW, UALTAFW, ZADSFW, UMODIFW, VALTAFW, HMODIFW, VMODIFW, HALTAFW, HORAIMPO, ESTTRANS, BDALTAFW, HORAEXPO, BDMODIFW, Codigo, FchDesde, FchHasta, Ejercicio, Base, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FchDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FchHasta ) + "'" + ',' + transform( &lcCursor..Ejercicio ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Base ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CMVFILTROSTPRE ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARSTOCKYPRECIOCMV'
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
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'FILTRARSTOCKYPRECIOCMV'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FILTRARSTOCKYPRECIOCMV_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FILTRARSTOCKYPRECIOCMV_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CMVFiltroStPre')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'FILTRARSTOCKYPRECIOCMV'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad FILTRARSTOCKYPRECIOCMV. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARSTOCKYPRECIOCMV'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARSTOCKYPRECIOCMV'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FchDesde  
		* Validar ANTERIORES A 1/1/1753  FchHasta  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CMVFiltroStPre') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CMVFiltroStPre
Create Table ZooLogic.TablaTrabajo_CMVFiltroStPre ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"fchdesde" datetime  null, 
"fchhasta" datetime  null, 
"ejercicio" numeric( 8, 0 )  null, 
"base" char( 21 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CMVFiltroStPre' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CMVFiltroStPre' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FILTRARSTOCKYPRECIOCMV'
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
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fchdesde','fchdesde')
			.AgregarMapeo('fchhasta','fchhasta')
			.AgregarMapeo('ejercicio','ejercicio')
			.AgregarMapeo('base','base')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CMVFiltroStPre'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FCHDESDE = isnull( d.FCHDESDE, t.FCHDESDE ),t.FCHHASTA = isnull( d.FCHHASTA, t.FCHHASTA ),t.EJERCICIO = isnull( d.EJERCICIO, t.EJERCICIO ),t.BASE = isnull( d.BASE, t.BASE ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.CMVFILTROSTPRE t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.CMVFILTROSTPRE(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Smodifw,Saltafw,Ualtafw,Zadsfw,Umodifw,Valtafw,Hmodifw,Vmodifw,Haltafw,Horaimpo,Esttrans,Bdaltafw,Horaexpo,Bdmodifw,Codigo,Fchdesde,Fchhasta,Ejercicio,Base,Obs)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.CODIGO,''),isnull( d.FCHDESDE,''),isnull( d.FCHHASTA,''),isnull( d.EJERCICIO,0),isnull( d.BASE,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.CMVFILTROSTPRE pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CMVFiltroStPre') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CMVFiltroStPre
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_FILTRARSTOCKYPRECIOCMV' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARSTOCKYPRECIOCMV.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARSTOCKYPRECIOCMV.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARSTOCKYPRECIOCMV.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARSTOCKYPRECIOCMV.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARSTOCKYPRECIOCMV.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Seriemodificacionfw = nvl( c_FILTRARSTOCKYPRECIOCMV.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_FILTRARSTOCKYPRECIOCMV.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_FILTRARSTOCKYPRECIOCMV.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_FILTRARSTOCKYPRECIOCMV.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_FILTRARSTOCKYPRECIOCMV.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_FILTRARSTOCKYPRECIOCMV.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_FILTRARSTOCKYPRECIOCMV.Versionmodificacionfw, [] )
					.Horaaltafw = nvl( c_FILTRARSTOCKYPRECIOCMV.Horaaltafw, [] )
					.Horaimpo = nvl( c_FILTRARSTOCKYPRECIOCMV.Horaimpo, [] )
					.Estadotransferencia = nvl( c_FILTRARSTOCKYPRECIOCMV.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_FILTRARSTOCKYPRECIOCMV.Basededatosaltafw, [] )
					.Horaexpo = nvl( c_FILTRARSTOCKYPRECIOCMV.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_FILTRARSTOCKYPRECIOCMV.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_FILTRARSTOCKYPRECIOCMV.Codigo, [] )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARSTOCKYPRECIOCMV.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_FILTRARSTOCKYPRECIOCMV.Fechahasta, ctod( '  /  /    ' ) ) )
					.Ejercicio_PK =  nvl( c_FILTRARSTOCKYPRECIOCMV.Ejercicio, 0 )
					.Basededatos = nvl( c_FILTRARSTOCKYPRECIOCMV.Basededatos, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
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
		return c_FILTRARSTOCKYPRECIOCMV.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CMVFILTROSTPRE' )
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
								from ZooLogic.CMVFILTROSTPRE 
								Where   CMVFILTROSTPRE.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CMVFILTROSTPRE", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Fchdesde" as "Fechadesde", "Fchhasta" as "Fechahasta", "Ejercicio" as "Ejercicio", "Base" as "Basededatos", "Obs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CMVFILTROSTPRE 
								Where   CMVFILTROSTPRE.CODIGO != ''
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
	Tabla = 'CMVFILTROSTPRE'
	Filtro = " CMVFILTROSTPRE.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CMVFILTROSTPRE.CODIGO != ''"
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
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="FECHAEXPO                               " tabla="CMVFILTROSTPRE " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="FECHATRANSFERENCIA                      " tabla="CMVFILTROSTPRE " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="FECHAIMPO                               " tabla="CMVFILTROSTPRE " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="FECHAALTAFW                             " tabla="CMVFILTROSTPRE " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="FECHAMODIFICACIONFW                     " tabla="CMVFILTROSTPRE " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="SERIEMODIFICACIONFW                     " tabla="CMVFILTROSTPRE " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="SERIEALTAFW                             " tabla="CMVFILTROSTPRE " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="USUARIOALTAFW                           " tabla="CMVFILTROSTPRE " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="ZADSFW                                  " tabla="CMVFILTROSTPRE " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="USUARIOMODIFICACIONFW                   " tabla="CMVFILTROSTPRE " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="VERSIONALTAFW                           " tabla="CMVFILTROSTPRE " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="HORAMODIFICACIONFW                      " tabla="CMVFILTROSTPRE " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="VERSIONMODIFICACIONFW                   " tabla="CMVFILTROSTPRE " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="HORAALTAFW                              " tabla="CMVFILTROSTPRE " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="HORAIMPO                                " tabla="CMVFILTROSTPRE " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="ESTADOTRANSFERENCIA                     " tabla="CMVFILTROSTPRE " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="BASEDEDATOSALTAFW                       " tabla="CMVFILTROSTPRE " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="HORAEXPO                                " tabla="CMVFILTROSTPRE " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CMVFILTROSTPRE " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="CODIGO                                  " tabla="CMVFILTROSTPRE " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="FECHADESDE                              " tabla="CMVFILTROSTPRE " campo="FCHDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha desde                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="FECHAHASTA                              " tabla="CMVFILTROSTPRE " campo="FCHHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Fecha hasta                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="EJERCICIO                               " tabla="CMVFILTROSTPRE " campo="EJERCICIO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="EJERCICIO                               " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Ejercicio                                                                                                                                                       " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="BASEDEDATOS                             " tabla="CMVFILTROSTPRE " campo="BASE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="21" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Base                                                                                                                                                            " dominio="COMBOSUCYAGRUCONVACIO         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FILTRARSTOCKYPRECIOCMV                  " atributo="OBS                                     " tabla="CMVFILTROSTPRE " campo="OBS       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="99" subgrupo="99" orden="99" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="EJERCICIO                               " atributo="DESCRIPCION                             " tabla="EJERCICIO      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Eje.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join EJERCICIO On CMVFILTROSTPRE.EJERCICIO = EJERCICIO.NUMERO And  EJERCICIO.NUMERO != 0                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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