
define class Din_EntidadTIPOAREAEXPORTACIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TIPOAREAEXPORTACION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_TAEPK'
	cTablaPrincipal = 'TAREAEXP'
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
			local  lxTareaexpFecexpo, lxTareaexpFectrans, lxTareaexpFecimpo, lxTareaexpFaltafw, lxTareaexpFmodifw, lxTareaexpBloqreg, lxTareaexpUaltafw, lxTareaexpUmodifw, lxTareaexpValtafw, lxTareaexpSmodifw, lxTareaexpZadsfw, lxTareaexpVmodifw, lxTareaexpHaltafw, lxTareaexpSaltafw, lxTareaexpEsttrans, lxTareaexpBdmodifw, lxTareaexpHoraexpo, lxTareaexpHmodifw, lxTareaexpBdaltafw, lxTareaexpHoraimpo, lxTareaexpCcod, lxTareaexpCdes, lxTareaexpLcabecera, lxTareaexpLdetalle, lxTareaexpLtitulo, lxTareaexpLpie, lxTareaexpLmulti
				lxTareaexpFecexpo =  .Fechaexpo			lxTareaexpFectrans =  .Fechatransferencia			lxTareaexpFecimpo =  .Fechaimpo			lxTareaexpFaltafw =  .Fechaaltafw			lxTareaexpFmodifw =  .Fechamodificacionfw			lxTareaexpBloqreg =  .Bloquearregistro			lxTareaexpUaltafw =  .Usuarioaltafw			lxTareaexpUmodifw =  .Usuariomodificacionfw			lxTareaexpValtafw =  .Versionaltafw			lxTareaexpSmodifw =  .Seriemodificacionfw			lxTareaexpZadsfw =  .Zadsfw			lxTareaexpVmodifw =  .Versionmodificacionfw			lxTareaexpHaltafw =  .Horaaltafw			lxTareaexpSaltafw =  .Seriealtafw			lxTareaexpEsttrans =  .Estadotransferencia			lxTareaexpBdmodifw =  .Basededatosmodificacionfw			lxTareaexpHoraexpo =  .Horaexpo			lxTareaexpHmodifw =  .Horamodificacionfw			lxTareaexpBdaltafw =  .Basededatosaltafw			lxTareaexpHoraimpo =  .Horaimpo			lxTareaexpCcod =  .Codigo			lxTareaexpCdes =  .Descripcion			lxTareaexpLcabecera =  .Cabecera			lxTareaexpLdetalle =  .Detalle			lxTareaexpLtitulo =  .Titulo			lxTareaexpLpie =  .Piedepagina			lxTareaexpLmulti =  .Multilinea
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTareaexpCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.TAREAEXP ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Bloqreg","Ualtafw","Umodifw","Valtafw","Smodifw","Zadsfw","Vmodifw","Haltafw","Saltafw","Esttrans","Bdmodifw","Horaexpo","Hmodifw","Bdaltafw","Horaimpo","Ccod","Cdes","Lcabecera","Ldetalle","Ltitulo","Lpie","Lmulti" ) values ( <<"'" + this.ConvertirDateSql( lxTareaexpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTareaexpFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTareaexpFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTareaexpFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTareaexpFmodifw ) + "'" >>, <<iif( lxTareaexpBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxTareaexpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpCdes ) + "'" >>, <<iif( lxTareaexpLcabecera, 1, 0 ) >>, <<iif( lxTareaexpLdetalle, 1, 0 ) >>, <<iif( lxTareaexpLtitulo, 1, 0 ) >>, <<iif( lxTareaexpLpie, 1, 0 ) >>, <<iif( lxTareaexpLmulti, 1, 0 ) >> )
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
			local  lxTareaexpFecexpo, lxTareaexpFectrans, lxTareaexpFecimpo, lxTareaexpFaltafw, lxTareaexpFmodifw, lxTareaexpBloqreg, lxTareaexpUaltafw, lxTareaexpUmodifw, lxTareaexpValtafw, lxTareaexpSmodifw, lxTareaexpZadsfw, lxTareaexpVmodifw, lxTareaexpHaltafw, lxTareaexpSaltafw, lxTareaexpEsttrans, lxTareaexpBdmodifw, lxTareaexpHoraexpo, lxTareaexpHmodifw, lxTareaexpBdaltafw, lxTareaexpHoraimpo, lxTareaexpCcod, lxTareaexpCdes, lxTareaexpLcabecera, lxTareaexpLdetalle, lxTareaexpLtitulo, lxTareaexpLpie, lxTareaexpLmulti
				lxTareaexpFecexpo =  .Fechaexpo			lxTareaexpFectrans =  .Fechatransferencia			lxTareaexpFecimpo =  .Fechaimpo			lxTareaexpFaltafw =  .Fechaaltafw			lxTareaexpFmodifw =  .Fechamodificacionfw			lxTareaexpBloqreg =  .Bloquearregistro			lxTareaexpUaltafw =  .Usuarioaltafw			lxTareaexpUmodifw =  .Usuariomodificacionfw			lxTareaexpValtafw =  .Versionaltafw			lxTareaexpSmodifw =  .Seriemodificacionfw			lxTareaexpZadsfw =  .Zadsfw			lxTareaexpVmodifw =  .Versionmodificacionfw			lxTareaexpHaltafw =  .Horaaltafw			lxTareaexpSaltafw =  .Seriealtafw			lxTareaexpEsttrans =  .Estadotransferencia			lxTareaexpBdmodifw =  .Basededatosmodificacionfw			lxTareaexpHoraexpo =  .Horaexpo			lxTareaexpHmodifw =  .Horamodificacionfw			lxTareaexpBdaltafw =  .Basededatosaltafw			lxTareaexpHoraimpo =  .Horaimpo			lxTareaexpCcod =  .Codigo			lxTareaexpCdes =  .Descripcion			lxTareaexpLcabecera =  .Cabecera			lxTareaexpLdetalle =  .Detalle			lxTareaexpLtitulo =  .Titulo			lxTareaexpLpie =  .Piedepagina			lxTareaexpLmulti =  .Multilinea
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.TAREAEXP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTareaexpFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTareaexpFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxTareaexpFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTareaexpFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTareaexpFmodifw ) + "'">>,"Bloqreg" = <<iif( lxTareaexpBloqreg, 1, 0 )>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTareaexpUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTareaexpValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpSmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTareaexpZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpVmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTareaexpHaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTareaexpSaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTareaexpEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTareaexpHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpHmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTareaexpBdaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTareaexpHoraimpo ) + "'">>,"Ccod" = <<"'" + this.FormatearTextoSql( lxTareaexpCcod ) + "'">>,"Cdes" = <<"'" + this.FormatearTextoSql( lxTareaexpCdes ) + "'">>,"Lcabecera" = <<iif( lxTareaexpLcabecera, 1, 0 )>>,"Ldetalle" = <<iif( lxTareaexpLdetalle, 1, 0 )>>,"Ltitulo" = <<iif( lxTareaexpLtitulo, 1, 0 )>>,"Lpie" = <<iif( lxTareaexpLpie, 1, 0 )>>,"Lmulti" = <<iif( lxTareaexpLmulti, 1, 0 )>> where "Ccod" = <<"'" + this.FormatearTextoSql( lxTareaexpCcod ) + "'">> and  TAREAEXP.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ORGANIZACION.TAREAEXP where " + this.ConvertirFuncionesSql( " TAREAEXP.CCOD != ''" ) )
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
			Local lxTareaexpCcod
			lxTareaexpCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo", "Cdes" as "Descripcion", "Lcabecera" as "Cabecera", "Ldetalle" as "Detalle", "Ltitulo" as "Titulo", "Lpie" as "Piedepagina", "Lmulti" as "Multilinea" from ORGANIZACION.TAREAEXP where "Ccod" = <<"'" + this.FormatearTextoSql( lxTareaexpCcod ) + "'">> and  TAREAEXP.CCOD != ''
			endtext
			use in select('c_TIPOAREAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPOAREAEXPORTACION', set( 'Datasession' ) )

			if reccount( 'c_TIPOAREAEXPORTACION' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTareaexpCcod as Variant
		llRetorno = .t.
		lxTareaexpCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.TAREAEXP where "Ccod" = <<"'" + this.FormatearTextoSql( lxTareaexpCcod ) + "'">> and  TAREAEXP.CCOD != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo", "Cdes" as "Descripcion", "Lcabecera" as "Cabecera", "Ldetalle" as "Detalle", "Ltitulo" as "Titulo", "Lpie" as "Piedepagina", "Lmulti" as "Multilinea" from ORGANIZACION.TAREAEXP where  TAREAEXP.CCOD != '' order by cCod
			endtext
			use in select('c_TIPOAREAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPOAREAEXPORTACION', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo", "Cdes" as "Descripcion", "Lcabecera" as "Cabecera", "Ldetalle" as "Detalle", "Ltitulo" as "Titulo", "Lpie" as "Piedepagina", "Lmulti" as "Multilinea" from ORGANIZACION.TAREAEXP where  funciones.padr( cCod, 3, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TAREAEXP.CCOD != '' order by cCod
			endtext
			use in select('c_TIPOAREAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPOAREAEXPORTACION', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo", "Cdes" as "Descripcion", "Lcabecera" as "Cabecera", "Ldetalle" as "Detalle", "Ltitulo" as "Titulo", "Lpie" as "Piedepagina", "Lmulti" as "Multilinea" from ORGANIZACION.TAREAEXP where  funciones.padr( cCod, 3, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TAREAEXP.CCOD != '' order by cCod desc
			endtext
			use in select('c_TIPOAREAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPOAREAEXPORTACION', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo", "Cdes" as "Descripcion", "Lcabecera" as "Cabecera", "Ldetalle" as "Detalle", "Ltitulo" as "Titulo", "Lpie" as "Piedepagina", "Lmulti" as "Multilinea" from ORGANIZACION.TAREAEXP where  TAREAEXP.CCOD != '' order by cCod desc
			endtext
			use in select('c_TIPOAREAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPOAREAEXPORTACION', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Bloqreg,Ualtafw,Umodifw,Valtafw,Smodifw,Zadsfw,Vmod" + ;
"ifw,Haltafw,Saltafw,Esttrans,Bdmodifw,Horaexpo,Hmodifw,Bdaltafw,Horaimpo,Ccod,Cdes,Lcabecera,Ldetall" + ;
"e,Ltitulo,Lpie,Lmulti" + ;
" from ORGANIZACION.TAREAEXP where  TAREAEXP.CCOD != '' and " + lcFiltro )
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
			local  lxTareaexpFecexpo, lxTareaexpFectrans, lxTareaexpFecimpo, lxTareaexpFaltafw, lxTareaexpFmodifw, lxTareaexpBloqreg, lxTareaexpUaltafw, lxTareaexpUmodifw, lxTareaexpValtafw, lxTareaexpSmodifw, lxTareaexpZadsfw, lxTareaexpVmodifw, lxTareaexpHaltafw, lxTareaexpSaltafw, lxTareaexpEsttrans, lxTareaexpBdmodifw, lxTareaexpHoraexpo, lxTareaexpHmodifw, lxTareaexpBdaltafw, lxTareaexpHoraimpo, lxTareaexpCcod, lxTareaexpCdes, lxTareaexpLcabecera, lxTareaexpLdetalle, lxTareaexpLtitulo, lxTareaexpLpie, lxTareaexpLmulti
				lxTareaexpFecexpo = ctod( '  /  /    ' )			lxTareaexpFectrans = ctod( '  /  /    ' )			lxTareaexpFecimpo = ctod( '  /  /    ' )			lxTareaexpFaltafw = ctod( '  /  /    ' )			lxTareaexpFmodifw = ctod( '  /  /    ' )			lxTareaexpBloqreg = .F.			lxTareaexpUaltafw = []			lxTareaexpUmodifw = []			lxTareaexpValtafw = []			lxTareaexpSmodifw = []			lxTareaexpZadsfw = []			lxTareaexpVmodifw = []			lxTareaexpHaltafw = []			lxTareaexpSaltafw = []			lxTareaexpEsttrans = []			lxTareaexpBdmodifw = []			lxTareaexpHoraexpo = []			lxTareaexpHmodifw = []			lxTareaexpBdaltafw = []			lxTareaexpHoraimpo = []			lxTareaexpCcod = []			lxTareaexpCdes = []			lxTareaexpLcabecera = .F.			lxTareaexpLdetalle = .F.			lxTareaexpLtitulo = .F.			lxTareaexpLpie = .F.			lxTareaexpLmulti = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.TAREAEXP where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TAREAEXP' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where cCod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(cCod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  TAREAEXP.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo", "Cdes" as "Descripcion", "Lcabecera" as "Cabecera", "Ldetalle" as "Detalle", "Ltitulo" as "Titulo", "Lpie" as "Piedepagina", "Lmulti" as "Multilinea"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TAREAEXP', '', tnTope )
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
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDES AS DESCRIPCION'
				Case lcAtributo == 'CABECERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LCABECERA AS CABECERA'
				Case lcAtributo == 'DETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LDETALLE AS DETALLE'
				Case lcAtributo == 'TITULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LTITULO AS TITULO'
				Case lcAtributo == 'PIEDEPAGINA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPIE AS PIEDEPAGINA'
				Case lcAtributo == 'MULTILINEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LMULTI AS MULTILINEA'
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
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CDES'
			Case upper( alltrim( tcAtributo ) ) == 'CABECERA'
				lcCampo = 'LCABECERA'
			Case upper( alltrim( tcAtributo ) ) == 'DETALLE'
				lcCampo = 'LDETALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TITULO'
				lcCampo = 'LTITULO'
			Case upper( alltrim( tcAtributo ) ) == 'PIEDEPAGINA'
				lcCampo = 'LPIE'
			Case upper( alltrim( tcAtributo ) ) == 'MULTILINEA'
				lcCampo = 'LMULTI'
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
			local  lxTareaexpFecexpo, lxTareaexpFectrans, lxTareaexpFecimpo, lxTareaexpFaltafw, lxTareaexpFmodifw, lxTareaexpBloqreg, lxTareaexpUaltafw, lxTareaexpUmodifw, lxTareaexpValtafw, lxTareaexpSmodifw, lxTareaexpZadsfw, lxTareaexpVmodifw, lxTareaexpHaltafw, lxTareaexpSaltafw, lxTareaexpEsttrans, lxTareaexpBdmodifw, lxTareaexpHoraexpo, lxTareaexpHmodifw, lxTareaexpBdaltafw, lxTareaexpHoraimpo, lxTareaexpCcod, lxTareaexpCdes, lxTareaexpLcabecera, lxTareaexpLdetalle, lxTareaexpLtitulo, lxTareaexpLpie, lxTareaexpLmulti
				lxTareaexpFecexpo =  .Fechaexpo			lxTareaexpFectrans =  .Fechatransferencia			lxTareaexpFecimpo =  .Fechaimpo			lxTareaexpFaltafw =  .Fechaaltafw			lxTareaexpFmodifw =  .Fechamodificacionfw			lxTareaexpBloqreg =  .Bloquearregistro			lxTareaexpUaltafw =  .Usuarioaltafw			lxTareaexpUmodifw =  .Usuariomodificacionfw			lxTareaexpValtafw =  .Versionaltafw			lxTareaexpSmodifw =  .Seriemodificacionfw			lxTareaexpZadsfw =  .Zadsfw			lxTareaexpVmodifw =  .Versionmodificacionfw			lxTareaexpHaltafw =  .Horaaltafw			lxTareaexpSaltafw =  .Seriealtafw			lxTareaexpEsttrans =  .Estadotransferencia			lxTareaexpBdmodifw =  .Basededatosmodificacionfw			lxTareaexpHoraexpo =  .Horaexpo			lxTareaexpHmodifw =  .Horamodificacionfw			lxTareaexpBdaltafw =  .Basededatosaltafw			lxTareaexpHoraimpo =  .Horaimpo			lxTareaexpCcod =  .Codigo			lxTareaexpCdes =  .Descripcion			lxTareaexpLcabecera =  .Cabecera			lxTareaexpLdetalle =  .Detalle			lxTareaexpLtitulo =  .Titulo			lxTareaexpLpie =  .Piedepagina			lxTareaexpLmulti =  .Multilinea
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.TAREAEXP ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Bloqreg","Ualtafw","Umodifw","Valtafw","Smodifw","Zadsfw","Vmodifw","Haltafw","Saltafw","Esttrans","Bdmodifw","Horaexpo","Hmodifw","Bdaltafw","Horaimpo","Ccod","Cdes","Lcabecera","Ldetalle","Ltitulo","Lpie","Lmulti" ) values ( <<"'" + this.ConvertirDateSql( lxTareaexpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTareaexpFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTareaexpFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTareaexpFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTareaexpFmodifw ) + "'" >>, <<iif( lxTareaexpBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxTareaexpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTareaexpCdes ) + "'" >>, <<iif( lxTareaexpLcabecera, 1, 0 ) >>, <<iif( lxTareaexpLdetalle, 1, 0 ) >>, <<iif( lxTareaexpLtitulo, 1, 0 ) >>, <<iif( lxTareaexpLpie, 1, 0 ) >>, <<iif( lxTareaexpLmulti, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'TAREAEXP' 
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
			local  lxTareaexpFecexpo, lxTareaexpFectrans, lxTareaexpFecimpo, lxTareaexpFaltafw, lxTareaexpFmodifw, lxTareaexpBloqreg, lxTareaexpUaltafw, lxTareaexpUmodifw, lxTareaexpValtafw, lxTareaexpSmodifw, lxTareaexpZadsfw, lxTareaexpVmodifw, lxTareaexpHaltafw, lxTareaexpSaltafw, lxTareaexpEsttrans, lxTareaexpBdmodifw, lxTareaexpHoraexpo, lxTareaexpHmodifw, lxTareaexpBdaltafw, lxTareaexpHoraimpo, lxTareaexpCcod, lxTareaexpCdes, lxTareaexpLcabecera, lxTareaexpLdetalle, lxTareaexpLtitulo, lxTareaexpLpie, lxTareaexpLmulti
				lxTareaexpFecexpo =  .Fechaexpo			lxTareaexpFectrans =  .Fechatransferencia			lxTareaexpFecimpo =  .Fechaimpo			lxTareaexpFaltafw =  .Fechaaltafw			lxTareaexpFmodifw =  .Fechamodificacionfw			lxTareaexpBloqreg =  .Bloquearregistro			lxTareaexpUaltafw =  .Usuarioaltafw			lxTareaexpUmodifw =  .Usuariomodificacionfw			lxTareaexpValtafw =  .Versionaltafw			lxTareaexpSmodifw =  .Seriemodificacionfw			lxTareaexpZadsfw =  .Zadsfw			lxTareaexpVmodifw =  .Versionmodificacionfw			lxTareaexpHaltafw =  .Horaaltafw			lxTareaexpSaltafw =  .Seriealtafw			lxTareaexpEsttrans =  .Estadotransferencia			lxTareaexpBdmodifw =  .Basededatosmodificacionfw			lxTareaexpHoraexpo =  .Horaexpo			lxTareaexpHmodifw =  .Horamodificacionfw			lxTareaexpBdaltafw =  .Basededatosaltafw			lxTareaexpHoraimpo =  .Horaimpo			lxTareaexpCcod =  .Codigo			lxTareaexpCdes =  .Descripcion			lxTareaexpLcabecera =  .Cabecera			lxTareaexpLdetalle =  .Detalle			lxTareaexpLtitulo =  .Titulo			lxTareaexpLpie =  .Piedepagina			lxTareaexpLmulti =  .Multilinea
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  TAREAEXP.CCOD != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.TAREAEXP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTareaexpFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTareaexpFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTareaexpFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTareaexpFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTareaexpFmodifw ) + "'">>, "Bloqreg" = <<iif( lxTareaexpBloqreg, 1, 0 )>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTareaexpUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTareaexpValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpSmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTareaexpZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpVmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTareaexpHaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTareaexpSaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTareaexpEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTareaexpHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTareaexpHmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTareaexpBdaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTareaexpHoraimpo ) + "'">>, "Ccod" = <<"'" + this.FormatearTextoSql( lxTareaexpCcod ) + "'">>, "Cdes" = <<"'" + this.FormatearTextoSql( lxTareaexpCdes ) + "'">>, "Lcabecera" = <<iif( lxTareaexpLcabecera, 1, 0 )>>, "Ldetalle" = <<iif( lxTareaexpLdetalle, 1, 0 )>>, "Ltitulo" = <<iif( lxTareaexpLtitulo, 1, 0 )>>, "Lpie" = <<iif( lxTareaexpLpie, 1, 0 )>>, "Lmulti" = <<iif( lxTareaexpLmulti, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TAREAEXP' 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  TAREAEXP.CCOD != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.TAREAEXP where ' + lcFiltro )
			loColeccion.cTabla = 'TAREAEXP' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.TAREAEXP where  TAREAEXP.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.TAREAEXP where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  TAREAEXP.CCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPOAREAEXPORTACION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.TAREAEXP Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.TAREAEXP set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"+ [, cDes = ] + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'"+ [, lCabecera = ] + Transform( iif( &lcCursor..lCabecera, 1, 0 ))+ [, lDetalle = ] + Transform( iif( &lcCursor..lDetalle, 1, 0 ))+ [, lTitulo = ] + Transform( iif( &lcCursor..lTitulo, 1, 0 ))+ [, lPie = ] + Transform( iif( &lcCursor..lPie, 1, 0 ))+ [, lMulti = ] + Transform( iif( &lcCursor..lMulti, 1, 0 )) + [ Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, BLOQREG, UALTAFW, UMODIFW, VALTAFW, SMODIFW, ZADSFW, VMODIFW, HALTAFW, SALTAFW, ESTTRANS, BDMODIFW, HORAEXPO, HMODIFW, BDALTAFW, HORAIMPO, cCod, cDes, lCabecera, lDetalle, lTitulo, lPie, lMulti
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'" + ',' + Transform( iif( &lcCursor..lCabecera, 1, 0 )) + ',' + Transform( iif( &lcCursor..lDetalle, 1, 0 )) + ',' + Transform( iif( &lcCursor..lTitulo, 1, 0 )) + ',' + Transform( iif( &lcCursor..lPie, 1, 0 )) + ',' + Transform( iif( &lcCursor..lMulti, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.TAREAEXP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPOAREAEXPORTACION'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( cCod C (3) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..cCod       )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'TIPOAREAEXPORTACION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TIPOAREAEXPORTACION_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_TAreaExp')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TIPOAREAEXPORTACION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TIPOAREAEXPORTACION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPOAREAEXPORTACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,cCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( cCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPOAREAEXPORTACION'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_TAreaExp') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_TAreaExp
Create Table ORGANIZACION.TablaTrabajo_TAreaExp ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"bloqreg" bit  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"ccod" char( 3 )  null, 
"cdes" char( 100 )  null, 
"lcabecera" bit  null, 
"ldetalle" bit  null, 
"ltitulo" bit  null, 
"lpie" bit  null, 
"lmulti" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TAreaExp' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TAreaExp' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPOAREAEXPORTACION'
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
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('cdes','cdes')
			.AgregarMapeo('lcabecera','lcabecera')
			.AgregarMapeo('ldetalle','ldetalle')
			.AgregarMapeo('ltitulo','ltitulo')
			.AgregarMapeo('lpie','lpie')
			.AgregarMapeo('lmulti','lmulti')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_TAreaExp'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.CDES = isnull( d.CDES, t.CDES ),t.LCABECERA = isnull( d.LCABECERA, t.LCABECERA ),t.LDETALLE = isnull( d.LDETALLE, t.LDETALLE ),t.LTITULO = isnull( d.LTITULO, t.LTITULO ),t.LPIE = isnull( d.LPIE, t.LPIE ),t.LMULTI = isnull( d.LMULTI, t.LMULTI )
					from ORGANIZACION.TAREAEXP t inner join deleted d 
							 on t.cCod = d.cCod
				-- Fin Updates
				insert into ORGANIZACION.TAREAEXP(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Bloqreg,Ualtafw,Umodifw,Valtafw,Smodifw,Zadsfw,Vmodifw,Haltafw,Saltafw,Esttrans,Bdmodifw,Horaexpo,Hmodifw,Bdaltafw,Horaimpo,Ccod,Cdes,Lcabecera,Ldetalle,Ltitulo,Lpie,Lmulti)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.BLOQREG,0),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.CCOD,''),isnull( d.CDES,''),isnull( d.LCABECERA,0),isnull( d.LDETALLE,0),isnull( d.LTITULO,0),isnull( d.LPIE,0),isnull( d.LMULTI,0)
						From deleted d left join ORGANIZACION.TAREAEXP pk 
							 on d.cCod = pk.cCod
						Where pk.cCod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_TAreaExp') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_TAreaExp
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TIPOAREAEXPORTACION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPOAREAEXPORTACION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPOAREAEXPORTACION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPOAREAEXPORTACION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPOAREAEXPORTACION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPOAREAEXPORTACION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Bloquearregistro = nvl( c_TIPOAREAEXPORTACION.Bloquearregistro, .F. )
					.Usuarioaltafw = nvl( c_TIPOAREAEXPORTACION.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_TIPOAREAEXPORTACION.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_TIPOAREAEXPORTACION.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_TIPOAREAEXPORTACION.Seriemodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_TIPOAREAEXPORTACION.Versionmodificacionfw, [] )
					.Horaaltafw = nvl( c_TIPOAREAEXPORTACION.Horaaltafw, [] )
					.Seriealtafw = nvl( c_TIPOAREAEXPORTACION.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_TIPOAREAEXPORTACION.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_TIPOAREAEXPORTACION.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_TIPOAREAEXPORTACION.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_TIPOAREAEXPORTACION.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_TIPOAREAEXPORTACION.Basededatosaltafw, [] )
					.Horaimpo = nvl( c_TIPOAREAEXPORTACION.Horaimpo, [] )
					.Codigo = nvl( c_TIPOAREAEXPORTACION.Codigo, [] )
					.Descripcion = nvl( c_TIPOAREAEXPORTACION.Descripcion, [] )
					.Cabecera = nvl( c_TIPOAREAEXPORTACION.Cabecera, .F. )
					.Detalle = nvl( c_TIPOAREAEXPORTACION.Detalle, .F. )
					.Titulo = nvl( c_TIPOAREAEXPORTACION.Titulo, .F. )
					.Piedepagina = nvl( c_TIPOAREAEXPORTACION.Piedepagina, .F. )
					.Multilinea = nvl( c_TIPOAREAEXPORTACION.Multilinea, .F. )
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
		return c_TIPOAREAEXPORTACION.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.TAREAEXP' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,cCod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    cCod from (
							select * 
								from ORGANIZACION.TAREAEXP 
								Where   TAREAEXP.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TAREAEXP", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Ccod" as "Codigo", "Cdes" as "Descripcion", "Lcabecera" as "Cabecera", "Ldetalle" as "Detalle", "Ltitulo" as "Titulo", "Lpie" as "Piedepagina", "Lmulti" as "Multilinea"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.TAREAEXP 
								Where   TAREAEXP.CCOD != ''
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
	Tabla = 'TAREAEXP'
	Filtro = " TAREAEXP.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TAREAEXP.CCOD != ''"
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
	<row entidad="TIPOAREAEXPORTACION                     " atributo="FECHAEXPO                               " tabla="TAREAEXP       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="FECHATRANSFERENCIA                      " tabla="TAREAEXP       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="FECHAIMPO                               " tabla="TAREAEXP       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="FECHAALTAFW                             " tabla="TAREAEXP       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="FECHAMODIFICACIONFW                     " tabla="TAREAEXP       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="BLOQUEARREGISTRO                        " tabla="TAREAEXP       " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="USUARIOALTAFW                           " tabla="TAREAEXP       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="USUARIOMODIFICACIONFW                   " tabla="TAREAEXP       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="VERSIONALTAFW                           " tabla="TAREAEXP       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="SERIEMODIFICACIONFW                     " tabla="TAREAEXP       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="ZADSFW                                  " tabla="TAREAEXP       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="VERSIONMODIFICACIONFW                   " tabla="TAREAEXP       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="HORAALTAFW                              " tabla="TAREAEXP       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="SERIEALTAFW                             " tabla="TAREAEXP       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="ESTADOTRANSFERENCIA                     " tabla="TAREAEXP       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TAREAEXP       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="HORAEXPO                                " tabla="TAREAEXP       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="HORAMODIFICACIONFW                      " tabla="TAREAEXP       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="BASEDEDATOSALTAFW                       " tabla="TAREAEXP       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="HORAIMPO                                " tabla="TAREAEXP       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="CODIGO                                  " tabla="TAREAEXP       " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="DESCRIPCION                             " tabla="TAREAEXP       " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="CABECERA                                " tabla="TAREAEXP       " campo="LCABECERA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Cabecera                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="DETALLE                                 " tabla="TAREAEXP       " campo="LDETALLE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Detalle                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="TITULO                                  " tabla="TAREAEXP       " campo="LTITULO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Título                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="PIEDEPAGINA                             " tabla="TAREAEXP       " campo="LPIE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Pié de Página                                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOAREAEXPORTACION                     " atributo="MULTILINEA                              " tabla="TAREAEXP       " campo="LMULTI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Múltiples líneas                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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