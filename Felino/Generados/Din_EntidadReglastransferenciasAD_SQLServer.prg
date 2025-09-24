
define class Din_EntidadREGLASTRANSFERENCIASAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_REGLASTRANSFERENCIAS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_RTRPK'
	cTablaPrincipal = 'REGLATRANS'
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
			local  lxReglatransFecimpo, lxReglatransFectrans, lxReglatransFmodifw, lxReglatransFecexpo, lxReglatransFaltafw, lxReglatransHaltafw, lxReglatransUaltafw, lxReglatransHoraimpo, lxReglatransSaltafw, lxReglatransHmodifw, lxReglatransHoraexpo, lxReglatransValtafw, lxReglatransUmodifw, lxReglatransVmodifw, lxReglatransZadsfw, lxReglatransBdaltafw, lxReglatransSmodifw, lxReglatransEsttrans, lxReglatransBdmodifw, lxReglatransAccion, lxReglatransTrans, lxReglatransCcod, lxReglatransObs, lxReglatransDestino, lxReglatransOrigen, lxReglatransOrigdest, lxReglatransMotivo, lxReglatransCdes, lxReglatransDdesde, lxReglatransDhasta, lxReglatransLhabilit
				lxReglatransFecimpo =  .Fechaimpo			lxReglatransFectrans =  .Fechatransferencia			lxReglatransFmodifw =  .Fechamodificacionfw			lxReglatransFecexpo =  .Fechaexpo			lxReglatransFaltafw =  .Fechaaltafw			lxReglatransHaltafw =  .Horaaltafw			lxReglatransUaltafw =  .Usuarioaltafw			lxReglatransHoraimpo =  .Horaimpo			lxReglatransSaltafw =  .Seriealtafw			lxReglatransHmodifw =  .Horamodificacionfw			lxReglatransHoraexpo =  .Horaexpo			lxReglatransValtafw =  .Versionaltafw			lxReglatransUmodifw =  .Usuariomodificacionfw			lxReglatransVmodifw =  .Versionmodificacionfw			lxReglatransZadsfw =  .Zadsfw			lxReglatransBdaltafw =  .Basededatosaltafw			lxReglatransSmodifw =  .Seriemodificacionfw			lxReglatransEsttrans =  .Estadotransferencia			lxReglatransBdmodifw =  .Basededatosmodificacionfw			lxReglatransAccion =  .Accion			lxReglatransTrans =  .Transferencia			lxReglatransCcod =  .Codigo			lxReglatransObs =  .Obs			lxReglatransDestino =  .Destino			lxReglatransOrigen =  .Origen			lxReglatransOrigdest =  upper( .OrigenDestino_PK ) 			lxReglatransMotivo =  upper( .motivo_PK ) 			lxReglatransCdes =  .Descripcion			lxReglatransDdesde =  .Fechadesde			lxReglatransDhasta =  .Fechahasta			lxReglatransLhabilit =  .Habilitada
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxReglatransCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.REGLATRANS ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Ualtafw","Horaimpo","Saltafw","Hmodifw","Horaexpo","Valtafw","Umodifw","Vmodifw","Zadsfw","Bdaltafw","Smodifw","Esttrans","Bdmodifw","Accion","Trans","Ccod","Obs","Destino","Origen","Origdest","Motivo","Cdes","Ddesde","Dhasta","Lhabilit" ) values ( <<"'" + this.ConvertirDateSql( lxReglatransFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransBdmodifw ) + "'" >>, <<lxReglatransAccion >>, <<"'" + this.FormatearTextoSql( lxReglatransTrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransDestino ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransOrigen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransOrigdest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransCdes ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransDdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransDhasta ) + "'" >>, <<iif( lxReglatransLhabilit, 1, 0 ) >> )
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
			local  lxReglatransFecimpo, lxReglatransFectrans, lxReglatransFmodifw, lxReglatransFecexpo, lxReglatransFaltafw, lxReglatransHaltafw, lxReglatransUaltafw, lxReglatransHoraimpo, lxReglatransSaltafw, lxReglatransHmodifw, lxReglatransHoraexpo, lxReglatransValtafw, lxReglatransUmodifw, lxReglatransVmodifw, lxReglatransZadsfw, lxReglatransBdaltafw, lxReglatransSmodifw, lxReglatransEsttrans, lxReglatransBdmodifw, lxReglatransAccion, lxReglatransTrans, lxReglatransCcod, lxReglatransObs, lxReglatransDestino, lxReglatransOrigen, lxReglatransOrigdest, lxReglatransMotivo, lxReglatransCdes, lxReglatransDdesde, lxReglatransDhasta, lxReglatransLhabilit
				lxReglatransFecimpo =  .Fechaimpo			lxReglatransFectrans =  .Fechatransferencia			lxReglatransFmodifw =  .Fechamodificacionfw			lxReglatransFecexpo =  .Fechaexpo			lxReglatransFaltafw =  .Fechaaltafw			lxReglatransHaltafw =  .Horaaltafw			lxReglatransUaltafw =  .Usuarioaltafw			lxReglatransHoraimpo =  .Horaimpo			lxReglatransSaltafw =  .Seriealtafw			lxReglatransHmodifw =  .Horamodificacionfw			lxReglatransHoraexpo =  .Horaexpo			lxReglatransValtafw =  .Versionaltafw			lxReglatransUmodifw =  .Usuariomodificacionfw			lxReglatransVmodifw =  .Versionmodificacionfw			lxReglatransZadsfw =  .Zadsfw			lxReglatransBdaltafw =  .Basededatosaltafw			lxReglatransSmodifw =  .Seriemodificacionfw			lxReglatransEsttrans =  .Estadotransferencia			lxReglatransBdmodifw =  .Basededatosmodificacionfw			lxReglatransAccion =  .Accion			lxReglatransTrans =  .Transferencia			lxReglatransCcod =  .Codigo			lxReglatransObs =  .Obs			lxReglatransDestino =  .Destino			lxReglatransOrigen =  .Origen			lxReglatransOrigdest =  upper( .OrigenDestino_PK ) 			lxReglatransMotivo =  upper( .motivo_PK ) 			lxReglatransCdes =  .Descripcion			lxReglatransDdesde =  .Fechadesde			lxReglatransDhasta =  .Fechahasta			lxReglatransLhabilit =  .Habilitada
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.REGLATRANS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxReglatransFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxReglatransFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxReglatransFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxReglatransFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxReglatransFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxReglatransHaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxReglatransUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxReglatransHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxReglatransSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxReglatransHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxReglatransHoraexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxReglatransValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxReglatransUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxReglatransVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxReglatransZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxReglatransBdaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxReglatransSmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxReglatransEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxReglatransBdmodifw ) + "'">>,"Accion" = <<lxReglatransAccion>>,"Trans" = <<"'" + this.FormatearTextoSql( lxReglatransTrans ) + "'">>,"Ccod" = <<"'" + this.FormatearTextoSql( lxReglatransCcod ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxReglatransObs ) + "'">>,"Destino" = <<"'" + this.FormatearTextoSql( lxReglatransDestino ) + "'">>,"Origen" = <<"'" + this.FormatearTextoSql( lxReglatransOrigen ) + "'">>,"Origdest" = <<"'" + this.FormatearTextoSql( lxReglatransOrigdest ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxReglatransMotivo ) + "'">>,"Cdes" = <<"'" + this.FormatearTextoSql( lxReglatransCdes ) + "'">>,"Ddesde" = <<"'" + this.ConvertirDateSql( lxReglatransDdesde ) + "'">>,"Dhasta" = <<"'" + this.ConvertirDateSql( lxReglatransDhasta ) + "'">>,"Lhabilit" = <<iif( lxReglatransLhabilit, 1, 0 )>> where "Ccod" = <<"'" + this.FormatearTextoSql( lxReglatransCcod ) + "'">> and  REGLATRANS.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ORGANIZACION.REGLATRANS where " + this.ConvertirFuncionesSql( " REGLATRANS.CCOD != ''" ) )
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
			Local lxReglatransCcod
			lxReglatransCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Accion" as "Accion", "Trans" as "Transferencia", "Ccod" as "Codigo", "Obs" as "Obs", "Destino" as "Destino", "Origen" as "Origen", "Origdest" as "Origendestino", "Motivo" as "Motivo", "Cdes" as "Descripcion", "Ddesde" as "Fechadesde", "Dhasta" as "Fechahasta", "Lhabilit" as "Habilitada" from ORGANIZACION.REGLATRANS where "Ccod" = <<"'" + this.FormatearTextoSql( lxReglatransCcod ) + "'">> and  REGLATRANS.CCOD != ''
			endtext
			use in select('c_REGLASTRANSFERENCIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGLASTRANSFERENCIAS', set( 'Datasession' ) )

			if reccount( 'c_REGLASTRANSFERENCIAS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxReglatransCcod as Variant
		llRetorno = .t.
		lxReglatransCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.REGLATRANS where "Ccod" = <<"'" + this.FormatearTextoSql( lxReglatransCcod ) + "'">> and  REGLATRANS.CCOD != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Accion" as "Accion", "Trans" as "Transferencia", "Ccod" as "Codigo", "Obs" as "Obs", "Destino" as "Destino", "Origen" as "Origen", "Origdest" as "Origendestino", "Motivo" as "Motivo", "Cdes" as "Descripcion", "Ddesde" as "Fechadesde", "Dhasta" as "Fechahasta", "Lhabilit" as "Habilitada" from ORGANIZACION.REGLATRANS where  REGLATRANS.CCOD != '' order by cCod
			endtext
			use in select('c_REGLASTRANSFERENCIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGLASTRANSFERENCIAS', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Accion" as "Accion", "Trans" as "Transferencia", "Ccod" as "Codigo", "Obs" as "Obs", "Destino" as "Destino", "Origen" as "Origen", "Origdest" as "Origendestino", "Motivo" as "Motivo", "Cdes" as "Descripcion", "Ddesde" as "Fechadesde", "Dhasta" as "Fechahasta", "Lhabilit" as "Habilitada" from ORGANIZACION.REGLATRANS where  funciones.padr( cCod, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGLATRANS.CCOD != '' order by cCod
			endtext
			use in select('c_REGLASTRANSFERENCIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGLASTRANSFERENCIAS', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Accion" as "Accion", "Trans" as "Transferencia", "Ccod" as "Codigo", "Obs" as "Obs", "Destino" as "Destino", "Origen" as "Origen", "Origdest" as "Origendestino", "Motivo" as "Motivo", "Cdes" as "Descripcion", "Ddesde" as "Fechadesde", "Dhasta" as "Fechahasta", "Lhabilit" as "Habilitada" from ORGANIZACION.REGLATRANS where  funciones.padr( cCod, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  REGLATRANS.CCOD != '' order by cCod desc
			endtext
			use in select('c_REGLASTRANSFERENCIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGLASTRANSFERENCIAS', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Accion" as "Accion", "Trans" as "Transferencia", "Ccod" as "Codigo", "Obs" as "Obs", "Destino" as "Destino", "Origen" as "Origen", "Origdest" as "Origendestino", "Motivo" as "Motivo", "Cdes" as "Descripcion", "Ddesde" as "Fechadesde", "Dhasta" as "Fechahasta", "Lhabilit" as "Habilitada" from ORGANIZACION.REGLATRANS where  REGLATRANS.CCOD != '' order by cCod desc
			endtext
			use in select('c_REGLASTRANSFERENCIAS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_REGLASTRANSFERENCIAS', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Ualtafw,Horaimpo,Saltafw,Hmodifw,Horaexpo,V" + ;
"altafw,Umodifw,Vmodifw,Zadsfw,Bdaltafw,Smodifw,Esttrans,Bdmodifw,Accion,Trans,Ccod,Obs,Destino,Orige" + ;
"n,Origdest,Motivo,Cdes,Ddesde,Dhasta,Lhabilit" + ;
" from ORGANIZACION.REGLATRANS where  REGLATRANS.CCOD != '' and " + lcFiltro )
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
			local  lxReglatransFecimpo, lxReglatransFectrans, lxReglatransFmodifw, lxReglatransFecexpo, lxReglatransFaltafw, lxReglatransHaltafw, lxReglatransUaltafw, lxReglatransHoraimpo, lxReglatransSaltafw, lxReglatransHmodifw, lxReglatransHoraexpo, lxReglatransValtafw, lxReglatransUmodifw, lxReglatransVmodifw, lxReglatransZadsfw, lxReglatransBdaltafw, lxReglatransSmodifw, lxReglatransEsttrans, lxReglatransBdmodifw, lxReglatransAccion, lxReglatransTrans, lxReglatransCcod, lxReglatransObs, lxReglatransDestino, lxReglatransOrigen, lxReglatransOrigdest, lxReglatransMotivo, lxReglatransCdes, lxReglatransDdesde, lxReglatransDhasta, lxReglatransLhabilit
				lxReglatransFecimpo = ctod( '  /  /    ' )			lxReglatransFectrans = ctod( '  /  /    ' )			lxReglatransFmodifw = ctod( '  /  /    ' )			lxReglatransFecexpo = ctod( '  /  /    ' )			lxReglatransFaltafw = ctod( '  /  /    ' )			lxReglatransHaltafw = []			lxReglatransUaltafw = []			lxReglatransHoraimpo = []			lxReglatransSaltafw = []			lxReglatransHmodifw = []			lxReglatransHoraexpo = []			lxReglatransValtafw = []			lxReglatransUmodifw = []			lxReglatransVmodifw = []			lxReglatransZadsfw = []			lxReglatransBdaltafw = []			lxReglatransSmodifw = []			lxReglatransEsttrans = []			lxReglatransBdmodifw = []			lxReglatransAccion = 0			lxReglatransTrans = []			lxReglatransCcod = []			lxReglatransObs = []			lxReglatransDestino = []			lxReglatransOrigen = []			lxReglatransOrigdest = []			lxReglatransMotivo = []			lxReglatransCdes = []			lxReglatransDdesde = ctod( '  /  /    ' )			lxReglatransDhasta = ctod( '  /  /    ' )			lxReglatransLhabilit = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.REGLATRANS where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'REGLATRANS' + '_' + tcCampo
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
		lcWhere = " Where  REGLATRANS.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Accion" as "Accion", "Trans" as "Transferencia", "Ccod" as "Codigo", "Obs" as "Obs", "Destino" as "Destino", "Origen" as "Origen", "Origdest" as "Origendestino", "Motivo" as "Motivo", "Cdes" as "Descripcion", "Ddesde" as "Fechadesde", "Dhasta" as "Fechahasta", "Lhabilit" as "Habilitada"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'REGLATRANS', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ACCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCION AS ACCION'
				Case lcAtributo == 'TRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRANS AS TRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'DESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESTINO AS DESTINO'
				Case lcAtributo == 'ORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGEN AS ORIGEN'
				Case lcAtributo == 'ORIGENDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGDEST AS ORIGENDESTINO'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDES AS DESCRIPCION'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DDESDE AS FECHADESDE'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DHASTA AS FECHAHASTA'
				Case lcAtributo == 'HABILITADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LHABILIT AS HABILITADA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ACCION'
				lcCampo = 'ACCION'
			Case upper( alltrim( tcAtributo ) ) == 'TRANSFERENCIA'
				lcCampo = 'TRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'DESTINO'
				lcCampo = 'DESTINO'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGEN'
				lcCampo = 'ORIGEN'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDESTINO'
				lcCampo = 'ORIGDEST'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CDES'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'DDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'DHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITADA'
				lcCampo = 'LHABILIT'
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
			local  lxReglatransFecimpo, lxReglatransFectrans, lxReglatransFmodifw, lxReglatransFecexpo, lxReglatransFaltafw, lxReglatransHaltafw, lxReglatransUaltafw, lxReglatransHoraimpo, lxReglatransSaltafw, lxReglatransHmodifw, lxReglatransHoraexpo, lxReglatransValtafw, lxReglatransUmodifw, lxReglatransVmodifw, lxReglatransZadsfw, lxReglatransBdaltafw, lxReglatransSmodifw, lxReglatransEsttrans, lxReglatransBdmodifw, lxReglatransAccion, lxReglatransTrans, lxReglatransCcod, lxReglatransObs, lxReglatransDestino, lxReglatransOrigen, lxReglatransOrigdest, lxReglatransMotivo, lxReglatransCdes, lxReglatransDdesde, lxReglatransDhasta, lxReglatransLhabilit
				lxReglatransFecimpo =  .Fechaimpo			lxReglatransFectrans =  .Fechatransferencia			lxReglatransFmodifw =  .Fechamodificacionfw			lxReglatransFecexpo =  .Fechaexpo			lxReglatransFaltafw =  .Fechaaltafw			lxReglatransHaltafw =  .Horaaltafw			lxReglatransUaltafw =  .Usuarioaltafw			lxReglatransHoraimpo =  .Horaimpo			lxReglatransSaltafw =  .Seriealtafw			lxReglatransHmodifw =  .Horamodificacionfw			lxReglatransHoraexpo =  .Horaexpo			lxReglatransValtafw =  .Versionaltafw			lxReglatransUmodifw =  .Usuariomodificacionfw			lxReglatransVmodifw =  .Versionmodificacionfw			lxReglatransZadsfw =  .Zadsfw			lxReglatransBdaltafw =  .Basededatosaltafw			lxReglatransSmodifw =  .Seriemodificacionfw			lxReglatransEsttrans =  .Estadotransferencia			lxReglatransBdmodifw =  .Basededatosmodificacionfw			lxReglatransAccion =  .Accion			lxReglatransTrans =  .Transferencia			lxReglatransCcod =  .Codigo			lxReglatransObs =  .Obs			lxReglatransDestino =  .Destino			lxReglatransOrigen =  .Origen			lxReglatransOrigdest =  upper( .OrigenDestino_PK ) 			lxReglatransMotivo =  upper( .motivo_PK ) 			lxReglatransCdes =  .Descripcion			lxReglatransDdesde =  .Fechadesde			lxReglatransDhasta =  .Fechahasta			lxReglatransLhabilit =  .Habilitada
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.REGLATRANS ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Ualtafw","Horaimpo","Saltafw","Hmodifw","Horaexpo","Valtafw","Umodifw","Vmodifw","Zadsfw","Bdaltafw","Smodifw","Esttrans","Bdmodifw","Accion","Trans","Ccod","Obs","Destino","Origen","Origdest","Motivo","Cdes","Ddesde","Dhasta","Lhabilit" ) values ( <<"'" + this.ConvertirDateSql( lxReglatransFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransBdmodifw ) + "'" >>, <<lxReglatransAccion >>, <<"'" + this.FormatearTextoSql( lxReglatransTrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransDestino ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransOrigen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransOrigdest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransMotivo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxReglatransCdes ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransDdesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxReglatransDhasta ) + "'" >>, <<iif( lxReglatransLhabilit, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'REGLATRANS' 
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
			local  lxReglatransFecimpo, lxReglatransFectrans, lxReglatransFmodifw, lxReglatransFecexpo, lxReglatransFaltafw, lxReglatransHaltafw, lxReglatransUaltafw, lxReglatransHoraimpo, lxReglatransSaltafw, lxReglatransHmodifw, lxReglatransHoraexpo, lxReglatransValtafw, lxReglatransUmodifw, lxReglatransVmodifw, lxReglatransZadsfw, lxReglatransBdaltafw, lxReglatransSmodifw, lxReglatransEsttrans, lxReglatransBdmodifw, lxReglatransAccion, lxReglatransTrans, lxReglatransCcod, lxReglatransObs, lxReglatransDestino, lxReglatransOrigen, lxReglatransOrigdest, lxReglatransMotivo, lxReglatransCdes, lxReglatransDdesde, lxReglatransDhasta, lxReglatransLhabilit
				lxReglatransFecimpo =  .Fechaimpo			lxReglatransFectrans =  .Fechatransferencia			lxReglatransFmodifw =  .Fechamodificacionfw			lxReglatransFecexpo =  .Fechaexpo			lxReglatransFaltafw =  .Fechaaltafw			lxReglatransHaltafw =  .Horaaltafw			lxReglatransUaltafw =  .Usuarioaltafw			lxReglatransHoraimpo =  .Horaimpo			lxReglatransSaltafw =  .Seriealtafw			lxReglatransHmodifw =  .Horamodificacionfw			lxReglatransHoraexpo =  .Horaexpo			lxReglatransValtafw =  .Versionaltafw			lxReglatransUmodifw =  .Usuariomodificacionfw			lxReglatransVmodifw =  .Versionmodificacionfw			lxReglatransZadsfw =  .Zadsfw			lxReglatransBdaltafw =  .Basededatosaltafw			lxReglatransSmodifw =  .Seriemodificacionfw			lxReglatransEsttrans =  .Estadotransferencia			lxReglatransBdmodifw =  .Basededatosmodificacionfw			lxReglatransAccion =  .Accion			lxReglatransTrans =  .Transferencia			lxReglatransCcod =  .Codigo			lxReglatransObs =  .Obs			lxReglatransDestino =  .Destino			lxReglatransOrigen =  .Origen			lxReglatransOrigdest =  upper( .OrigenDestino_PK ) 			lxReglatransMotivo =  upper( .motivo_PK ) 			lxReglatransCdes =  .Descripcion			lxReglatransDdesde =  .Fechadesde			lxReglatransDhasta =  .Fechahasta			lxReglatransLhabilit =  .Habilitada
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  REGLATRANS.CCOD != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.REGLATRANS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxReglatransFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxReglatransFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxReglatransFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxReglatransFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxReglatransFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxReglatransHaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxReglatransUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxReglatransHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxReglatransSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxReglatransHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxReglatransHoraexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxReglatransValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxReglatransUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxReglatransVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxReglatransZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxReglatransBdaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxReglatransSmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxReglatransEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxReglatransBdmodifw ) + "'">>, "Accion" = <<lxReglatransAccion>>, "Trans" = <<"'" + this.FormatearTextoSql( lxReglatransTrans ) + "'">>, "Ccod" = <<"'" + this.FormatearTextoSql( lxReglatransCcod ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxReglatransObs ) + "'">>, "Destino" = <<"'" + this.FormatearTextoSql( lxReglatransDestino ) + "'">>, "Origen" = <<"'" + this.FormatearTextoSql( lxReglatransOrigen ) + "'">>, "Origdest" = <<"'" + this.FormatearTextoSql( lxReglatransOrigdest ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxReglatransMotivo ) + "'">>, "Cdes" = <<"'" + this.FormatearTextoSql( lxReglatransCdes ) + "'">>, "Ddesde" = <<"'" + this.ConvertirDateSql( lxReglatransDdesde ) + "'">>, "Dhasta" = <<"'" + this.ConvertirDateSql( lxReglatransDhasta ) + "'">>, "Lhabilit" = <<iif( lxReglatransLhabilit, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'REGLATRANS' 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  REGLATRANS.CCOD != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.REGLATRANS where ' + lcFiltro )
			loColeccion.cTabla = 'REGLATRANS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.REGLATRANS where  REGLATRANS.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.REGLATRANS where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  REGLATRANS.CCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGLASTRANSFERENCIAS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.REGLATRANS Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.REGLATRANS set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, accion = ] + transform( &lcCursor..accion )+ [, trans = ] + "'" + this.FormatearTextoSql( &lcCursor..trans ) + "'"+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"+ [, obs = ] + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'"+ [, destino = ] + "'" + this.FormatearTextoSql( &lcCursor..destino ) + "'"+ [, origen = ] + "'" + this.FormatearTextoSql( &lcCursor..origen ) + "'"+ [, OrigDest = ] + "'" + this.FormatearTextoSql( &lcCursor..OrigDest ) + "'"+ [, motivo = ] + "'" + this.FormatearTextoSql( &lcCursor..motivo ) + "'"+ [, cDes = ] + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'"+ [, dDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..dDesde ) + "'"+ [, dHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..dHasta ) + "'"+ [, lHabilit = ] + Transform( iif( &lcCursor..lHabilit, 1, 0 )) + [ Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, HALTAFW, UALTAFW, HORAIMPO, SALTAFW, HMODIFW, HORAEXPO, VALTAFW, UMODIFW, VMODIFW, ZADSFW, BDALTAFW, SMODIFW, ESTTRANS, BDMODIFW, accion, trans, cCod, obs, destino, origen, OrigDest, motivo, cDes, dDesde, dHasta, lHabilit
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..accion ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..trans ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..destino ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..origen ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OrigDest ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..motivo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..dDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..dHasta ) + "'" + ',' + Transform( iif( &lcCursor..lHabilit, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.REGLATRANS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'REGLASTRANSFERENCIAS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( cCod C (20) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'REGLASTRANSFERENCIAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGLASTRANSFERENCIAS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'REGLASTRANSFERENCIAS_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_reglaTrans')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'REGLASTRANSFERENCIAS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad REGLASTRANSFERENCIAS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGLASTRANSFERENCIAS'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGLASTRANSFERENCIAS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  dDesde    
		* Validar ANTERIORES A 1/1/1753  dHasta    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_reglaTrans') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_reglaTrans
Create Table ORGANIZACION.TablaTrabajo_reglaTrans ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"accion" numeric( 2, 0 )  null, 
"trans" char( 50 )  null, 
"ccod" char( 20 )  null, 
"obs" varchar(max)  null, 
"destino" char( 50 )  null, 
"origen" char( 50 )  null, 
"origdest" char( 8 )  null, 
"motivo" char( 3 )  null, 
"cdes" char( 50 )  null, 
"ddesde" datetime  null, 
"dhasta" datetime  null, 
"lhabilit" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_reglaTrans' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_reglaTrans' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'REGLASTRANSFERENCIAS'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('accion','accion')
			.AgregarMapeo('trans','trans')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('destino','destino')
			.AgregarMapeo('origen','origen')
			.AgregarMapeo('origdest','origdest')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('cdes','cdes')
			.AgregarMapeo('ddesde','ddesde')
			.AgregarMapeo('dhasta','dhasta')
			.AgregarMapeo('lhabilit','lhabilit')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_reglaTrans'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ACCION = isnull( d.ACCION, t.ACCION ),t.TRANS = isnull( d.TRANS, t.TRANS ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.OBS = isnull( d.OBS, t.OBS ),t.DESTINO = isnull( d.DESTINO, t.DESTINO ),t.ORIGEN = isnull( d.ORIGEN, t.ORIGEN ),t.ORIGDEST = isnull( d.ORIGDEST, t.ORIGDEST ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.CDES = isnull( d.CDES, t.CDES ),t.DDESDE = isnull( d.DDESDE, t.DDESDE ),t.DHASTA = isnull( d.DHASTA, t.DHASTA ),t.LHABILIT = isnull( d.LHABILIT, t.LHABILIT )
					from ORGANIZACION.REGLATRANS t inner join deleted d 
							 on t.cCod = d.cCod
				-- Fin Updates
				insert into ORGANIZACION.REGLATRANS(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Ualtafw,Horaimpo,Saltafw,Hmodifw,Horaexpo,Valtafw,Umodifw,Vmodifw,Zadsfw,Bdaltafw,Smodifw,Esttrans,Bdmodifw,Accion,Trans,Ccod,Obs,Destino,Origen,Origdest,Motivo,Cdes,Ddesde,Dhasta,Lhabilit)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.SMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.ACCION,0),isnull( d.TRANS,''),isnull( d.CCOD,''),isnull( d.OBS,''),isnull( d.DESTINO,''),isnull( d.ORIGEN,''),isnull( d.ORIGDEST,''),isnull( d.MOTIVO,''),isnull( d.CDES,''),isnull( d.DDESDE,''),isnull( d.DHASTA,''),isnull( d.LHABILIT,0)
						From deleted d left join ORGANIZACION.REGLATRANS pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_reglaTrans') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_reglaTrans
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_REGLASTRANSFERENCIAS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGLASTRANSFERENCIAS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGLASTRANSFERENCIAS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGLASTRANSFERENCIAS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGLASTRANSFERENCIAS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGLASTRANSFERENCIAS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_REGLASTRANSFERENCIAS.Horaaltafw, [] )
					.Usuarioaltafw = nvl( c_REGLASTRANSFERENCIAS.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_REGLASTRANSFERENCIAS.Horaimpo, [] )
					.Seriealtafw = nvl( c_REGLASTRANSFERENCIAS.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_REGLASTRANSFERENCIAS.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_REGLASTRANSFERENCIAS.Horaexpo, [] )
					.Versionaltafw = nvl( c_REGLASTRANSFERENCIAS.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_REGLASTRANSFERENCIAS.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_REGLASTRANSFERENCIAS.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_REGLASTRANSFERENCIAS.Basededatosaltafw, [] )
					.Seriemodificacionfw = nvl( c_REGLASTRANSFERENCIAS.Seriemodificacionfw, [] )
					.Estadotransferencia = nvl( c_REGLASTRANSFERENCIAS.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_REGLASTRANSFERENCIAS.Basededatosmodificacionfw, [] )
					.Accion = nvl( c_REGLASTRANSFERENCIAS.Accion, 0 )
					.Transferencia = nvl( c_REGLASTRANSFERENCIAS.Transferencia, [] )
					.Codigo = nvl( c_REGLASTRANSFERENCIAS.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Destino = nvl( c_REGLASTRANSFERENCIAS.Destino, [] )
					.Origen = nvl( c_REGLASTRANSFERENCIAS.Origen, [] )
					.Origendestino_PK =  nvl( c_REGLASTRANSFERENCIAS.Origendestino, [] )
					.Motivo_PK =  nvl( c_REGLASTRANSFERENCIAS.Motivo, [] )
					.Descripcion = nvl( c_REGLASTRANSFERENCIAS.Descripcion, [] )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGLASTRANSFERENCIAS.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_REGLASTRANSFERENCIAS.Fechahasta, ctod( '  /  /    ' ) ) )
					.Habilitada = nvl( c_REGLASTRANSFERENCIAS.Habilitada, .F. )
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
		return c_REGLASTRANSFERENCIAS.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.REGLATRANS' )
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
								from ORGANIZACION.REGLATRANS 
								Where   REGLATRANS.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "REGLATRANS", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Accion" as "Accion", "Trans" as "Transferencia", "Ccod" as "Codigo", "Obs" as "Obs", "Destino" as "Destino", "Origen" as "Origen", "Origdest" as "Origendestino", "Motivo" as "Motivo", "Cdes" as "Descripcion", "Ddesde" as "Fechadesde", "Dhasta" as "Fechahasta", "Lhabilit" as "Habilitada"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.REGLATRANS 
								Where   REGLATRANS.CCOD != ''
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
	Tabla = 'REGLATRANS'
	Filtro = " REGLATRANS.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " REGLATRANS.CCOD != ''"
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
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="FECHAIMPO                               " tabla="REGLATRANS     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="FECHATRANSFERENCIA                      " tabla="REGLATRANS     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="FECHAMODIFICACIONFW                     " tabla="REGLATRANS     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="FECHAEXPO                               " tabla="REGLATRANS     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="FECHAALTAFW                             " tabla="REGLATRANS     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="HORAALTAFW                              " tabla="REGLATRANS     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="USUARIOALTAFW                           " tabla="REGLATRANS     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="HORAIMPO                                " tabla="REGLATRANS     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="SERIEALTAFW                             " tabla="REGLATRANS     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="HORAMODIFICACIONFW                      " tabla="REGLATRANS     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="HORAEXPO                                " tabla="REGLATRANS     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="VERSIONALTAFW                           " tabla="REGLATRANS     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="USUARIOMODIFICACIONFW                   " tabla="REGLATRANS     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="VERSIONMODIFICACIONFW                   " tabla="REGLATRANS     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="ZADSFW                                  " tabla="REGLATRANS     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="BASEDEDATOSALTAFW                       " tabla="REGLATRANS     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="SERIEMODIFICACIONFW                     " tabla="REGLATRANS     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="ESTADOTRANSFERENCIA                     " tabla="REGLATRANS     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="REGLATRANS     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="ACCION                                  " tabla="REGLATRANS     " campo="ACCION    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Acción                                                                                                                                                          " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="TRANSFERENCIA                           " tabla="REGLATRANS     " campo="TRANS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="12" etiqueta="Transferencia                                                                                                                                                   " dominio="COMBOTRANSFERENCIAS           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="CODIGO                                  " tabla="REGLATRANS     " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="OBS                                     " tabla="REGLATRANS     " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="DESTINO                                 " tabla="REGLATRANS     " campo="DESTINO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Base de datos destino                                                                                                                                           " dominio="COMBOSUCURSALES               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="ORIGEN                                  " tabla="REGLATRANS     " campo="ORIGEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Base de datos origen                                                                                                                                            " dominio="COMBOSUCURSALESCONVACIO       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="ORIGENDESTINO                           " tabla="REGLATRANS     " campo="ORIGDEST  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Origen/Destino                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="MOTIVO                                  " tabla="REGLATRANS     " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVO                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Motivo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="DESCRIPCION                             " tabla="REGLATRANS     " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="FECHADESDE                              " tabla="REGLATRANS     " campo="DDESDE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Desde                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="FECHAHASTA                              " tabla="REGLATRANS     " campo="DHASTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Hasta                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGLASTRANSFERENCIAS                    " atributo="HABILITADA                              " tabla="REGLATRANS     " campo="LHABILIT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Habilitada                                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On REGLATRANS.ORIGDEST = ORDAT.codigo And  ORDAT.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MOTIVO                                  " atributo="DESCRIPCION                             " tabla="MOTIVO         " campo="MOTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Mot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MOTIVO On REGLATRANS.MOTIVO = MOTIVO.MOTCOD And  MOTIVO.MOTCOD != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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