
define class Din_EntidadBUZONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_BUZON'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_044PK'
	cTablaPrincipal = 'HOST'
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
			local  lxHostFmodifw, lxHostFectrans, lxHostFecimpo, lxHostFecexpo, lxHostFaltafw, lxHostTimestamp, lxHostBdaltafw, lxHostEsttrans, lxHostBdmodifw, lxHostHoraimpo, lxHostHaltafw, lxHostHoraexpo, lxHostSaltafw, lxHostVmodifw, lxHostSmodifw, lxHostZadsfw, lxHostValtafw, lxHostHmodifw, lxHostUaltafw, lxHostUmodifw, lxHostObs, lxHostHoscod, lxHostHunid, lxHostHpath, lxHostHserie, lxHostBdatos, lxHostHsucori, lxHostHpath1, lxHostHpath2, lxHostCliente, lxHostComport, lxHostProveedor, lxHostHpath3, lxHostHdiscove, lxHostHcompkit, lxHostHtranstk, lxHostHtranart, lxHostHdatestk, lxHostHtipoconx, lxHostHcodfiltr, lxHostHeslince, lxHostOrigfran, lxHostCliefran, lxHostProvfran
				lxHostFmodifw =  .Fechamodificacionfw			lxHostFectrans =  .Fechatransferencia			lxHostFecimpo =  .Fechaimpo			lxHostFecexpo =  .Fechaexpo			lxHostFaltafw =  .Fechaaltafw			lxHostTimestamp = goLibrerias.ObtenerTimestamp()			lxHostBdaltafw =  .Basededatosaltafw			lxHostEsttrans =  .Estadotransferencia			lxHostBdmodifw =  .Basededatosmodificacionfw			lxHostHoraimpo =  .Horaimpo			lxHostHaltafw =  .Horaaltafw			lxHostHoraexpo =  .Horaexpo			lxHostSaltafw =  .Seriealtafw			lxHostVmodifw =  .Versionmodificacionfw			lxHostSmodifw =  .Seriemodificacionfw			lxHostZadsfw =  .Zadsfw			lxHostValtafw =  .Versionaltafw			lxHostHmodifw =  .Horamodificacionfw			lxHostUaltafw =  .Usuarioaltafw			lxHostUmodifw =  .Usuariomodificacionfw			lxHostObs =  .Obs			lxHostHoscod =  .Codigo			lxHostHunid =  .Hunid			lxHostHpath =  .Hpath			lxHostHserie =  .Serie			lxHostBdatos =  .Basededatos			lxHostHsucori =  upper( .OrigenDeDatos_PK ) 			lxHostHpath1 =  .Hpath1			lxHostHpath2 =  .Hpath2			lxHostCliente =  upper( .CLIENTE_PK ) 			lxHostComport =  .Comportamiento			lxHostProveedor =  upper( .PROVEEDOR_PK ) 			lxHostHpath3 =  .Hpath3			lxHostHdiscove =  .Hdiscove			lxHostHcompkit =  .Hcompkit			lxHostHtranstk =  .Htranstk			lxHostHtranart =  .Htranart			lxHostHdatestk =  .Hdatestk			lxHostHtipoconx =  .Htipoconx			lxHostHcodfiltr =  .Hcodfiltr			lxHostHeslince =  .Esbuzonlince			lxHostOrigfran =  upper( .OrigenFranquicia_PK ) 			lxHostCliefran =  upper( .ClienteFranquicia_PK ) 			lxHostProvfran =  upper( .ProveedorFranquicia_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxHostHoscod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into PUESTO.HOST ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Faltafw","Timestamp","Bdaltafw","Esttrans","Bdmodifw","Horaimpo","Haltafw","Horaexpo","Saltafw","Vmodifw","Smodifw","Zadsfw","Valtafw","Hmodifw","Ualtafw","Umodifw","Obs","Hoscod","Hunid","Hpath","Hserie","Bdatos","Hsucori","Hpath1","Hpath2","Cliente","Comport","Proveedor","Hpath3","Hdiscove","Hcompkit","Htranstk","Htranart","Hdatestk","Htipoconx","Hcodfiltr","Heslince","Origfran","Cliefran","Provfran" ) values ( <<"'" + this.ConvertirDateSql( lxHostFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHostFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHostFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHostFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHostFaltafw ) + "'" >>, <<lxHostTimestamp >>, <<"'" + this.FormatearTextoSql( lxHostBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHoscod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHunid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHpath ) + "'" >>, <<lxHostHserie >>, <<"'" + this.FormatearTextoSql( lxHostBdatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHsucori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHpath1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHpath2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostCliente ) + "'" >>, <<lxHostComport >>, <<"'" + this.FormatearTextoSql( lxHostProveedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHpath3 ) + "'" >>, <<lxHostHdiscove >>, <<lxHostHcompkit >>, <<lxHostHtranstk >>, <<lxHostHtranart >>, <<"'" + this.ConvertirDateSql( lxHostHdatestk ) + "'" >>, <<lxHostHtipoconx >>, <<"'" + this.FormatearTextoSql( lxHostHcodfiltr ) + "'" >>, <<iif( lxHostHeslince, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxHostOrigfran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostCliefran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostProvfran ) + "'" >> )
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
		this.oEntidad.Timestamp = lxHostTimestamp
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
			local  lxHostFmodifw, lxHostFectrans, lxHostFecimpo, lxHostFecexpo, lxHostFaltafw, lxHostTimestamp, lxHostBdaltafw, lxHostEsttrans, lxHostBdmodifw, lxHostHoraimpo, lxHostHaltafw, lxHostHoraexpo, lxHostSaltafw, lxHostVmodifw, lxHostSmodifw, lxHostZadsfw, lxHostValtafw, lxHostHmodifw, lxHostUaltafw, lxHostUmodifw, lxHostObs, lxHostHoscod, lxHostHunid, lxHostHpath, lxHostHserie, lxHostBdatos, lxHostHsucori, lxHostHpath1, lxHostHpath2, lxHostCliente, lxHostComport, lxHostProveedor, lxHostHpath3, lxHostHdiscove, lxHostHcompkit, lxHostHtranstk, lxHostHtranart, lxHostHdatestk, lxHostHtipoconx, lxHostHcodfiltr, lxHostHeslince, lxHostOrigfran, lxHostCliefran, lxHostProvfran
				lxHostFmodifw =  .Fechamodificacionfw			lxHostFectrans =  .Fechatransferencia			lxHostFecimpo =  .Fechaimpo			lxHostFecexpo =  .Fechaexpo			lxHostFaltafw =  .Fechaaltafw			lxHostTimestamp = goLibrerias.ObtenerTimestamp()			lxHostBdaltafw =  .Basededatosaltafw			lxHostEsttrans =  .Estadotransferencia			lxHostBdmodifw =  .Basededatosmodificacionfw			lxHostHoraimpo =  .Horaimpo			lxHostHaltafw =  .Horaaltafw			lxHostHoraexpo =  .Horaexpo			lxHostSaltafw =  .Seriealtafw			lxHostVmodifw =  .Versionmodificacionfw			lxHostSmodifw =  .Seriemodificacionfw			lxHostZadsfw =  .Zadsfw			lxHostValtafw =  .Versionaltafw			lxHostHmodifw =  .Horamodificacionfw			lxHostUaltafw =  .Usuarioaltafw			lxHostUmodifw =  .Usuariomodificacionfw			lxHostObs =  .Obs			lxHostHoscod =  .Codigo			lxHostHunid =  .Hunid			lxHostHpath =  .Hpath			lxHostHserie =  .Serie			lxHostBdatos =  .Basededatos			lxHostHsucori =  upper( .OrigenDeDatos_PK ) 			lxHostHpath1 =  .Hpath1			lxHostHpath2 =  .Hpath2			lxHostCliente =  upper( .CLIENTE_PK ) 			lxHostComport =  .Comportamiento			lxHostProveedor =  upper( .PROVEEDOR_PK ) 			lxHostHpath3 =  .Hpath3			lxHostHdiscove =  .Hdiscove			lxHostHcompkit =  .Hcompkit			lxHostHtranstk =  .Htranstk			lxHostHtranart =  .Htranart			lxHostHdatestk =  .Hdatestk			lxHostHtipoconx =  .Htipoconx			lxHostHcodfiltr =  .Hcodfiltr			lxHostHeslince =  .Esbuzonlince			lxHostOrigfran =  upper( .OrigenFranquicia_PK ) 			lxHostCliefran =  upper( .ClienteFranquicia_PK ) 			lxHostProvfran =  upper( .ProveedorFranquicia_PK ) 
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
				update PUESTO.HOST set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxHostFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxHostFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxHostFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxHostFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxHostFaltafw ) + "'">>,"Timestamp" = <<lxHostTimestamp>>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxHostBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxHostEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxHostBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxHostHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxHostHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxHostHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxHostSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxHostVmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxHostSmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxHostZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxHostValtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxHostHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxHostUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxHostUmodifw ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxHostObs ) + "'">>,"Hoscod" = <<"'" + this.FormatearTextoSql( lxHostHoscod ) + "'">>,"Hunid" = <<"'" + this.FormatearTextoSql( lxHostHunid ) + "'">>,"Hpath" = <<"'" + this.FormatearTextoSql( lxHostHpath ) + "'">>,"Hserie" = <<lxHostHserie>>,"Bdatos" = <<"'" + this.FormatearTextoSql( lxHostBdatos ) + "'">>,"Hsucori" = <<"'" + this.FormatearTextoSql( lxHostHsucori ) + "'">>,"Hpath1" = <<"'" + this.FormatearTextoSql( lxHostHpath1 ) + "'">>,"Hpath2" = <<"'" + this.FormatearTextoSql( lxHostHpath2 ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxHostCliente ) + "'">>,"Comport" = <<lxHostComport>>,"Proveedor" = <<"'" + this.FormatearTextoSql( lxHostProveedor ) + "'">>,"Hpath3" = <<"'" + this.FormatearTextoSql( lxHostHpath3 ) + "'">>,"Hdiscove" = <<lxHostHdiscove>>,"Hcompkit" = <<lxHostHcompkit>>,"Htranstk" = <<lxHostHtranstk>>,"Htranart" = <<lxHostHtranart>>,"Hdatestk" = <<"'" + this.ConvertirDateSql( lxHostHdatestk ) + "'">>,"Htipoconx" = <<lxHostHtipoconx>>,"Hcodfiltr" = <<"'" + this.FormatearTextoSql( lxHostHcodfiltr ) + "'">>,"Heslince" = <<iif( lxHostHeslince, 1, 0 )>>,"Origfran" = <<"'" + this.FormatearTextoSql( lxHostOrigfran ) + "'">>,"Cliefran" = <<"'" + this.FormatearTextoSql( lxHostCliefran ) + "'">>,"Provfran" = <<"'" + this.FormatearTextoSql( lxHostProvfran ) + "'">> where "Hoscod" = <<"'" + this.FormatearTextoSql( lxHostHoscod ) + "'">> and  HOST.HOSCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxHostTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 HOSCOD from PUESTO.HOST where " + this.ConvertirFuncionesSql( " HOST.HOSCOD != ''" ) )
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
			Local lxHostHoscod
			lxHostHoscod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Obs" as "Obs", "Hoscod" as "Codigo", "Hunid" as "Hunid", "Hpath" as "Hpath", "Hserie" as "Serie", "Bdatos" as "Basededatos", "Hsucori" as "Origendedatos", "Hpath1" as "Hpath1", "Hpath2" as "Hpath2", "Cliente" as "Cliente", "Comport" as "Comportamiento", "Proveedor" as "Proveedor", "Hpath3" as "Hpath3", "Hdiscove" as "Hdiscove", "Hcompkit" as "Hcompkit", "Htranstk" as "Htranstk", "Htranart" as "Htranart", "Hdatestk" as "Hdatestk", "Htipoconx" as "Htipoconx", "Hcodfiltr" as "Hcodfiltr", "Heslince" as "Esbuzonlince", "Origfran" as "Origenfranquicia", "Cliefran" as "Clientefranquicia", "Provfran" as "Proveedorfranquicia" from PUESTO.HOST where "Hoscod" = <<"'" + this.FormatearTextoSql( lxHostHoscod ) + "'">> and  HOST.HOSCOD != ''
			endtext
			use in select('c_BUZON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BUZON', set( 'Datasession' ) )

			if reccount( 'c_BUZON' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxHostHoscod as Variant
		llRetorno = .t.
		lxHostHoscod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from PUESTO.HOST where "Hoscod" = <<"'" + this.FormatearTextoSql( lxHostHoscod ) + "'">> and  HOST.HOSCOD != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Obs" as "Obs", "Hoscod" as "Codigo", "Hunid" as "Hunid", "Hpath" as "Hpath", "Hserie" as "Serie", "Bdatos" as "Basededatos", "Hsucori" as "Origendedatos", "Hpath1" as "Hpath1", "Hpath2" as "Hpath2", "Cliente" as "Cliente", "Comport" as "Comportamiento", "Proveedor" as "Proveedor", "Hpath3" as "Hpath3", "Hdiscove" as "Hdiscove", "Hcompkit" as "Hcompkit", "Htranstk" as "Htranstk", "Htranart" as "Htranart", "Hdatestk" as "Hdatestk", "Htipoconx" as "Htipoconx", "Hcodfiltr" as "Hcodfiltr", "Heslince" as "Esbuzonlince", "Origfran" as "Origenfranquicia", "Cliefran" as "Clientefranquicia", "Provfran" as "Proveedorfranquicia" from PUESTO.HOST where  HOST.HOSCOD != '' order by HOSCOD
			endtext
			use in select('c_BUZON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BUZON', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Obs" as "Obs", "Hoscod" as "Codigo", "Hunid" as "Hunid", "Hpath" as "Hpath", "Hserie" as "Serie", "Bdatos" as "Basededatos", "Hsucori" as "Origendedatos", "Hpath1" as "Hpath1", "Hpath2" as "Hpath2", "Cliente" as "Cliente", "Comport" as "Comportamiento", "Proveedor" as "Proveedor", "Hpath3" as "Hpath3", "Hdiscove" as "Hdiscove", "Hcompkit" as "Hcompkit", "Htranstk" as "Htranstk", "Htranart" as "Htranart", "Hdatestk" as "Hdatestk", "Htipoconx" as "Htipoconx", "Hcodfiltr" as "Hcodfiltr", "Heslince" as "Esbuzonlince", "Origfran" as "Origenfranquicia", "Cliefran" as "Clientefranquicia", "Provfran" as "Proveedorfranquicia" from PUESTO.HOST where  funciones.padr( HOSCOD, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  HOST.HOSCOD != '' order by HOSCOD
			endtext
			use in select('c_BUZON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BUZON', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Obs" as "Obs", "Hoscod" as "Codigo", "Hunid" as "Hunid", "Hpath" as "Hpath", "Hserie" as "Serie", "Bdatos" as "Basededatos", "Hsucori" as "Origendedatos", "Hpath1" as "Hpath1", "Hpath2" as "Hpath2", "Cliente" as "Cliente", "Comport" as "Comportamiento", "Proveedor" as "Proveedor", "Hpath3" as "Hpath3", "Hdiscove" as "Hdiscove", "Hcompkit" as "Hcompkit", "Htranstk" as "Htranstk", "Htranart" as "Htranart", "Hdatestk" as "Hdatestk", "Htipoconx" as "Htipoconx", "Hcodfiltr" as "Hcodfiltr", "Heslince" as "Esbuzonlince", "Origfran" as "Origenfranquicia", "Cliefran" as "Clientefranquicia", "Provfran" as "Proveedorfranquicia" from PUESTO.HOST where  funciones.padr( HOSCOD, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  HOST.HOSCOD != '' order by HOSCOD desc
			endtext
			use in select('c_BUZON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BUZON', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Obs" as "Obs", "Hoscod" as "Codigo", "Hunid" as "Hunid", "Hpath" as "Hpath", "Hserie" as "Serie", "Bdatos" as "Basededatos", "Hsucori" as "Origendedatos", "Hpath1" as "Hpath1", "Hpath2" as "Hpath2", "Cliente" as "Cliente", "Comport" as "Comportamiento", "Proveedor" as "Proveedor", "Hpath3" as "Hpath3", "Hdiscove" as "Hdiscove", "Hcompkit" as "Hcompkit", "Htranstk" as "Htranstk", "Htranart" as "Htranart", "Hdatestk" as "Hdatestk", "Htipoconx" as "Htipoconx", "Hcodfiltr" as "Hcodfiltr", "Heslince" as "Esbuzonlince", "Origfran" as "Origenfranquicia", "Cliefran" as "Clientefranquicia", "Provfran" as "Proveedorfranquicia" from PUESTO.HOST where  HOST.HOSCOD != '' order by HOSCOD desc
			endtext
			use in select('c_BUZON')
			this.oConexion.EjecutarSql( lcSentencia, 'c_BUZON', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecimpo,Fecexpo,Faltafw,Timestamp,Bdaltafw,Esttrans,Bdmodifw,Horaimpo,Halta" + ;
"fw,Horaexpo,Saltafw,Vmodifw,Smodifw,Zadsfw,Valtafw,Hmodifw,Ualtafw,Umodifw,Obs,Hoscod,Hunid,Hpath,Hs" + ;
"erie,Bdatos,Hsucori,Hpath1,Hpath2,Cliente,Comport,Proveedor,Hpath3,Hdiscove,Hcompkit,Htranstk,Htrana" + ;
"rt,Hdatestk,Htipoconx,Hcodfiltr,Heslince,Origfran,Cliefran,Provfran" + ;
" from PUESTO.HOST where  HOST.HOSCOD != '' and " + lcFiltro )
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
			local  lxHostFmodifw, lxHostFectrans, lxHostFecimpo, lxHostFecexpo, lxHostFaltafw, lxHostTimestamp, lxHostBdaltafw, lxHostEsttrans, lxHostBdmodifw, lxHostHoraimpo, lxHostHaltafw, lxHostHoraexpo, lxHostSaltafw, lxHostVmodifw, lxHostSmodifw, lxHostZadsfw, lxHostValtafw, lxHostHmodifw, lxHostUaltafw, lxHostUmodifw, lxHostObs, lxHostHoscod, lxHostHunid, lxHostHpath, lxHostHserie, lxHostBdatos, lxHostHsucori, lxHostHpath1, lxHostHpath2, lxHostCliente, lxHostComport, lxHostProveedor, lxHostHpath3, lxHostHdiscove, lxHostHcompkit, lxHostHtranstk, lxHostHtranart, lxHostHdatestk, lxHostHtipoconx, lxHostHcodfiltr, lxHostHeslince, lxHostOrigfran, lxHostCliefran, lxHostProvfran
				lxHostFmodifw = ctod( '  /  /    ' )			lxHostFectrans = ctod( '  /  /    ' )			lxHostFecimpo = ctod( '  /  /    ' )			lxHostFecexpo = ctod( '  /  /    ' )			lxHostFaltafw = ctod( '  /  /    ' )			lxHostTimestamp = goLibrerias.ObtenerTimestamp()			lxHostBdaltafw = []			lxHostEsttrans = []			lxHostBdmodifw = []			lxHostHoraimpo = []			lxHostHaltafw = []			lxHostHoraexpo = []			lxHostSaltafw = []			lxHostVmodifw = []			lxHostSmodifw = []			lxHostZadsfw = []			lxHostValtafw = []			lxHostHmodifw = []			lxHostUaltafw = []			lxHostUmodifw = []			lxHostObs = []			lxHostHoscod = []			lxHostHunid = []			lxHostHpath = []			lxHostHserie = 0			lxHostBdatos = []			lxHostHsucori = []			lxHostHpath1 = []			lxHostHpath2 = []			lxHostCliente = []			lxHostComport = 0			lxHostProveedor = []			lxHostHpath3 = []			lxHostHdiscove = 0			lxHostHcompkit = 0			lxHostHtranstk = 0			lxHostHtranart = 0			lxHostHdatestk = ctod( '  /  /    ' )			lxHostHtipoconx = 0			lxHostHcodfiltr = []			lxHostHeslince = .F.			lxHostOrigfran = []			lxHostCliefran = []			lxHostProvfran = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from PUESTO.HOST where "HOSCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'HOST' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where HOSCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(HOSCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  HOST.HOSCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Obs" as "Obs", "Hoscod" as "Codigo", "Hunid" as "Hunid", "Hpath" as "Hpath", "Hserie" as "Serie", "Bdatos" as "Basededatos", "Hsucori" as "Origendedatos", "Hpath1" as "Hpath1", "Hpath2" as "Hpath2", "Cliente" as "Cliente", "Comport" as "Comportamiento", "Proveedor" as "Proveedor", "Hpath3" as "Hpath3", "Hdiscove" as "Hdiscove", "Hcompkit" as "Hcompkit", "Htranstk" as "Htranstk", "Htranart" as "Htranart", "Hdatestk" as "Hdatestk", "Htipoconx" as "Htipoconx", "Hcodfiltr" as "Hcodfiltr", "Heslince" as "Esbuzonlince", "Origfran" as "Origenfranquicia", "Cliefran" as "Clientefranquicia", "Provfran" as "Proveedorfranquicia"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'HOST', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HOSCOD AS CODIGO'
				Case lcAtributo == 'HUNID'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HUNID AS HUNID'
				Case lcAtributo == 'HPATH'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HPATH AS HPATH'
				Case lcAtributo == 'SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HSERIE AS SERIE'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDATOS AS BASEDEDATOS'
				Case lcAtributo == 'ORIGENDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HSUCORI AS ORIGENDEDATOS'
				Case lcAtributo == 'HPATH1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HPATH1 AS HPATH1'
				Case lcAtributo == 'HPATH2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HPATH2 AS HPATH2'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPORT AS COMPORTAMIENTO'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDOR AS PROVEEDOR'
				Case lcAtributo == 'HPATH3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HPATH3 AS HPATH3'
				Case lcAtributo == 'HDISCOVE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HDISCOVE AS HDISCOVE'
				Case lcAtributo == 'HCOMPKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HCOMPKIT AS HCOMPKIT'
				Case lcAtributo == 'HTRANSTK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HTRANSTK AS HTRANSTK'
				Case lcAtributo == 'HTRANART'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HTRANART AS HTRANART'
				Case lcAtributo == 'HDATESTK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HDATESTK AS HDATESTK'
				Case lcAtributo == 'HTIPOCONX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HTIPOCONX AS HTIPOCONX'
				Case lcAtributo == 'HCODFILTR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HCODFILTR AS HCODFILTR'
				Case lcAtributo == 'ESBUZONLINCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HESLINCE AS ESBUZONLINCE'
				Case lcAtributo == 'ORIGENFRANQUICIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGFRAN AS ORIGENFRANQUICIA'
				Case lcAtributo == 'CLIENTEFRANQUICIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEFRAN AS CLIENTEFRANQUICIA'
				Case lcAtributo == 'PROVEEDORFRANQUICIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVFRAN AS PROVEEDORFRANQUICIA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'HOSCOD'
			Case upper( alltrim( tcAtributo ) ) == 'HUNID'
				lcCampo = 'HUNID'
			Case upper( alltrim( tcAtributo ) ) == 'HPATH'
				lcCampo = 'HPATH'
			Case upper( alltrim( tcAtributo ) ) == 'SERIE'
				lcCampo = 'HSERIE'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENDEDATOS'
				lcCampo = 'HSUCORI'
			Case upper( alltrim( tcAtributo ) ) == 'HPATH1'
				lcCampo = 'HPATH1'
			Case upper( alltrim( tcAtributo ) ) == 'HPATH2'
				lcCampo = 'HPATH2'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMPORT'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROVEEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'HPATH3'
				lcCampo = 'HPATH3'
			Case upper( alltrim( tcAtributo ) ) == 'HDISCOVE'
				lcCampo = 'HDISCOVE'
			Case upper( alltrim( tcAtributo ) ) == 'HCOMPKIT'
				lcCampo = 'HCOMPKIT'
			Case upper( alltrim( tcAtributo ) ) == 'HTRANSTK'
				lcCampo = 'HTRANSTK'
			Case upper( alltrim( tcAtributo ) ) == 'HTRANART'
				lcCampo = 'HTRANART'
			Case upper( alltrim( tcAtributo ) ) == 'HDATESTK'
				lcCampo = 'HDATESTK'
			Case upper( alltrim( tcAtributo ) ) == 'HTIPOCONX'
				lcCampo = 'HTIPOCONX'
			Case upper( alltrim( tcAtributo ) ) == 'HCODFILTR'
				lcCampo = 'HCODFILTR'
			Case upper( alltrim( tcAtributo ) ) == 'ESBUZONLINCE'
				lcCampo = 'HESLINCE'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGENFRANQUICIA'
				lcCampo = 'ORIGFRAN'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEFRANQUICIA'
				lcCampo = 'CLIEFRAN'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORFRANQUICIA'
				lcCampo = 'PROVFRAN'
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
			local  lxHostFmodifw, lxHostFectrans, lxHostFecimpo, lxHostFecexpo, lxHostFaltafw, lxHostTimestamp, lxHostBdaltafw, lxHostEsttrans, lxHostBdmodifw, lxHostHoraimpo, lxHostHaltafw, lxHostHoraexpo, lxHostSaltafw, lxHostVmodifw, lxHostSmodifw, lxHostZadsfw, lxHostValtafw, lxHostHmodifw, lxHostUaltafw, lxHostUmodifw, lxHostObs, lxHostHoscod, lxHostHunid, lxHostHpath, lxHostHserie, lxHostBdatos, lxHostHsucori, lxHostHpath1, lxHostHpath2, lxHostCliente, lxHostComport, lxHostProveedor, lxHostHpath3, lxHostHdiscove, lxHostHcompkit, lxHostHtranstk, lxHostHtranart, lxHostHdatestk, lxHostHtipoconx, lxHostHcodfiltr, lxHostHeslince, lxHostOrigfran, lxHostCliefran, lxHostProvfran
				lxHostFmodifw =  .Fechamodificacionfw			lxHostFectrans =  .Fechatransferencia			lxHostFecimpo =  .Fechaimpo			lxHostFecexpo =  .Fechaexpo			lxHostFaltafw =  .Fechaaltafw			lxHostTimestamp = goLibrerias.ObtenerTimestamp()			lxHostBdaltafw =  .Basededatosaltafw			lxHostEsttrans =  .Estadotransferencia			lxHostBdmodifw =  .Basededatosmodificacionfw			lxHostHoraimpo =  .Horaimpo			lxHostHaltafw =  .Horaaltafw			lxHostHoraexpo =  .Horaexpo			lxHostSaltafw =  .Seriealtafw			lxHostVmodifw =  .Versionmodificacionfw			lxHostSmodifw =  .Seriemodificacionfw			lxHostZadsfw =  .Zadsfw			lxHostValtafw =  .Versionaltafw			lxHostHmodifw =  .Horamodificacionfw			lxHostUaltafw =  .Usuarioaltafw			lxHostUmodifw =  .Usuariomodificacionfw			lxHostObs =  .Obs			lxHostHoscod =  .Codigo			lxHostHunid =  .Hunid			lxHostHpath =  .Hpath			lxHostHserie =  .Serie			lxHostBdatos =  .Basededatos			lxHostHsucori =  upper( .OrigenDeDatos_PK ) 			lxHostHpath1 =  .Hpath1			lxHostHpath2 =  .Hpath2			lxHostCliente =  upper( .CLIENTE_PK ) 			lxHostComport =  .Comportamiento			lxHostProveedor =  upper( .PROVEEDOR_PK ) 			lxHostHpath3 =  .Hpath3			lxHostHdiscove =  .Hdiscove			lxHostHcompkit =  .Hcompkit			lxHostHtranstk =  .Htranstk			lxHostHtranart =  .Htranart			lxHostHdatestk =  .Hdatestk			lxHostHtipoconx =  .Htipoconx			lxHostHcodfiltr =  .Hcodfiltr			lxHostHeslince =  .Esbuzonlince			lxHostOrigfran =  upper( .OrigenFranquicia_PK ) 			lxHostCliefran =  upper( .ClienteFranquicia_PK ) 			lxHostProvfran =  upper( .ProveedorFranquicia_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into PUESTO.HOST ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Faltafw","Timestamp","Bdaltafw","Esttrans","Bdmodifw","Horaimpo","Haltafw","Horaexpo","Saltafw","Vmodifw","Smodifw","Zadsfw","Valtafw","Hmodifw","Ualtafw","Umodifw","Obs","Hoscod","Hunid","Hpath","Hserie","Bdatos","Hsucori","Hpath1","Hpath2","Cliente","Comport","Proveedor","Hpath3","Hdiscove","Hcompkit","Htranstk","Htranart","Hdatestk","Htipoconx","Hcodfiltr","Heslince","Origfran","Cliefran","Provfran" ) values ( <<"'" + this.ConvertirDateSql( lxHostFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHostFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHostFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHostFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxHostFaltafw ) + "'" >>, <<lxHostTimestamp >>, <<"'" + this.FormatearTextoSql( lxHostBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHoscod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHunid ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHpath ) + "'" >>, <<lxHostHserie >>, <<"'" + this.FormatearTextoSql( lxHostBdatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHsucori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHpath1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHpath2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostCliente ) + "'" >>, <<lxHostComport >>, <<"'" + this.FormatearTextoSql( lxHostProveedor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostHpath3 ) + "'" >>, <<lxHostHdiscove >>, <<lxHostHcompkit >>, <<lxHostHtranstk >>, <<lxHostHtranart >>, <<"'" + this.ConvertirDateSql( lxHostHdatestk ) + "'" >>, <<lxHostHtipoconx >>, <<"'" + this.FormatearTextoSql( lxHostHcodfiltr ) + "'" >>, <<iif( lxHostHeslince, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxHostOrigfran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostCliefran ) + "'" >>, <<"'" + this.FormatearTextoSql( lxHostProvfran ) + "'" >> )
		endtext
		loColeccion.cTabla = 'HOST' 
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
			local  lxHostFmodifw, lxHostFectrans, lxHostFecimpo, lxHostFecexpo, lxHostFaltafw, lxHostTimestamp, lxHostBdaltafw, lxHostEsttrans, lxHostBdmodifw, lxHostHoraimpo, lxHostHaltafw, lxHostHoraexpo, lxHostSaltafw, lxHostVmodifw, lxHostSmodifw, lxHostZadsfw, lxHostValtafw, lxHostHmodifw, lxHostUaltafw, lxHostUmodifw, lxHostObs, lxHostHoscod, lxHostHunid, lxHostHpath, lxHostHserie, lxHostBdatos, lxHostHsucori, lxHostHpath1, lxHostHpath2, lxHostCliente, lxHostComport, lxHostProveedor, lxHostHpath3, lxHostHdiscove, lxHostHcompkit, lxHostHtranstk, lxHostHtranart, lxHostHdatestk, lxHostHtipoconx, lxHostHcodfiltr, lxHostHeslince, lxHostOrigfran, lxHostCliefran, lxHostProvfran
				lxHostFmodifw =  .Fechamodificacionfw			lxHostFectrans =  .Fechatransferencia			lxHostFecimpo =  .Fechaimpo			lxHostFecexpo =  .Fechaexpo			lxHostFaltafw =  .Fechaaltafw			lxHostTimestamp = goLibrerias.ObtenerTimestamp()			lxHostBdaltafw =  .Basededatosaltafw			lxHostEsttrans =  .Estadotransferencia			lxHostBdmodifw =  .Basededatosmodificacionfw			lxHostHoraimpo =  .Horaimpo			lxHostHaltafw =  .Horaaltafw			lxHostHoraexpo =  .Horaexpo			lxHostSaltafw =  .Seriealtafw			lxHostVmodifw =  .Versionmodificacionfw			lxHostSmodifw =  .Seriemodificacionfw			lxHostZadsfw =  .Zadsfw			lxHostValtafw =  .Versionaltafw			lxHostHmodifw =  .Horamodificacionfw			lxHostUaltafw =  .Usuarioaltafw			lxHostUmodifw =  .Usuariomodificacionfw			lxHostObs =  .Obs			lxHostHoscod =  .Codigo			lxHostHunid =  .Hunid			lxHostHpath =  .Hpath			lxHostHserie =  .Serie			lxHostBdatos =  .Basededatos			lxHostHsucori =  upper( .OrigenDeDatos_PK ) 			lxHostHpath1 =  .Hpath1			lxHostHpath2 =  .Hpath2			lxHostCliente =  upper( .CLIENTE_PK ) 			lxHostComport =  .Comportamiento			lxHostProveedor =  upper( .PROVEEDOR_PK ) 			lxHostHpath3 =  .Hpath3			lxHostHdiscove =  .Hdiscove			lxHostHcompkit =  .Hcompkit			lxHostHtranstk =  .Htranstk			lxHostHtranart =  .Htranart			lxHostHdatestk =  .Hdatestk			lxHostHtipoconx =  .Htipoconx			lxHostHcodfiltr =  .Hcodfiltr			lxHostHeslince =  .Esbuzonlince			lxHostOrigfran =  upper( .OrigenFranquicia_PK ) 			lxHostCliefran =  upper( .ClienteFranquicia_PK ) 			lxHostProvfran =  upper( .ProveedorFranquicia_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Hoscod" = ] + lcValorClavePrimariaString  + [ and  HOST.HOSCOD != '']
			text to lcSentencia noshow textmerge
				update PUESTO.HOST set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxHostFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxHostFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxHostFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxHostFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxHostFaltafw ) + "'">>, "Timestamp" = <<lxHostTimestamp>>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxHostBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxHostEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxHostBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxHostHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxHostHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxHostHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxHostSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxHostVmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxHostSmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxHostZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxHostValtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxHostHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxHostUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxHostUmodifw ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxHostObs ) + "'">>, "Hoscod" = <<"'" + this.FormatearTextoSql( lxHostHoscod ) + "'">>, "Hunid" = <<"'" + this.FormatearTextoSql( lxHostHunid ) + "'">>, "Hpath" = <<"'" + this.FormatearTextoSql( lxHostHpath ) + "'">>, "Hserie" = <<lxHostHserie>>, "Bdatos" = <<"'" + this.FormatearTextoSql( lxHostBdatos ) + "'">>, "Hsucori" = <<"'" + this.FormatearTextoSql( lxHostHsucori ) + "'">>, "Hpath1" = <<"'" + this.FormatearTextoSql( lxHostHpath1 ) + "'">>, "Hpath2" = <<"'" + this.FormatearTextoSql( lxHostHpath2 ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxHostCliente ) + "'">>, "Comport" = <<lxHostComport>>, "Proveedor" = <<"'" + this.FormatearTextoSql( lxHostProveedor ) + "'">>, "Hpath3" = <<"'" + this.FormatearTextoSql( lxHostHpath3 ) + "'">>, "Hdiscove" = <<lxHostHdiscove>>, "Hcompkit" = <<lxHostHcompkit>>, "Htranstk" = <<lxHostHtranstk>>, "Htranart" = <<lxHostHtranart>>, "Hdatestk" = <<"'" + this.ConvertirDateSql( lxHostHdatestk ) + "'">>, "Htipoconx" = <<lxHostHtipoconx>>, "Hcodfiltr" = <<"'" + this.FormatearTextoSql( lxHostHcodfiltr ) + "'">>, "Heslince" = <<iif( lxHostHeslince, 1, 0 )>>, "Origfran" = <<"'" + this.FormatearTextoSql( lxHostOrigfran ) + "'">>, "Cliefran" = <<"'" + this.FormatearTextoSql( lxHostCliefran ) + "'">>, "Provfran" = <<"'" + this.FormatearTextoSql( lxHostProvfran ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'HOST' 
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

			lcFiltro = ["Hoscod" = ] + lcValorClavePrimariaString  + [ and  HOST.HOSCOD != '']
		loColeccion.Agregar( 'delete from PUESTO.HOST where ' + lcFiltro )
			loColeccion.cTabla = 'HOST' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from PUESTO.HOST where  HOST.HOSCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from PUESTO.HOST where HOSCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  HOST.HOSCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'BUZON'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From PUESTO.HOST Where HOSCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..HOSCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE PUESTO.HOST set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, HOSCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..HOSCOD ) + "'"+ [, HUNID = ] + "'" + this.FormatearTextoSql( &lcCursor..HUNID ) + "'"+ [, HPATH = ] + "'" + this.FormatearTextoSql( &lcCursor..HPATH ) + "'"+ [, HSERIE = ] + transform( &lcCursor..HSERIE )+ [, BDATOS = ] + "'" + this.FormatearTextoSql( &lcCursor..BDATOS ) + "'"+ [, HSUCORI = ] + "'" + this.FormatearTextoSql( &lcCursor..HSUCORI ) + "'"+ [, HPATH1 = ] + "'" + this.FormatearTextoSql( &lcCursor..HPATH1 ) + "'"+ [, HPATH2 = ] + "'" + this.FormatearTextoSql( &lcCursor..HPATH2 ) + "'"+ [, CLIENTE = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIENTE ) + "'"+ [, COMPORT = ] + transform( &lcCursor..COMPORT )+ [, PROVEEDOR = ] + "'" + this.FormatearTextoSql( &lcCursor..PROVEEDOR ) + "'"+ [, HPATH3 = ] + "'" + this.FormatearTextoSql( &lcCursor..HPATH3 ) + "'"+ [, HDISCOVE = ] + transform( &lcCursor..HDISCOVE )+ [, HCOMPKIT = ] + transform( &lcCursor..HCOMPKIT )+ [, HTRANSTK = ] + transform( &lcCursor..HTRANSTK )+ [, HTRANART = ] + transform( &lcCursor..HTRANART )+ [, HDATESTK = ] + "'" + this.ConvertirDateSql( &lcCursor..HDATESTK ) + "'"+ [, HTIPOCONX = ] + transform( &lcCursor..HTIPOCONX )+ [, HCODFILTR = ] + "'" + this.FormatearTextoSql( &lcCursor..HCODFILTR ) + "'"+ [, HESLINCE = ] + Transform( iif( &lcCursor..HESLINCE, 1, 0 ))+ [, ORIGFRAN = ] + "'" + this.FormatearTextoSql( &lcCursor..ORIGFRAN ) + "'"+ [, CLIEFRAN = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIEFRAN ) + "'"+ [, PROVFRAN = ] + "'" + this.FormatearTextoSql( &lcCursor..PROVFRAN ) + "'" + [ Where HOSCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..HOSCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECTRANS, FECIMPO, FECEXPO, FALTAFW, TIMESTAMP, BDALTAFW, ESTTRANS, BDMODIFW, HORAIMPO, HALTAFW, HORAEXPO, SALTAFW, VMODIFW, SMODIFW, ZADSFW, VALTAFW, HMODIFW, UALTAFW, UMODIFW, Obs, HOSCOD, HUNID, HPATH, HSERIE, BDATOS, HSUCORI, HPATH1, HPATH2, CLIENTE, COMPORT, PROVEEDOR, HPATH3, HDISCOVE, HCOMPKIT, HTRANSTK, HTRANART, HDATESTK, HTIPOCONX, HCODFILTR, HESLINCE, ORIGFRAN, CLIEFRAN, PROVFRAN
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HOSCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HUNID ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HPATH ) + "'" + ',' + transform( &lcCursor..HSERIE ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDATOS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HSUCORI ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HPATH1 ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HPATH2 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIENTE ) + "'" + ',' + transform( &lcCursor..COMPORT ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..PROVEEDOR ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HPATH3 ) + "'" + ',' + transform( &lcCursor..HDISCOVE ) + ',' + transform( &lcCursor..HCOMPKIT ) + ',' + transform( &lcCursor..HTRANSTK )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..HTRANART ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..HDATESTK ) + "'" + ',' + transform( &lcCursor..HTIPOCONX ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HCODFILTR ) + "'" + ',' + Transform( iif( &lcCursor..HESLINCE, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ORIGFRAN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIEFRAN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..PROVFRAN ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into PUESTO.HOST ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'BUZON'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( HOSCOD C (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Nombre: ' + transform( &tcCursor..HOSCOD     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'BUZON'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'BUZON_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'BUZON_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From PUESTO.TablaTrabajo_HOST')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'BUZON'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..HOSCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad BUZON. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'BUZON'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,HOSCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( HOSCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'BUZON'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  HDATESTK  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('PUESTO.TablaTrabajo_HOST') AND type in ('U')) DROP TABLE PUESTO.TablaTrabajo_HOST
Create Table PUESTO.TablaTrabajo_HOST ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"obs" varchar(max)  null, 
"hoscod" char( 8 )  null, 
"hunid" char( 1 )  null, 
"hpath" char( 250 )  null, 
"hserie" numeric( 10, 0 )  null, 
"bdatos" char( 8 )  null, 
"hsucori" char( 8 )  null, 
"hpath1" char( 8 )  null, 
"hpath2" char( 8 )  null, 
"cliente" char( 5 )  null, 
"comport" numeric( 1, 0 )  null, 
"proveedor" char( 5 )  null, 
"hpath3" char( 8 )  null, 
"hdiscove" numeric( 1, 0 )  null, 
"hcompkit" numeric( 1, 0 )  null, 
"htranstk" numeric( 1, 0 )  null, 
"htranart" numeric( 1, 0 )  null, 
"hdatestk" datetime  null, 
"htipoconx" numeric( 1, 0 )  null, 
"hcodfiltr" char( 2 )  null, 
"heslince" bit  null, 
"origfran" char( 8 )  null, 
"cliefran" char( 5 )  null, 
"provfran" char( 5 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_HOST' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_HOST' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'BUZON'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('hoscod','hoscod')
			.AgregarMapeo('hunid','hunid')
			.AgregarMapeo('hpath','hpath')
			.AgregarMapeo('hserie','hserie')
			.AgregarMapeo('bdatos','bdatos')
			.AgregarMapeo('hsucori','hsucori')
			.AgregarMapeo('hpath1','hpath1')
			.AgregarMapeo('hpath2','hpath2')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('comport','comport')
			.AgregarMapeo('proveedor','proveedor')
			.AgregarMapeo('hpath3','hpath3')
			.AgregarMapeo('hdiscove','hdiscove')
			.AgregarMapeo('hcompkit','hcompkit')
			.AgregarMapeo('htranstk','htranstk')
			.AgregarMapeo('htranart','htranart')
			.AgregarMapeo('hdatestk','hdatestk')
			.AgregarMapeo('htipoconx','htipoconx')
			.AgregarMapeo('hcodfiltr','hcodfiltr')
			.AgregarMapeo('heslince','heslince')
			.AgregarMapeo('origfran','origfran')
			.AgregarMapeo('cliefran','cliefran')
			.AgregarMapeo('provfran','provfran')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'PUESTO.TablaTrabajo_HOST'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.OBS = isnull( d.OBS, t.OBS ),t.HOSCOD = isnull( d.HOSCOD, t.HOSCOD ),t.HUNID = isnull( d.HUNID, t.HUNID ),t.HPATH = isnull( d.HPATH, t.HPATH ),t.HSERIE = isnull( d.HSERIE, t.HSERIE ),t.BDATOS = isnull( d.BDATOS, t.BDATOS ),t.HSUCORI = isnull( d.HSUCORI, t.HSUCORI ),t.HPATH1 = isnull( d.HPATH1, t.HPATH1 ),t.HPATH2 = isnull( d.HPATH2, t.HPATH2 ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.COMPORT = isnull( d.COMPORT, t.COMPORT ),t.PROVEEDOR = isnull( d.PROVEEDOR, t.PROVEEDOR ),t.HPATH3 = isnull( d.HPATH3, t.HPATH3 ),t.HDISCOVE = isnull( d.HDISCOVE, t.HDISCOVE ),t.HCOMPKIT = isnull( d.HCOMPKIT, t.HCOMPKIT ),t.HTRANSTK = isnull( d.HTRANSTK, t.HTRANSTK ),t.HTRANART = isnull( d.HTRANART, t.HTRANART ),t.HDATESTK = isnull( d.HDATESTK, t.HDATESTK ),t.HTIPOCONX = isnull( d.HTIPOCONX, t.HTIPOCONX ),t.HCODFILTR = isnull( d.HCODFILTR, t.HCODFILTR ),t.HESLINCE = isnull( d.HESLINCE, t.HESLINCE ),t.ORIGFRAN = isnull( d.ORIGFRAN, t.ORIGFRAN ),t.CLIEFRAN = isnull( d.CLIEFRAN, t.CLIEFRAN ),t.PROVFRAN = isnull( d.PROVFRAN, t.PROVFRAN )
					from PUESTO.HOST t inner join deleted d 
							 on t.HOSCOD = d.HOSCOD
				-- Fin Updates
				insert into PUESTO.HOST(Fmodifw,Fectrans,Fecimpo,Fecexpo,Faltafw,Timestamp,Bdaltafw,Esttrans,Bdmodifw,Horaimpo,Haltafw,Horaexpo,Saltafw,Vmodifw,Smodifw,Zadsfw,Valtafw,Hmodifw,Ualtafw,Umodifw,Obs,Hoscod,Hunid,Hpath,Hserie,Bdatos,Hsucori,Hpath1,Hpath2,Cliente,Comport,Proveedor,Hpath3,Hdiscove,Hcompkit,Htranstk,Htranart,Hdatestk,Htipoconx,Hcodfiltr,Heslince,Origfran,Cliefran,Provfran)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.TIMESTAMP,0),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.SMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.OBS,''),isnull( d.HOSCOD,''),isnull( d.HUNID,''),isnull( d.HPATH,''),isnull( d.HSERIE,0),isnull( d.BDATOS,''),isnull( d.HSUCORI,''),isnull( d.HPATH1,''),isnull( d.HPATH2,''),isnull( d.CLIENTE,''),isnull( d.COMPORT,0),isnull( d.PROVEEDOR,''),isnull( d.HPATH3,''),isnull( d.HDISCOVE,0),isnull( d.HCOMPKIT,0),isnull( d.HTRANSTK,0),isnull( d.HTRANART,0),isnull( d.HDATESTK,''),isnull( d.HTIPOCONX,0),isnull( d.HCODFILTR,''),isnull( d.HESLINCE,0),isnull( d.ORIGFRAN,''),isnull( d.CLIEFRAN,''),isnull( d.PROVFRAN,'')
						From deleted d left join PUESTO.HOST pk 
							 on d.HOSCOD = pk.HOSCOD
						Where pk.HOSCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('PUESTO.TablaTrabajo_HOST') AND type in ('U')) DROP TABLE PUESTO.TablaTrabajo_HOST
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_BUZON' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_BUZON.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_BUZON.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_BUZON.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_BUZON.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_BUZON.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_BUZON.Timestamp, 0 )
					.Basededatosaltafw = nvl( c_BUZON.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_BUZON.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_BUZON.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_BUZON.Horaimpo, [] )
					.Horaaltafw = nvl( c_BUZON.Horaaltafw, [] )
					.Horaexpo = nvl( c_BUZON.Horaexpo, [] )
					.Seriealtafw = nvl( c_BUZON.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_BUZON.Versionmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_BUZON.Seriemodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_BUZON.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_BUZON.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_BUZON.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_BUZON.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Codigo = nvl( c_BUZON.Codigo, [] )
					.Hunid = nvl( c_BUZON.Hunid, [] )
					.Hpath = nvl( c_BUZON.Hpath, [] )
					.Serie = nvl( c_BUZON.Serie, 0 )
					.Basededatos = nvl( c_BUZON.Basededatos, [] )
					.Origendedatos_PK =  nvl( c_BUZON.Origendedatos, [] )
					.Hpath1 = nvl( c_BUZON.Hpath1, [] )
					.Hpath2 = nvl( c_BUZON.Hpath2, [] )
					.Cliente_PK =  nvl( c_BUZON.Cliente, [] )
					.Comportamiento = nvl( c_BUZON.Comportamiento, 0 )
					.Proveedor_PK =  nvl( c_BUZON.Proveedor, [] )
					.Hpath3 = nvl( c_BUZON.Hpath3, [] )
					.Hdiscove = nvl( c_BUZON.Hdiscove, 0 )
					.Hcompkit = nvl( c_BUZON.Hcompkit, 0 )
					.Htranstk = nvl( c_BUZON.Htranstk, 0 )
					.Htranart = nvl( c_BUZON.Htranart, 0 )
					.Hdatestk = GoLibrerias.ObtenerFechaFormateada( nvl( c_BUZON.Hdatestk, ctod( '  /  /    ' ) ) )
					.Htipoconx = nvl( c_BUZON.Htipoconx, 0 )
					.Hcodfiltr = nvl( c_BUZON.Hcodfiltr, [] )
					.Esbuzonlince = nvl( c_BUZON.Esbuzonlince, .F. )
					.Origenfranquicia_PK =  nvl( c_BUZON.Origenfranquicia, [] )
					.Clientefranquicia_PK =  nvl( c_BUZON.Clientefranquicia, [] )
					.Proveedorfranquicia_PK =  nvl( c_BUZON.Proveedorfranquicia, [] )
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
		return c_BUZON.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.PUESTO.HOST' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "HOSCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,HOSCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    HOSCOD from (
							select * 
								from PUESTO.HOST 
								Where   HOST.HOSCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "HOST", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "HOSCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Timestamp" as "Timestamp", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Obs" as "Obs", "Hoscod" as "Codigo", "Hunid" as "Hunid", "Hpath" as "Hpath", "Hserie" as "Serie", "Bdatos" as "Basededatos", "Hsucori" as "Origendedatos", "Hpath1" as "Hpath1", "Hpath2" as "Hpath2", "Cliente" as "Cliente", "Comport" as "Comportamiento", "Proveedor" as "Proveedor", "Hpath3" as "Hpath3", "Hdiscove" as "Hdiscove", "Hcompkit" as "Hcompkit", "Htranstk" as "Htranstk", "Htranart" as "Htranart", "Hdatestk" as "Hdatestk", "Htipoconx" as "Htipoconx", "Hcodfiltr" as "Hcodfiltr", "Heslince" as "Esbuzonlince", "Origfran" as "Origenfranquicia", "Cliefran" as "Clientefranquicia", "Provfran" as "Proveedorfranquicia"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from PUESTO.HOST 
								Where   HOST.HOSCOD != ''
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
	Tabla = 'HOST'
	Filtro = " HOST.HOSCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " HOST.HOSCOD != ''"
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
	<row entidad="BUZON                                   " atributo="FECHAMODIFICACIONFW                     " tabla="HOST           " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="FECHATRANSFERENCIA                      " tabla="HOST           " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="FECHAIMPO                               " tabla="HOST           " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="FECHAEXPO                               " tabla="HOST           " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="FECHAALTAFW                             " tabla="HOST           " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="TIMESTAMP                               " tabla="HOST           " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="BASEDEDATOSALTAFW                       " tabla="HOST           " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="ESTADOTRANSFERENCIA                     " tabla="HOST           " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="HOST           " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HORAIMPO                                " tabla="HOST           " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HORAALTAFW                              " tabla="HOST           " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HORAEXPO                                " tabla="HOST           " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="SERIEALTAFW                             " tabla="HOST           " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="VERSIONMODIFICACIONFW                   " tabla="HOST           " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="SERIEMODIFICACIONFW                     " tabla="HOST           " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="ZADSFW                                  " tabla="HOST           " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="VERSIONALTAFW                           " tabla="HOST           " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HORAMODIFICACIONFW                      " tabla="HOST           " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="USUARIOALTAFW                           " tabla="HOST           " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="USUARIOMODIFICACIONFW                   " tabla="HOST           " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="OBS                                     " tabla="HOST           " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="CODIGO                                  " tabla="HOST           " campo="HOSCOD    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Nombre                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="DIRECTORIO                              " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="402" etiqueta="Carpeta                                                                                                                                                         " dominio="DIRECTORIO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HUNID                                   " tabla="HOST           " campo="HUNID     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Unidad                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HPATH                                   " tabla="HOST           " campo="HPATH     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Carpeta                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="SERIE                                   " tabla="HOST           " campo="HSERIE    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Serie                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="BASEDEDATOS                             " tabla="HOST           " campo="BDATOS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Base de datos                                                                                                                                                   " dominio="COMBOSUCURSALESCONVACIO       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="ORIGENDEDATOS                           " tabla="HOST           " campo="HSUCORI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Origen de Datos                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HPATH1                                  " tabla="HOST           " campo="HPATH1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HPATH2                                  " tabla="HOST           " campo="HPATH2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="CLIENTE                                 " tabla="HOST           " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="COMPORTAMIENTO                          " tabla="HOST           " campo="COMPORT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Comportamiento                                                                                                                                                  " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="PROVEEDOR                               " tabla="HOST           " campo="PROVEEDOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HPATH3                                  " tabla="HOST           " campo="HPATH3    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="11" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HDISCOVE                                " tabla="HOST           " campo="HDISCOVE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HCOMPKIT                                " tabla="HOST           " campo="HCOMPKIT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HTRANSTK                                " tabla="HOST           " campo="HTRANSTK  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="14" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HTRANART                                " tabla="HOST           " campo="HTRANART  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HDATESTK                                " tabla="HOST           " campo="HDATESTK  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="16" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HTIPOCONX                               " tabla="HOST           " campo="HTIPOCONX " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="17" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="HCODFILTR                               " tabla="HOST           " campo="HCODFILTR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="18" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="ESBUZONLINCE                            " tabla="HOST           " campo="HESLINCE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Destino Lince Indumentaria                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="ORIGENFRANQUICIA                        " tabla="HOST           " campo="ORIGFRAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORIGENDEDATOS                           " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Origen                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="CLIENTEFRANQUICIA                       " tabla="HOST           " campo="CLIEFRAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Cliente origen                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="BUZON                                   " atributo="PROVEEDORFRANQUICIA                     " tabla="HOST           " campo="PROVFRAN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Proveedor origen                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On HOST.HSUCORI = ORDAT.codigo And  ORDAT.CODIGO != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="407" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On HOST.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On HOST.PROVEEDOR = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORIGENDEDATOS                           " atributo="DESCRIPCION                             " tabla="ORDAT          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Ori.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDAT On HOST.ORIGFRAN = ORDAT.codigo And  ORDAT.CODIGO != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="415" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On HOST.CLIEFRAN = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On HOST.PROVFRAN = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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