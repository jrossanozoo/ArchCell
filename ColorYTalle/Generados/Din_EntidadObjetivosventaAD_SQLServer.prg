
define class Din_EntidadOBJETIVOSVENTAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_OBJETIVOSVENTA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_OBJPK'
	cTablaPrincipal = 'OBJETIVOSVENTA'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxObjetivosventaFectrans, lxObjetivosventaFecimpo, lxObjetivosventaFmodifw, lxObjetivosventaFecexpo, lxObjetivosventaHoraexpo, lxObjetivosventaZadsfw, lxObjetivosventaHoraimpo, lxObjetivosventaSaltafw, lxObjetivosventaHmodifw, lxObjetivosventaVmodifw, lxObjetivosventaUmodifw, lxObjetivosventaUaltafw, lxObjetivosventaValtafw, lxObjetivosventaSmodifw, lxObjetivosventaBdaltafw, lxObjetivosventaEsttrans, lxObjetivosventaClave, lxObjetivosventaBdmodifw, lxObjetivosventaCodigo, lxObjetivosventaHaltafw, lxObjetivosventaNombre, lxObjetivosventaRegpor, lxObjetivosventaSucursal, lxObjetivosventaFaltafw, lxObjetivosventaSerie, lxObjetivosventaTipoobj, lxObjetivosventaBd, lxObjetivosventaMonto, lxObjetivosventaDesde, lxObjetivosventaHasta, lxObjetivosventaObs
				lxObjetivosventaFectrans =  .Fechatransferencia			lxObjetivosventaFecimpo =  .Fechaimpo			lxObjetivosventaFmodifw =  .Fechamodificacionfw			lxObjetivosventaFecexpo =  .Fechaexpo			lxObjetivosventaHoraexpo =  .Horaexpo			lxObjetivosventaZadsfw =  .Zadsfw			lxObjetivosventaHoraimpo =  .Horaimpo			lxObjetivosventaSaltafw =  .Seriealtafw			lxObjetivosventaHmodifw =  .Horamodificacionfw			lxObjetivosventaVmodifw =  .Versionmodificacionfw			lxObjetivosventaUmodifw =  .Usuariomodificacionfw			lxObjetivosventaUaltafw =  .Usuarioaltafw			lxObjetivosventaValtafw =  .Versionaltafw			lxObjetivosventaSmodifw =  .Seriemodificacionfw			lxObjetivosventaBdaltafw =  .Basededatosaltafw			lxObjetivosventaEsttrans =  .Estadotransferencia			lxObjetivosventaClave =  .Clave			lxObjetivosventaBdmodifw =  .Basededatosmodificacionfw			lxObjetivosventaCodigo =  .Codigo			lxObjetivosventaHaltafw =  .Horaaltafw			lxObjetivosventaNombre =  .Nombre			lxObjetivosventaRegpor =  .Registradopor			lxObjetivosventaSucursal =  upper( .Sucursal_PK ) 			lxObjetivosventaFaltafw =  .Fechaaltafw			lxObjetivosventaSerie =  .Serie			lxObjetivosventaTipoobj =  upper( .TipoObj_PK ) 			lxObjetivosventaBd =  .Bd			lxObjetivosventaMonto =  .Monto			lxObjetivosventaDesde =  .Vigenciadesde			lxObjetivosventaHasta =  .Vigenciahasta			lxObjetivosventaObs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxObjetivosventaCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.OBJETIVOSVENTA ( "Fectrans","Fecimpo","Fmodifw","Fecexpo","Horaexpo","Zadsfw","Horaimpo","Saltafw","Hmodifw","Vmodifw","Umodifw","Ualtafw","Valtafw","Smodifw","Bdaltafw","Esttrans","Clave","Bdmodifw","Codigo","Haltafw","Nombre","Regpor","Sucursal","Faltafw","Serie","Tipoobj","Bd","Monto","Desde","Hasta","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxObjetivosventaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaClave ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaBdmodifw ) + "'" >>, <<lxObjetivosventaCodigo >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaNombre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaRegpor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaSucursal ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaTipoobj ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaBd ) + "'" >>, <<lxObjetivosventaMonto >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaDesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaHasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaObs ) + "'" >> )
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
			local  lxObjetivosventaFectrans, lxObjetivosventaFecimpo, lxObjetivosventaFmodifw, lxObjetivosventaFecexpo, lxObjetivosventaHoraexpo, lxObjetivosventaZadsfw, lxObjetivosventaHoraimpo, lxObjetivosventaSaltafw, lxObjetivosventaHmodifw, lxObjetivosventaVmodifw, lxObjetivosventaUmodifw, lxObjetivosventaUaltafw, lxObjetivosventaValtafw, lxObjetivosventaSmodifw, lxObjetivosventaBdaltafw, lxObjetivosventaEsttrans, lxObjetivosventaClave, lxObjetivosventaBdmodifw, lxObjetivosventaCodigo, lxObjetivosventaHaltafw, lxObjetivosventaNombre, lxObjetivosventaRegpor, lxObjetivosventaSucursal, lxObjetivosventaFaltafw, lxObjetivosventaSerie, lxObjetivosventaTipoobj, lxObjetivosventaBd, lxObjetivosventaMonto, lxObjetivosventaDesde, lxObjetivosventaHasta, lxObjetivosventaObs
				lxObjetivosventaFectrans =  .Fechatransferencia			lxObjetivosventaFecimpo =  .Fechaimpo			lxObjetivosventaFmodifw =  .Fechamodificacionfw			lxObjetivosventaFecexpo =  .Fechaexpo			lxObjetivosventaHoraexpo =  .Horaexpo			lxObjetivosventaZadsfw =  .Zadsfw			lxObjetivosventaHoraimpo =  .Horaimpo			lxObjetivosventaSaltafw =  .Seriealtafw			lxObjetivosventaHmodifw =  .Horamodificacionfw			lxObjetivosventaVmodifw =  .Versionmodificacionfw			lxObjetivosventaUmodifw =  .Usuariomodificacionfw			lxObjetivosventaUaltafw =  .Usuarioaltafw			lxObjetivosventaValtafw =  .Versionaltafw			lxObjetivosventaSmodifw =  .Seriemodificacionfw			lxObjetivosventaBdaltafw =  .Basededatosaltafw			lxObjetivosventaEsttrans =  .Estadotransferencia			lxObjetivosventaClave =  .Clave			lxObjetivosventaBdmodifw =  .Basededatosmodificacionfw			lxObjetivosventaCodigo =  .Codigo			lxObjetivosventaHaltafw =  .Horaaltafw			lxObjetivosventaNombre =  .Nombre			lxObjetivosventaRegpor =  .Registradopor			lxObjetivosventaSucursal =  upper( .Sucursal_PK ) 			lxObjetivosventaFaltafw =  .Fechaaltafw			lxObjetivosventaSerie =  .Serie			lxObjetivosventaTipoobj =  upper( .TipoObj_PK ) 			lxObjetivosventaBd =  .Bd			lxObjetivosventaMonto =  .Monto			lxObjetivosventaDesde =  .Vigenciadesde			lxObjetivosventaHasta =  .Vigenciahasta			lxObjetivosventaObs =  .Obs
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.OBJETIVOSVENTA set "Fectrans" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFecexpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxObjetivosventaHoraexpo ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaZadsfw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxObjetivosventaHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaValtafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaSmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxObjetivosventaEsttrans ) + "'">>,"Clave" = <<"'" + this.FormatearTextoSql( lxObjetivosventaClave ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaBdmodifw ) + "'">>,"Codigo" = <<lxObjetivosventaCodigo>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaHaltafw ) + "'">>,"Nombre" = <<"'" + this.FormatearTextoSql( lxObjetivosventaNombre ) + "'">>,"Regpor" = <<"'" + this.FormatearTextoSql( lxObjetivosventaRegpor ) + "'">>,"Sucursal" = <<"'" + this.FormatearTextoSql( lxObjetivosventaSucursal ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFaltafw ) + "'">>,"Serie" = <<"'" + this.FormatearTextoSql( lxObjetivosventaSerie ) + "'">>,"Tipoobj" = <<"'" + this.FormatearTextoSql( lxObjetivosventaTipoobj ) + "'">>,"Bd" = <<"'" + this.FormatearTextoSql( lxObjetivosventaBd ) + "'">>,"Monto" = <<lxObjetivosventaMonto>>,"Desde" = <<"'" + this.ConvertirDateSql( lxObjetivosventaDesde ) + "'">>,"Hasta" = <<"'" + this.ConvertirDateSql( lxObjetivosventaHasta ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxObjetivosventaObs ) + "'">> where "Codigo" = <<lxObjetivosventaCodigo>> and  OBJETIVOSVENTA.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ORGANIZACION.OBJETIVOSVENTA where " + this.ConvertirFuncionesSql( " OBJETIVOSVENTA.CODIGO != 0" ) )
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
			Local lxObjetivosventaCodigo
			lxObjetivosventaCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Clave" as "Clave", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Nombre" as "Nombre", "Regpor" as "Registradopor", "Sucursal" as "Sucursal", "Faltafw" as "Fechaaltafw", "Serie" as "Serie", "Tipoobj" as "Tipoobj", "Bd" as "Bd", "Monto" as "Monto", "Desde" as "Vigenciadesde", "Hasta" as "Vigenciahasta", "Obs" as "Obs" from ORGANIZACION.OBJETIVOSVENTA where "Codigo" = <<lxObjetivosventaCodigo>> and  OBJETIVOSVENTA.CODIGO != 0
			endtext
			use in select('c_OBJETIVOSVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OBJETIVOSVENTA', set( 'Datasession' ) )

			if reccount( 'c_OBJETIVOSVENTA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxObjetivosventaCodigo as Variant
		llRetorno = .t.
		lxObjetivosventaCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.OBJETIVOSVENTA where "Codigo" = <<lxObjetivosventaCodigo>> and  OBJETIVOSVENTA.CODIGO != 0
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
				lcOrden =  str( .Codigo, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Clave" as "Clave", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Nombre" as "Nombre", "Regpor" as "Registradopor", "Sucursal" as "Sucursal", "Faltafw" as "Fechaaltafw", "Serie" as "Serie", "Tipoobj" as "Tipoobj", "Bd" as "Bd", "Monto" as "Monto", "Desde" as "Vigenciadesde", "Hasta" as "Vigenciahasta", "Obs" as "Obs" from ORGANIZACION.OBJETIVOSVENTA where  OBJETIVOSVENTA.CODIGO != 0 order by codigo
			endtext
			use in select('c_OBJETIVOSVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OBJETIVOSVENTA', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Clave" as "Clave", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Nombre" as "Nombre", "Regpor" as "Registradopor", "Sucursal" as "Sucursal", "Faltafw" as "Fechaaltafw", "Serie" as "Serie", "Tipoobj" as "Tipoobj", "Bd" as "Bd", "Monto" as "Monto", "Desde" as "Vigenciadesde", "Hasta" as "Vigenciahasta", "Obs" as "Obs" from ORGANIZACION.OBJETIVOSVENTA where  str( codigo, 10, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  OBJETIVOSVENTA.CODIGO != 0 order by codigo
			endtext
			use in select('c_OBJETIVOSVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OBJETIVOSVENTA', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Clave" as "Clave", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Nombre" as "Nombre", "Regpor" as "Registradopor", "Sucursal" as "Sucursal", "Faltafw" as "Fechaaltafw", "Serie" as "Serie", "Tipoobj" as "Tipoobj", "Bd" as "Bd", "Monto" as "Monto", "Desde" as "Vigenciadesde", "Hasta" as "Vigenciahasta", "Obs" as "Obs" from ORGANIZACION.OBJETIVOSVENTA where  str( codigo, 10, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  OBJETIVOSVENTA.CODIGO != 0 order by codigo desc
			endtext
			use in select('c_OBJETIVOSVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OBJETIVOSVENTA', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 10, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Clave" as "Clave", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Nombre" as "Nombre", "Regpor" as "Registradopor", "Sucursal" as "Sucursal", "Faltafw" as "Fechaaltafw", "Serie" as "Serie", "Tipoobj" as "Tipoobj", "Bd" as "Bd", "Monto" as "Monto", "Desde" as "Vigenciadesde", "Hasta" as "Vigenciahasta", "Obs" as "Obs" from ORGANIZACION.OBJETIVOSVENTA where  OBJETIVOSVENTA.CODIGO != 0 order by codigo desc
			endtext
			use in select('c_OBJETIVOSVENTA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OBJETIVOSVENTA', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.CODIGO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fecimpo,Fmodifw,Fecexpo,Horaexpo,Zadsfw,Horaimpo,Saltafw,Hmodifw,Vmodifw,Umodifw,Ua" + ;
"ltafw,Valtafw,Smodifw,Bdaltafw,Esttrans,Clave,Bdmodifw,Codigo,Haltafw,Nombre,Regpor,Sucursal,Faltafw" + ;
",Serie,Tipoobj,Bd,Monto,Desde,Hasta,Obs" + ;
" from ORGANIZACION.OBJETIVOSVENTA where  OBJETIVOSVENTA.CODIGO != 0 and " + lcFiltro )
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
			local  lxObjetivosventaFectrans, lxObjetivosventaFecimpo, lxObjetivosventaFmodifw, lxObjetivosventaFecexpo, lxObjetivosventaHoraexpo, lxObjetivosventaZadsfw, lxObjetivosventaHoraimpo, lxObjetivosventaSaltafw, lxObjetivosventaHmodifw, lxObjetivosventaVmodifw, lxObjetivosventaUmodifw, lxObjetivosventaUaltafw, lxObjetivosventaValtafw, lxObjetivosventaSmodifw, lxObjetivosventaBdaltafw, lxObjetivosventaEsttrans, lxObjetivosventaClave, lxObjetivosventaBdmodifw, lxObjetivosventaCodigo, lxObjetivosventaHaltafw, lxObjetivosventaNombre, lxObjetivosventaRegpor, lxObjetivosventaSucursal, lxObjetivosventaFaltafw, lxObjetivosventaSerie, lxObjetivosventaTipoobj, lxObjetivosventaBd, lxObjetivosventaMonto, lxObjetivosventaDesde, lxObjetivosventaHasta, lxObjetivosventaObs
				lxObjetivosventaFectrans = ctod( '  /  /    ' )			lxObjetivosventaFecimpo = ctod( '  /  /    ' )			lxObjetivosventaFmodifw = ctod( '  /  /    ' )			lxObjetivosventaFecexpo = ctod( '  /  /    ' )			lxObjetivosventaHoraexpo = []			lxObjetivosventaZadsfw = []			lxObjetivosventaHoraimpo = []			lxObjetivosventaSaltafw = []			lxObjetivosventaHmodifw = []			lxObjetivosventaVmodifw = []			lxObjetivosventaUmodifw = []			lxObjetivosventaUaltafw = []			lxObjetivosventaValtafw = []			lxObjetivosventaSmodifw = []			lxObjetivosventaBdaltafw = []			lxObjetivosventaEsttrans = []			lxObjetivosventaClave = []			lxObjetivosventaBdmodifw = []			lxObjetivosventaCodigo = 0			lxObjetivosventaHaltafw = []			lxObjetivosventaNombre = []			lxObjetivosventaRegpor = []			lxObjetivosventaSucursal = []			lxObjetivosventaFaltafw = ctod( '  /  /    ' )			lxObjetivosventaSerie = []			lxObjetivosventaTipoobj = []			lxObjetivosventaBd = []			lxObjetivosventaMonto = 0			lxObjetivosventaDesde = ctod( '  /  /    ' )			lxObjetivosventaHasta = ctod( '  /  /    ' )			lxObjetivosventaObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.OBJETIVOSVENTA where "codigo" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'OBJETIVOSVENTA' + '_' + tcCampo
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
		lcWhere = " Where  OBJETIVOSVENTA.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Clave" as "Clave", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Nombre" as "Nombre", "Regpor" as "Registradopor", "Sucursal" as "Sucursal", "Faltafw" as "Fechaaltafw", "Serie" as "Serie", "Tipoobj" as "Tipoobj", "Bd" as "Bd", "Monto" as "Monto", "Desde" as "Vigenciadesde", "Hasta" as "Vigenciahasta", "Obs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'OBJETIVOSVENTA', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CLAVE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAVE AS CLAVE'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMBRE AS NOMBRE'
				Case lcAtributo == 'REGISTRADOPOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGPOR AS REGISTRADOPOR'
				Case lcAtributo == 'SUCURSAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUCURSAL AS SUCURSAL'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS SERIE'
				Case lcAtributo == 'TIPOOBJ'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOOBJ AS TIPOOBJ'
				Case lcAtributo == 'BD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BD AS BD'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'VIGENCIADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESDE AS VIGENCIADESDE'
				Case lcAtributo == 'VIGENCIAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HASTA AS VIGENCIAHASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CLAVE'
				lcCampo = 'CLAVE'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'NOMBRE'
			Case upper( alltrim( tcAtributo ) ) == 'REGISTRADOPOR'
				lcCampo = 'REGPOR'
			Case upper( alltrim( tcAtributo ) ) == 'SUCURSAL'
				lcCampo = 'SUCURSAL'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIE'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOOBJ'
				lcCampo = 'TIPOOBJ'
			Case upper( alltrim( tcAtributo ) ) == 'BD'
				lcCampo = 'BD'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIADESDE'
				lcCampo = 'DESDE'
			Case upper( alltrim( tcAtributo ) ) == 'VIGENCIAHASTA'
				lcCampo = 'HASTA'
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
			local  lxObjetivosventaFectrans, lxObjetivosventaFecimpo, lxObjetivosventaFmodifw, lxObjetivosventaFecexpo, lxObjetivosventaHoraexpo, lxObjetivosventaZadsfw, lxObjetivosventaHoraimpo, lxObjetivosventaSaltafw, lxObjetivosventaHmodifw, lxObjetivosventaVmodifw, lxObjetivosventaUmodifw, lxObjetivosventaUaltafw, lxObjetivosventaValtafw, lxObjetivosventaSmodifw, lxObjetivosventaBdaltafw, lxObjetivosventaEsttrans, lxObjetivosventaClave, lxObjetivosventaBdmodifw, lxObjetivosventaCodigo, lxObjetivosventaHaltafw, lxObjetivosventaNombre, lxObjetivosventaRegpor, lxObjetivosventaSucursal, lxObjetivosventaFaltafw, lxObjetivosventaSerie, lxObjetivosventaTipoobj, lxObjetivosventaBd, lxObjetivosventaMonto, lxObjetivosventaDesde, lxObjetivosventaHasta, lxObjetivosventaObs
				lxObjetivosventaFectrans =  .Fechatransferencia			lxObjetivosventaFecimpo =  .Fechaimpo			lxObjetivosventaFmodifw =  .Fechamodificacionfw			lxObjetivosventaFecexpo =  .Fechaexpo			lxObjetivosventaHoraexpo =  .Horaexpo			lxObjetivosventaZadsfw =  .Zadsfw			lxObjetivosventaHoraimpo =  .Horaimpo			lxObjetivosventaSaltafw =  .Seriealtafw			lxObjetivosventaHmodifw =  .Horamodificacionfw			lxObjetivosventaVmodifw =  .Versionmodificacionfw			lxObjetivosventaUmodifw =  .Usuariomodificacionfw			lxObjetivosventaUaltafw =  .Usuarioaltafw			lxObjetivosventaValtafw =  .Versionaltafw			lxObjetivosventaSmodifw =  .Seriemodificacionfw			lxObjetivosventaBdaltafw =  .Basededatosaltafw			lxObjetivosventaEsttrans =  .Estadotransferencia			lxObjetivosventaClave =  .Clave			lxObjetivosventaBdmodifw =  .Basededatosmodificacionfw			lxObjetivosventaCodigo =  .Codigo			lxObjetivosventaHaltafw =  .Horaaltafw			lxObjetivosventaNombre =  .Nombre			lxObjetivosventaRegpor =  .Registradopor			lxObjetivosventaSucursal =  upper( .Sucursal_PK ) 			lxObjetivosventaFaltafw =  .Fechaaltafw			lxObjetivosventaSerie =  .Serie			lxObjetivosventaTipoobj =  upper( .TipoObj_PK ) 			lxObjetivosventaBd =  .Bd			lxObjetivosventaMonto =  .Monto			lxObjetivosventaDesde =  .Vigenciadesde			lxObjetivosventaHasta =  .Vigenciahasta			lxObjetivosventaObs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.OBJETIVOSVENTA ( "Fectrans","Fecimpo","Fmodifw","Fecexpo","Horaexpo","Zadsfw","Horaimpo","Saltafw","Hmodifw","Vmodifw","Umodifw","Ualtafw","Valtafw","Smodifw","Bdaltafw","Esttrans","Clave","Bdmodifw","Codigo","Haltafw","Nombre","Regpor","Sucursal","Faltafw","Serie","Tipoobj","Bd","Monto","Desde","Hasta","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxObjetivosventaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaClave ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaBdmodifw ) + "'" >>, <<lxObjetivosventaCodigo >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaNombre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaRegpor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaSucursal ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaTipoobj ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaBd ) + "'" >>, <<lxObjetivosventaMonto >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaDesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxObjetivosventaHasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxObjetivosventaObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'OBJETIVOSVENTA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxObjetivosventaFectrans, lxObjetivosventaFecimpo, lxObjetivosventaFmodifw, lxObjetivosventaFecexpo, lxObjetivosventaHoraexpo, lxObjetivosventaZadsfw, lxObjetivosventaHoraimpo, lxObjetivosventaSaltafw, lxObjetivosventaHmodifw, lxObjetivosventaVmodifw, lxObjetivosventaUmodifw, lxObjetivosventaUaltafw, lxObjetivosventaValtafw, lxObjetivosventaSmodifw, lxObjetivosventaBdaltafw, lxObjetivosventaEsttrans, lxObjetivosventaClave, lxObjetivosventaBdmodifw, lxObjetivosventaCodigo, lxObjetivosventaHaltafw, lxObjetivosventaNombre, lxObjetivosventaRegpor, lxObjetivosventaSucursal, lxObjetivosventaFaltafw, lxObjetivosventaSerie, lxObjetivosventaTipoobj, lxObjetivosventaBd, lxObjetivosventaMonto, lxObjetivosventaDesde, lxObjetivosventaHasta, lxObjetivosventaObs
				lxObjetivosventaFectrans =  .Fechatransferencia			lxObjetivosventaFecimpo =  .Fechaimpo			lxObjetivosventaFmodifw =  .Fechamodificacionfw			lxObjetivosventaFecexpo =  .Fechaexpo			lxObjetivosventaHoraexpo =  .Horaexpo			lxObjetivosventaZadsfw =  .Zadsfw			lxObjetivosventaHoraimpo =  .Horaimpo			lxObjetivosventaSaltafw =  .Seriealtafw			lxObjetivosventaHmodifw =  .Horamodificacionfw			lxObjetivosventaVmodifw =  .Versionmodificacionfw			lxObjetivosventaUmodifw =  .Usuariomodificacionfw			lxObjetivosventaUaltafw =  .Usuarioaltafw			lxObjetivosventaValtafw =  .Versionaltafw			lxObjetivosventaSmodifw =  .Seriemodificacionfw			lxObjetivosventaBdaltafw =  .Basededatosaltafw			lxObjetivosventaEsttrans =  .Estadotransferencia			lxObjetivosventaClave =  .Clave			lxObjetivosventaBdmodifw =  .Basededatosmodificacionfw			lxObjetivosventaCodigo =  .Codigo			lxObjetivosventaHaltafw =  .Horaaltafw			lxObjetivosventaNombre =  .Nombre			lxObjetivosventaRegpor =  .Registradopor			lxObjetivosventaSucursal =  upper( .Sucursal_PK ) 			lxObjetivosventaFaltafw =  .Fechaaltafw			lxObjetivosventaSerie =  .Serie			lxObjetivosventaTipoobj =  upper( .TipoObj_PK ) 			lxObjetivosventaBd =  .Bd			lxObjetivosventaMonto =  .Monto			lxObjetivosventaDesde =  .Vigenciadesde			lxObjetivosventaHasta =  .Vigenciahasta			lxObjetivosventaObs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  OBJETIVOSVENTA.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ORGANIZACION.OBJETIVOSVENTA set "Fectrans" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFecexpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxObjetivosventaHoraexpo ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaZadsfw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxObjetivosventaHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaValtafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaSmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxObjetivosventaEsttrans ) + "'">>, "Clave" = <<"'" + this.FormatearTextoSql( lxObjetivosventaClave ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaBdmodifw ) + "'">>, "Codigo" = <<lxObjetivosventaCodigo>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxObjetivosventaHaltafw ) + "'">>, "Nombre" = <<"'" + this.FormatearTextoSql( lxObjetivosventaNombre ) + "'">>, "Regpor" = <<"'" + this.FormatearTextoSql( lxObjetivosventaRegpor ) + "'">>, "Sucursal" = <<"'" + this.FormatearTextoSql( lxObjetivosventaSucursal ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxObjetivosventaFaltafw ) + "'">>, "Serie" = <<"'" + this.FormatearTextoSql( lxObjetivosventaSerie ) + "'">>, "Tipoobj" = <<"'" + this.FormatearTextoSql( lxObjetivosventaTipoobj ) + "'">>, "Bd" = <<"'" + this.FormatearTextoSql( lxObjetivosventaBd ) + "'">>, "Monto" = <<lxObjetivosventaMonto>>, "Desde" = <<"'" + this.ConvertirDateSql( lxObjetivosventaDesde ) + "'">>, "Hasta" = <<"'" + this.ConvertirDateSql( lxObjetivosventaHasta ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxObjetivosventaObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'OBJETIVOSVENTA' 
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
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  OBJETIVOSVENTA.CODIGO != 0]
		loColeccion.Agregar( 'delete from ORGANIZACION.OBJETIVOSVENTA where ' + lcFiltro )
			loColeccion.cTabla = 'OBJETIVOSVENTA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.OBJETIVOSVENTA where  OBJETIVOSVENTA.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.OBJETIVOSVENTA where codigo = " + transform( this.oEntidad.CODIGO )+ " and  OBJETIVOSVENTA.CODIGO != 0" )
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
					if empty( .oNumeraciones.ObtenerServicio('CODIGO') ) and iif( type( '.CODIGO' ) = 'C', int( val( .CODIGO ) ),.CODIGO ) = .oNumeraciones.UltimoNumero( 'CODIGO' )
						.oNumeraciones.Actualizar( 'CODIGO' )
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
					.CODIGO = .oNumeraciones.grabar( 'CODIGO' )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'OBJETIVOSVENTA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.OBJETIVOSVENTA Where codigo = ] + transform( &lcCursor..codigo ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.OBJETIVOSVENTA set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, clave = ] + "'" + this.FormatearTextoSql( &lcCursor..clave ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, codigo = ] + transform( &lcCursor..codigo )+ [, nombre = ] + "'" + this.FormatearTextoSql( &lcCursor..nombre ) + "'"+ [, regPor = ] + "'" + this.FormatearTextoSql( &lcCursor..regPor ) + "'"+ [, sucursal = ] + "'" + this.FormatearTextoSql( &lcCursor..sucursal ) + "'"+ [, serie = ] + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'"+ [, tipoObj = ] + "'" + this.FormatearTextoSql( &lcCursor..tipoObj ) + "'"+ [, bd = ] + "'" + this.FormatearTextoSql( &lcCursor..bd ) + "'"+ [, monto = ] + transform( &lcCursor..monto )+ [, desde = ] + "'" + this.ConvertirDateSql( &lcCursor..desde ) + "'"+ [, hasta = ] + "'" + this.ConvertirDateSql( &lcCursor..hasta ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where codigo = ] + transform( &lcCursor..codigo ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FECIMPO, FMODIFW, FECEXPO, HORAEXPO, ZADSFW, HORAIMPO, SALTAFW, HMODIFW, VMODIFW, UMODIFW, UALTAFW, VALTAFW, SMODIFW, BDALTAFW, ESTTRANS, clave, BDMODIFW, codigo, HAltaFW, nombre, regPor, sucursal, FAltaFW, serie, tipoObj, bd, monto, desde, hasta, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..clave ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..codigo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..nombre ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..regPor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..sucursal ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipoObj ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..bd ) + "'" + ',' + transform( &lcCursor..monto )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..desde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..hasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.OBJETIVOSVENTA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'OBJETIVOSVENTA'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo N (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'OBJETIVOSVENTA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'OBJETIVOSVENTA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'OBJETIVOSVENTA_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_OBJETIVOSVENTA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'OBJETIVOSVENTA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad OBJETIVOSVENTA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'OBJETIVOSVENTA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'OBJETIVOSVENTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  desde     
		* Validar ANTERIORES A 1/1/1753  hasta     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_OBJETIVOSVENTA') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_OBJETIVOSVENTA
Create Table ORGANIZACION.TablaTrabajo_OBJETIVOSVENTA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"clave" char( 38 )  null, 
"bdmodifw" char( 8 )  null, 
"codigo" numeric( 10, 0 )  null, 
"haltafw" char( 8 )  null, 
"nombre" char( 150 )  null, 
"regpor" char( 100 )  null, 
"sucursal" char( 10 )  null, 
"faltafw" datetime  null, 
"serie" char( 6 )  null, 
"tipoobj" char( 10 )  null, 
"bd" char( 8 )  null, 
"monto" numeric( 15, 2 )  null, 
"desde" datetime  null, 
"hasta" datetime  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_OBJETIVOSVENTA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_OBJETIVOSVENTA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'OBJETIVOSVENTA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('clave','clave')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('nombre','nombre')
			.AgregarMapeo('regpor','regpor')
			.AgregarMapeo('sucursal','sucursal')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('tipoobj','tipoobj')
			.AgregarMapeo('bd','bd')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('desde','desde')
			.AgregarMapeo('hasta','hasta')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_OBJETIVOSVENTA'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CLAVE = isnull( d.CLAVE, t.CLAVE ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.NOMBRE = isnull( d.NOMBRE, t.NOMBRE ),t.REGPOR = isnull( d.REGPOR, t.REGPOR ),t.SUCURSAL = isnull( d.SUCURSAL, t.SUCURSAL ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.TIPOOBJ = isnull( d.TIPOOBJ, t.TIPOOBJ ),t.BD = isnull( d.BD, t.BD ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.DESDE = isnull( d.DESDE, t.DESDE ),t.HASTA = isnull( d.HASTA, t.HASTA ),t.OBS = isnull( d.OBS, t.OBS )
					from ORGANIZACION.OBJETIVOSVENTA t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ORGANIZACION.OBJETIVOSVENTA(Fectrans,Fecimpo,Fmodifw,Fecexpo,Horaexpo,Zadsfw,Horaimpo,Saltafw,Hmodifw,Vmodifw,Umodifw,Ualtafw,Valtafw,Smodifw,Bdaltafw,Esttrans,Clave,Bdmodifw,Codigo,Haltafw,Nombre,Regpor,Sucursal,Faltafw,Serie,Tipoobj,Bd,Monto,Desde,Hasta,Obs)
					Select isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.HORAEXPO,''),isnull( d.ZADSFW,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.SMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CLAVE,''),isnull( d.BDMODIFW,''),isnull( d.CODIGO,0),convert( char(8), getdate(), 108 ),isnull( d.NOMBRE,''),isnull( d.REGPOR,''),isnull( d.SUCURSAL,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.SERIE,''),isnull( d.TIPOOBJ,''),isnull( d.BD,''),isnull( d.MONTO,0),isnull( d.DESDE,''),isnull( d.HASTA,''),isnull( d.OBS,'')
						From deleted d left join ORGANIZACION.OBJETIVOSVENTA pk 
							 on d.codigo = pk.codigo
						Where pk.codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_OBJETIVOSVENTA') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_OBJETIVOSVENTA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_OBJETIVOSVENTA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_OBJETIVOSVENTA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_OBJETIVOSVENTA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_OBJETIVOSVENTA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_OBJETIVOSVENTA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_OBJETIVOSVENTA.Horaexpo, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaimpo = nvl( c_OBJETIVOSVENTA.Horaimpo, [] )
					.Seriealtafw = nvl( c_OBJETIVOSVENTA.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_OBJETIVOSVENTA.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_OBJETIVOSVENTA.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_OBJETIVOSVENTA.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_OBJETIVOSVENTA.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_OBJETIVOSVENTA.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_OBJETIVOSVENTA.Seriemodificacionfw, [] )
					.Basededatosaltafw = nvl( c_OBJETIVOSVENTA.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_OBJETIVOSVENTA.Estadotransferencia, [] )
					.Clave = nvl( c_OBJETIVOSVENTA.Clave, [] )
					.Basededatosmodificacionfw = nvl( c_OBJETIVOSVENTA.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_OBJETIVOSVENTA.Codigo, 0 )
					.Horaaltafw = nvl( c_OBJETIVOSVENTA.Horaaltafw, [] )
					.Nombre = nvl( c_OBJETIVOSVENTA.Nombre, [] )
					.Registradopor = nvl( c_OBJETIVOSVENTA.Registradopor, [] )
					.Sucursal_PK =  nvl( c_OBJETIVOSVENTA.Sucursal, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_OBJETIVOSVENTA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Serie = nvl( c_OBJETIVOSVENTA.Serie, [] )
					.Tipoobj_PK =  nvl( c_OBJETIVOSVENTA.Tipoobj, [] )
					.Bd = nvl( c_OBJETIVOSVENTA.Bd, [] )
					.Monto = nvl( c_OBJETIVOSVENTA.Monto, 0 )
					.Vigenciadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_OBJETIVOSVENTA.Vigenciadesde, ctod( '  /  /    ' ) ) )
					.Vigenciahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_OBJETIVOSVENTA.Vigenciahasta, ctod( '  /  /    ' ) ) )
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
		return c_OBJETIVOSVENTA.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.OBJETIVOSVENTA' )
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
								from ORGANIZACION.OBJETIVOSVENTA 
								Where   OBJETIVOSVENTA.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "OBJETIVOSVENTA", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Horaexpo" as "Horaexpo", "Zadsfw" as "Zadsfw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Clave" as "Clave", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Nombre" as "Nombre", "Regpor" as "Registradopor", "Sucursal" as "Sucursal", "Faltafw" as "Fechaaltafw", "Serie" as "Serie", "Tipoobj" as "Tipoobj", "Bd" as "Bd", "Monto" as "Monto", "Desde" as "Vigenciadesde", "Hasta" as "Vigenciahasta", "Obs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.OBJETIVOSVENTA 
								Where   OBJETIVOSVENTA.CODIGO != 0
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
	Tabla = 'OBJETIVOSVENTA'
	Filtro = " OBJETIVOSVENTA.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " OBJETIVOSVENTA.CODIGO != 0"
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
	<row entidad="OBJETIVOSVENTA                          " atributo="FECHATRANSFERENCIA                      " tabla="OBJETIVOSVENTA " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="FECHAIMPO                               " tabla="OBJETIVOSVENTA " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="FECHAMODIFICACIONFW                     " tabla="OBJETIVOSVENTA " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="FECHAEXPO                               " tabla="OBJETIVOSVENTA " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="HORAEXPO                                " tabla="OBJETIVOSVENTA " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="ZADSFW                                  " tabla="OBJETIVOSVENTA " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="HORAIMPO                                " tabla="OBJETIVOSVENTA " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="SERIEALTAFW                             " tabla="OBJETIVOSVENTA " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="HORAMODIFICACIONFW                      " tabla="OBJETIVOSVENTA " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="VERSIONMODIFICACIONFW                   " tabla="OBJETIVOSVENTA " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="USUARIOMODIFICACIONFW                   " tabla="OBJETIVOSVENTA " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="USUARIOALTAFW                           " tabla="OBJETIVOSVENTA " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="VERSIONALTAFW                           " tabla="OBJETIVOSVENTA " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="SERIEMODIFICACIONFW                     " tabla="OBJETIVOSVENTA " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="BASEDEDATOSALTAFW                       " tabla="OBJETIVOSVENTA " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="ESTADOTRANSFERENCIA                     " tabla="OBJETIVOSVENTA " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="CLAVE                                   " tabla="OBJETIVOSVENTA " campo="CLAVE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="=goLibrerias.ObtenerGuidPK()                                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="OBJETIVOSVENTA " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="BASEDEDATOS                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="BASEDEDATOS                             " tipodato="C         " longitud="8" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="BaseDeDatos                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="CODIGO                                  " tabla="OBJETIVOSVENTA " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código número                                                                                                                                                   " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="HORAALTAFW                              " tabla="OBJETIVOSVENTA " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="NOMBRE                                  " tabla="OBJETIVOSVENTA " campo="NOMBRE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Nombre                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="REGISTRADOPOR                           " tabla="OBJETIVOSVENTA " campo="REGPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="0" etiqueta="Registrado por                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="SUCURSAL                                " tabla="OBJETIVOSVENTA " campo="SUCURSAL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="=this.Basededatos.Sucursal_PK                                                                                                                                                                                                                                 " obligatorio="true" admitebusqueda="402" etiqueta="Sucursal                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="FECHAALTAFW                             " tabla="OBJETIVOSVENTA " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Fecha de alta                                                                                                                                                   " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="SERIE                                   " tabla="OBJETIVOSVENTA " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="=_screen.zoo.app.cSerie                                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="0" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="TIPOOBJ                                 " tabla="OBJETIVOSVENTA " campo="TIPOOBJ   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOOBJETIVO                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Tipo                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="BD                                      " tabla="OBJETIVOSVENTA " campo="BD        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="MONTO                                   " tabla="OBJETIVOSVENTA " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="408" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="VIGENCIADESDE                           " tabla="OBJETIVOSVENTA " campo="DESDE     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="410" etiqueta="Desde                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="VIGENCIAHASTA                           " tabla="OBJETIVOSVENTA " campo="HASTA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="412" etiqueta="Hasta                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OBJETIVOSVENTA                          " atributo="OBS                                     " tabla="OBJETIVOSVENTA " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="403" etiqueta="Detalle Suc.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SUC On OBJETIVOSVENTA.SUCURSAL = SUC.codigo And  SUC.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOOBJETIVO                            " atributo="DESCRIPCION                             " tabla="TIPOOBJ        " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOOBJ On OBJETIVOSVENTA.TIPOOBJ = TIPOOBJ.codigo And  TIPOOBJ.CODIGO != ''                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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