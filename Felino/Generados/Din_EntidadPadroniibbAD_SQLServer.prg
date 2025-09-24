
define class Din_EntidadPADRONIIBBAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PADRONIIBB'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [CODIGOCLIENTE + JURISDICCION]
	cExpresionCCPorCampos = [#tabla#.COD + #tabla#.JURISDICCI]
	cTagClaveCandidata = '_IIBCC'
	cTagClavePk = '_IIBPK'
	cTablaPrincipal = 'PERCLIDET'
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
			local  lxPerclidetFecexpo, lxPerclidetFectrans, lxPerclidetFmodifw, lxPerclidetFaltafw, lxPerclidetFecimpo, lxPerclidetUaltafw, lxPerclidetSaltafw, lxPerclidetSmodifw, lxPerclidetHmodifw, lxPerclidetUmodifw, lxPerclidetZadsfw, lxPerclidetValtafw, lxPerclidetVmodifw, lxPerclidetHoraimpo, lxPerclidetBdmodifw, lxPerclidetBdaltafw, lxPerclidetEsttrans, lxPerclidetHoraexpo, lxPerclidetHaltafw, lxPerclidetCodigo, lxPerclidetJurisdicci, lxPerclidetCuit, lxPerclidetPorcen, lxPerclidetFecexp, lxPerclidetCod, lxPerclidetDesjur, lxPerclidetNroitem
				lxPerclidetFecexpo =  .Fechaexpo			lxPerclidetFectrans =  .Fechatransferencia			lxPerclidetFmodifw =  .Fechamodificacionfw			lxPerclidetFaltafw =  .Fechaaltafw			lxPerclidetFecimpo =  .Fechaimpo			lxPerclidetUaltafw =  .Usuarioaltafw			lxPerclidetSaltafw =  .Seriealtafw			lxPerclidetSmodifw =  .Seriemodificacionfw			lxPerclidetHmodifw =  .Horamodificacionfw			lxPerclidetUmodifw =  .Usuariomodificacionfw			lxPerclidetZadsfw =  .Zadsfw			lxPerclidetValtafw =  .Versionaltafw			lxPerclidetVmodifw =  .Versionmodificacionfw			lxPerclidetHoraimpo =  .Horaimpo			lxPerclidetBdmodifw =  .Basededatosmodificacionfw			lxPerclidetBdaltafw =  .Basededatosaltafw			lxPerclidetEsttrans =  .Estadotransferencia			lxPerclidetHoraexpo =  .Horaexpo			lxPerclidetHaltafw =  .Horaaltafw			lxPerclidetCodigo =  .Codigo			lxPerclidetJurisdicci =  upper( .JURISDICCION_PK ) 			lxPerclidetCuit =  .Cuit			lxPerclidetPorcen =  .Porcentaje			lxPerclidetFecexp =  .Fechaexpiracion			lxPerclidetCod =  .Codigocliente			lxPerclidetDesjur =  .Descripcion			lxPerclidetNroitem =  .Nroitem
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxPerclidetCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PERCLIDET ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Ualtafw","Saltafw","Smodifw","Hmodifw","Umodifw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Bdmodifw","Bdaltafw","Esttrans","Horaexpo","Haltafw","Codigo","Jurisdicci","Cuit","Porcen","Fecexp","Cod","Desjur","Nroitem" ) values ( <<"'" + this.ConvertirDateSql( lxPerclidetFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPerclidetFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPerclidetFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPerclidetFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPerclidetFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetJurisdicci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetCuit ) + "'" >>, <<lxPerclidetPorcen >>, <<"'" + this.ConvertirDateSql( lxPerclidetFecexp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetCod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetDesjur ) + "'" >>, <<lxPerclidetNroitem >> )
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
			local  lxPerclidetFecexpo, lxPerclidetFectrans, lxPerclidetFmodifw, lxPerclidetFaltafw, lxPerclidetFecimpo, lxPerclidetUaltafw, lxPerclidetSaltafw, lxPerclidetSmodifw, lxPerclidetHmodifw, lxPerclidetUmodifw, lxPerclidetZadsfw, lxPerclidetValtafw, lxPerclidetVmodifw, lxPerclidetHoraimpo, lxPerclidetBdmodifw, lxPerclidetBdaltafw, lxPerclidetEsttrans, lxPerclidetHoraexpo, lxPerclidetHaltafw, lxPerclidetCodigo, lxPerclidetJurisdicci, lxPerclidetCuit, lxPerclidetPorcen, lxPerclidetFecexp, lxPerclidetCod, lxPerclidetDesjur, lxPerclidetNroitem
				lxPerclidetFecexpo =  .Fechaexpo			lxPerclidetFectrans =  .Fechatransferencia			lxPerclidetFmodifw =  .Fechamodificacionfw			lxPerclidetFaltafw =  .Fechaaltafw			lxPerclidetFecimpo =  .Fechaimpo			lxPerclidetUaltafw =  .Usuarioaltafw			lxPerclidetSaltafw =  .Seriealtafw			lxPerclidetSmodifw =  .Seriemodificacionfw			lxPerclidetHmodifw =  .Horamodificacionfw			lxPerclidetUmodifw =  .Usuariomodificacionfw			lxPerclidetZadsfw =  .Zadsfw			lxPerclidetValtafw =  .Versionaltafw			lxPerclidetVmodifw =  .Versionmodificacionfw			lxPerclidetHoraimpo =  .Horaimpo			lxPerclidetBdmodifw =  .Basededatosmodificacionfw			lxPerclidetBdaltafw =  .Basededatosaltafw			lxPerclidetEsttrans =  .Estadotransferencia			lxPerclidetHoraexpo =  .Horaexpo			lxPerclidetHaltafw =  .Horaaltafw			lxPerclidetCodigo =  .Codigo			lxPerclidetJurisdicci =  upper( .JURISDICCION_PK ) 			lxPerclidetCuit =  .Cuit			lxPerclidetPorcen =  .Porcentaje			lxPerclidetFecexp =  .Fechaexpiracion			lxPerclidetCod =  .Codigocliente			lxPerclidetDesjur =  .Descripcion			lxPerclidetNroitem =  .Nroitem
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.PERCLIDET set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPerclidetFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxPerclidetFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxPerclidetFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxPerclidetFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxPerclidetFecimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxPerclidetUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxPerclidetSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetHmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxPerclidetZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxPerclidetValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxPerclidetHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPerclidetBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxPerclidetEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxPerclidetHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxPerclidetHaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxPerclidetCodigo ) + "'">>,"Jurisdicci" = <<"'" + this.FormatearTextoSql( lxPerclidetJurisdicci ) + "'">>,"Cuit" = <<"'" + this.FormatearTextoSql( lxPerclidetCuit ) + "'">>,"Porcen" = <<lxPerclidetPorcen>>,"Fecexp" = <<"'" + this.ConvertirDateSql( lxPerclidetFecexp ) + "'">>,"Cod" = <<"'" + this.FormatearTextoSql( lxPerclidetCod ) + "'">>,"Desjur" = <<"'" + this.FormatearTextoSql( lxPerclidetDesjur ) + "'">>,"Nroitem" = <<lxPerclidetNroitem>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxPerclidetCodigo ) + "'">> and  PERCLIDET.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.PERCLIDET where " + this.ConvertirFuncionesSql( " PERCLIDET.CODIGO != ''" ) )
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
			Local lxPerclidetCodigo
			lxPerclidetCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Cuit" as "Cuit", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Cod" as "Codigocliente", "Desjur" as "Descripcion", "Nroitem" as "Nroitem" from ZooLogic.PERCLIDET where "Codigo" = <<"'" + this.FormatearTextoSql( lxPerclidetCodigo ) + "'">> and  PERCLIDET.CODIGO != ''
			endtext
			use in select('c_PADRONIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PADRONIIBB', set( 'Datasession' ) )

			if reccount( 'c_PADRONIIBB' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxPerCliDetCOD As Variant, lxPerCliDetJURISDICCI As Variant
			lxPerCliDetCOD = .CODIGOCLIENTE
			lxPerCliDetJURISDICCI = .JURISDICCION_Pk
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Cuit" as "Cuit", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Cod" as "Codigocliente", "Desjur" as "Descripcion", "Nroitem" as "Nroitem" from ZooLogic.PERCLIDET where  PERCLIDET.CODIGO != '' And COD = <<"'" + this.FormatearTextoSql( lxPerCliDetCOD ) + "'">> and JURISDICCI = <<"'" + this.FormatearTextoSql( lxPerCliDetJURISDICCI ) + "'">>
			endtext
			use in select('c_PADRONIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PADRONIIBB', set( 'Datasession' ) )
			if reccount( 'c_PADRONIIBB' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxPerclidetCodigo as Variant
		llRetorno = .t.
		lxPerclidetCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PERCLIDET where "Codigo" = <<"'" + this.FormatearTextoSql( lxPerclidetCodigo ) + "'">> and  PERCLIDET.CODIGO != ''
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
				lcOrden =  .CODIGOCLIENTE + .JURISDICCION_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Cuit" as "Cuit", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Cod" as "Codigocliente", "Desjur" as "Descripcion", "Nroitem" as "Nroitem" from ZooLogic.PERCLIDET where  PERCLIDET.CODIGO != '' order by COD,JURISDICCI
			endtext
			use in select('c_PADRONIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PADRONIIBB', set( 'Datasession' ) )
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
				lcOrden =  .CODIGOCLIENTE + .JURISDICCION_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Cuit" as "Cuit", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Cod" as "Codigocliente", "Desjur" as "Descripcion", "Nroitem" as "Nroitem" from ZooLogic.PERCLIDET where  funciones.padr( COD, 5, ' ' ) + funciones.padr( JURISDICCI, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PERCLIDET.CODIGO != '' order by COD,JURISDICCI
			endtext
			use in select('c_PADRONIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PADRONIIBB', set( 'Datasession' ) )
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
				lcOrden =  .CODIGOCLIENTE + .JURISDICCION_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Cuit" as "Cuit", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Cod" as "Codigocliente", "Desjur" as "Descripcion", "Nroitem" as "Nroitem" from ZooLogic.PERCLIDET where  funciones.padr( COD, 5, ' ' ) + funciones.padr( JURISDICCI, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PERCLIDET.CODIGO != '' order by COD desc,JURISDICCI desc
			endtext
			use in select('c_PADRONIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PADRONIIBB', set( 'Datasession' ) )
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
				lcOrden =  .CODIGOCLIENTE + .JURISDICCION_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Cuit" as "Cuit", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Cod" as "Codigocliente", "Desjur" as "Descripcion", "Nroitem" as "Nroitem" from ZooLogic.PERCLIDET where  PERCLIDET.CODIGO != '' order by COD desc,JURISDICCI desc
			endtext
			use in select('c_PADRONIIBB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PADRONIIBB', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Ualtafw,Saltafw,Smodifw,Hmodifw,Umodifw,Zadsfw,Valt" + ;
"afw,Vmodifw,Horaimpo,Bdmodifw,Bdaltafw,Esttrans,Horaexpo,Haltafw,Codigo,Jurisdicci,Cuit,Porcen,Fecex" + ;
"p,Cod,Desjur,Nroitem" + ;
" from ZooLogic.PERCLIDET where  PERCLIDET.CODIGO != '' and " + lcFiltro )
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
			local  lxPerclidetFecexpo, lxPerclidetFectrans, lxPerclidetFmodifw, lxPerclidetFaltafw, lxPerclidetFecimpo, lxPerclidetUaltafw, lxPerclidetSaltafw, lxPerclidetSmodifw, lxPerclidetHmodifw, lxPerclidetUmodifw, lxPerclidetZadsfw, lxPerclidetValtafw, lxPerclidetVmodifw, lxPerclidetHoraimpo, lxPerclidetBdmodifw, lxPerclidetBdaltafw, lxPerclidetEsttrans, lxPerclidetHoraexpo, lxPerclidetHaltafw, lxPerclidetCodigo, lxPerclidetJurisdicci, lxPerclidetCuit, lxPerclidetPorcen, lxPerclidetFecexp, lxPerclidetCod, lxPerclidetDesjur, lxPerclidetNroitem
				lxPerclidetFecexpo = ctod( '  /  /    ' )			lxPerclidetFectrans = ctod( '  /  /    ' )			lxPerclidetFmodifw = ctod( '  /  /    ' )			lxPerclidetFaltafw = ctod( '  /  /    ' )			lxPerclidetFecimpo = ctod( '  /  /    ' )			lxPerclidetUaltafw = []			lxPerclidetSaltafw = []			lxPerclidetSmodifw = []			lxPerclidetHmodifw = []			lxPerclidetUmodifw = []			lxPerclidetZadsfw = []			lxPerclidetValtafw = []			lxPerclidetVmodifw = []			lxPerclidetHoraimpo = []			lxPerclidetBdmodifw = []			lxPerclidetBdaltafw = []			lxPerclidetEsttrans = []			lxPerclidetHoraexpo = []			lxPerclidetHaltafw = []			lxPerclidetCodigo = []			lxPerclidetJurisdicci = []			lxPerclidetCuit = []			lxPerclidetPorcen = 0			lxPerclidetFecexp = ctod( '  /  /    ' )			lxPerclidetCod = []			lxPerclidetDesjur = []			lxPerclidetNroitem = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PERCLIDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'PERCLIDET' + '_' + tcCampo
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
		lcWhere = " Where  PERCLIDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Cuit" as "Cuit", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Cod" as "Codigocliente", "Desjur" as "Descripcion", "Nroitem" as "Nroitem"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PERCLIDET', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURISDICCI AS JURISDICCION'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUIT AS CUIT'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'FECHAEXPIRACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXP AS FECHAEXPIRACION'
				Case lcAtributo == 'CODIGOCLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGOCLIENTE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESJUR AS DESCRIPCION'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'JURISDICCI'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'CUIT'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPIRACION'
				lcCampo = 'FECEXP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCLIENTE'
				lcCampo = 'COD'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESJUR'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
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
			local  lxPerclidetFecexpo, lxPerclidetFectrans, lxPerclidetFmodifw, lxPerclidetFaltafw, lxPerclidetFecimpo, lxPerclidetUaltafw, lxPerclidetSaltafw, lxPerclidetSmodifw, lxPerclidetHmodifw, lxPerclidetUmodifw, lxPerclidetZadsfw, lxPerclidetValtafw, lxPerclidetVmodifw, lxPerclidetHoraimpo, lxPerclidetBdmodifw, lxPerclidetBdaltafw, lxPerclidetEsttrans, lxPerclidetHoraexpo, lxPerclidetHaltafw, lxPerclidetCodigo, lxPerclidetJurisdicci, lxPerclidetCuit, lxPerclidetPorcen, lxPerclidetFecexp, lxPerclidetCod, lxPerclidetDesjur, lxPerclidetNroitem
				lxPerclidetFecexpo =  .Fechaexpo			lxPerclidetFectrans =  .Fechatransferencia			lxPerclidetFmodifw =  .Fechamodificacionfw			lxPerclidetFaltafw =  .Fechaaltafw			lxPerclidetFecimpo =  .Fechaimpo			lxPerclidetUaltafw =  .Usuarioaltafw			lxPerclidetSaltafw =  .Seriealtafw			lxPerclidetSmodifw =  .Seriemodificacionfw			lxPerclidetHmodifw =  .Horamodificacionfw			lxPerclidetUmodifw =  .Usuariomodificacionfw			lxPerclidetZadsfw =  .Zadsfw			lxPerclidetValtafw =  .Versionaltafw			lxPerclidetVmodifw =  .Versionmodificacionfw			lxPerclidetHoraimpo =  .Horaimpo			lxPerclidetBdmodifw =  .Basededatosmodificacionfw			lxPerclidetBdaltafw =  .Basededatosaltafw			lxPerclidetEsttrans =  .Estadotransferencia			lxPerclidetHoraexpo =  .Horaexpo			lxPerclidetHaltafw =  .Horaaltafw			lxPerclidetCodigo =  .Codigo			lxPerclidetJurisdicci =  upper( .JURISDICCION_PK ) 			lxPerclidetCuit =  .Cuit			lxPerclidetPorcen =  .Porcentaje			lxPerclidetFecexp =  .Fechaexpiracion			lxPerclidetCod =  .Codigocliente			lxPerclidetDesjur =  .Descripcion			lxPerclidetNroitem =  .Nroitem
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PERCLIDET ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Ualtafw","Saltafw","Smodifw","Hmodifw","Umodifw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Bdmodifw","Bdaltafw","Esttrans","Horaexpo","Haltafw","Codigo","Jurisdicci","Cuit","Porcen","Fecexp","Cod","Desjur","Nroitem" ) values ( <<"'" + this.ConvertirDateSql( lxPerclidetFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPerclidetFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPerclidetFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPerclidetFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPerclidetFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetJurisdicci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetCuit ) + "'" >>, <<lxPerclidetPorcen >>, <<"'" + this.ConvertirDateSql( lxPerclidetFecexp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetCod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPerclidetDesjur ) + "'" >>, <<lxPerclidetNroitem >> )
		endtext
		loColeccion.cTabla = 'PERCLIDET' 
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
			local  lxPerclidetFecexpo, lxPerclidetFectrans, lxPerclidetFmodifw, lxPerclidetFaltafw, lxPerclidetFecimpo, lxPerclidetUaltafw, lxPerclidetSaltafw, lxPerclidetSmodifw, lxPerclidetHmodifw, lxPerclidetUmodifw, lxPerclidetZadsfw, lxPerclidetValtafw, lxPerclidetVmodifw, lxPerclidetHoraimpo, lxPerclidetBdmodifw, lxPerclidetBdaltafw, lxPerclidetEsttrans, lxPerclidetHoraexpo, lxPerclidetHaltafw, lxPerclidetCodigo, lxPerclidetJurisdicci, lxPerclidetCuit, lxPerclidetPorcen, lxPerclidetFecexp, lxPerclidetCod, lxPerclidetDesjur, lxPerclidetNroitem
				lxPerclidetFecexpo =  .Fechaexpo			lxPerclidetFectrans =  .Fechatransferencia			lxPerclidetFmodifw =  .Fechamodificacionfw			lxPerclidetFaltafw =  .Fechaaltafw			lxPerclidetFecimpo =  .Fechaimpo			lxPerclidetUaltafw =  .Usuarioaltafw			lxPerclidetSaltafw =  .Seriealtafw			lxPerclidetSmodifw =  .Seriemodificacionfw			lxPerclidetHmodifw =  .Horamodificacionfw			lxPerclidetUmodifw =  .Usuariomodificacionfw			lxPerclidetZadsfw =  .Zadsfw			lxPerclidetValtafw =  .Versionaltafw			lxPerclidetVmodifw =  .Versionmodificacionfw			lxPerclidetHoraimpo =  .Horaimpo			lxPerclidetBdmodifw =  .Basededatosmodificacionfw			lxPerclidetBdaltafw =  .Basededatosaltafw			lxPerclidetEsttrans =  .Estadotransferencia			lxPerclidetHoraexpo =  .Horaexpo			lxPerclidetHaltafw =  .Horaaltafw			lxPerclidetCodigo =  .Codigo			lxPerclidetJurisdicci =  upper( .JURISDICCION_PK ) 			lxPerclidetCuit =  .Cuit			lxPerclidetPorcen =  .Porcentaje			lxPerclidetFecexp =  .Fechaexpiracion			lxPerclidetCod =  .Codigocliente			lxPerclidetDesjur =  .Descripcion			lxPerclidetNroitem =  .Nroitem
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PERCLIDET.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.PERCLIDET set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxPerclidetFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxPerclidetFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPerclidetFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxPerclidetFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxPerclidetFecimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxPerclidetUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxPerclidetSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetHmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxPerclidetZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxPerclidetValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxPerclidetHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxPerclidetBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxPerclidetBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxPerclidetEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxPerclidetHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxPerclidetHaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxPerclidetCodigo ) + "'">>, "Jurisdicci" = <<"'" + this.FormatearTextoSql( lxPerclidetJurisdicci ) + "'">>, "Cuit" = <<"'" + this.FormatearTextoSql( lxPerclidetCuit ) + "'">>, "Porcen" = <<lxPerclidetPorcen>>, "Fecexp" = <<"'" + this.ConvertirDateSql( lxPerclidetFecexp ) + "'">>, "Cod" = <<"'" + this.FormatearTextoSql( lxPerclidetCod ) + "'">>, "Desjur" = <<"'" + this.FormatearTextoSql( lxPerclidetDesjur ) + "'">>, "Nroitem" = <<lxPerclidetNroitem>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PERCLIDET' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PERCLIDET.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.PERCLIDET where ' + lcFiltro )
			loColeccion.cTabla = 'PERCLIDET' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PERCLIDET where  PERCLIDET.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PERCLIDET where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PERCLIDET.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxPerCliDetJURISDICCI as variant, lxPerCliDetCOD as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PADRONIIBB'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PERCLIDET Where  COD = ] + "'" + this.FormatearTextoSql( &lcCursor..COD        ) + "'" + [ and JURISDICCI = ] + "'" + this.FormatearTextoSql( &lcCursor..JURISDICCI ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.PERCLIDET set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, JURISDICCI = ] + "'" + this.FormatearTextoSql( &lcCursor..JURISDICCI ) + "'"+ [, CUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..CUIT ) + "'"+ [, PORCEN = ] + transform( &lcCursor..PORCEN )+ [, FECEXP = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXP ) + "'"+ [, COD = ] + "'" + this.FormatearTextoSql( &lcCursor..COD ) + "'"+ [, DesJur = ] + "'" + this.FormatearTextoSql( &lcCursor..DesJur ) + "'"+ [, NroItem = ] + transform( &lcCursor..NroItem ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.PERCLIDET Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, UALTAFW, SALTAFW, SMODIFW, HMODIFW, UMODIFW, ZADSFW, VALTAFW, VMODIFW, HORAIMPO, BDMODIFW, BDALTAFW, ESTTRANS, HORAEXPO, HALTAFW, CODIGO, JURISDICCI, CUIT, PORCEN, FECEXP, COD, DesJur, NroItem
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..JURISDICCI ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CUIT ) + "'" + ',' + transform( &lcCursor..PORCEN ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DesJur ) + "'" + ',' + transform( &lcCursor..NroItem )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.PERCLIDET ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PADRONIIBB'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - .: ' + transform( &tcCursor..COD        )
		lcRetorno = lcRetorno + ' - JURISDICCION: ' + transform( &tcCursor..JURISDICCI )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'PADRONIIBB'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PADRONIIBB_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PerCliDet')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'PADRONIIBB'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..COD ) or isnull( &lcCursor..JURISDICCI )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PADRONIIBB. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PADRONIIBB'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,COD + JURISDICCI as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( COD + JURISDICCI, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PADRONIIBB'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXP    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PerCliDet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PerCliDet
Create Table ZooLogic.TablaTrabajo_PerCliDet ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"jurisdicci" char( 8 )  null, 
"cuit" char( 11 )  null, 
"porcen" numeric( 6, 2 )  null, 
"fecexp" datetime  null, 
"cod" char( 5 )  null, 
"desjur" char( 50 )  null, 
"nroitem" numeric( 5, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PerCliDet' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PerCliDet' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PADRONIIBB'
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('jurisdicci','jurisdicci')
			.AgregarMapeo('cuit','cuit')
			.AgregarMapeo('porcen','porcen')
			.AgregarMapeo('fecexp','fecexp')
			.AgregarMapeo('cod','cod')
			.AgregarMapeo('desjur','desjur')
			.AgregarMapeo('nroitem','nroitem')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PerCliDet'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.JURISDICCI = isnull( d.JURISDICCI, t.JURISDICCI ),t.CUIT = isnull( d.CUIT, t.CUIT ),t.PORCEN = isnull( d.PORCEN, t.PORCEN ),t.FECEXP = isnull( d.FECEXP, t.FECEXP ),t.COD = isnull( d.COD, t.COD ),t.DESJUR = isnull( d.DESJUR, t.DESJUR ),t.NROITEM = isnull( d.NROITEM, t.NROITEM )
					from ZooLogic.PERCLIDET t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.COD = d.COD
							 and  t.JURISDICCI = d.JURISDICCI
				-- Fin Updates
				insert into ZooLogic.PERCLIDET(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Ualtafw,Saltafw,Smodifw,Hmodifw,Umodifw,Zadsfw,Valtafw,Vmodifw,Horaimpo,Bdmodifw,Bdaltafw,Esttrans,Horaexpo,Haltafw,Codigo,Jurisdicci,Cuit,Porcen,Fecexp,Cod,Desjur,Nroitem)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.CODIGO,''),isnull( d.JURISDICCI,''),isnull( d.CUIT,''),isnull( d.PORCEN,0),isnull( d.FECEXP,''),isnull( d.COD,''),isnull( d.DESJUR,''),isnull( d.NROITEM,0)
						From deleted d left join ZooLogic.PERCLIDET pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.PERCLIDET cc 
							 on  d.COD = cc.COD
							 and  d.JURISDICCI = cc.JURISDICCI
						Where pk.CODIGO Is Null 
							 and cc.COD Is Null 
							 and cc.JURISDICCI Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: . ' + cast( d.COD as Varchar(5) ) + ', JURISDICCION ' + cast( d.JURISDICCI as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.PERCLIDET t inner join deleted d 
							on   t.COD = d.COD
							 and  t.JURISDICCI = d.JURISDICCI
						left join deleted h 
							 on t.CODIGO = h.CODIGO
							 where h.CODIGO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: . ' + cast( d.COD as Varchar(5) ) + ', JURISDICCION ' + cast( d.JURISDICCI as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.PERCLIDET t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.COD = h.COD
							 and   t.JURISDICCI = h.JURISDICCI
							where   h.COD is null 
							 and   h.JURISDICCI is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PerCliDet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PerCliDet
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PADRONIIBB' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PADRONIIBB.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PADRONIIBB.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PADRONIIBB.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PADRONIIBB.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PADRONIIBB.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Usuarioaltafw = nvl( c_PADRONIIBB.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_PADRONIIBB.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_PADRONIIBB.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_PADRONIIBB.Horamodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_PADRONIIBB.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_PADRONIIBB.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_PADRONIIBB.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_PADRONIIBB.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_PADRONIIBB.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_PADRONIIBB.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_PADRONIIBB.Estadotransferencia, [] )
					.Horaexpo = nvl( c_PADRONIIBB.Horaexpo, [] )
					.Horaaltafw = nvl( c_PADRONIIBB.Horaaltafw, [] )
					.Codigo = nvl( c_PADRONIIBB.Codigo, [] )
					.Jurisdiccion_PK =  nvl( c_PADRONIIBB.Jurisdiccion, [] )
					.Cuit = nvl( c_PADRONIIBB.Cuit, [] )
					.Porcentaje = nvl( c_PADRONIIBB.Porcentaje, 0 )
					.Fechaexpiracion = GoLibrerias.ObtenerFechaFormateada( nvl( c_PADRONIIBB.Fechaexpiracion, ctod( '  /  /    ' ) ) )
					.Codigocliente = nvl( c_PADRONIIBB.Codigocliente, [] )
					.Descripcion = nvl( c_PADRONIIBB.Descripcion, [] )
					.Nroitem = nvl( c_PADRONIIBB.Nroitem, 0 )
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
			lxRetorno = c_PADRONIIBB.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_PADRONIIBB.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PERCLIDET' )
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
								from ZooLogic.PERCLIDET 
								Where   PERCLIDET.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PERCLIDET", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Jurisdicci" as "Jurisdiccion", "Cuit" as "Cuit", "Porcen" as "Porcentaje", "Fecexp" as "Fechaexpiracion", "Cod" as "Codigocliente", "Desjur" as "Descripcion", "Nroitem" as "Nroitem"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PERCLIDET 
								Where   PERCLIDET.CODIGO != ''
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
	Tabla = 'PERCLIDET'
	Filtro = " PERCLIDET.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PERCLIDET.CODIGO != ''"
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
	<row entidad="PADRONIIBB                              " atributo="FECHAEXPO                               " tabla="PERCLIDET      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="FECHATRANSFERENCIA                      " tabla="PERCLIDET      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="FECHAMODIFICACIONFW                     " tabla="PERCLIDET      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="FECHAALTAFW                             " tabla="PERCLIDET      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="FECHAIMPO                               " tabla="PERCLIDET      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="USUARIOALTAFW                           " tabla="PERCLIDET      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="SERIEALTAFW                             " tabla="PERCLIDET      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="SERIEMODIFICACIONFW                     " tabla="PERCLIDET      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="HORAMODIFICACIONFW                      " tabla="PERCLIDET      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="USUARIOMODIFICACIONFW                   " tabla="PERCLIDET      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="ZADSFW                                  " tabla="PERCLIDET      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="VERSIONALTAFW                           " tabla="PERCLIDET      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="VERSIONMODIFICACIONFW                   " tabla="PERCLIDET      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="HORAIMPO                                " tabla="PERCLIDET      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PERCLIDET      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="BASEDEDATOSALTAFW                       " tabla="PERCLIDET      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="ESTADOTRANSFERENCIA                     " tabla="PERCLIDET      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="HORAEXPO                                " tabla="PERCLIDET      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="HORAALTAFW                              " tabla="PERCLIDET      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="CODIGO                                  " tabla="PERCLIDET      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta=".                                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="JURISDICCION                            " tabla="PERCLIDET      " campo="JURISDICCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="JURISDICCION                            " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="JURISDICCION                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="CUIT                                    " tabla="PERCLIDET      " campo="CUIT      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="11" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta=".                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="PORCENTAJE                              " tabla="PERCLIDET      " campo="PORCEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta=".                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="FECHAEXPIRACION                         " tabla="PERCLIDET      " campo="FECEXP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta=".                                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="CODIGOCLIENTE                           " tabla="PERCLIDET      " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta=".                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="DESCRIPCION                             " tabla="PERCLIDET      " campo="DESJUR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta=".                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PADRONIIBB                              " atributo="NROITEM                                 " tabla="PERCLIDET      " campo="NROITEM   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta=".                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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