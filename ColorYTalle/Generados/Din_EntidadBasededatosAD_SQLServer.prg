
define class Din_EntidadBASEDEDATOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_BASEDEDATOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_052PK'
	cTablaPrincipal = 'EMP'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'PUESTO'
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'PUESTO'
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
			local  lxEmpFecexpo, lxEmpFectrans, lxEmpFecimpo, lxEmpFmodifw, lxEmpFaltafw, lxEmpHoraexpo, lxEmpHoraimpo, lxEmpEsttrans, lxEmpHaltafw, lxEmpHmodifw, lxEmpBdmodifw, lxEmpBdaltafw, lxEmpSmodifw, lxEmpZadsfw, lxEmpSaltafw, lxEmpUmodifw, lxEmpUaltafw, lxEmpValtafw, lxEmpVmodifw, lxEmpBloqreg, lxEmpEmpcod, lxEmpEunid, lxEmpCrutamdf, lxEmpDescrip, lxEmpUsuario, lxEmpNc1, lxEmpFchlog, lxEmpEpath, lxEmpColor_bd, lxEmpInfstk, lxEmpReplica, lxEmpCobs, lxEmpHaceback, lxEmpRutaback, lxEmpValsalu
				lxEmpFecexpo =  .Fechaexpo			lxEmpFectrans =  .Fechatransferencia			lxEmpFecimpo =  .Fechaimpo			lxEmpFmodifw =  .Fechamodificacionfw			lxEmpFaltafw =  .Fechaaltafw			lxEmpHoraexpo =  .Horaexpo			lxEmpHoraimpo =  .Horaimpo			lxEmpEsttrans =  .Estadotransferencia			lxEmpHaltafw =  .Horaaltafw			lxEmpHmodifw =  .Horamodificacionfw			lxEmpBdmodifw =  .Basededatosmodificacionfw			lxEmpBdaltafw =  .Basededatosaltafw			lxEmpSmodifw =  .Seriemodificacionfw			lxEmpZadsfw =  .Zadsfw			lxEmpSaltafw =  .Seriealtafw			lxEmpUmodifw =  .Usuariomodificacionfw			lxEmpUaltafw =  .Usuarioaltafw			lxEmpValtafw =  .Versionaltafw			lxEmpVmodifw =  .Versionmodificacionfw			lxEmpBloqreg =  .Bloquearregistro			lxEmpEmpcod =  .Codigo			lxEmpEunid =  .Unidad			lxEmpCrutamdf =  .Rutamdf			lxEmpDescrip =  .Descripcion			lxEmpUsuario =  .Usuario			lxEmpNc1 =  upper( .OrigenDestino_PK ) 			lxEmpFchlog =  .Fechalog			lxEmpEpath =  .Ruta			lxEmpColor_bd =  .Color			lxEmpInfstk =  .Informastock			lxEmpReplica =  .Replica			lxEmpCobs =  .Observacion			lxEmpHaceback =  .Realizabackup			lxEmpRutaback =  .Rutabackup			lxEmpValsalu =  .Validarsaluddelabase
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxEmpEmpcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into PUESTO.EMP ( "Fecexpo","Fectrans","Fecimpo","Fmodifw","Faltafw","Horaexpo","Horaimpo","Esttrans","Haltafw","Hmodifw","Bdmodifw","Bdaltafw","Smodifw","Zadsfw","Saltafw","Umodifw","Ualtafw","Valtafw","Vmodifw","Bloqreg","Empcod","Eunid","Crutamdf","Descrip","Usuario","Nc1","Fchlog","Epath","Color_bd","Infstk","Replica","Cobs","Haceback","Rutaback","Valsalu" ) values ( <<"'" + this.ConvertirDateSql( lxEmpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpVmodifw ) + "'" >>, <<iif( lxEmpBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEmpEmpcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpEunid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpCrutamdf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpNc1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFchlog ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpEpath ) + "'" >>, <<lxEmpColor_bd >>, <<iif( lxEmpInfstk, 1, 0 ) >>, <<iif( lxEmpReplica, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEmpCobs ) + "'" >>, <<iif( lxEmpHaceback, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEmpRutaback ) + "'" >>, <<iif( lxEmpValsalu, 1, 0 ) >> )
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
			local  lxEmpFecexpo, lxEmpFectrans, lxEmpFecimpo, lxEmpFmodifw, lxEmpFaltafw, lxEmpHoraexpo, lxEmpHoraimpo, lxEmpEsttrans, lxEmpHaltafw, lxEmpHmodifw, lxEmpBdmodifw, lxEmpBdaltafw, lxEmpSmodifw, lxEmpZadsfw, lxEmpSaltafw, lxEmpUmodifw, lxEmpUaltafw, lxEmpValtafw, lxEmpVmodifw, lxEmpBloqreg, lxEmpEmpcod, lxEmpEunid, lxEmpCrutamdf, lxEmpDescrip, lxEmpUsuario, lxEmpNc1, lxEmpFchlog, lxEmpEpath, lxEmpColor_bd, lxEmpInfstk, lxEmpReplica, lxEmpCobs, lxEmpHaceback, lxEmpRutaback, lxEmpValsalu
				lxEmpFecexpo =  .Fechaexpo			lxEmpFectrans =  .Fechatransferencia			lxEmpFecimpo =  .Fechaimpo			lxEmpFmodifw =  .Fechamodificacionfw			lxEmpFaltafw =  .Fechaaltafw			lxEmpHoraexpo =  .Horaexpo			lxEmpHoraimpo =  .Horaimpo			lxEmpEsttrans =  .Estadotransferencia			lxEmpHaltafw =  .Horaaltafw			lxEmpHmodifw =  .Horamodificacionfw			lxEmpBdmodifw =  .Basededatosmodificacionfw			lxEmpBdaltafw =  .Basededatosaltafw			lxEmpSmodifw =  .Seriemodificacionfw			lxEmpZadsfw =  .Zadsfw			lxEmpSaltafw =  .Seriealtafw			lxEmpUmodifw =  .Usuariomodificacionfw			lxEmpUaltafw =  .Usuarioaltafw			lxEmpValtafw =  .Versionaltafw			lxEmpVmodifw =  .Versionmodificacionfw			lxEmpBloqreg =  .Bloquearregistro			lxEmpEmpcod =  .Codigo			lxEmpEunid =  .Unidad			lxEmpCrutamdf =  .Rutamdf			lxEmpDescrip =  .Descripcion			lxEmpUsuario =  .Usuario			lxEmpNc1 =  upper( .OrigenDestino_PK ) 			lxEmpFchlog =  .Fechalog			lxEmpEpath =  .Ruta			lxEmpColor_bd =  .Color			lxEmpInfstk =  .Informastock			lxEmpReplica =  .Replica			lxEmpCobs =  .Observacion			lxEmpHaceback =  .Realizabackup			lxEmpRutaback =  .Rutabackup			lxEmpValsalu =  .Validarsaluddelabase
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update PUESTO.EMP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxEmpFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxEmpFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxEmpFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxEmpFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxEmpFaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxEmpHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxEmpHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxEmpEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxEmpHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxEmpHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEmpBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEmpBdaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxEmpSmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxEmpZadsfw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxEmpSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxEmpUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxEmpUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxEmpValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxEmpVmodifw ) + "'">>,"Bloqreg" = <<iif( lxEmpBloqreg, 1, 0 )>>,"Empcod" = <<"'" + this.FormatearTextoSql( lxEmpEmpcod ) + "'">>,"Eunid" = <<"'" + this.FormatearTextoSql( lxEmpEunid ) + "'">>,"Crutamdf" = <<"'" + this.FormatearTextoSql( lxEmpCrutamdf ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxEmpDescrip ) + "'">>,"Usuario" = <<"'" + this.FormatearTextoSql( lxEmpUsuario ) + "'">>,"Nc1" = <<"'" + this.FormatearTextoSql( lxEmpNc1 ) + "'">>,"Fchlog" = <<"'" + this.ConvertirDateSql( lxEmpFchlog ) + "'">>,"Epath" = <<"'" + this.FormatearTextoSql( lxEmpEpath ) + "'">>,"Color_bd" = <<lxEmpColor_bd>>,"Infstk" = <<iif( lxEmpInfstk, 1, 0 )>>,"Replica" = <<iif( lxEmpReplica, 1, 0 )>>,"Cobs" = <<"'" + this.FormatearTextoSql( lxEmpCobs ) + "'">>,"Haceback" = <<iif( lxEmpHaceback, 1, 0 )>>,"Rutaback" = <<"'" + this.FormatearTextoSql( lxEmpRutaback ) + "'">>,"Valsalu" = <<iif( lxEmpValsalu, 1, 0 )>> where "Empcod" = <<"'" + this.FormatearTextoSql( lxEmpEmpcod ) + "'">> and  EMP.EMPCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 EMPCOD from PUESTO.EMP where " + this.ConvertirFuncionesSql( " EMP.EMPCOD != ''" ) )
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
			Local lxEmpEmpcod
			lxEmpEmpcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bloqreg" as "Bloquearregistro", "Empcod" as "Codigo", "Eunid" as "Unidad", "Crutamdf" as "Rutamdf", "Descrip" as "Descripcion", "Usuario" as "Usuario", "Nc1" as "Origendestino", "Fchlog" as "Fechalog", "Epath" as "Ruta", "Color_bd" as "Color", "Infstk" as "Informastock", "Replica" as "Replica", "Cobs" as "Observacion", "Haceback" as "Realizabackup", "Rutaback" as "Rutabackup", "Valsalu" as "Validarsaluddelabase" from PUESTO.EMP where "Empcod" = <<"'" + this.FormatearTextoSql( lxEmpEmpcod ) + "'">> and  EMP.EMPCOD != ''
			endtext
			use in select('c_BASEDEDATOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BASEDEDATOS', set( 'Datasession' ) )

			if reccount( 'c_BASEDEDATOS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxEmpEmpcod as Variant
		llRetorno = .t.
		lxEmpEmpcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from PUESTO.EMP where "Empcod" = <<"'" + this.FormatearTextoSql( lxEmpEmpcod ) + "'">> and  EMP.EMPCOD != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bloqreg" as "Bloquearregistro", "Empcod" as "Codigo", "Eunid" as "Unidad", "Crutamdf" as "Rutamdf", "Descrip" as "Descripcion", "Usuario" as "Usuario", "Nc1" as "Origendestino", "Fchlog" as "Fechalog", "Epath" as "Ruta", "Color_bd" as "Color", "Infstk" as "Informastock", "Replica" as "Replica", "Cobs" as "Observacion", "Haceback" as "Realizabackup", "Rutaback" as "Rutabackup", "Valsalu" as "Validarsaluddelabase" from PUESTO.EMP where  EMP.EMPCOD != '' order by EMPCOD
			endtext
			use in select('c_BASEDEDATOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BASEDEDATOS', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bloqreg" as "Bloquearregistro", "Empcod" as "Codigo", "Eunid" as "Unidad", "Crutamdf" as "Rutamdf", "Descrip" as "Descripcion", "Usuario" as "Usuario", "Nc1" as "Origendestino", "Fchlog" as "Fechalog", "Epath" as "Ruta", "Color_bd" as "Color", "Infstk" as "Informastock", "Replica" as "Replica", "Cobs" as "Observacion", "Haceback" as "Realizabackup", "Rutaback" as "Rutabackup", "Valsalu" as "Validarsaluddelabase" from PUESTO.EMP where  funciones.padr( EMPCOD, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  EMP.EMPCOD != '' order by EMPCOD
			endtext
			use in select('c_BASEDEDATOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BASEDEDATOS', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bloqreg" as "Bloquearregistro", "Empcod" as "Codigo", "Eunid" as "Unidad", "Crutamdf" as "Rutamdf", "Descrip" as "Descripcion", "Usuario" as "Usuario", "Nc1" as "Origendestino", "Fchlog" as "Fechalog", "Epath" as "Ruta", "Color_bd" as "Color", "Infstk" as "Informastock", "Replica" as "Replica", "Cobs" as "Observacion", "Haceback" as "Realizabackup", "Rutaback" as "Rutabackup", "Valsalu" as "Validarsaluddelabase" from PUESTO.EMP where  funciones.padr( EMPCOD, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  EMP.EMPCOD != '' order by EMPCOD desc
			endtext
			use in select('c_BASEDEDATOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BASEDEDATOS', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bloqreg" as "Bloquearregistro", "Empcod" as "Codigo", "Eunid" as "Unidad", "Crutamdf" as "Rutamdf", "Descrip" as "Descripcion", "Usuario" as "Usuario", "Nc1" as "Origendestino", "Fchlog" as "Fechalog", "Epath" as "Ruta", "Color_bd" as "Color", "Infstk" as "Informastock", "Replica" as "Replica", "Cobs" as "Observacion", "Haceback" as "Realizabackup", "Rutaback" as "Rutabackup", "Valsalu" as "Validarsaluddelabase" from PUESTO.EMP where  EMP.EMPCOD != '' order by EMPCOD desc
			endtext
			use in select('c_BASEDEDATOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BASEDEDATOS', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Fmodifw,Faltafw,Horaexpo,Horaimpo,Esttrans,Haltafw,Hmodifw,Bdmodifw" + ;
",Bdaltafw,Smodifw,Zadsfw,Saltafw,Umodifw,Ualtafw,Valtafw,Vmodifw,Bloqreg,Empcod,Eunid,Crutamdf,Descr" + ;
"ip,Usuario,Nc1,Fchlog,Epath,Color_bd,Infstk,Replica,Cobs,Haceback,Rutaback,Valsalu" + ;
" from PUESTO.EMP where  EMP.EMPCOD != '' and " + lcFiltro )
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
			local  lxEmpFecexpo, lxEmpFectrans, lxEmpFecimpo, lxEmpFmodifw, lxEmpFaltafw, lxEmpHoraexpo, lxEmpHoraimpo, lxEmpEsttrans, lxEmpHaltafw, lxEmpHmodifw, lxEmpBdmodifw, lxEmpBdaltafw, lxEmpSmodifw, lxEmpZadsfw, lxEmpSaltafw, lxEmpUmodifw, lxEmpUaltafw, lxEmpValtafw, lxEmpVmodifw, lxEmpBloqreg, lxEmpEmpcod, lxEmpEunid, lxEmpCrutamdf, lxEmpDescrip, lxEmpUsuario, lxEmpNc1, lxEmpFchlog, lxEmpEpath, lxEmpColor_bd, lxEmpInfstk, lxEmpReplica, lxEmpCobs, lxEmpHaceback, lxEmpRutaback, lxEmpValsalu
				lxEmpFecexpo = ctod( '  /  /    ' )			lxEmpFectrans = ctod( '  /  /    ' )			lxEmpFecimpo = ctod( '  /  /    ' )			lxEmpFmodifw = ctod( '  /  /    ' )			lxEmpFaltafw = ctod( '  /  /    ' )			lxEmpHoraexpo = []			lxEmpHoraimpo = []			lxEmpEsttrans = []			lxEmpHaltafw = []			lxEmpHmodifw = []			lxEmpBdmodifw = []			lxEmpBdaltafw = []			lxEmpSmodifw = []			lxEmpZadsfw = []			lxEmpSaltafw = []			lxEmpUmodifw = []			lxEmpUaltafw = []			lxEmpValtafw = []			lxEmpVmodifw = []			lxEmpBloqreg = .F.			lxEmpEmpcod = []			lxEmpEunid = []			lxEmpCrutamdf = []			lxEmpDescrip = []			lxEmpUsuario = []			lxEmpNc1 = []			lxEmpFchlog = ctod( '  /  /    ' )			lxEmpEpath = []			lxEmpColor_bd = 0			lxEmpInfstk = .F.			lxEmpReplica = .F.			lxEmpCobs = []			lxEmpHaceback = .F.			lxEmpRutaback = []			lxEmpValsalu = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from PUESTO.EMP where "EMPCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'EMP' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where EMPCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(EMPCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  EMP.EMPCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bloqreg" as "Bloquearregistro", "Empcod" as "Codigo", "Eunid" as "Unidad", "Crutamdf" as "Rutamdf", "Descrip" as "Descripcion", "Usuario" as "Usuario", "Nc1" as "Origendestino", "Fchlog" as "Fechalog", "Epath" as "Ruta", "Color_bd" as "Color", "Infstk" as "Informastock", "Replica" as "Replica", "Cobs" as "Observacion", "Haceback" as "Realizabackup", "Rutaback" as "Rutabackup", "Valsalu" as "Validarsaluddelabase"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'EMP', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EMPCOD AS CODIGO'
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EUNID AS UNIDAD'
				Case lcAtributo == 'RUTAMDF'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRUTAMDF AS RUTAMDF'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'USUARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USUARIO AS USUARIO'
				Case lcAtributo == 'ORIGENDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NC1 AS ORIGENDESTINO'
				Case lcAtributo == 'FECHALOG'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCHLOG AS FECHALOG'
				Case lcAtributo == 'RUTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EPATH AS RUTA'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLOR_BD AS COLOR'
				Case lcAtributo == 'INFORMASTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INFSTK AS INFORMASTOCK'
				Case lcAtributo == 'REPLICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REPLICA AS REPLICA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERVACION'
				Case lcAtributo == 'REALIZABACKUP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HACEBACK AS REALIZABACKUP'
				Case lcAtributo == 'RUTABACKUP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RUTABACK AS RUTABACKUP'
				Case lcAtributo == 'VALIDARSALUDDELABASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALSALU AS VALIDARSALUDDELABASE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'EMPCOD'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'EUNID'
			Case upper( alltrim( tcAtributo ) ) == 'RUTAMDF'
				lcCampo = 'CRUTAMDF'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIO'
				lcCampo = 'USUARIO'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDESTINO'
				lcCampo = 'NC1'
			Case upper( alltrim( tcAtributo ) ) == 'FECHALOG'
				lcCampo = 'FCHLOG'
			Case upper( alltrim( tcAtributo ) ) == 'RUTA'
				lcCampo = 'EPATH'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'COLOR_BD'
			Case upper( alltrim( tcAtributo ) ) == 'INFORMASTOCK'
				lcCampo = 'INFSTK'
			Case upper( alltrim( tcAtributo ) ) == 'REPLICA'
				lcCampo = 'REPLICA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'REALIZABACKUP'
				lcCampo = 'HACEBACK'
			Case upper( alltrim( tcAtributo ) ) == 'RUTABACKUP'
				lcCampo = 'RUTABACK'
			Case upper( alltrim( tcAtributo ) ) == 'VALIDARSALUDDELABASE'
				lcCampo = 'VALSALU'
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
			local  lxEmpFecexpo, lxEmpFectrans, lxEmpFecimpo, lxEmpFmodifw, lxEmpFaltafw, lxEmpHoraexpo, lxEmpHoraimpo, lxEmpEsttrans, lxEmpHaltafw, lxEmpHmodifw, lxEmpBdmodifw, lxEmpBdaltafw, lxEmpSmodifw, lxEmpZadsfw, lxEmpSaltafw, lxEmpUmodifw, lxEmpUaltafw, lxEmpValtafw, lxEmpVmodifw, lxEmpBloqreg, lxEmpEmpcod, lxEmpEunid, lxEmpCrutamdf, lxEmpDescrip, lxEmpUsuario, lxEmpNc1, lxEmpFchlog, lxEmpEpath, lxEmpColor_bd, lxEmpInfstk, lxEmpReplica, lxEmpCobs, lxEmpHaceback, lxEmpRutaback, lxEmpValsalu
				lxEmpFecexpo =  .Fechaexpo			lxEmpFectrans =  .Fechatransferencia			lxEmpFecimpo =  .Fechaimpo			lxEmpFmodifw =  .Fechamodificacionfw			lxEmpFaltafw =  .Fechaaltafw			lxEmpHoraexpo =  .Horaexpo			lxEmpHoraimpo =  .Horaimpo			lxEmpEsttrans =  .Estadotransferencia			lxEmpHaltafw =  .Horaaltafw			lxEmpHmodifw =  .Horamodificacionfw			lxEmpBdmodifw =  .Basededatosmodificacionfw			lxEmpBdaltafw =  .Basededatosaltafw			lxEmpSmodifw =  .Seriemodificacionfw			lxEmpZadsfw =  .Zadsfw			lxEmpSaltafw =  .Seriealtafw			lxEmpUmodifw =  .Usuariomodificacionfw			lxEmpUaltafw =  .Usuarioaltafw			lxEmpValtafw =  .Versionaltafw			lxEmpVmodifw =  .Versionmodificacionfw			lxEmpBloqreg =  .Bloquearregistro			lxEmpEmpcod =  .Codigo			lxEmpEunid =  .Unidad			lxEmpCrutamdf =  .Rutamdf			lxEmpDescrip =  .Descripcion			lxEmpUsuario =  .Usuario			lxEmpNc1 =  upper( .OrigenDestino_PK ) 			lxEmpFchlog =  .Fechalog			lxEmpEpath =  .Ruta			lxEmpColor_bd =  .Color			lxEmpInfstk =  .Informastock			lxEmpReplica =  .Replica			lxEmpCobs =  .Observacion			lxEmpHaceback =  .Realizabackup			lxEmpRutaback =  .Rutabackup			lxEmpValsalu =  .Validarsaluddelabase
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into PUESTO.EMP ( "Fecexpo","Fectrans","Fecimpo","Fmodifw","Faltafw","Horaexpo","Horaimpo","Esttrans","Haltafw","Hmodifw","Bdmodifw","Bdaltafw","Smodifw","Zadsfw","Saltafw","Umodifw","Ualtafw","Valtafw","Vmodifw","Bloqreg","Empcod","Eunid","Crutamdf","Descrip","Usuario","Nc1","Fchlog","Epath","Color_bd","Infstk","Replica","Cobs","Haceback","Rutaback","Valsalu" ) values ( <<"'" + this.ConvertirDateSql( lxEmpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpVmodifw ) + "'" >>, <<iif( lxEmpBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEmpEmpcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpEunid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpCrutamdf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpNc1 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEmpFchlog ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEmpEpath ) + "'" >>, <<lxEmpColor_bd >>, <<iif( lxEmpInfstk, 1, 0 ) >>, <<iif( lxEmpReplica, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEmpCobs ) + "'" >>, <<iif( lxEmpHaceback, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEmpRutaback ) + "'" >>, <<iif( lxEmpValsalu, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'EMP' 
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
			local  lxEmpFecexpo, lxEmpFectrans, lxEmpFecimpo, lxEmpFmodifw, lxEmpFaltafw, lxEmpHoraexpo, lxEmpHoraimpo, lxEmpEsttrans, lxEmpHaltafw, lxEmpHmodifw, lxEmpBdmodifw, lxEmpBdaltafw, lxEmpSmodifw, lxEmpZadsfw, lxEmpSaltafw, lxEmpUmodifw, lxEmpUaltafw, lxEmpValtafw, lxEmpVmodifw, lxEmpBloqreg, lxEmpEmpcod, lxEmpEunid, lxEmpCrutamdf, lxEmpDescrip, lxEmpUsuario, lxEmpNc1, lxEmpFchlog, lxEmpEpath, lxEmpColor_bd, lxEmpInfstk, lxEmpReplica, lxEmpCobs, lxEmpHaceback, lxEmpRutaback, lxEmpValsalu
				lxEmpFecexpo =  .Fechaexpo			lxEmpFectrans =  .Fechatransferencia			lxEmpFecimpo =  .Fechaimpo			lxEmpFmodifw =  .Fechamodificacionfw			lxEmpFaltafw =  .Fechaaltafw			lxEmpHoraexpo =  .Horaexpo			lxEmpHoraimpo =  .Horaimpo			lxEmpEsttrans =  .Estadotransferencia			lxEmpHaltafw =  .Horaaltafw			lxEmpHmodifw =  .Horamodificacionfw			lxEmpBdmodifw =  .Basededatosmodificacionfw			lxEmpBdaltafw =  .Basededatosaltafw			lxEmpSmodifw =  .Seriemodificacionfw			lxEmpZadsfw =  .Zadsfw			lxEmpSaltafw =  .Seriealtafw			lxEmpUmodifw =  .Usuariomodificacionfw			lxEmpUaltafw =  .Usuarioaltafw			lxEmpValtafw =  .Versionaltafw			lxEmpVmodifw =  .Versionmodificacionfw			lxEmpBloqreg =  .Bloquearregistro			lxEmpEmpcod =  .Codigo			lxEmpEunid =  .Unidad			lxEmpCrutamdf =  .Rutamdf			lxEmpDescrip =  .Descripcion			lxEmpUsuario =  .Usuario			lxEmpNc1 =  upper( .OrigenDestino_PK ) 			lxEmpFchlog =  .Fechalog			lxEmpEpath =  .Ruta			lxEmpColor_bd =  .Color			lxEmpInfstk =  .Informastock			lxEmpReplica =  .Replica			lxEmpCobs =  .Observacion			lxEmpHaceback =  .Realizabackup			lxEmpRutaback =  .Rutabackup			lxEmpValsalu =  .Validarsaluddelabase
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Empcod" = ] + lcValorClavePrimariaString  + [ and  EMP.EMPCOD != '']
			text to lcSentencia noshow textmerge
				update PUESTO.EMP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxEmpFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxEmpFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxEmpFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxEmpFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxEmpFaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxEmpHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxEmpHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxEmpEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxEmpHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxEmpHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEmpBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEmpBdaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxEmpSmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxEmpZadsfw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxEmpSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxEmpUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxEmpUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxEmpValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxEmpVmodifw ) + "'">>, "Bloqreg" = <<iif( lxEmpBloqreg, 1, 0 )>>, "Empcod" = <<"'" + this.FormatearTextoSql( lxEmpEmpcod ) + "'">>, "Eunid" = <<"'" + this.FormatearTextoSql( lxEmpEunid ) + "'">>, "Crutamdf" = <<"'" + this.FormatearTextoSql( lxEmpCrutamdf ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxEmpDescrip ) + "'">>, "Usuario" = <<"'" + this.FormatearTextoSql( lxEmpUsuario ) + "'">>, "Nc1" = <<"'" + this.FormatearTextoSql( lxEmpNc1 ) + "'">>, "Fchlog" = <<"'" + this.ConvertirDateSql( lxEmpFchlog ) + "'">>, "Epath" = <<"'" + this.FormatearTextoSql( lxEmpEpath ) + "'">>, "Color_bd" = <<lxEmpColor_bd>>, "Infstk" = <<iif( lxEmpInfstk, 1, 0 )>>, "Replica" = <<iif( lxEmpReplica, 1, 0 )>>, "Cobs" = <<"'" + this.FormatearTextoSql( lxEmpCobs ) + "'">>, "Haceback" = <<iif( lxEmpHaceback, 1, 0 )>>, "Rutaback" = <<"'" + this.FormatearTextoSql( lxEmpRutaback ) + "'">>, "Valsalu" = <<iif( lxEmpValsalu, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'EMP' 
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

			lcFiltro = ["Empcod" = ] + lcValorClavePrimariaString  + [ and  EMP.EMPCOD != '']
		loColeccion.Agregar( 'delete from PUESTO.EMP where ' + lcFiltro )
			loColeccion.cTabla = 'EMP' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from PUESTO.EMP where  EMP.EMPCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from PUESTO.EMP where EMPCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  EMP.EMPCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'BASEDEDATOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From PUESTO.EMP Where EMPCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..EMPCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE PUESTO.EMP set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, EMPCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..EMPCOD ) + "'"+ [, EUNID = ] + "'" + this.FormatearTextoSql( &lcCursor..EUNID ) + "'"+ [, cRutaMDF = ] + "'" + this.FormatearTextoSql( &lcCursor..cRutaMDF ) + "'"+ [, DESCRIP = ] + "'" + this.FormatearTextoSql( &lcCursor..DESCRIP ) + "'"+ [, USUARIO = ] + "'" + this.FormatearTextoSql( &lcCursor..USUARIO ) + "'"+ [, NC1 = ] + "'" + this.FormatearTextoSql( &lcCursor..NC1 ) + "'"+ [, FCHLOG = ] + "'" + this.ConvertirDateSql( &lcCursor..FCHLOG ) + "'"+ [, EPATH = ] + "'" + this.FormatearTextoSql( &lcCursor..EPATH ) + "'"+ [, COLOR_BD = ] + transform( &lcCursor..COLOR_BD )+ [, infstk = ] + Transform( iif( &lcCursor..infstk, 1, 0 ))+ [, REPLICA = ] + Transform( iif( &lcCursor..REPLICA, 1, 0 ))+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"+ [, haceBack = ] + Transform( iif( &lcCursor..haceBack, 1, 0 ))+ [, RutaBack = ] + "'" + this.FormatearTextoSql( &lcCursor..RutaBack ) + "'"+ [, ValSalu = ] + Transform( iif( &lcCursor..ValSalu, 1, 0 )) + [ Where EMPCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..EMPCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FMODIFW, FALTAFW, HORAEXPO, HORAIMPO, ESTTRANS, HALTAFW, HMODIFW, BDMODIFW, BDALTAFW, SMODIFW, ZADSFW, SALTAFW, UMODIFW, UALTAFW, VALTAFW, VMODIFW, BLOQREG, EMPCOD, EUNID, cRutaMDF, DESCRIP, USUARIO, NC1, FCHLOG, EPATH, COLOR_BD, infstk, REPLICA, cObs, haceBack, RutaBack, ValSalu
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..EMPCOD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..EUNID ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cRutaMDF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DESCRIP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..USUARIO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NC1 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FCHLOG ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EPATH ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..COLOR_BD ) + ',' + Transform( iif( &lcCursor..infstk, 1, 0 )) + ',' + Transform( iif( &lcCursor..REPLICA, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'" + ',' + Transform( iif( &lcCursor..haceBack, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..RutaBack ) + "'" + ',' + Transform( iif( &lcCursor..ValSalu, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into PUESTO.EMP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'BASEDEDATOS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( EMPCOD C (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Nombre: ' + transform( &tcCursor..EMPCOD     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'BASEDEDATOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'BASEDEDATOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'BASEDEDATOS_COBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From PUESTO.TablaTrabajo_EMP')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'BASEDEDATOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..EMPCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad BASEDEDATOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'BASEDEDATOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,EMPCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( EMPCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'BASEDEDATOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FCHLOG    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('PUESTO.TablaTrabajo_EMP') AND type in ('U')) DROP TABLE PUESTO.TablaTrabajo_EMP
Create Table PUESTO.TablaTrabajo_EMP ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"bloqreg" bit  null, 
"empcod" char( 8 )  null, 
"eunid" char( 1 )  null, 
"crutamdf" char( 250 )  null, 
"descrip" char( 30 )  null, 
"usuario" char( 8 )  null, 
"nc1" char( 8 )  null, 
"fchlog" datetime  null, 
"epath" char( 250 )  null, 
"color_bd" numeric( 9, 0 )  null, 
"infstk" bit  null, 
"replica" bit  null, 
"cobs" varchar(max)  null, 
"haceback" bit  null, 
"rutaback" char( 250 )  null, 
"valsalu" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_EMP' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_EMP' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'BASEDEDATOS'
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('empcod','empcod')
			.AgregarMapeo('eunid','eunid')
			.AgregarMapeo('crutamdf','crutamdf')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('usuario','usuario')
			.AgregarMapeo('nc1','nc1')
			.AgregarMapeo('fchlog','fchlog')
			.AgregarMapeo('epath','epath')
			.AgregarMapeo('color_bd','color_bd')
			.AgregarMapeo('infstk','infstk')
			.AgregarMapeo('replica','replica')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('haceback','haceback')
			.AgregarMapeo('rutaback','rutaback')
			.AgregarMapeo('valsalu','valsalu')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'PUESTO.TablaTrabajo_EMP'
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
			CREATE TRIGGER PUESTO.DELETE_<<lcTabla>>
				ON PUESTO.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.EMPCOD = isnull( d.EMPCOD, t.EMPCOD ),t.EUNID = isnull( d.EUNID, t.EUNID ),t.CRUTAMDF = isnull( d.CRUTAMDF, t.CRUTAMDF ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.USUARIO = isnull( d.USUARIO, t.USUARIO ),t.NC1 = isnull( d.NC1, t.NC1 ),t.FCHLOG = isnull( d.FCHLOG, t.FCHLOG ),t.EPATH = isnull( d.EPATH, t.EPATH ),t.COLOR_BD = isnull( d.COLOR_BD, t.COLOR_BD ),t.INFSTK = isnull( d.INFSTK, t.INFSTK ),t.REPLICA = isnull( d.REPLICA, t.REPLICA ),t.COBS = isnull( d.COBS, t.COBS ),t.HACEBACK = isnull( d.HACEBACK, t.HACEBACK ),t.RUTABACK = isnull( d.RUTABACK, t.RUTABACK ),t.VALSALU = isnull( d.VALSALU, t.VALSALU )
					from PUESTO.EMP t inner join deleted d 
							 on t.EMPCOD = d.EMPCOD
				-- Fin Updates
				insert into PUESTO.EMP(Fecexpo,Fectrans,Fecimpo,Fmodifw,Faltafw,Horaexpo,Horaimpo,Esttrans,Haltafw,Hmodifw,Bdmodifw,Bdaltafw,Smodifw,Zadsfw,Saltafw,Umodifw,Ualtafw,Valtafw,Vmodifw,Bloqreg,Empcod,Eunid,Crutamdf,Descrip,Usuario,Nc1,Fchlog,Epath,Color_bd,Infstk,Replica,Cobs,Haceback,Rutaback,Valsalu)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.SMODIFW,''),isnull( d.ZADSFW,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.BLOQREG,0),isnull( d.EMPCOD,''),isnull( d.EUNID,''),isnull( d.CRUTAMDF,''),isnull( d.DESCRIP,''),isnull( d.USUARIO,''),isnull( d.NC1,''),isnull( d.FCHLOG,''),isnull( d.EPATH,''),isnull( d.COLOR_BD,0),isnull( d.INFSTK,0),isnull( d.REPLICA,0),isnull( d.COBS,''),isnull( d.HACEBACK,0),isnull( d.RUTABACK,''),isnull( d.VALSALU,0)
						From deleted d left join PUESTO.EMP pk 
							 on d.EMPCOD = pk.EMPCOD
						Where pk.EMPCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('PUESTO.TablaTrabajo_EMP') AND type in ('U')) DROP TABLE PUESTO.TablaTrabajo_EMP
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_BASEDEDATOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_BASEDEDATOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_BASEDEDATOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_BASEDEDATOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_BASEDEDATOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_BASEDEDATOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_BASEDEDATOS.Horaexpo, [] )
					.Horaimpo = nvl( c_BASEDEDATOS.Horaimpo, [] )
					.Estadotransferencia = nvl( c_BASEDEDATOS.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_BASEDEDATOS.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_BASEDEDATOS.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_BASEDEDATOS.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_BASEDEDATOS.Basededatosaltafw, [] )
					.Seriemodificacionfw = nvl( c_BASEDEDATOS.Seriemodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriealtafw = nvl( c_BASEDEDATOS.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_BASEDEDATOS.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_BASEDEDATOS.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_BASEDEDATOS.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_BASEDEDATOS.Versionmodificacionfw, [] )
					.Bloquearregistro = nvl( c_BASEDEDATOS.Bloquearregistro, .F. )
					.Codigo = nvl( c_BASEDEDATOS.Codigo, [] )
					.Unidad = nvl( c_BASEDEDATOS.Unidad, [] )
					.Rutamdf = nvl( c_BASEDEDATOS.Rutamdf, [] )
					.Descripcion = nvl( c_BASEDEDATOS.Descripcion, [] )
					.Usuario = nvl( c_BASEDEDATOS.Usuario, [] )
					.Origendestino_PK =  nvl( c_BASEDEDATOS.Origendestino, [] )
					.Fechalog = GoLibrerias.ObtenerFechaFormateada( nvl( c_BASEDEDATOS.Fechalog, ctod( '  /  /    ' ) ) )
					.Ruta = nvl( c_BASEDEDATOS.Ruta, [] )
					.Color = nvl( c_BASEDEDATOS.Color, 0 )
					.Informastock = nvl( c_BASEDEDATOS.Informastock, .F. )
					.Replica = nvl( c_BASEDEDATOS.Replica, .F. )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Realizabackup = nvl( c_BASEDEDATOS.Realizabackup, .F. )
					.Rutabackup = nvl( c_BASEDEDATOS.Rutabackup, [] )
					.Validarsaluddelabase = nvl( c_BASEDEDATOS.Validarsaluddelabase, .F. )
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
		return c_BASEDEDATOS.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.PUESTO.EMP' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "EMPCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,EMPCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    EMPCOD from (
							select * 
								from PUESTO.EMP 
								Where   EMP.EMPCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "EMP", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "EMPCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Bloqreg" as "Bloquearregistro", "Empcod" as "Codigo", "Eunid" as "Unidad", "Crutamdf" as "Rutamdf", "Descrip" as "Descripcion", "Usuario" as "Usuario", "Nc1" as "Origendestino", "Fchlog" as "Fechalog", "Epath" as "Ruta", "Color_bd" as "Color", "Infstk" as "Informastock", "Replica" as "Replica", "Cobs" as "Observacion", "Haceback" as "Realizabackup", "Rutaback" as "Rutabackup", "Valsalu" as "Validarsaluddelabase"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from PUESTO.EMP 
								Where   EMP.EMPCOD != ''
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
	Tabla = 'EMP'
	Filtro = " EMP.EMPCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " EMP.EMPCOD != ''"
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
	<row entidad="BASEDEDATOS                             " atributo="FECHAEXPO                               " tabla="EMP            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="FECHATRANSFERENCIA                      " tabla="EMP            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="FECHAIMPO                               " tabla="EMP            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="FECHAMODIFICACIONFW                     " tabla="EMP            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="FECHAALTAFW                             " tabla="EMP            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="HORAEXPO                                " tabla="EMP            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="HORAIMPO                                " tabla="EMP            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="ESTADOTRANSFERENCIA                     " tabla="EMP            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="HORAALTAFW                              " tabla="EMP            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="HORAMODIFICACIONFW                      " tabla="EMP            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="EMP            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="BASEDEDATOSALTAFW                       " tabla="EMP            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="SERIEMODIFICACIONFW                     " tabla="EMP            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="ZADSFW                                  " tabla="EMP            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="SERIEALTAFW                             " tabla="EMP            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="USUARIOMODIFICACIONFW                   " tabla="EMP            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="USUARIOALTAFW                           " tabla="EMP            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="VERSIONALTAFW                           " tabla="EMP            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="VERSIONMODIFICACIONFW                   " tabla="EMP            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="BLOQUEARREGISTRO                        " tabla="EMP            " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="CODIGO                                  " tabla="EMP            " campo="EMPCOD    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Nombre                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="RUTACOMPLETA                            " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="=_screen.zoo.crutainicial                                                                                                                                                                                                                                     " obligatorio="true" admitebusqueda="400" etiqueta="Ruta completa                                                                                                                                                   " dominio="RUTABASEDEDATOS               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="UNIDAD                                  " tabla="EMP            " campo="EUNID     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Unidad                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="RUTAMDF                                 " tabla="EMP            " campo="CRUTAMDF  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Ruta de los archivos de datos                                                                                                                                   " dominio="RUTABASEDEDATOS               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="DESCRIPCION                             " tabla="EMP            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="USUARIO                                 " tabla="EMP            " campo="USUARIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="ORIGENDESTINO                           " tabla="EMP            " campo="NC1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Origen                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="FECHALOG                                " tabla="EMP            " campo="FCHLOG    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha Log                                                                                                                                                       " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="RUTA                                    " tabla="EMP            " campo="EPATH     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Ruta                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="SUCURSAL                                " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Sucursal                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="COLOR                                   " tabla="EMP            " campo="COLOR_BD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Color                                                                                                                                                           " dominio="COLOR                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="PREFERENTE                              " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Base de datos preferente                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="PROCESAPAQUETES                         " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Procesar paquetes de datos                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="INFORMASTOCK                            " tabla="EMP            " campo="INFSTK    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Informa stock interlocales                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="CONECTADA                               " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="414" etiqueta="Conectada                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="REPLICA                                 " tabla="EMP            " campo="REPLICA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Es réplica                                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="OBSERVACION                             " tabla="EMP            " campo="COBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="IDBASEDEDATOS                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="ID de base de datos                                                                                                                                             " dominio="CARACTERPERMITEFOCO           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="REALIZABACKUP                           " tabla="EMP            " campo="HACEBACK  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Incluir en backup automático                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="RUTABACKUP                              " tabla="EMP            " campo="RUTABACK  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Ruta del backup                                                                                                                                                 " dominio="RUTABACKUPBD                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="92" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BASEDEDATOS                             " atributo="VALIDARSALUDDELABASE                    " tabla="EMP            " campo="VALSALU   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Debe revisar la salud de la base?                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="100" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On EMP.NC1 = ORDAT.CODIGO And  ORDAT.CODIGO != ''                                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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