
define class Din_EntidadCLIENTEECOMMERCEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CLIENTEECOMMERCE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [ClienteEcommerce + Cuentaecommerce]
	cExpresionCCPorCampos = [#tabla#.CLIENECOM + #tabla#.cuenta]
	cTagClaveCandidata = '_CECCC'
	cTagClavePk = '_CECPK'
	cTablaPrincipal = 'CLIECOM'
	cCampoCodigoWH = 'numero'
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
			local  lxCliecomFecimpo, lxCliecomFectrans, lxCliecomFmodifw, lxCliecomFecexpo, lxCliecomFaltafw, lxCliecomHaltafw, lxCliecomHoraexpo, lxCliecomValtafw, lxCliecomHmodifw, lxCliecomHoraimpo, lxCliecomUaltafw, lxCliecomSaltafw, lxCliecomSmodifw, lxCliecomZadsfw, lxCliecomBdaltafw, lxCliecomUmodifw, lxCliecomBdmodifw, lxCliecomEsttrans, lxCliecomVmodifw, lxCliecomNumero, lxCliecomObs, lxCliecomClienecom, lxCliecomNombre, lxCliecomApellido, lxCliecomCuenta, lxCliecomEmail, lxCliecomCliedragon, lxCliecomTelefono, lxCliecomTipodoc, lxCliecomNomyape, lxCliecomNrodoc
				lxCliecomFecimpo =  .Fechaimpo			lxCliecomFectrans =  .Fechatransferencia			lxCliecomFmodifw =  .Fechamodificacionfw			lxCliecomFecexpo =  .Fechaexpo			lxCliecomFaltafw =  .Fechaaltafw			lxCliecomHaltafw =  .Horaaltafw			lxCliecomHoraexpo =  .Horaexpo			lxCliecomValtafw =  .Versionaltafw			lxCliecomHmodifw =  .Horamodificacionfw			lxCliecomHoraimpo =  .Horaimpo			lxCliecomUaltafw =  .Usuarioaltafw			lxCliecomSaltafw =  .Seriealtafw			lxCliecomSmodifw =  .Seriemodificacionfw			lxCliecomZadsfw =  .Zadsfw			lxCliecomBdaltafw =  .Basededatosaltafw			lxCliecomUmodifw =  .Usuariomodificacionfw			lxCliecomBdmodifw =  .Basededatosmodificacionfw			lxCliecomEsttrans =  .Estadotransferencia			lxCliecomVmodifw =  .Versionmodificacionfw			lxCliecomNumero =  .Codigo			lxCliecomObs =  .Observacion			lxCliecomClienecom =  .Clienteecommerce			lxCliecomNombre =  .Nombre			lxCliecomApellido =  .Apellido			lxCliecomCuenta =  upper( .Cuentaecommerce_PK ) 			lxCliecomEmail =  .Mail			lxCliecomCliedragon =  upper( .ClienteDragon_PK ) 			lxCliecomTelefono =  .Telefono			lxCliecomTipodoc =  .Tipodoc			lxCliecomNomyape =  .Nombrecompleto			lxCliecomNrodoc =  .Nrodoc
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCliecomNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CLIECOM ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Horaexpo","Valtafw","Hmodifw","Horaimpo","Ualtafw","Saltafw","Smodifw","Zadsfw","Bdaltafw","Umodifw","Bdmodifw","Esttrans","Vmodifw","Numero","Obs","Clienecom","Nombre","Apellido","Cuenta","Email","Cliedragon","Telefono","Tipodoc","Nomyape","Nrodoc" ) values ( <<"'" + this.ConvertirDateSql( lxCliecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliecomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliecomFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomNumero ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomClienecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomNombre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomApellido ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomCuenta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomEmail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomCliedragon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomTelefono ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomTipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomNomyape ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomNrodoc ) + "'" >> )
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
			local  lxCliecomFecimpo, lxCliecomFectrans, lxCliecomFmodifw, lxCliecomFecexpo, lxCliecomFaltafw, lxCliecomHaltafw, lxCliecomHoraexpo, lxCliecomValtafw, lxCliecomHmodifw, lxCliecomHoraimpo, lxCliecomUaltafw, lxCliecomSaltafw, lxCliecomSmodifw, lxCliecomZadsfw, lxCliecomBdaltafw, lxCliecomUmodifw, lxCliecomBdmodifw, lxCliecomEsttrans, lxCliecomVmodifw, lxCliecomNumero, lxCliecomObs, lxCliecomClienecom, lxCliecomNombre, lxCliecomApellido, lxCliecomCuenta, lxCliecomEmail, lxCliecomCliedragon, lxCliecomTelefono, lxCliecomTipodoc, lxCliecomNomyape, lxCliecomNrodoc
				lxCliecomFecimpo =  .Fechaimpo			lxCliecomFectrans =  .Fechatransferencia			lxCliecomFmodifw =  .Fechamodificacionfw			lxCliecomFecexpo =  .Fechaexpo			lxCliecomFaltafw =  .Fechaaltafw			lxCliecomHaltafw =  .Horaaltafw			lxCliecomHoraexpo =  .Horaexpo			lxCliecomValtafw =  .Versionaltafw			lxCliecomHmodifw =  .Horamodificacionfw			lxCliecomHoraimpo =  .Horaimpo			lxCliecomUaltafw =  .Usuarioaltafw			lxCliecomSaltafw =  .Seriealtafw			lxCliecomSmodifw =  .Seriemodificacionfw			lxCliecomZadsfw =  .Zadsfw			lxCliecomBdaltafw =  .Basededatosaltafw			lxCliecomUmodifw =  .Usuariomodificacionfw			lxCliecomBdmodifw =  .Basededatosmodificacionfw			lxCliecomEsttrans =  .Estadotransferencia			lxCliecomVmodifw =  .Versionmodificacionfw			lxCliecomNumero =  .Codigo			lxCliecomObs =  .Observacion			lxCliecomClienecom =  .Clienteecommerce			lxCliecomNombre =  .Nombre			lxCliecomApellido =  .Apellido			lxCliecomCuenta =  upper( .Cuentaecommerce_PK ) 			lxCliecomEmail =  .Mail			lxCliecomCliedragon =  upper( .ClienteDragon_PK ) 			lxCliecomTelefono =  .Telefono			lxCliecomTipodoc =  .Tipodoc			lxCliecomNomyape =  .Nombrecompleto			lxCliecomNrodoc =  .Nrodoc
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CLIECOM set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCliecomFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCliecomFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCliecomFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCliecomFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCliecomFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCliecomHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCliecomHoraexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCliecomValtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCliecomHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCliecomHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCliecomUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCliecomSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCliecomSmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCliecomZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCliecomBdaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCliecomUmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCliecomBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCliecomEsttrans ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCliecomVmodifw ) + "'">>,"Numero" = <<"'" + this.FormatearTextoSql( lxCliecomNumero ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCliecomObs ) + "'">>,"Clienecom" = <<"'" + this.FormatearTextoSql( lxCliecomClienecom ) + "'">>,"Nombre" = <<"'" + this.FormatearTextoSql( lxCliecomNombre ) + "'">>,"Apellido" = <<"'" + this.FormatearTextoSql( lxCliecomApellido ) + "'">>,"Cuenta" = <<"'" + this.FormatearTextoSql( lxCliecomCuenta ) + "'">>,"Email" = <<"'" + this.FormatearTextoSql( lxCliecomEmail ) + "'">>,"Cliedragon" = <<"'" + this.FormatearTextoSql( lxCliecomCliedragon ) + "'">>,"Telefono" = <<"'" + this.FormatearTextoSql( lxCliecomTelefono ) + "'">>,"Tipodoc" = <<"'" + this.FormatearTextoSql( lxCliecomTipodoc ) + "'">>,"Nomyape" = <<"'" + this.FormatearTextoSql( lxCliecomNomyape ) + "'">>,"Nrodoc" = <<"'" + this.FormatearTextoSql( lxCliecomNrodoc ) + "'">> where "Numero" = <<"'" + this.FormatearTextoSql( lxCliecomNumero ) + "'">> and  CLIECOM.NUMERO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 numero from ZooLogic.CLIECOM where " + this.ConvertirFuncionesSql( " CLIECOM.NUMERO != ''" ) )
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
			Local lxCliecomNumero
			lxCliecomNumero = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Numero" as "Codigo", "Obs" as "Observacion", "Clienecom" as "Clienteecommerce", "Nombre" as "Nombre", "Apellido" as "Apellido", "Cuenta" as "Cuentaecommerce", "Email" as "Mail", "Cliedragon" as "Clientedragon", "Telefono" as "Telefono", "Tipodoc" as "Tipodoc", "Nomyape" as "Nombrecompleto", "Nrodoc" as "Nrodoc" from ZooLogic.CLIECOM where "Numero" = <<"'" + this.FormatearTextoSql( lxCliecomNumero ) + "'">> and  CLIECOM.NUMERO != ''
			endtext
			use in select('c_CLIENTEECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTEECOMMERCE', set( 'Datasession' ) )

			if reccount( 'c_CLIENTEECOMMERCE' ) = 0
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
			Local lxCLIECOMCLIENECOM As Variant, lxCLIECOMcuenta As Variant
			lxCLIECOMCLIENECOM = .ClienteEcommerce
			lxCLIECOMcuenta = .Cuentaecommerce_Pk
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Numero" as "Codigo", "Obs" as "Observacion", "Clienecom" as "Clienteecommerce", "Nombre" as "Nombre", "Apellido" as "Apellido", "Cuenta" as "Cuentaecommerce", "Email" as "Mail", "Cliedragon" as "Clientedragon", "Telefono" as "Telefono", "Tipodoc" as "Tipodoc", "Nomyape" as "Nombrecompleto", "Nrodoc" as "Nrodoc" from ZooLogic.CLIECOM where  CLIECOM.NUMERO != '' And CLIENECOM = <<"'" + this.FormatearTextoSql( lxCLIECOMCLIENECOM ) + "'">> and cuenta = <<"'" + this.FormatearTextoSql( lxCLIECOMcuenta ) + "'">>
			endtext
			use in select('c_CLIENTEECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTEECOMMERCE', set( 'Datasession' ) )
			if reccount( 'c_CLIENTEECOMMERCE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCliecomNumero as Variant
		llRetorno = .t.
		lxCliecomNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CLIECOM where "Numero" = <<"'" + this.FormatearTextoSql( lxCliecomNumero ) + "'">> and  CLIECOM.NUMERO != ''
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
				lcOrden =  .ClienteEcommerce + .Cuentaecommerce_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Numero" as "Codigo", "Obs" as "Observacion", "Clienecom" as "Clienteecommerce", "Nombre" as "Nombre", "Apellido" as "Apellido", "Cuenta" as "Cuentaecommerce", "Email" as "Mail", "Cliedragon" as "Clientedragon", "Telefono" as "Telefono", "Tipodoc" as "Tipodoc", "Nomyape" as "Nombrecompleto", "Nrodoc" as "Nrodoc" from ZooLogic.CLIECOM where  CLIECOM.NUMERO != '' order by CLIENECOM,cuenta
			endtext
			use in select('c_CLIENTEECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTEECOMMERCE', set( 'Datasession' ) )
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
				lcOrden =  .ClienteEcommerce + .Cuentaecommerce_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Numero" as "Codigo", "Obs" as "Observacion", "Clienecom" as "Clienteecommerce", "Nombre" as "Nombre", "Apellido" as "Apellido", "Cuenta" as "Cuentaecommerce", "Email" as "Mail", "Cliedragon" as "Clientedragon", "Telefono" as "Telefono", "Tipodoc" as "Tipodoc", "Nomyape" as "Nombrecompleto", "Nrodoc" as "Nrodoc" from ZooLogic.CLIECOM where  funciones.padr( CLIENECOM, 40, ' ' ) + funciones.padr( cuenta, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CLIECOM.NUMERO != '' order by CLIENECOM,cuenta
			endtext
			use in select('c_CLIENTEECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTEECOMMERCE', set( 'Datasession' ) )
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
				lcOrden =  .ClienteEcommerce + .Cuentaecommerce_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Numero" as "Codigo", "Obs" as "Observacion", "Clienecom" as "Clienteecommerce", "Nombre" as "Nombre", "Apellido" as "Apellido", "Cuenta" as "Cuentaecommerce", "Email" as "Mail", "Cliedragon" as "Clientedragon", "Telefono" as "Telefono", "Tipodoc" as "Tipodoc", "Nomyape" as "Nombrecompleto", "Nrodoc" as "Nrodoc" from ZooLogic.CLIECOM where  funciones.padr( CLIENECOM, 40, ' ' ) + funciones.padr( cuenta, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CLIECOM.NUMERO != '' order by CLIENECOM desc,cuenta desc
			endtext
			use in select('c_CLIENTEECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTEECOMMERCE', set( 'Datasession' ) )
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
				lcOrden =  .ClienteEcommerce + .Cuentaecommerce_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Numero" as "Codigo", "Obs" as "Observacion", "Clienecom" as "Clienteecommerce", "Nombre" as "Nombre", "Apellido" as "Apellido", "Cuenta" as "Cuentaecommerce", "Email" as "Mail", "Cliedragon" as "Clientedragon", "Telefono" as "Telefono", "Tipodoc" as "Tipodoc", "Nomyape" as "Nombrecompleto", "Nrodoc" as "Nrodoc" from ZooLogic.CLIECOM where  CLIECOM.NUMERO != '' order by CLIENECOM desc,cuenta desc
			endtext
			use in select('c_CLIENTEECOMMERCE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CLIENTEECOMMERCE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Horaexpo,Valtafw,Hmodifw,Horaimpo,Ualtafw,S" + ;
"altafw,Smodifw,Zadsfw,Bdaltafw,Umodifw,Bdmodifw,Esttrans,Vmodifw,Numero,Obs,Clienecom,Nombre,Apellid" + ;
"o,Cuenta,Email,Cliedragon,Telefono,Tipodoc,Nomyape,Nrodoc" + ;
" from ZooLogic.CLIECOM where  CLIECOM.NUMERO != '' and " + lcFiltro )
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
			local  lxCliecomFecimpo, lxCliecomFectrans, lxCliecomFmodifw, lxCliecomFecexpo, lxCliecomFaltafw, lxCliecomHaltafw, lxCliecomHoraexpo, lxCliecomValtafw, lxCliecomHmodifw, lxCliecomHoraimpo, lxCliecomUaltafw, lxCliecomSaltafw, lxCliecomSmodifw, lxCliecomZadsfw, lxCliecomBdaltafw, lxCliecomUmodifw, lxCliecomBdmodifw, lxCliecomEsttrans, lxCliecomVmodifw, lxCliecomNumero, lxCliecomObs, lxCliecomClienecom, lxCliecomNombre, lxCliecomApellido, lxCliecomCuenta, lxCliecomEmail, lxCliecomCliedragon, lxCliecomTelefono, lxCliecomTipodoc, lxCliecomNomyape, lxCliecomNrodoc
				lxCliecomFecimpo = ctod( '  /  /    ' )			lxCliecomFectrans = ctod( '  /  /    ' )			lxCliecomFmodifw = ctod( '  /  /    ' )			lxCliecomFecexpo = ctod( '  /  /    ' )			lxCliecomFaltafw = ctod( '  /  /    ' )			lxCliecomHaltafw = []			lxCliecomHoraexpo = []			lxCliecomValtafw = []			lxCliecomHmodifw = []			lxCliecomHoraimpo = []			lxCliecomUaltafw = []			lxCliecomSaltafw = []			lxCliecomSmodifw = []			lxCliecomZadsfw = []			lxCliecomBdaltafw = []			lxCliecomUmodifw = []			lxCliecomBdmodifw = []			lxCliecomEsttrans = []			lxCliecomVmodifw = []			lxCliecomNumero = []			lxCliecomObs = []			lxCliecomClienecom = []			lxCliecomNombre = []			lxCliecomApellido = []			lxCliecomCuenta = []			lxCliecomEmail = []			lxCliecomCliedragon = []			lxCliecomTelefono = []			lxCliecomTipodoc = []			lxCliecomNomyape = []			lxCliecomNrodoc = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CLIECOM where "numero" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CLIECOM' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where numero = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(numero, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CLIECOM.NUMERO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Numero" as "Codigo", "Obs" as "Observacion", "Clienecom" as "Clienteecommerce", "Nombre" as "Nombre", "Apellido" as "Apellido", "Cuenta" as "Cuentaecommerce", "Email" as "Mail", "Cliedragon" as "Clientedragon", "Telefono" as "Telefono", "Tipodoc" as "Tipodoc", "Nomyape" as "Nombrecompleto", "Nrodoc" as "Nrodoc"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CLIECOM', '', tnTope )
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
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'CLIENTEECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENECOM AS CLIENTEECOMMERCE'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMBRE AS NOMBRE'
				Case lcAtributo == 'APELLIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APELLIDO AS APELLIDO'
				Case lcAtributo == 'CUENTAECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUENTA AS CUENTAECOMMERCE'
				Case lcAtributo == 'MAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EMAIL AS MAIL'
				Case lcAtributo == 'CLIENTEDRAGON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDRAGON AS CLIENTEDRAGON'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TELEFONO AS TELEFONO'
				Case lcAtributo == 'TIPODOC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODOC AS TIPODOC'
				Case lcAtributo == 'NOMBRECOMPLETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMYAPE AS NOMBRECOMPLETO'
				Case lcAtributo == 'NRODOC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOC AS NRODOC'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEECOMMERCE'
				lcCampo = 'CLIENECOM'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'NOMBRE'
			Case upper( alltrim( tcAtributo ) ) == 'APELLIDO'
				lcCampo = 'APELLIDO'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTAECOMMERCE'
				lcCampo = 'CUENTA'
			Case upper( alltrim( tcAtributo ) ) == 'MAIL'
				lcCampo = 'EMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDRAGON'
				lcCampo = 'CLIEDRAGON'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'TELEFONO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOC'
				lcCampo = 'TIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRECOMPLETO'
				lcCampo = 'NOMYAPE'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOC'
				lcCampo = 'NRODOC'
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
			local  lxCliecomFecimpo, lxCliecomFectrans, lxCliecomFmodifw, lxCliecomFecexpo, lxCliecomFaltafw, lxCliecomHaltafw, lxCliecomHoraexpo, lxCliecomValtafw, lxCliecomHmodifw, lxCliecomHoraimpo, lxCliecomUaltafw, lxCliecomSaltafw, lxCliecomSmodifw, lxCliecomZadsfw, lxCliecomBdaltafw, lxCliecomUmodifw, lxCliecomBdmodifw, lxCliecomEsttrans, lxCliecomVmodifw, lxCliecomNumero, lxCliecomObs, lxCliecomClienecom, lxCliecomNombre, lxCliecomApellido, lxCliecomCuenta, lxCliecomEmail, lxCliecomCliedragon, lxCliecomTelefono, lxCliecomTipodoc, lxCliecomNomyape, lxCliecomNrodoc
				lxCliecomFecimpo =  .Fechaimpo			lxCliecomFectrans =  .Fechatransferencia			lxCliecomFmodifw =  .Fechamodificacionfw			lxCliecomFecexpo =  .Fechaexpo			lxCliecomFaltafw =  .Fechaaltafw			lxCliecomHaltafw =  .Horaaltafw			lxCliecomHoraexpo =  .Horaexpo			lxCliecomValtafw =  .Versionaltafw			lxCliecomHmodifw =  .Horamodificacionfw			lxCliecomHoraimpo =  .Horaimpo			lxCliecomUaltafw =  .Usuarioaltafw			lxCliecomSaltafw =  .Seriealtafw			lxCliecomSmodifw =  .Seriemodificacionfw			lxCliecomZadsfw =  .Zadsfw			lxCliecomBdaltafw =  .Basededatosaltafw			lxCliecomUmodifw =  .Usuariomodificacionfw			lxCliecomBdmodifw =  .Basededatosmodificacionfw			lxCliecomEsttrans =  .Estadotransferencia			lxCliecomVmodifw =  .Versionmodificacionfw			lxCliecomNumero =  .Codigo			lxCliecomObs =  .Observacion			lxCliecomClienecom =  .Clienteecommerce			lxCliecomNombre =  .Nombre			lxCliecomApellido =  .Apellido			lxCliecomCuenta =  upper( .Cuentaecommerce_PK ) 			lxCliecomEmail =  .Mail			lxCliecomCliedragon =  upper( .ClienteDragon_PK ) 			lxCliecomTelefono =  .Telefono			lxCliecomTipodoc =  .Tipodoc			lxCliecomNomyape =  .Nombrecompleto			lxCliecomNrodoc =  .Nrodoc
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CLIECOM ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Haltafw","Horaexpo","Valtafw","Hmodifw","Horaimpo","Ualtafw","Saltafw","Smodifw","Zadsfw","Bdaltafw","Umodifw","Bdmodifw","Esttrans","Vmodifw","Numero","Obs","Clienecom","Nombre","Apellido","Cuenta","Email","Cliedragon","Telefono","Tipodoc","Nomyape","Nrodoc" ) values ( <<"'" + this.ConvertirDateSql( lxCliecomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliecomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliecomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliecomFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCliecomFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomNumero ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomClienecom ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomNombre ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomApellido ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomCuenta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomEmail ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomCliedragon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomTelefono ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomTipodoc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomNomyape ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCliecomNrodoc ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CLIECOM' 
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
			local  lxCliecomFecimpo, lxCliecomFectrans, lxCliecomFmodifw, lxCliecomFecexpo, lxCliecomFaltafw, lxCliecomHaltafw, lxCliecomHoraexpo, lxCliecomValtafw, lxCliecomHmodifw, lxCliecomHoraimpo, lxCliecomUaltafw, lxCliecomSaltafw, lxCliecomSmodifw, lxCliecomZadsfw, lxCliecomBdaltafw, lxCliecomUmodifw, lxCliecomBdmodifw, lxCliecomEsttrans, lxCliecomVmodifw, lxCliecomNumero, lxCliecomObs, lxCliecomClienecom, lxCliecomNombre, lxCliecomApellido, lxCliecomCuenta, lxCliecomEmail, lxCliecomCliedragon, lxCliecomTelefono, lxCliecomTipodoc, lxCliecomNomyape, lxCliecomNrodoc
				lxCliecomFecimpo =  .Fechaimpo			lxCliecomFectrans =  .Fechatransferencia			lxCliecomFmodifw =  .Fechamodificacionfw			lxCliecomFecexpo =  .Fechaexpo			lxCliecomFaltafw =  .Fechaaltafw			lxCliecomHaltafw =  .Horaaltafw			lxCliecomHoraexpo =  .Horaexpo			lxCliecomValtafw =  .Versionaltafw			lxCliecomHmodifw =  .Horamodificacionfw			lxCliecomHoraimpo =  .Horaimpo			lxCliecomUaltafw =  .Usuarioaltafw			lxCliecomSaltafw =  .Seriealtafw			lxCliecomSmodifw =  .Seriemodificacionfw			lxCliecomZadsfw =  .Zadsfw			lxCliecomBdaltafw =  .Basededatosaltafw			lxCliecomUmodifw =  .Usuariomodificacionfw			lxCliecomBdmodifw =  .Basededatosmodificacionfw			lxCliecomEsttrans =  .Estadotransferencia			lxCliecomVmodifw =  .Versionmodificacionfw			lxCliecomNumero =  .Codigo			lxCliecomObs =  .Observacion			lxCliecomClienecom =  .Clienteecommerce			lxCliecomNombre =  .Nombre			lxCliecomApellido =  .Apellido			lxCliecomCuenta =  upper( .Cuentaecommerce_PK ) 			lxCliecomEmail =  .Mail			lxCliecomCliedragon =  upper( .ClienteDragon_PK ) 			lxCliecomTelefono =  .Telefono			lxCliecomTipodoc =  .Tipodoc			lxCliecomNomyape =  .Nombrecompleto			lxCliecomNrodoc =  .Nrodoc
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  CLIECOM.NUMERO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CLIECOM set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCliecomFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCliecomFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCliecomFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCliecomFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCliecomFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCliecomHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCliecomHoraexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCliecomValtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCliecomHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCliecomHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCliecomUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCliecomSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCliecomSmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCliecomZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCliecomBdaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCliecomUmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCliecomBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCliecomEsttrans ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCliecomVmodifw ) + "'">>, "Numero" = <<"'" + this.FormatearTextoSql( lxCliecomNumero ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCliecomObs ) + "'">>, "Clienecom" = <<"'" + this.FormatearTextoSql( lxCliecomClienecom ) + "'">>, "Nombre" = <<"'" + this.FormatearTextoSql( lxCliecomNombre ) + "'">>, "Apellido" = <<"'" + this.FormatearTextoSql( lxCliecomApellido ) + "'">>, "Cuenta" = <<"'" + this.FormatearTextoSql( lxCliecomCuenta ) + "'">>, "Email" = <<"'" + this.FormatearTextoSql( lxCliecomEmail ) + "'">>, "Cliedragon" = <<"'" + this.FormatearTextoSql( lxCliecomCliedragon ) + "'">>, "Telefono" = <<"'" + this.FormatearTextoSql( lxCliecomTelefono ) + "'">>, "Tipodoc" = <<"'" + this.FormatearTextoSql( lxCliecomTipodoc ) + "'">>, "Nomyape" = <<"'" + this.FormatearTextoSql( lxCliecomNomyape ) + "'">>, "Nrodoc" = <<"'" + this.FormatearTextoSql( lxCliecomNrodoc ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CLIECOM' 
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

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  CLIECOM.NUMERO != '']
		loColeccion.Agregar( 'delete from ZooLogic.CLIECOM where ' + lcFiltro )
			loColeccion.cTabla = 'CLIECOM' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CLIECOM where  CLIECOM.NUMERO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CLIECOM where numero = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CLIECOM.NUMERO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCLIECOMCLIENECOM as variant, lxCLIECOMcuenta as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTEECOMMERCE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CLIECOM Where  CLIENECOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIENECOM  ) + "'" + [ and cuenta = ] + "'" + this.FormatearTextoSql( &lcCursor..cuenta     ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..numero
				if lxValorClavePK == curSeek.numero or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.numero and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.numero
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.CLIECOM set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, numero = ] + "'" + this.FormatearTextoSql( &lcCursor..numero ) + "'"+ [, obs = ] + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'"+ [, CLIENECOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLIENECOM ) + "'"+ [, NOMBRE = ] + "'" + this.FormatearTextoSql( &lcCursor..NOMBRE ) + "'"+ [, APELLIDO = ] + "'" + this.FormatearTextoSql( &lcCursor..APELLIDO ) + "'"+ [, cuenta = ] + "'" + this.FormatearTextoSql( &lcCursor..cuenta ) + "'"+ [, EMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..EMAIL ) + "'"+ [, cliedragon = ] + "'" + this.FormatearTextoSql( &lcCursor..cliedragon ) + "'"+ [, TELEFONO = ] + "'" + this.FormatearTextoSql( &lcCursor..TELEFONO ) + "'"+ [, TIPODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..TIPODOC ) + "'"+ [, NOMYAPE = ] + "'" + this.FormatearTextoSql( &lcCursor..NOMYAPE ) + "'"+ [, NRODOC = ] + "'" + this.FormatearTextoSql( &lcCursor..NRODOC ) + "'" + [ Where numero = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						lcCampo = lcCursor + '.' + this.cCampoCodigoWH
						this.AgregarMensajeWebHook( 'MODIFICAR', &lcCampo )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CLIECOM Where numero = ] + "'" + this.FormatearTextoSql( &lcCursor..numero ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, HALTAFW, HORAEXPO, VALTAFW, HMODIFW, HORAIMPO, UALTAFW, SALTAFW, SMODIFW, ZADSFW, BDALTAFW, UMODIFW, BDMODIFW, ESTTRANS, VMODIFW, numero, obs, CLIENECOM, NOMBRE, APELLIDO, cuenta, EMAIL, cliedragon, TELEFONO, TIPODOC, NOMYAPE, NRODOC
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..numero ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..obs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLIENECOM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NOMBRE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..APELLIDO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cuenta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..EMAIL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cliedragon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TELEFONO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..TIPODOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NOMYAPE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NRODOC ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CLIECOM ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					lcCampo = lcCursor + '.' + this.cCampoCodigoWH
					this.AgregarMensajeWebHook( 'INGRESAR', &lcCampo )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTEECOMMERCE'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( numero C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Cliente ecommerce: ' + transform( &tcCursor..CLIENECOM  )
		lcRetorno = lcRetorno + ' - Plataforma: ' + transform( &tcCursor..cuenta     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function AgregarMensajeWebHook( tcEvento as String, tcCodigo as String ) As Void

		if ( alltrim( tcEvento ) = 'MODIFICAR' and this.oEntidad.lWHModificar ) or ( alltrim( tcEvento ) = 'INGRESAR' and this.oEntidad.lWHIngresar )
			goServicios.WebHook.AgregarMensajeALaCola( tcEvento, tcCodigo, this.oEntidad.cNombre )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function EnviarColaWebHook() As Void
		goServicios.WebHook.EnviarColaDeMensajes( this.oEntidad.cNombre )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CLIENTEECOMMERCE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CLIENTEECOMMERCE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CLIENTEECOMMERCE_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CLIECOM')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CLIENTEECOMMERCE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..numero
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..CLIENECOM ) or isnull( &lcCursor..cuenta )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CLIENTEECOMMERCE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTEECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,numero as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( numero, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,CLIENECOM + cuenta as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CLIENECOM + cuenta, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTEECOMMERCE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CLIECOM') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CLIECOM
Create Table ZooLogic.TablaTrabajo_CLIECOM ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"vmodifw" char( 13 )  null, 
"numero" char( 10 )  null, 
"obs" varchar(max)  null, 
"clienecom" char( 40 )  null, 
"nombre" char( 40 )  null, 
"apellido" char( 40 )  null, 
"cuenta" char( 10 )  null, 
"email" char( 100 )  null, 
"cliedragon" char( 10 )  null, 
"telefono" char( 40 )  null, 
"tipodoc" char( 5 )  null, 
"nomyape" char( 80 )  null, 
"nrodoc" char( 40 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CLIECOM' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CLIECOM' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CLIENTEECOMMERCE'
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
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('clienecom','clienecom')
			.AgregarMapeo('nombre','nombre')
			.AgregarMapeo('apellido','apellido')
			.AgregarMapeo('cuenta','cuenta')
			.AgregarMapeo('email','email')
			.AgregarMapeo('cliedragon','cliedragon')
			.AgregarMapeo('telefono','telefono')
			.AgregarMapeo('tipodoc','tipodoc')
			.AgregarMapeo('nomyape','nomyape')
			.AgregarMapeo('nrodoc','nrodoc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CLIECOM'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.OBS = isnull( d.OBS, t.OBS ),t.CLIENECOM = isnull( d.CLIENECOM, t.CLIENECOM ),t.NOMBRE = isnull( d.NOMBRE, t.NOMBRE ),t.APELLIDO = isnull( d.APELLIDO, t.APELLIDO ),t.CUENTA = isnull( d.CUENTA, t.CUENTA ),t.EMAIL = isnull( d.EMAIL, t.EMAIL ),t.CLIEDRAGON = isnull( d.CLIEDRAGON, t.CLIEDRAGON ),t.TELEFONO = isnull( d.TELEFONO, t.TELEFONO ),t.TIPODOC = isnull( d.TIPODOC, t.TIPODOC ),t.NOMYAPE = isnull( d.NOMYAPE, t.NOMYAPE ),t.NRODOC = isnull( d.NRODOC, t.NRODOC )
					from ZooLogic.CLIECOM t inner join deleted d 
							 on t.numero = d.numero
							 and  t.CLIENECOM = d.CLIENECOM
							 and  t.cuenta = d.cuenta
				-- Fin Updates
				insert into ZooLogic.CLIECOM(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Haltafw,Horaexpo,Valtafw,Hmodifw,Horaimpo,Ualtafw,Saltafw,Smodifw,Zadsfw,Bdaltafw,Umodifw,Bdmodifw,Esttrans,Vmodifw,Numero,Obs,Clienecom,Nombre,Apellido,Cuenta,Email,Cliedragon,Telefono,Tipodoc,Nomyape,Nrodoc)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.UMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.VMODIFW,''),isnull( d.NUMERO,''),isnull( d.OBS,''),isnull( d.CLIENECOM,''),isnull( d.NOMBRE,''),isnull( d.APELLIDO,''),isnull( d.CUENTA,''),isnull( d.EMAIL,''),isnull( d.CLIEDRAGON,''),isnull( d.TELEFONO,''),isnull( d.TIPODOC,''),isnull( d.NOMYAPE,''),isnull( d.NRODOC,'')
						From deleted d left join ZooLogic.CLIECOM pk 
							 on d.numero = pk.numero
						 left join ZooLogic.CLIECOM cc 
							 on  d.CLIENECOM = cc.CLIENECOM
							 and  d.cuenta = cc.cuenta
						Where pk.numero Is Null 
							 and cc.CLIENECOM Is Null 
							 and cc.cuenta Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CLIENTE ECOMMERCE ' + cast( d.CLIENECOM as Varchar(40) ) + ', PLATAFORMA ' + cast( d.cuenta as Varchar(10) ) + '','La clave principal no es la esperada'
					from ZooLogic.CLIECOM t inner join deleted d 
							on   t.CLIENECOM = d.CLIENECOM
							 and  t.cuenta = d.cuenta
						left join deleted h 
							 on t.numero = h.numero
							 where h.numero is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CLIENTE ECOMMERCE ' + cast( d.CLIENECOM as Varchar(40) ) + ', PLATAFORMA ' + cast( d.cuenta as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CLIECOM t inner join deleted d 
							 on t.numero = d.numero
						left join deleted h 
							on   t.CLIENECOM = h.CLIENECOM
							 and   t.cuenta = h.cuenta
							where   h.CLIENECOM is null 
							 and   h.cuenta is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CLIECOM') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CLIECOM
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CLIENTEECOMMERCE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTEECOMMERCE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTEECOMMERCE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTEECOMMERCE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTEECOMMERCE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CLIENTEECOMMERCE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_CLIENTEECOMMERCE.Horaaltafw, [] )
					.Horaexpo = nvl( c_CLIENTEECOMMERCE.Horaexpo, [] )
					.Versionaltafw = nvl( c_CLIENTEECOMMERCE.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_CLIENTEECOMMERCE.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_CLIENTEECOMMERCE.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_CLIENTEECOMMERCE.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_CLIENTEECOMMERCE.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_CLIENTEECOMMERCE.Seriemodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_CLIENTEECOMMERCE.Basededatosaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CLIENTEECOMMERCE.Usuariomodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_CLIENTEECOMMERCE.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_CLIENTEECOMMERCE.Estadotransferencia, [] )
					.Versionmodificacionfw = nvl( c_CLIENTEECOMMERCE.Versionmodificacionfw, [] )
					.Codigo = nvl( c_CLIENTEECOMMERCE.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Clienteecommerce = nvl( c_CLIENTEECOMMERCE.Clienteecommerce, [] )
					.Nombre = nvl( c_CLIENTEECOMMERCE.Nombre, [] )
					.Apellido = nvl( c_CLIENTEECOMMERCE.Apellido, [] )
					.Cuentaecommerce_PK =  nvl( c_CLIENTEECOMMERCE.Cuentaecommerce, [] )
					.Mail = nvl( c_CLIENTEECOMMERCE.Mail, [] )
					.Clientedragon_PK =  nvl( c_CLIENTEECOMMERCE.Clientedragon, [] )
					.Telefono = nvl( c_CLIENTEECOMMERCE.Telefono, [] )
					.Tipodoc = nvl( c_CLIENTEECOMMERCE.Tipodoc, [] )
					.Nombrecompleto = nvl( c_CLIENTEECOMMERCE.Nombrecompleto, [] )
					.Nrodoc = nvl( c_CLIENTEECOMMERCE.Nrodoc, [] )
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
			lxRetorno = c_CLIENTEECOMMERCE.CODIGO
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
		return c_CLIENTEECOMMERCE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CLIECOM' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "numero"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,numero as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    numero from (
							select * 
								from ZooLogic.CLIECOM 
								Where   CLIECOM.NUMERO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CLIECOM", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "numero"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Numero" as "Codigo", "Obs" as "Observacion", "Clienecom" as "Clienteecommerce", "Nombre" as "Nombre", "Apellido" as "Apellido", "Cuenta" as "Cuentaecommerce", "Email" as "Mail", "Cliedragon" as "Clientedragon", "Telefono" as "Telefono", "Tipodoc" as "Tipodoc", "Nomyape" as "Nombrecompleto", "Nrodoc" as "Nrodoc"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CLIECOM 
								Where   CLIECOM.NUMERO != ''
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
	Tabla = 'CLIECOM'
	Filtro = " CLIECOM.NUMERO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CLIECOM.NUMERO != ''"
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
	<row entidad="CLIENTEECOMMERCE                        " atributo="FECHAIMPO                               " tabla="CLIECOM        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="FECHATRANSFERENCIA                      " tabla="CLIECOM        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="FECHAMODIFICACIONFW                     " tabla="CLIECOM        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="FECHAEXPO                               " tabla="CLIECOM        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="FECHAALTAFW                             " tabla="CLIECOM        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="HORAALTAFW                              " tabla="CLIECOM        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="HORAEXPO                                " tabla="CLIECOM        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="VERSIONALTAFW                           " tabla="CLIECOM        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="HORAMODIFICACIONFW                      " tabla="CLIECOM        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="HORAIMPO                                " tabla="CLIECOM        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="USUARIOALTAFW                           " tabla="CLIECOM        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="SERIEALTAFW                             " tabla="CLIECOM        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="SERIEMODIFICACIONFW                     " tabla="CLIECOM        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="ZADSFW                                  " tabla="CLIECOM        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="BASEDEDATOSALTAFW                       " tabla="CLIECOM        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="USUARIOMODIFICACIONFW                   " tabla="CLIECOM        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CLIECOM        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="ESTADOTRANSFERENCIA                     " tabla="CLIECOM        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="VERSIONMODIFICACIONFW                   " tabla="CLIECOM        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="CODIGO                                  " tabla="CLIECOM        " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="OBSERVACION                             " tabla="CLIECOM        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="CLIENTEECOMMERCE                        " tabla="CLIECOM        " campo="CLIENECOM " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Cliente ecommerce                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="NOMBRE                                  " tabla="CLIECOM        " campo="NOMBRE    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Nombre                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="APELLIDO                                " tabla="CLIECOM        " campo="APELLIDO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Apellido                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="CUENTAECOMMERCE                         " tabla="CLIECOM        " campo="CUENTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ECOMMERCE                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Plataforma                                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="MAIL                                    " tabla="CLIECOM        " campo="EMAIL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Mail                                                                                                                                                            " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="CLIENTEDRAGON                           " tabla="CLIECOM        " campo="CLIEDRAGON" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Cliente Dragonfish                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="TELEFONO                                " tabla="CLIECOM        " campo="TELEFONO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="TIPODOC                                 " tabla="CLIECOM        " campo="TIPODOC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Tipo de documento                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="NOMBRECOMPLETO                          " tabla="CLIECOM        " campo="NOMYAPE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta=".                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTEECOMMERCE                        " atributo="NRODOC                                  " tabla="CLIECOM        " campo="NRODOC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Número de documento                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="DESCRIPCION                             " tabla="ECOM           " campo="CUENTA    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="5" etiqueta="Detalle Pla.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ECOM On CLIECOM.CUENTA = ECOM.CODIGO And  ECOM.CODIGO != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="7" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On CLIECOM.CLIEDRAGON = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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