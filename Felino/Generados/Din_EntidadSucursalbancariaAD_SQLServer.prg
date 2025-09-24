
define class Din_EntidadSUCURSALBANCARIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_SUCURSALBANCARIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_131PK'
	cTablaPrincipal = 'SUCBAN'
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
			local  lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecexpo, lxSucbanFecimpo, lxSucbanFmodifw, lxSucbanSbcalle, lxSucbanTimestamp, lxSucbanHaltafw, lxSucbanZadsfw, lxSucbanHoraexpo, lxSucbanHmodifw, lxSucbanHoraimpo, lxSucbanUaltafw, lxSucbanSaltafw, lxSucbanValtafw, lxSucbanUmodifw, lxSucbanSmodifw, lxSucbanVmodifw, lxSucbanBdmodifw, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFectrans =  .Fechatransferencia			lxSucbanFaltafw =  .Fechaaltafw			lxSucbanFecexpo =  .Fechaexpo			lxSucbanFecimpo =  .Fechaimpo			lxSucbanFmodifw =  .Fechamodificacionfw			lxSucbanSbcalle =  .Calle			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanHaltafw =  .Horaaltafw			lxSucbanZadsfw =  .Zadsfw			lxSucbanHoraexpo =  .Horaexpo			lxSucbanHmodifw =  .Horamodificacionfw			lxSucbanHoraimpo =  .Horaimpo			lxSucbanUaltafw =  .Usuarioaltafw			lxSucbanSaltafw =  .Seriealtafw			lxSucbanValtafw =  .Versionaltafw			lxSucbanUmodifw =  .Usuariomodificacionfw			lxSucbanSmodifw =  .Seriemodificacionfw			lxSucbanVmodifw =  .Versionmodificacionfw			lxSucbanBdmodifw =  .Basededatosmodificacionfw			lxSucbanEsttrans =  .Estadotransferencia			lxSucbanBdaltafw =  .Basededatosaltafw			lxSucbanSbcod =  .Codigo			lxSucbanSbnro =  .Numero			lxSucbanSbdes =  .Descripcion			lxSucbanSbpiso =  .Piso			lxSucbanSbentfin =  upper( .EntidadFinanciera_PK ) 			lxSucbanSbdepto =  .Departamento			lxSucbanSbnum =  .Numerosuc			lxSucbanSbloc =  .Localidad			lxSucbanSbcp =  .Codigopostal			lxSucbanSbprv =  upper( .Provincia_PK ) 			lxSucbanSbtlf =  .Telefono			lxSucbanSbpais =  upper( .Pais_PK ) 			lxSucbanSbemail =  .Email			lxSucbanSbcontac =  .Contacto			lxSucbanSbobs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxSucbanSbcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.SUCBAN ( "Fectrans","Faltafw","Fecexpo","Fecimpo","Fmodifw","Sbcalle","Timestamp","Haltafw","Zadsfw","Horaexpo","Hmodifw","Horaimpo","Ualtafw","Saltafw","Valtafw","Umodifw","Smodifw","Vmodifw","Bdmodifw","Esttrans","Bdaltafw","Sbcod","Sbnro","Sbdes","Sbpiso","Sbentfin","Sbdepto","Sbnum","Sbloc","Sbcp","Sbprv","Sbtlf","Sbpais","Sbemail","Sbcontac","Sbobs" ) values ( <<"'" + this.ConvertirDateSql( lxSucbanFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcalle ) + "'" >>, <<lxSucbanTimestamp >>, <<"'" + this.FormatearTextoSql( lxSucbanHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'" >>, <<lxSucbanSbnro >>, <<"'" + this.FormatearTextoSql( lxSucbanSbdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbentfin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbdepto ) + "'" >>, <<lxSucbanSbnum >>, <<"'" + this.FormatearTextoSql( lxSucbanSbloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbtlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbpais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcontac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbobs ) + "'" >> )
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
		this.oEntidad.Timestamp = lxSucbanTimestamp
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
			local  lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecexpo, lxSucbanFecimpo, lxSucbanFmodifw, lxSucbanSbcalle, lxSucbanTimestamp, lxSucbanHaltafw, lxSucbanZadsfw, lxSucbanHoraexpo, lxSucbanHmodifw, lxSucbanHoraimpo, lxSucbanUaltafw, lxSucbanSaltafw, lxSucbanValtafw, lxSucbanUmodifw, lxSucbanSmodifw, lxSucbanVmodifw, lxSucbanBdmodifw, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFectrans =  .Fechatransferencia			lxSucbanFaltafw =  .Fechaaltafw			lxSucbanFecexpo =  .Fechaexpo			lxSucbanFecimpo =  .Fechaimpo			lxSucbanFmodifw =  .Fechamodificacionfw			lxSucbanSbcalle =  .Calle			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanHaltafw =  .Horaaltafw			lxSucbanZadsfw =  .Zadsfw			lxSucbanHoraexpo =  .Horaexpo			lxSucbanHmodifw =  .Horamodificacionfw			lxSucbanHoraimpo =  .Horaimpo			lxSucbanUaltafw =  .Usuarioaltafw			lxSucbanSaltafw =  .Seriealtafw			lxSucbanValtafw =  .Versionaltafw			lxSucbanUmodifw =  .Usuariomodificacionfw			lxSucbanSmodifw =  .Seriemodificacionfw			lxSucbanVmodifw =  .Versionmodificacionfw			lxSucbanBdmodifw =  .Basededatosmodificacionfw			lxSucbanEsttrans =  .Estadotransferencia			lxSucbanBdaltafw =  .Basededatosaltafw			lxSucbanSbcod =  .Codigo			lxSucbanSbnro =  .Numero			lxSucbanSbdes =  .Descripcion			lxSucbanSbpiso =  .Piso			lxSucbanSbentfin =  upper( .EntidadFinanciera_PK ) 			lxSucbanSbdepto =  .Departamento			lxSucbanSbnum =  .Numerosuc			lxSucbanSbloc =  .Localidad			lxSucbanSbcp =  .Codigopostal			lxSucbanSbprv =  upper( .Provincia_PK ) 			lxSucbanSbtlf =  .Telefono			lxSucbanSbpais =  upper( .Pais_PK ) 			lxSucbanSbemail =  .Email			lxSucbanSbcontac =  .Contacto			lxSucbanSbobs =  .Observacion
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
				update ZooLogic.SUCBAN set "Fectrans" = <<"'" + this.ConvertirDateSql( lxSucbanFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxSucbanFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxSucbanFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxSucbanFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxSucbanFmodifw ) + "'">>,"Sbcalle" = <<"'" + this.FormatearTextoSql( lxSucbanSbcalle ) + "'">>,"Timestamp" = <<lxSucbanTimestamp>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxSucbanHaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxSucbanZadsfw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxSucbanHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxSucbanHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxSucbanUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxSucbanSaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxSucbanValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxSucbanUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxSucbanSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanVmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxSucbanEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSucbanBdaltafw ) + "'">>,"Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">>,"Sbnro" = <<lxSucbanSbnro>>,"Sbdes" = <<"'" + this.FormatearTextoSql( lxSucbanSbdes ) + "'">>,"Sbpiso" = <<"'" + this.FormatearTextoSql( lxSucbanSbpiso ) + "'">>,"Sbentfin" = <<"'" + this.FormatearTextoSql( lxSucbanSbentfin ) + "'">>,"Sbdepto" = <<"'" + this.FormatearTextoSql( lxSucbanSbdepto ) + "'">>,"Sbnum" = <<lxSucbanSbnum>>,"Sbloc" = <<"'" + this.FormatearTextoSql( lxSucbanSbloc ) + "'">>,"Sbcp" = <<"'" + this.FormatearTextoSql( lxSucbanSbcp ) + "'">>,"Sbprv" = <<"'" + this.FormatearTextoSql( lxSucbanSbprv ) + "'">>,"Sbtlf" = <<"'" + this.FormatearTextoSql( lxSucbanSbtlf ) + "'">>,"Sbpais" = <<"'" + this.FormatearTextoSql( lxSucbanSbpais ) + "'">>,"Sbemail" = <<"'" + this.FormatearTextoSql( lxSucbanSbemail ) + "'">>,"Sbcontac" = <<"'" + this.FormatearTextoSql( lxSucbanSbcontac ) + "'">>,"Sbobs" = <<"'" + this.FormatearTextoSql( lxSucbanSbobs ) + "'">> where "Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">> and  SUCBAN.SBCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxSucbanTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 SbCod from ZooLogic.SUCBAN where " + this.ConvertirFuncionesSql( " SUCBAN.SBCOD != ''" ) )
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
			Local lxSucbanSbcod
			lxSucbanSbcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Sbcalle" as "Calle", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where "Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">> and  SUCBAN.SBCOD != ''
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )

			if reccount( 'c_SUCURSALBANCARIA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxSucbanSbcod as Variant
		llRetorno = .t.
		lxSucbanSbcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.SUCBAN where "Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">> and  SUCBAN.SBCOD != ''
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Sbcalle" as "Calle", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where  SUCBAN.SBCOD != '' order by SbCod
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Sbcalle" as "Calle", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where  funciones.padr( SbCod, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SUCBAN.SBCOD != '' order by SbCod
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Sbcalle" as "Calle", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where  funciones.padr( SbCod, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SUCBAN.SBCOD != '' order by SbCod desc
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Sbcalle" as "Calle", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion" from ZooLogic.SUCBAN where  SUCBAN.SBCOD != '' order by SbCod desc
			endtext
			use in select('c_SUCURSALBANCARIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSALBANCARIA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Faltafw,Fecexpo,Fecimpo,Fmodifw,Sbcalle,Timestamp,Haltafw,Zadsfw,Horaexpo,Hmodifw,H" + ;
"oraimpo,Ualtafw,Saltafw,Valtafw,Umodifw,Smodifw,Vmodifw,Bdmodifw,Esttrans,Bdaltafw,Sbcod,Sbnro,Sbdes" + ;
",Sbpiso,Sbentfin,Sbdepto,Sbnum,Sbloc,Sbcp,Sbprv,Sbtlf,Sbpais,Sbemail,Sbcontac,Sbobs" + ;
" from ZooLogic.SUCBAN where  SUCBAN.SBCOD != '' and " + lcFiltro )
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
			local  lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecexpo, lxSucbanFecimpo, lxSucbanFmodifw, lxSucbanSbcalle, lxSucbanTimestamp, lxSucbanHaltafw, lxSucbanZadsfw, lxSucbanHoraexpo, lxSucbanHmodifw, lxSucbanHoraimpo, lxSucbanUaltafw, lxSucbanSaltafw, lxSucbanValtafw, lxSucbanUmodifw, lxSucbanSmodifw, lxSucbanVmodifw, lxSucbanBdmodifw, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFectrans = ctod( '  /  /    ' )			lxSucbanFaltafw = ctod( '  /  /    ' )			lxSucbanFecexpo = ctod( '  /  /    ' )			lxSucbanFecimpo = ctod( '  /  /    ' )			lxSucbanFmodifw = ctod( '  /  /    ' )			lxSucbanSbcalle = []			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanHaltafw = []			lxSucbanZadsfw = []			lxSucbanHoraexpo = []			lxSucbanHmodifw = []			lxSucbanHoraimpo = []			lxSucbanUaltafw = []			lxSucbanSaltafw = []			lxSucbanValtafw = []			lxSucbanUmodifw = []			lxSucbanSmodifw = []			lxSucbanVmodifw = []			lxSucbanBdmodifw = []			lxSucbanEsttrans = []			lxSucbanBdaltafw = []			lxSucbanSbcod = []			lxSucbanSbnro = 0			lxSucbanSbdes = []			lxSucbanSbpiso = []			lxSucbanSbentfin = []			lxSucbanSbdepto = []			lxSucbanSbnum = 0			lxSucbanSbloc = []			lxSucbanSbcp = []			lxSucbanSbprv = []			lxSucbanSbtlf = []			lxSucbanSbpais = []			lxSucbanSbemail = []			lxSucbanSbcontac = []			lxSucbanSbobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.SUCBAN where "SbCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'SUCBAN' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where SbCod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(SbCod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  SUCBAN.SBCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Sbcalle" as "Calle", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SUCBAN', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBCALLE AS CALLE'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBCOD AS CODIGO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBNRO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBDES AS DESCRIPCION'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBPISO AS PISO'
				Case lcAtributo == 'ENTIDADFINANCIERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBENTFIN AS ENTIDADFINANCIERA'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBDEPTO AS DEPARTAMENTO'
				Case lcAtributo == 'NUMEROSUC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBNUM AS NUMEROSUC'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBLOC AS LOCALIDAD'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBCP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBPRV AS PROVINCIA'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBTLF AS TELEFONO'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBPAIS AS PAIS'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBEMAIL AS EMAIL'
				Case lcAtributo == 'CONTACTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBCONTAC AS CONTACTO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SBOBS AS OBSERVACION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'SBCALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'SBCOD'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'SBNRO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'SBDES'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'SBPISO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADFINANCIERA'
				lcCampo = 'SBENTFIN'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'SBDEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROSUC'
				lcCampo = 'SBNUM'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'SBLOC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'SBCP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'SBPRV'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'SBTLF'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'SBPAIS'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'SBEMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'CONTACTO'
				lcCampo = 'SBCONTAC'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'SBOBS'
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
			local  lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecexpo, lxSucbanFecimpo, lxSucbanFmodifw, lxSucbanSbcalle, lxSucbanTimestamp, lxSucbanHaltafw, lxSucbanZadsfw, lxSucbanHoraexpo, lxSucbanHmodifw, lxSucbanHoraimpo, lxSucbanUaltafw, lxSucbanSaltafw, lxSucbanValtafw, lxSucbanUmodifw, lxSucbanSmodifw, lxSucbanVmodifw, lxSucbanBdmodifw, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFectrans =  .Fechatransferencia			lxSucbanFaltafw =  .Fechaaltafw			lxSucbanFecexpo =  .Fechaexpo			lxSucbanFecimpo =  .Fechaimpo			lxSucbanFmodifw =  .Fechamodificacionfw			lxSucbanSbcalle =  .Calle			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanHaltafw =  .Horaaltafw			lxSucbanZadsfw =  .Zadsfw			lxSucbanHoraexpo =  .Horaexpo			lxSucbanHmodifw =  .Horamodificacionfw			lxSucbanHoraimpo =  .Horaimpo			lxSucbanUaltafw =  .Usuarioaltafw			lxSucbanSaltafw =  .Seriealtafw			lxSucbanValtafw =  .Versionaltafw			lxSucbanUmodifw =  .Usuariomodificacionfw			lxSucbanSmodifw =  .Seriemodificacionfw			lxSucbanVmodifw =  .Versionmodificacionfw			lxSucbanBdmodifw =  .Basededatosmodificacionfw			lxSucbanEsttrans =  .Estadotransferencia			lxSucbanBdaltafw =  .Basededatosaltafw			lxSucbanSbcod =  .Codigo			lxSucbanSbnro =  .Numero			lxSucbanSbdes =  .Descripcion			lxSucbanSbpiso =  .Piso			lxSucbanSbentfin =  upper( .EntidadFinanciera_PK ) 			lxSucbanSbdepto =  .Departamento			lxSucbanSbnum =  .Numerosuc			lxSucbanSbloc =  .Localidad			lxSucbanSbcp =  .Codigopostal			lxSucbanSbprv =  upper( .Provincia_PK ) 			lxSucbanSbtlf =  .Telefono			lxSucbanSbpais =  upper( .Pais_PK ) 			lxSucbanSbemail =  .Email			lxSucbanSbcontac =  .Contacto			lxSucbanSbobs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.SUCBAN ( "Fectrans","Faltafw","Fecexpo","Fecimpo","Fmodifw","Sbcalle","Timestamp","Haltafw","Zadsfw","Horaexpo","Hmodifw","Horaimpo","Ualtafw","Saltafw","Valtafw","Umodifw","Smodifw","Vmodifw","Bdmodifw","Esttrans","Bdaltafw","Sbcod","Sbnro","Sbdes","Sbpiso","Sbentfin","Sbdepto","Sbnum","Sbloc","Sbcp","Sbprv","Sbtlf","Sbpais","Sbemail","Sbcontac","Sbobs" ) values ( <<"'" + this.ConvertirDateSql( lxSucbanFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucbanFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcalle ) + "'" >>, <<lxSucbanTimestamp >>, <<"'" + this.FormatearTextoSql( lxSucbanHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'" >>, <<lxSucbanSbnro >>, <<"'" + this.FormatearTextoSql( lxSucbanSbdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbpiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbentfin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbdepto ) + "'" >>, <<lxSucbanSbnum >>, <<"'" + this.FormatearTextoSql( lxSucbanSbloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbprv ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbtlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbpais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbemail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbcontac ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucbanSbobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'SUCBAN' 
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
			local  lxSucbanFectrans, lxSucbanFaltafw, lxSucbanFecexpo, lxSucbanFecimpo, lxSucbanFmodifw, lxSucbanSbcalle, lxSucbanTimestamp, lxSucbanHaltafw, lxSucbanZadsfw, lxSucbanHoraexpo, lxSucbanHmodifw, lxSucbanHoraimpo, lxSucbanUaltafw, lxSucbanSaltafw, lxSucbanValtafw, lxSucbanUmodifw, lxSucbanSmodifw, lxSucbanVmodifw, lxSucbanBdmodifw, lxSucbanEsttrans, lxSucbanBdaltafw, lxSucbanSbcod, lxSucbanSbnro, lxSucbanSbdes, lxSucbanSbpiso, lxSucbanSbentfin, lxSucbanSbdepto, lxSucbanSbnum, lxSucbanSbloc, lxSucbanSbcp, lxSucbanSbprv, lxSucbanSbtlf, lxSucbanSbpais, lxSucbanSbemail, lxSucbanSbcontac, lxSucbanSbobs
				lxSucbanFectrans =  .Fechatransferencia			lxSucbanFaltafw =  .Fechaaltafw			lxSucbanFecexpo =  .Fechaexpo			lxSucbanFecimpo =  .Fechaimpo			lxSucbanFmodifw =  .Fechamodificacionfw			lxSucbanSbcalle =  .Calle			lxSucbanTimestamp = goLibrerias.ObtenerTimestamp()			lxSucbanHaltafw =  .Horaaltafw			lxSucbanZadsfw =  .Zadsfw			lxSucbanHoraexpo =  .Horaexpo			lxSucbanHmodifw =  .Horamodificacionfw			lxSucbanHoraimpo =  .Horaimpo			lxSucbanUaltafw =  .Usuarioaltafw			lxSucbanSaltafw =  .Seriealtafw			lxSucbanValtafw =  .Versionaltafw			lxSucbanUmodifw =  .Usuariomodificacionfw			lxSucbanSmodifw =  .Seriemodificacionfw			lxSucbanVmodifw =  .Versionmodificacionfw			lxSucbanBdmodifw =  .Basededatosmodificacionfw			lxSucbanEsttrans =  .Estadotransferencia			lxSucbanBdaltafw =  .Basededatosaltafw			lxSucbanSbcod =  .Codigo			lxSucbanSbnro =  .Numero			lxSucbanSbdes =  .Descripcion			lxSucbanSbpiso =  .Piso			lxSucbanSbentfin =  upper( .EntidadFinanciera_PK ) 			lxSucbanSbdepto =  .Departamento			lxSucbanSbnum =  .Numerosuc			lxSucbanSbloc =  .Localidad			lxSucbanSbcp =  .Codigopostal			lxSucbanSbprv =  upper( .Provincia_PK ) 			lxSucbanSbtlf =  .Telefono			lxSucbanSbpais =  upper( .Pais_PK ) 			lxSucbanSbemail =  .Email			lxSucbanSbcontac =  .Contacto			lxSucbanSbobs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Sbcod" = ] + lcValorClavePrimariaString  + [ and  SUCBAN.SBCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.SUCBAN set "Fectrans" = <<"'" + this.ConvertirDateSql( lxSucbanFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxSucbanFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSucbanFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSucbanFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSucbanFmodifw ) + "'">>, "Sbcalle" = <<"'" + this.FormatearTextoSql( lxSucbanSbcalle ) + "'">>, "Timestamp" = <<lxSucbanTimestamp>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxSucbanHaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxSucbanZadsfw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxSucbanHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxSucbanHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxSucbanUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxSucbanSaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxSucbanValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxSucbanUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxSucbanSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanVmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSucbanBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxSucbanEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSucbanBdaltafw ) + "'">>, "Sbcod" = <<"'" + this.FormatearTextoSql( lxSucbanSbcod ) + "'">>, "Sbnro" = <<lxSucbanSbnro>>, "Sbdes" = <<"'" + this.FormatearTextoSql( lxSucbanSbdes ) + "'">>, "Sbpiso" = <<"'" + this.FormatearTextoSql( lxSucbanSbpiso ) + "'">>, "Sbentfin" = <<"'" + this.FormatearTextoSql( lxSucbanSbentfin ) + "'">>, "Sbdepto" = <<"'" + this.FormatearTextoSql( lxSucbanSbdepto ) + "'">>, "Sbnum" = <<lxSucbanSbnum>>, "Sbloc" = <<"'" + this.FormatearTextoSql( lxSucbanSbloc ) + "'">>, "Sbcp" = <<"'" + this.FormatearTextoSql( lxSucbanSbcp ) + "'">>, "Sbprv" = <<"'" + this.FormatearTextoSql( lxSucbanSbprv ) + "'">>, "Sbtlf" = <<"'" + this.FormatearTextoSql( lxSucbanSbtlf ) + "'">>, "Sbpais" = <<"'" + this.FormatearTextoSql( lxSucbanSbpais ) + "'">>, "Sbemail" = <<"'" + this.FormatearTextoSql( lxSucbanSbemail ) + "'">>, "Sbcontac" = <<"'" + this.FormatearTextoSql( lxSucbanSbcontac ) + "'">>, "Sbobs" = <<"'" + this.FormatearTextoSql( lxSucbanSbobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SUCBAN' 
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

			lcFiltro = ["Sbcod" = ] + lcValorClavePrimariaString  + [ and  SUCBAN.SBCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.SUCBAN where ' + lcFiltro )
			loColeccion.cTabla = 'SUCBAN' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.SUCBAN where  SUCBAN.SBCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.SUCBAN where SbCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SUCBAN.SBCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.SUCBAN Where SbCod = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.SUCBAN set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, SbCalle = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCalle ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, SbCod = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCod ) + "'"+ [, SbNro = ] + transform( &lcCursor..SbNro )+ [, SbDes = ] + "'" + this.FormatearTextoSql( &lcCursor..SbDes ) + "'"+ [, SbPiso = ] + "'" + this.FormatearTextoSql( &lcCursor..SbPiso ) + "'"+ [, SbEntFin = ] + "'" + this.FormatearTextoSql( &lcCursor..SbEntFin ) + "'"+ [, SbDepto = ] + "'" + this.FormatearTextoSql( &lcCursor..SbDepto ) + "'"+ [, SbNum = ] + transform( &lcCursor..SbNum )+ [, SbLoc = ] + "'" + this.FormatearTextoSql( &lcCursor..SbLoc ) + "'"+ [, SbCP = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCP ) + "'"+ [, SbPrv = ] + "'" + this.FormatearTextoSql( &lcCursor..SbPrv ) + "'"+ [, SbTlf = ] + "'" + this.FormatearTextoSql( &lcCursor..SbTlf ) + "'"+ [, SbPais = ] + "'" + this.FormatearTextoSql( &lcCursor..SbPais ) + "'"+ [, SbEmail = ] + "'" + this.FormatearTextoSql( &lcCursor..SbEmail ) + "'"+ [, SbContac = ] + "'" + this.FormatearTextoSql( &lcCursor..SbContac ) + "'"+ [, SbObs = ] + "'" + this.FormatearTextoSql( &lcCursor..SbObs ) + "'" + [ Where SbCod = ] + "'" + this.FormatearTextoSql( &lcCursor..SbCod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FALTAFW, FECEXPO, FECIMPO, FMODIFW, SbCalle, TIMESTAMP, HALTAFW, ZADSFW, HORAEXPO, HMODIFW, HORAIMPO, UALTAFW, SALTAFW, VALTAFW, UMODIFW, SMODIFW, VMODIFW, BDMODIFW, ESTTRANS, BDALTAFW, SbCod, SbNro, SbDes, SbPiso, SbEntFin, SbDepto, SbNum, SbLoc, SbCP, SbPrv, SbTlf, SbPais, SbEmail, SbContac, SbObs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbCalle ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbCod ) + "'" + ',' + transform( &lcCursor..SbNro ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbDes ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbPiso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbEntFin ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbDepto ) + "'" + ',' + transform( &lcCursor..SbNum ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbLoc ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbCP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbPrv ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbTlf ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbPais ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbEmail ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbContac ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SbObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.SUCBAN ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( SbCod C (5) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..SbCod      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'SUCURSALBANCARIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SUCURSALBANCARIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SUCURSALBANCARIA_SBOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_SucBan')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'SUCURSALBANCARIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..SbCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad SUCURSALBANCARIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,SbCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( SbCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SucBan') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SucBan
Create Table ZooLogic.TablaTrabajo_SucBan ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"sbcalle" char( 70 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"haltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"sbcod" char( 5 )  null, 
"sbnro" numeric( 5, 0 )  null, 
"sbdes" char( 40 )  null, 
"sbpiso" char( 3 )  null, 
"sbentfin" char( 5 )  null, 
"sbdepto" char( 3 )  null, 
"sbnum" numeric( 10, 0 )  null, 
"sbloc" char( 70 )  null, 
"sbcp" char( 8 )  null, 
"sbprv" char( 2 )  null, 
"sbtlf" char( 30 )  null, 
"sbpais" char( 3 )  null, 
"sbemail" char( 60 )  null, 
"sbcontac" char( 60 )  null, 
"sbobs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_SucBan' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_SucBan' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSALBANCARIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('sbcalle','sbcalle')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('sbcod','sbcod')
			.AgregarMapeo('sbnro','sbnro')
			.AgregarMapeo('sbdes','sbdes')
			.AgregarMapeo('sbpiso','sbpiso')
			.AgregarMapeo('sbentfin','sbentfin')
			.AgregarMapeo('sbdepto','sbdepto')
			.AgregarMapeo('sbnum','sbnum')
			.AgregarMapeo('sbloc','sbloc')
			.AgregarMapeo('sbcp','sbcp')
			.AgregarMapeo('sbprv','sbprv')
			.AgregarMapeo('sbtlf','sbtlf')
			.AgregarMapeo('sbpais','sbpais')
			.AgregarMapeo('sbemail','sbemail')
			.AgregarMapeo('sbcontac','sbcontac')
			.AgregarMapeo('sbobs','sbobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_SucBan'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.SBCALLE = isnull( d.SBCALLE, t.SBCALLE ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SBCOD = isnull( d.SBCOD, t.SBCOD ),t.SBNRO = isnull( d.SBNRO, t.SBNRO ),t.SBDES = isnull( d.SBDES, t.SBDES ),t.SBPISO = isnull( d.SBPISO, t.SBPISO ),t.SBENTFIN = isnull( d.SBENTFIN, t.SBENTFIN ),t.SBDEPTO = isnull( d.SBDEPTO, t.SBDEPTO ),t.SBNUM = isnull( d.SBNUM, t.SBNUM ),t.SBLOC = isnull( d.SBLOC, t.SBLOC ),t.SBCP = isnull( d.SBCP, t.SBCP ),t.SBPRV = isnull( d.SBPRV, t.SBPRV ),t.SBTLF = isnull( d.SBTLF, t.SBTLF ),t.SBPAIS = isnull( d.SBPAIS, t.SBPAIS ),t.SBEMAIL = isnull( d.SBEMAIL, t.SBEMAIL ),t.SBCONTAC = isnull( d.SBCONTAC, t.SBCONTAC ),t.SBOBS = isnull( d.SBOBS, t.SBOBS )
					from ZooLogic.SUCBAN t inner join deleted d 
							 on t.SbCod = d.SbCod
				-- Fin Updates
				insert into ZooLogic.SUCBAN(Fectrans,Faltafw,Fecexpo,Fecimpo,Fmodifw,Sbcalle,Timestamp,Haltafw,Zadsfw,Horaexpo,Hmodifw,Horaimpo,Ualtafw,Saltafw,Valtafw,Umodifw,Smodifw,Vmodifw,Bdmodifw,Esttrans,Bdaltafw,Sbcod,Sbnro,Sbdes,Sbpiso,Sbentfin,Sbdepto,Sbnum,Sbloc,Sbcp,Sbprv,Sbtlf,Sbpais,Sbemail,Sbcontac,Sbobs)
					Select isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.SBCALLE,''),isnull( d.TIMESTAMP,0),convert( char(8), getdate(), 108 ),isnull( d.ZADSFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.SBCOD,''),isnull( d.SBNRO,0),isnull( d.SBDES,''),isnull( d.SBPISO,''),isnull( d.SBENTFIN,''),isnull( d.SBDEPTO,''),isnull( d.SBNUM,0),isnull( d.SBLOC,''),isnull( d.SBCP,''),isnull( d.SBPRV,''),isnull( d.SBTLF,''),isnull( d.SBPAIS,''),isnull( d.SBEMAIL,''),isnull( d.SBCONTAC,''),isnull( d.SBOBS,'')
						From deleted d left join ZooLogic.SUCBAN pk 
							 on d.SbCod = pk.SbCod
						Where pk.SbCod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SucBan') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SucBan
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_SUCURSALBANCARIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSALBANCARIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Calle = nvl( c_SUCURSALBANCARIA.Calle, [] )
					.Timestamp = nvl( c_SUCURSALBANCARIA.Timestamp, 0 )
					.Horaaltafw = nvl( c_SUCURSALBANCARIA.Horaaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaexpo = nvl( c_SUCURSALBANCARIA.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_SUCURSALBANCARIA.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_SUCURSALBANCARIA.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_SUCURSALBANCARIA.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_SUCURSALBANCARIA.Seriealtafw, [] )
					.Versionaltafw = nvl( c_SUCURSALBANCARIA.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_SUCURSALBANCARIA.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_SUCURSALBANCARIA.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_SUCURSALBANCARIA.Versionmodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_SUCURSALBANCARIA.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_SUCURSALBANCARIA.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_SUCURSALBANCARIA.Basededatosaltafw, [] )
					.Codigo = nvl( c_SUCURSALBANCARIA.Codigo, [] )
					.Numero = nvl( c_SUCURSALBANCARIA.Numero, 0 )
					.Descripcion = nvl( c_SUCURSALBANCARIA.Descripcion, [] )
					.Piso = nvl( c_SUCURSALBANCARIA.Piso, [] )
					.Entidadfinanciera_PK =  nvl( c_SUCURSALBANCARIA.Entidadfinanciera, [] )
					.Departamento = nvl( c_SUCURSALBANCARIA.Departamento, [] )
					.Numerosuc = nvl( c_SUCURSALBANCARIA.Numerosuc, 0 )
					.Localidad = nvl( c_SUCURSALBANCARIA.Localidad, [] )
					.Codigopostal = nvl( c_SUCURSALBANCARIA.Codigopostal, [] )
					.Provincia_PK =  nvl( c_SUCURSALBANCARIA.Provincia, [] )
					.Telefono = nvl( c_SUCURSALBANCARIA.Telefono, [] )
					.Pais_PK =  nvl( c_SUCURSALBANCARIA.Pais, [] )
					.Email = nvl( c_SUCURSALBANCARIA.Email, [] )
					.Contacto = nvl( c_SUCURSALBANCARIA.Contacto, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
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
		return c_SUCURSALBANCARIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.SUCBAN' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "SbCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,SbCod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    SbCod from (
							select * 
								from ZooLogic.SUCBAN 
								Where   SUCBAN.SBCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SUCBAN", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "SbCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Sbcalle" as "Calle", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Sbcod" as "Codigo", "Sbnro" as "Numero", "Sbdes" as "Descripcion", "Sbpiso" as "Piso", "Sbentfin" as "Entidadfinanciera", "Sbdepto" as "Departamento", "Sbnum" as "Numerosuc", "Sbloc" as "Localidad", "Sbcp" as "Codigopostal", "Sbprv" as "Provincia", "Sbtlf" as "Telefono", "Sbpais" as "Pais", "Sbemail" as "Email", "Sbcontac" as "Contacto", "Sbobs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.SUCBAN 
								Where   SUCBAN.SBCOD != ''
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
	Tabla = 'SUCBAN'
	Filtro = " SUCBAN.SBCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SUCBAN.SBCOD != ''"
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
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHATRANSFERENCIA                      " tabla="SUCBAN         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHAALTAFW                             " tabla="SUCBAN         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHAEXPO                               " tabla="SUCBAN         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHAIMPO                               " tabla="SUCBAN         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="FECHAMODIFICACIONFW                     " tabla="SUCBAN         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="CALLE                                   " tabla="SUCBAN         " campo="SBCALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="TIMESTAMP                               " tabla="SUCBAN         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="HORAALTAFW                              " tabla="SUCBAN         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="ZADSFW                                  " tabla="SUCBAN         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="HORAEXPO                                " tabla="SUCBAN         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="HORAMODIFICACIONFW                      " tabla="SUCBAN         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="HORAIMPO                                " tabla="SUCBAN         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="USUARIOALTAFW                           " tabla="SUCBAN         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="SERIEALTAFW                             " tabla="SUCBAN         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="VERSIONALTAFW                           " tabla="SUCBAN         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="USUARIOMODIFICACIONFW                   " tabla="SUCBAN         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="SERIEMODIFICACIONFW                     " tabla="SUCBAN         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="VERSIONMODIFICACIONFW                   " tabla="SUCBAN         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SUCBAN         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="ESTADOTRANSFERENCIA                     " tabla="SUCBAN         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="BASEDEDATOSALTAFW                       " tabla="SUCBAN         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="CODIGO                                  " tabla="SUCBAN         " campo="SBCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="NUMERO                                  " tabla="SUCBAN         " campo="SBNRO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Nro                                                                                                                                                             " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="DESCRIPCION                             " tabla="SUCBAN         " campo="SBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="PISO                                    " tabla="SUCBAN         " campo="SBPISO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="ENTIDADFINANCIERA                       " tabla="SUCBAN         " campo="SBENTFIN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Entidad financiera                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="DEPARTAMENTO                            " tabla="SUCBAN         " campo="SBDEPTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="NUMEROSUC                               " tabla="SUCBAN         " campo="SBNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número de sucursal                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="LOCALIDAD                               " tabla="SUCBAN         " campo="SBLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Localidad                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="CODIGOPOSTAL                            " tabla="SUCBAN         " campo="SBCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Código Postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="PROVINCIA                               " tabla="SUCBAN         " campo="SBPRV     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="TELEFONO                                " tabla="SUCBAN         " campo="SBTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="PAIS                                    " tabla="SUCBAN         " campo="SBPAIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="EMAIL                                   " tabla="SUCBAN         " campo="SBEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="E-Mail                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="CONTACTO                                " tabla="SUCBAN         " campo="SBCONTAC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Contacto                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSALBANCARIA                        " atributo="OBSERVACION                             " tabla="SUCBAN         " campo="SBOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADFINANCIERA                       " atributo="DESCRIPCION                             " tabla="ENTFIN         " campo="EFDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTFIN On SUCBAN.SBENTFIN = ENTFIN.EfCod And  ENTFIN.EFCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On SUCBAN.SBPRV = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAISES                                  " atributo="DESCRIPCION                             " tabla="PAISES         " campo="PDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Paí.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PAISES On SUCBAN.SBPAIS = PAISES.pcod And  PAISES.PCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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