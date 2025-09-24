
define class Din_EntidadSUCURSALAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_SUCURSAL'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_SUCPK'
	cTablaPrincipal = 'SUC'
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
			local  lxSucFmodifw, lxSucFaltafw, lxSucFectrans, lxSucFecexpo, lxSucFecimpo, lxSucHaltafw, lxSucHoraexpo, lxSucSmodifw, lxSucVmodifw, lxSucZadsfw, lxSucValtafw, lxSucUaltafw, lxSucUmodifw, lxSucHmodifw, lxSucSaltafw, lxSucHoraimpo, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucCodigo, lxSucCalle, lxSucDescrip, lxSucTipo, lxSucNumero, lxSucLinea, lxSucObs, lxSucPiso, lxSucSeg, lxSucDepartam, lxSucM2, lxSucHorario, lxSucLocali, lxSucCp, lxSucProvin, lxSucPais, lxSucUbicacion, lxSucCltlf, lxSucClemail
				lxSucFmodifw =  .Fechamodificacionfw			lxSucFaltafw =  .Fechaaltafw			lxSucFectrans =  .Fechatransferencia			lxSucFecexpo =  .Fechaexpo			lxSucFecimpo =  .Fechaimpo			lxSucHaltafw =  .Horaaltafw			lxSucHoraexpo =  .Horaexpo			lxSucSmodifw =  .Seriemodificacionfw			lxSucVmodifw =  .Versionmodificacionfw			lxSucZadsfw =  .Zadsfw			lxSucValtafw =  .Versionaltafw			lxSucUaltafw =  .Usuarioaltafw			lxSucUmodifw =  .Usuariomodificacionfw			lxSucHmodifw =  .Horamodificacionfw			lxSucSaltafw =  .Seriealtafw			lxSucHoraimpo =  .Horaimpo			lxSucEsttrans =  .Estadotransferencia			lxSucBdaltafw =  .Basededatosaltafw			lxSucBdmodifw =  .Basededatosmodificacionfw			lxSucCodigo =  .Codigo			lxSucCalle =  .Calle			lxSucDescrip =  .Descripcion			lxSucTipo =  upper( .tipo_PK ) 			lxSucNumero =  .Numero			lxSucLinea =  upper( .Linea_PK ) 			lxSucObs =  .Observaciones			lxSucPiso =  .Piso			lxSucSeg =  upper( .Segmentacion_PK ) 			lxSucDepartam =  .Departamento			lxSucM2 =  .Metroscuadrados			lxSucHorario =  .Horario			lxSucLocali =  .Localidad			lxSucCp =  .Codigopostal			lxSucProvin =  upper( .Provincia_PK ) 			lxSucPais =  upper( .Pais_PK ) 			lxSucUbicacion =  .Ubicacion			lxSucCltlf =  .Telefono			lxSucClemail =  .Email
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxSucCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.SUC ( "Fmodifw","Faltafw","Fectrans","Fecexpo","Fecimpo","Haltafw","Horaexpo","Smodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Hmodifw","Saltafw","Horaimpo","Esttrans","Bdaltafw","Bdmodifw","Codigo","Calle","Descrip","Tipo","Numero","Linea","Obs","Piso","Seg","Departam","M2","Horario","Locali","Cp","Provin","Pais","Ubicacion","Cltlf","Clemail" ) values ( <<"'" + this.ConvertirDateSql( lxSucFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucTipo ) + "'" >>, <<lxSucNumero >>, <<"'" + this.FormatearTextoSql( lxSucLinea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucPiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSeg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucDepartam ) + "'" >>, <<lxSucM2 >>, <<"'" + this.FormatearTextoSql( lxSucHorario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucLocali ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucProvin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucPais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucUbicacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClemail ) + "'" >> )
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
			local  lxSucFmodifw, lxSucFaltafw, lxSucFectrans, lxSucFecexpo, lxSucFecimpo, lxSucHaltafw, lxSucHoraexpo, lxSucSmodifw, lxSucVmodifw, lxSucZadsfw, lxSucValtafw, lxSucUaltafw, lxSucUmodifw, lxSucHmodifw, lxSucSaltafw, lxSucHoraimpo, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucCodigo, lxSucCalle, lxSucDescrip, lxSucTipo, lxSucNumero, lxSucLinea, lxSucObs, lxSucPiso, lxSucSeg, lxSucDepartam, lxSucM2, lxSucHorario, lxSucLocali, lxSucCp, lxSucProvin, lxSucPais, lxSucUbicacion, lxSucCltlf, lxSucClemail
				lxSucFmodifw =  .Fechamodificacionfw			lxSucFaltafw =  .Fechaaltafw			lxSucFectrans =  .Fechatransferencia			lxSucFecexpo =  .Fechaexpo			lxSucFecimpo =  .Fechaimpo			lxSucHaltafw =  .Horaaltafw			lxSucHoraexpo =  .Horaexpo			lxSucSmodifw =  .Seriemodificacionfw			lxSucVmodifw =  .Versionmodificacionfw			lxSucZadsfw =  .Zadsfw			lxSucValtafw =  .Versionaltafw			lxSucUaltafw =  .Usuarioaltafw			lxSucUmodifw =  .Usuariomodificacionfw			lxSucHmodifw =  .Horamodificacionfw			lxSucSaltafw =  .Seriealtafw			lxSucHoraimpo =  .Horaimpo			lxSucEsttrans =  .Estadotransferencia			lxSucBdaltafw =  .Basededatosaltafw			lxSucBdmodifw =  .Basededatosmodificacionfw			lxSucCodigo =  .Codigo			lxSucCalle =  .Calle			lxSucDescrip =  .Descripcion			lxSucTipo =  upper( .tipo_PK ) 			lxSucNumero =  .Numero			lxSucLinea =  upper( .Linea_PK ) 			lxSucObs =  .Observaciones			lxSucPiso =  .Piso			lxSucSeg =  upper( .Segmentacion_PK ) 			lxSucDepartam =  .Departamento			lxSucM2 =  .Metroscuadrados			lxSucHorario =  .Horario			lxSucLocali =  .Localidad			lxSucCp =  .Codigopostal			lxSucProvin =  upper( .Provincia_PK ) 			lxSucPais =  upper( .Pais_PK ) 			lxSucUbicacion =  .Ubicacion			lxSucCltlf =  .Telefono			lxSucClemail =  .Email
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.SUC set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSucFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxSucFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxSucFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxSucFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxSucFecimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxSucHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxSucHoraexpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxSucSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxSucVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxSucZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxSucValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxSucUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxSucUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxSucHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxSucSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxSucHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxSucEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSucBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSucBdmodifw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">>,"Calle" = <<"'" + this.FormatearTextoSql( lxSucCalle ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxSucDescrip ) + "'">>,"Tipo" = <<"'" + this.FormatearTextoSql( lxSucTipo ) + "'">>,"Numero" = <<lxSucNumero>>,"Linea" = <<"'" + this.FormatearTextoSql( lxSucLinea ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxSucObs ) + "'">>,"Piso" = <<"'" + this.FormatearTextoSql( lxSucPiso ) + "'">>,"Seg" = <<"'" + this.FormatearTextoSql( lxSucSeg ) + "'">>,"Departam" = <<"'" + this.FormatearTextoSql( lxSucDepartam ) + "'">>,"M2" = <<lxSucM2>>,"Horario" = <<"'" + this.FormatearTextoSql( lxSucHorario ) + "'">>,"Locali" = <<"'" + this.FormatearTextoSql( lxSucLocali ) + "'">>,"Cp" = <<"'" + this.FormatearTextoSql( lxSucCp ) + "'">>,"Provin" = <<"'" + this.FormatearTextoSql( lxSucProvin ) + "'">>,"Pais" = <<"'" + this.FormatearTextoSql( lxSucPais ) + "'">>,"Ubicacion" = <<"'" + this.FormatearTextoSql( lxSucUbicacion ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxSucCltlf ) + "'">>,"Clemail" = <<"'" + this.FormatearTextoSql( lxSucClemail ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">> and  SUC.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ORGANIZACION.SUC where " + this.ConvertirFuncionesSql( " SUC.CODIGO != ''" ) )
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
			Local lxSucCodigo
			lxSucCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Calle" as "Calle", "Descrip" as "Descripcion", "Tipo" as "Tipo", "Numero" as "Numero", "Linea" as "Linea", "Obs" as "Observaciones", "Piso" as "Piso", "Seg" as "Segmentacion", "Departam" as "Departamento", "M2" as "Metroscuadrados", "Horario" as "Horario", "Locali" as "Localidad", "Cp" as "Codigopostal", "Provin" as "Provincia", "Pais" as "Pais", "Ubicacion" as "Ubicacion", "Cltlf" as "Telefono", "Clemail" as "Email" from ORGANIZACION.SUC where "Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">> and  SUC.CODIGO != ''
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )

			if reccount( 'c_SUCURSAL' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxSucCodigo as Variant
		llRetorno = .t.
		lxSucCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.SUC where "Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">> and  SUC.CODIGO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Calle" as "Calle", "Descrip" as "Descripcion", "Tipo" as "Tipo", "Numero" as "Numero", "Linea" as "Linea", "Obs" as "Observaciones", "Piso" as "Piso", "Seg" as "Segmentacion", "Departam" as "Departamento", "M2" as "Metroscuadrados", "Horario" as "Horario", "Locali" as "Localidad", "Cp" as "Codigopostal", "Provin" as "Provincia", "Pais" as "Pais", "Ubicacion" as "Ubicacion", "Cltlf" as "Telefono", "Clemail" as "Email" from ORGANIZACION.SUC where  SUC.CODIGO != '' order by codigo
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Calle" as "Calle", "Descrip" as "Descripcion", "Tipo" as "Tipo", "Numero" as "Numero", "Linea" as "Linea", "Obs" as "Observaciones", "Piso" as "Piso", "Seg" as "Segmentacion", "Departam" as "Departamento", "M2" as "Metroscuadrados", "Horario" as "Horario", "Locali" as "Localidad", "Cp" as "Codigopostal", "Provin" as "Provincia", "Pais" as "Pais", "Ubicacion" as "Ubicacion", "Cltlf" as "Telefono", "Clemail" as "Email" from ORGANIZACION.SUC where  funciones.padr( codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SUC.CODIGO != '' order by codigo
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Calle" as "Calle", "Descrip" as "Descripcion", "Tipo" as "Tipo", "Numero" as "Numero", "Linea" as "Linea", "Obs" as "Observaciones", "Piso" as "Piso", "Seg" as "Segmentacion", "Departam" as "Departamento", "M2" as "Metroscuadrados", "Horario" as "Horario", "Locali" as "Localidad", "Cp" as "Codigopostal", "Provin" as "Provincia", "Pais" as "Pais", "Ubicacion" as "Ubicacion", "Cltlf" as "Telefono", "Clemail" as "Email" from ORGANIZACION.SUC where  funciones.padr( codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SUC.CODIGO != '' order by codigo desc
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Calle" as "Calle", "Descrip" as "Descripcion", "Tipo" as "Tipo", "Numero" as "Numero", "Linea" as "Linea", "Obs" as "Observaciones", "Piso" as "Piso", "Seg" as "Segmentacion", "Departam" as "Departamento", "M2" as "Metroscuadrados", "Horario" as "Horario", "Locali" as "Localidad", "Cp" as "Codigopostal", "Provin" as "Provincia", "Pais" as "Pais", "Ubicacion" as "Ubicacion", "Cltlf" as "Telefono", "Clemail" as "Email" from ORGANIZACION.SUC where  SUC.CODIGO != '' order by codigo desc
			endtext
			use in select('c_SUCURSAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SUCURSAL', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Faltafw,Fectrans,Fecexpo,Fecimpo,Haltafw,Horaexpo,Smodifw,Vmodifw,Zadsfw,Valtafw,Ual" + ;
"tafw,Umodifw,Hmodifw,Saltafw,Horaimpo,Esttrans,Bdaltafw,Bdmodifw,Codigo,Calle,Descrip,Tipo,Numero,Li" + ;
"nea,Obs,Piso,Seg,Departam,M2,Horario,Locali,Cp,Provin,Pais,Ubicacion,Cltlf,Clemail" + ;
" from ORGANIZACION.SUC where  SUC.CODIGO != '' and " + lcFiltro )
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
			local  lxSucFmodifw, lxSucFaltafw, lxSucFectrans, lxSucFecexpo, lxSucFecimpo, lxSucHaltafw, lxSucHoraexpo, lxSucSmodifw, lxSucVmodifw, lxSucZadsfw, lxSucValtafw, lxSucUaltafw, lxSucUmodifw, lxSucHmodifw, lxSucSaltafw, lxSucHoraimpo, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucCodigo, lxSucCalle, lxSucDescrip, lxSucTipo, lxSucNumero, lxSucLinea, lxSucObs, lxSucPiso, lxSucSeg, lxSucDepartam, lxSucM2, lxSucHorario, lxSucLocali, lxSucCp, lxSucProvin, lxSucPais, lxSucUbicacion, lxSucCltlf, lxSucClemail
				lxSucFmodifw = ctod( '  /  /    ' )			lxSucFaltafw = ctod( '  /  /    ' )			lxSucFectrans = ctod( '  /  /    ' )			lxSucFecexpo = ctod( '  /  /    ' )			lxSucFecimpo = ctod( '  /  /    ' )			lxSucHaltafw = []			lxSucHoraexpo = []			lxSucSmodifw = []			lxSucVmodifw = []			lxSucZadsfw = []			lxSucValtafw = []			lxSucUaltafw = []			lxSucUmodifw = []			lxSucHmodifw = []			lxSucSaltafw = []			lxSucHoraimpo = []			lxSucEsttrans = []			lxSucBdaltafw = []			lxSucBdmodifw = []			lxSucCodigo = []			lxSucCalle = []			lxSucDescrip = []			lxSucTipo = []			lxSucNumero = 0			lxSucLinea = []			lxSucObs = []			lxSucPiso = []			lxSucSeg = []			lxSucDepartam = []			lxSucM2 = 0			lxSucHorario = []			lxSucLocali = []			lxSucCp = []			lxSucProvin = []			lxSucPais = []			lxSucUbicacion = []			lxSucCltlf = []			lxSucClemail = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.SUC where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'SUC' + '_' + tcCampo
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
		lcWhere = " Where  SUC.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Calle" as "Calle", "Descrip" as "Descripcion", "Tipo" as "Tipo", "Numero" as "Numero", "Linea" as "Linea", "Obs" as "Observaciones", "Piso" as "Piso", "Seg" as "Segmentacion", "Departam" as "Departamento", "M2" as "Metroscuadrados", "Horario" as "Horario", "Locali" as "Localidad", "Cp" as "Codigopostal", "Provin" as "Provincia", "Pais" as "Pais", "Ubicacion" as "Ubicacion", "Cltlf" as "Telefono", "Clemail" as "Email"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SUC', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CALLE AS CALLE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'LINEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINEA AS LINEA'
				Case lcAtributo == 'OBSERVACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACIONES'
				Case lcAtributo == 'PISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PISO AS PISO'
				Case lcAtributo == 'SEGMENTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SEG AS SEGMENTACION'
				Case lcAtributo == 'DEPARTAMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DEPARTAM AS DEPARTAMENTO'
				Case lcAtributo == 'METROSCUADRADOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'M2 AS METROSCUADRADOS'
				Case lcAtributo == 'HORARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORARIO AS HORARIO'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LOCALI AS LOCALIDAD'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVIN AS PROVINCIA'
				Case lcAtributo == 'PAIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAIS AS PAIS'
				Case lcAtributo == 'UBICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UBICACION AS UBICACION'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEMAIL AS EMAIL'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CALLE'
				lcCampo = 'CALLE'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'LINEA'
				lcCampo = 'LINEA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACIONES'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'PISO'
				lcCampo = 'PISO'
			Case upper( alltrim( tcAtributo ) ) == 'SEGMENTACION'
				lcCampo = 'SEG'
			Case upper( alltrim( tcAtributo ) ) == 'DEPARTAMENTO'
				lcCampo = 'DEPARTAM'
			Case upper( alltrim( tcAtributo ) ) == 'METROSCUADRADOS'
				lcCampo = 'M2'
			Case upper( alltrim( tcAtributo ) ) == 'HORARIO'
				lcCampo = 'HORARIO'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'LOCALI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'PROVIN'
			Case upper( alltrim( tcAtributo ) ) == 'PAIS'
				lcCampo = 'PAIS'
			Case upper( alltrim( tcAtributo ) ) == 'UBICACION'
				lcCampo = 'UBICACION'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'CLEMAIL'
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
			local  lxSucFmodifw, lxSucFaltafw, lxSucFectrans, lxSucFecexpo, lxSucFecimpo, lxSucHaltafw, lxSucHoraexpo, lxSucSmodifw, lxSucVmodifw, lxSucZadsfw, lxSucValtafw, lxSucUaltafw, lxSucUmodifw, lxSucHmodifw, lxSucSaltafw, lxSucHoraimpo, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucCodigo, lxSucCalle, lxSucDescrip, lxSucTipo, lxSucNumero, lxSucLinea, lxSucObs, lxSucPiso, lxSucSeg, lxSucDepartam, lxSucM2, lxSucHorario, lxSucLocali, lxSucCp, lxSucProvin, lxSucPais, lxSucUbicacion, lxSucCltlf, lxSucClemail
				lxSucFmodifw =  .Fechamodificacionfw			lxSucFaltafw =  .Fechaaltafw			lxSucFectrans =  .Fechatransferencia			lxSucFecexpo =  .Fechaexpo			lxSucFecimpo =  .Fechaimpo			lxSucHaltafw =  .Horaaltafw			lxSucHoraexpo =  .Horaexpo			lxSucSmodifw =  .Seriemodificacionfw			lxSucVmodifw =  .Versionmodificacionfw			lxSucZadsfw =  .Zadsfw			lxSucValtafw =  .Versionaltafw			lxSucUaltafw =  .Usuarioaltafw			lxSucUmodifw =  .Usuariomodificacionfw			lxSucHmodifw =  .Horamodificacionfw			lxSucSaltafw =  .Seriealtafw			lxSucHoraimpo =  .Horaimpo			lxSucEsttrans =  .Estadotransferencia			lxSucBdaltafw =  .Basededatosaltafw			lxSucBdmodifw =  .Basededatosmodificacionfw			lxSucCodigo =  .Codigo			lxSucCalle =  .Calle			lxSucDescrip =  .Descripcion			lxSucTipo =  upper( .tipo_PK ) 			lxSucNumero =  .Numero			lxSucLinea =  upper( .Linea_PK ) 			lxSucObs =  .Observaciones			lxSucPiso =  .Piso			lxSucSeg =  upper( .Segmentacion_PK ) 			lxSucDepartam =  .Departamento			lxSucM2 =  .Metroscuadrados			lxSucHorario =  .Horario			lxSucLocali =  .Localidad			lxSucCp =  .Codigopostal			lxSucProvin =  upper( .Provincia_PK ) 			lxSucPais =  upper( .Pais_PK ) 			lxSucUbicacion =  .Ubicacion			lxSucCltlf =  .Telefono			lxSucClemail =  .Email
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.SUC ( "Fmodifw","Faltafw","Fectrans","Fecexpo","Fecimpo","Haltafw","Horaexpo","Smodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Hmodifw","Saltafw","Horaimpo","Esttrans","Bdaltafw","Bdmodifw","Codigo","Calle","Descrip","Tipo","Numero","Linea","Obs","Piso","Seg","Departam","M2","Horario","Locali","Cp","Provin","Pais","Ubicacion","Cltlf","Clemail" ) values ( <<"'" + this.ConvertirDateSql( lxSucFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSucFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucTipo ) + "'" >>, <<lxSucNumero >>, <<"'" + this.FormatearTextoSql( lxSucLinea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucPiso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucSeg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucDepartam ) + "'" >>, <<lxSucM2 >>, <<"'" + this.FormatearTextoSql( lxSucHorario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucLocali ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucProvin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucPais ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucUbicacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSucClemail ) + "'" >> )
		endtext
		loColeccion.cTabla = 'SUC' 
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
			local  lxSucFmodifw, lxSucFaltafw, lxSucFectrans, lxSucFecexpo, lxSucFecimpo, lxSucHaltafw, lxSucHoraexpo, lxSucSmodifw, lxSucVmodifw, lxSucZadsfw, lxSucValtafw, lxSucUaltafw, lxSucUmodifw, lxSucHmodifw, lxSucSaltafw, lxSucHoraimpo, lxSucEsttrans, lxSucBdaltafw, lxSucBdmodifw, lxSucCodigo, lxSucCalle, lxSucDescrip, lxSucTipo, lxSucNumero, lxSucLinea, lxSucObs, lxSucPiso, lxSucSeg, lxSucDepartam, lxSucM2, lxSucHorario, lxSucLocali, lxSucCp, lxSucProvin, lxSucPais, lxSucUbicacion, lxSucCltlf, lxSucClemail
				lxSucFmodifw =  .Fechamodificacionfw			lxSucFaltafw =  .Fechaaltafw			lxSucFectrans =  .Fechatransferencia			lxSucFecexpo =  .Fechaexpo			lxSucFecimpo =  .Fechaimpo			lxSucHaltafw =  .Horaaltafw			lxSucHoraexpo =  .Horaexpo			lxSucSmodifw =  .Seriemodificacionfw			lxSucVmodifw =  .Versionmodificacionfw			lxSucZadsfw =  .Zadsfw			lxSucValtafw =  .Versionaltafw			lxSucUaltafw =  .Usuarioaltafw			lxSucUmodifw =  .Usuariomodificacionfw			lxSucHmodifw =  .Horamodificacionfw			lxSucSaltafw =  .Seriealtafw			lxSucHoraimpo =  .Horaimpo			lxSucEsttrans =  .Estadotransferencia			lxSucBdaltafw =  .Basededatosaltafw			lxSucBdmodifw =  .Basededatosmodificacionfw			lxSucCodigo =  .Codigo			lxSucCalle =  .Calle			lxSucDescrip =  .Descripcion			lxSucTipo =  upper( .tipo_PK ) 			lxSucNumero =  .Numero			lxSucLinea =  upper( .Linea_PK ) 			lxSucObs =  .Observaciones			lxSucPiso =  .Piso			lxSucSeg =  upper( .Segmentacion_PK ) 			lxSucDepartam =  .Departamento			lxSucM2 =  .Metroscuadrados			lxSucHorario =  .Horario			lxSucLocali =  .Localidad			lxSucCp =  .Codigopostal			lxSucProvin =  upper( .Provincia_PK ) 			lxSucPais =  upper( .Pais_PK ) 			lxSucUbicacion =  .Ubicacion			lxSucCltlf =  .Telefono			lxSucClemail =  .Email
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SUC.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.SUC set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSucFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxSucFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxSucFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSucFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSucFecimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxSucHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxSucHoraexpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxSucSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxSucVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxSucZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxSucValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxSucUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxSucUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxSucHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxSucSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxSucHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxSucEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSucBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSucBdmodifw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxSucCodigo ) + "'">>, "Calle" = <<"'" + this.FormatearTextoSql( lxSucCalle ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxSucDescrip ) + "'">>, "Tipo" = <<"'" + this.FormatearTextoSql( lxSucTipo ) + "'">>, "Numero" = <<lxSucNumero>>, "Linea" = <<"'" + this.FormatearTextoSql( lxSucLinea ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxSucObs ) + "'">>, "Piso" = <<"'" + this.FormatearTextoSql( lxSucPiso ) + "'">>, "Seg" = <<"'" + this.FormatearTextoSql( lxSucSeg ) + "'">>, "Departam" = <<"'" + this.FormatearTextoSql( lxSucDepartam ) + "'">>, "M2" = <<lxSucM2>>, "Horario" = <<"'" + this.FormatearTextoSql( lxSucHorario ) + "'">>, "Locali" = <<"'" + this.FormatearTextoSql( lxSucLocali ) + "'">>, "Cp" = <<"'" + this.FormatearTextoSql( lxSucCp ) + "'">>, "Provin" = <<"'" + this.FormatearTextoSql( lxSucProvin ) + "'">>, "Pais" = <<"'" + this.FormatearTextoSql( lxSucPais ) + "'">>, "Ubicacion" = <<"'" + this.FormatearTextoSql( lxSucUbicacion ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxSucCltlf ) + "'">>, "Clemail" = <<"'" + this.FormatearTextoSql( lxSucClemail ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SUC' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SUC.CODIGO != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.SUC where ' + lcFiltro )
			loColeccion.cTabla = 'SUC' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.SUC where  SUC.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.SUC where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SUC.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.SUC Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.SUC set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, calle = ] + "'" + this.FormatearTextoSql( &lcCursor..calle ) + "'"+ [, descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'"+ [, Tipo = ] + "'" + this.FormatearTextoSql( &lcCursor..Tipo ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Linea = ] + "'" + this.FormatearTextoSql( &lcCursor..Linea ) + "'"+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"+ [, piso = ] + "'" + this.FormatearTextoSql( &lcCursor..piso ) + "'"+ [, seg = ] + "'" + this.FormatearTextoSql( &lcCursor..seg ) + "'"+ [, Departam = ] + "'" + this.FormatearTextoSql( &lcCursor..Departam ) + "'"+ [, m2 = ] + transform( &lcCursor..m2 )+ [, horario = ] + "'" + this.FormatearTextoSql( &lcCursor..horario ) + "'"+ [, Locali = ] + "'" + this.FormatearTextoSql( &lcCursor..Locali ) + "'"+ [, CP = ] + "'" + this.FormatearTextoSql( &lcCursor..CP ) + "'"+ [, provin = ] + "'" + this.FormatearTextoSql( &lcCursor..provin ) + "'"+ [, pais = ] + "'" + this.FormatearTextoSql( &lcCursor..pais ) + "'"+ [, Ubicacion = ] + "'" + this.FormatearTextoSql( &lcCursor..Ubicacion ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, CLEMAIL = ] + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FALTAFW, FECTRANS, FECEXPO, FECIMPO, HALTAFW, HORAEXPO, SMODIFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, HMODIFW, SALTAFW, HORAIMPO, ESTTRANS, BDALTAFW, BDMODIFW, codigo, calle, descrip, Tipo, Numero, Linea, OBS, piso, seg, Departam, m2, horario, Locali, CP, provin, pais, Ubicacion, CLTLF, CLEMAIL
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..calle ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Tipo ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Linea ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..piso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..seg ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Departam ) + "'" + ',' + transform( &lcCursor..m2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..horario ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Locali ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..provin ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..pais ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Ubicacion ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLEMAIL ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.SUC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'SUCURSAL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SUCURSAL_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'SUCURSAL_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_suc')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'SUCURSAL'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad SUCURSAL. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_suc') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_suc
Create Table ORGANIZACION.TablaTrabajo_suc ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"codigo" char( 10 )  null, 
"calle" char( 70 )  null, 
"descrip" char( 50 )  null, 
"tipo" char( 10 )  null, 
"numero" numeric( 5, 0 )  null, 
"linea" char( 10 )  null, 
"obs" varchar(max)  null, 
"piso" char( 3 )  null, 
"seg" char( 10 )  null, 
"departam" char( 3 )  null, 
"m2" numeric( 6, 0 )  null, 
"horario" char( 100 )  null, 
"locali" char( 70 )  null, 
"cp" char( 8 )  null, 
"provin" char( 2 )  null, 
"pais" char( 3 )  null, 
"ubicacion" char( 50 )  null, 
"cltlf" char( 30 )  null, 
"clemail" char( 250 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_suc' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_suc' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'SUCURSAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('calle','calle')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('linea','linea')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('piso','piso')
			.AgregarMapeo('seg','seg')
			.AgregarMapeo('departam','departam')
			.AgregarMapeo('m2','m2')
			.AgregarMapeo('horario','horario')
			.AgregarMapeo('locali','locali')
			.AgregarMapeo('cp','cp')
			.AgregarMapeo('provin','provin')
			.AgregarMapeo('pais','pais')
			.AgregarMapeo('ubicacion','ubicacion')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('clemail','clemail')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_suc'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CALLE = isnull( d.CALLE, t.CALLE ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.LINEA = isnull( d.LINEA, t.LINEA ),t.OBS = isnull( d.OBS, t.OBS ),t.PISO = isnull( d.PISO, t.PISO ),t.SEG = isnull( d.SEG, t.SEG ),t.DEPARTAM = isnull( d.DEPARTAM, t.DEPARTAM ),t.M2 = isnull( d.M2, t.M2 ),t.HORARIO = isnull( d.HORARIO, t.HORARIO ),t.LOCALI = isnull( d.LOCALI, t.LOCALI ),t.CP = isnull( d.CP, t.CP ),t.PROVIN = isnull( d.PROVIN, t.PROVIN ),t.PAIS = isnull( d.PAIS, t.PAIS ),t.UBICACION = isnull( d.UBICACION, t.UBICACION ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.CLEMAIL = isnull( d.CLEMAIL, t.CLEMAIL )
					from ORGANIZACION.SUC t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ORGANIZACION.SUC(Fmodifw,Faltafw,Fectrans,Fecexpo,Fecimpo,Haltafw,Horaexpo,Smodifw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Hmodifw,Saltafw,Horaimpo,Esttrans,Bdaltafw,Bdmodifw,Codigo,Calle,Descrip,Tipo,Numero,Linea,Obs,Piso,Seg,Departam,M2,Horario,Locali,Cp,Provin,Pais,Ubicacion,Cltlf,Clemail)
					Select isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CODIGO,''),isnull( d.CALLE,''),isnull( d.DESCRIP,''),isnull( d.TIPO,''),isnull( d.NUMERO,0),isnull( d.LINEA,''),isnull( d.OBS,''),isnull( d.PISO,''),isnull( d.SEG,''),isnull( d.DEPARTAM,''),isnull( d.M2,0),isnull( d.HORARIO,''),isnull( d.LOCALI,''),isnull( d.CP,''),isnull( d.PROVIN,''),isnull( d.PAIS,''),isnull( d.UBICACION,''),isnull( d.CLTLF,''),isnull( d.CLEMAIL,'')
						From deleted d left join ORGANIZACION.SUC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_suc') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_suc
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_SUCURSAL' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_SUCURSAL.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_SUCURSAL.Horaaltafw, [] )
					.Horaexpo = nvl( c_SUCURSAL.Horaexpo, [] )
					.Seriemodificacionfw = nvl( c_SUCURSAL.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_SUCURSAL.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_SUCURSAL.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_SUCURSAL.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_SUCURSAL.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_SUCURSAL.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_SUCURSAL.Seriealtafw, [] )
					.Horaimpo = nvl( c_SUCURSAL.Horaimpo, [] )
					.Estadotransferencia = nvl( c_SUCURSAL.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_SUCURSAL.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_SUCURSAL.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_SUCURSAL.Codigo, [] )
					.Calle = nvl( c_SUCURSAL.Calle, [] )
					.Descripcion = nvl( c_SUCURSAL.Descripcion, [] )
					.Tipo_PK =  nvl( c_SUCURSAL.Tipo, [] )
					.Numero = nvl( c_SUCURSAL.Numero, 0 )
					.Linea_PK =  nvl( c_SUCURSAL.Linea, [] )
					lcValor = This.ObtenerMemo( 'c_Observaciones')
					.Observaciones = lcValor 
					.Piso = nvl( c_SUCURSAL.Piso, [] )
					.Segmentacion_PK =  nvl( c_SUCURSAL.Segmentacion, [] )
					.Departamento = nvl( c_SUCURSAL.Departamento, [] )
					.Metroscuadrados = nvl( c_SUCURSAL.Metroscuadrados, 0 )
					.Horario = nvl( c_SUCURSAL.Horario, [] )
					.Localidad = nvl( c_SUCURSAL.Localidad, [] )
					.Codigopostal = nvl( c_SUCURSAL.Codigopostal, [] )
					.Provincia_PK =  nvl( c_SUCURSAL.Provincia, [] )
					.Pais_PK =  nvl( c_SUCURSAL.Pais, [] )
					.Ubicacion = nvl( c_SUCURSAL.Ubicacion, [] )
					.Telefono = nvl( c_SUCURSAL.Telefono, [] )
					.Email = nvl( c_SUCURSAL.Email, [] )
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
		return c_SUCURSAL.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.SUC' )
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
								from ORGANIZACION.SUC 
								Where   SUC.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SUC", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Calle" as "Calle", "Descrip" as "Descripcion", "Tipo" as "Tipo", "Numero" as "Numero", "Linea" as "Linea", "Obs" as "Observaciones", "Piso" as "Piso", "Seg" as "Segmentacion", "Departam" as "Departamento", "M2" as "Metroscuadrados", "Horario" as "Horario", "Locali" as "Localidad", "Cp" as "Codigopostal", "Provin" as "Provincia", "Pais" as "Pais", "Ubicacion" as "Ubicacion", "Cltlf" as "Telefono", "Clemail" as "Email"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.SUC 
								Where   SUC.CODIGO != ''
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
	Tabla = 'SUC'
	Filtro = " SUC.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SUC.CODIGO != ''"
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
	<row entidad="SUCURSAL                                " atributo="FECHAMODIFICACIONFW                     " tabla="SUC            " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHAALTAFW                             " tabla="SUC            " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHATRANSFERENCIA                      " tabla="SUC            " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHAEXPO                               " tabla="SUC            " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="FECHAIMPO                               " tabla="SUC            " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="HORAALTAFW                              " tabla="SUC            " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="HORAEXPO                                " tabla="SUC            " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="SERIEMODIFICACIONFW                     " tabla="SUC            " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="VERSIONMODIFICACIONFW                   " tabla="SUC            " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="ZADSFW                                  " tabla="SUC            " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="VERSIONALTAFW                           " tabla="SUC            " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="USUARIOALTAFW                           " tabla="SUC            " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="USUARIOMODIFICACIONFW                   " tabla="SUC            " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="HORAMODIFICACIONFW                      " tabla="SUC            " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="SERIEALTAFW                             " tabla="SUC            " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="HORAIMPO                                " tabla="SUC            " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="ESTADOTRANSFERENCIA                     " tabla="SUC            " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="BASEDEDATOSALTAFW                       " tabla="SUC            " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SUC            " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="CODIGO                                  " tabla="SUC            " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="CALLE                                   " tabla="SUC            " campo="CALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Calle                                                                                                                                                           " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DESCRIPCION                             " tabla="SUC            " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="TIPO                                    " tabla="SUC            " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOSUCURSAL                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Tipo                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="NUMERO                                  " tabla="SUC            " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Número                                                                                                                                                          " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="LINEA                                   " tabla="SUC            " campo="LINEA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEASUCURSAL                           " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Línea                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="OBSERVACIONES                           " tabla="SUC            " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="PISO                                    " tabla="SUC            " campo="PISO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Piso                                                                                                                                                            " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="SEGMENTACION                            " tabla="SUC            " campo="SEG       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SEGMENTACION                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Segmentación                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="DEPARTAMENTO                            " tabla="SUC            " campo="DEPARTAM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Departamento                                                                                                                                                    " dominio="DIRECCION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="METROSCUADRADOS                         " tabla="SUC            " campo="M2        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Metros cuadrados                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="HORARIO                                 " tabla="SUC            " campo="HORARIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Horario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="LOCALIDAD                               " tabla="SUC            " campo="LOCALI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Localidad                                                                                                                                                       " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="CODIGOPOSTAL                            " tabla="SUC            " campo="CP        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Código postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="PROVINCIA                               " tabla="SUC            " campo="PROVIN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="PAIS                                    " tabla="SUC            " campo="PAIS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PAISES                                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="País                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="UBICACION                               " tabla="SUC            " campo="UBICACION " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Ubicación geográfica                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="TELEFONO                                " tabla="SUC            " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SUCURSAL                                " atributo="EMAIL                                   " tabla="SUC            " campo="CLEMAIL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Email                                                                                                                                                           " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOSUCURSAL                            " atributo="DESCRIPCION                             " tabla="TSUCUR         " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TSUCUR On SUC.TIPO = TSUCUR.TCOD And  TSUCUR.TCOD != ''                                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEASUCURSAL                           " atributo="DESCRIPCION                             " tabla="LSUCUR         " campo="LSDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LSUCUR On SUC.LINEA = LSUCUR.LSCOD And  LSUCUR.LSCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="SEGMENTACION                            " atributo="DESCRIPCION                             " tabla="SECOD          " campo="SDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Seg.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join SECOD On SUC.SEG = SECOD.SCOD And  SECOD.SCOD != ''                                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="19" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On SUC.PROVIN = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PAISES                                  " atributo="DESCRIPCION                             " tabla="PAISES         " campo="PDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Paí.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PAISES On SUC.PAIS = PAISES.pcod And  PAISES.PCOD != ''                                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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