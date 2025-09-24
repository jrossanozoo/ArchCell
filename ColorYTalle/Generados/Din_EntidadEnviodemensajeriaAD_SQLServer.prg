
define class Din_EntidadENVIODEMENSAJERIAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ENVIODEMENSAJERIA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 4, 0)]
	cExpresionCCPorCampos = [str( #tabla#.NUMERO, 4, 0)]
	cTagClaveCandidata = '_EMECC'
	cTagClavePk = '_EMEPK'
	cTablaPrincipal = 'ENVMENS'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxEnvmensFecimpo, lxEnvmensFectrans, lxEnvmensFmodifw, lxEnvmensFecexpo, lxEnvmensFaltafw, lxEnvmensSaltafw, lxEnvmensEsttrans, lxEnvmensHoraimpo, lxEnvmensHmodifw, lxEnvmensBdmodifw, lxEnvmensHoraexpo, lxEnvmensSmodifw, lxEnvmensBdaltafw, lxEnvmensVmodifw, lxEnvmensZadsfw, lxEnvmensUmodifw, lxEnvmensValtafw, lxEnvmensHaltafw, lxEnvmensUaltafw, lxEnvmensCodigo, lxEnvmensMlenvuno, lxEnvmensEcommerce, lxEnvmensNumero, lxEnvmensMlenvdos, lxEnvmensEntidad, lxEnvmensMlacordar, lxEnvmensDis, lxEnvmensMotivomens, lxEnvmensTemplate, lxEnvmensMensaje, lxEnvmensImagen
				lxEnvmensFecimpo =  .Fechaimpo			lxEnvmensFectrans =  .Fechatransferencia			lxEnvmensFmodifw =  .Fechamodificacionfw			lxEnvmensFecexpo =  .Fechaexpo			lxEnvmensFaltafw =  .Fechaaltafw			lxEnvmensSaltafw =  .Seriealtafw			lxEnvmensEsttrans =  .Estadotransferencia			lxEnvmensHoraimpo =  .Horaimpo			lxEnvmensHmodifw =  .Horamodificacionfw			lxEnvmensBdmodifw =  .Basededatosmodificacionfw			lxEnvmensHoraexpo =  .Horaexpo			lxEnvmensSmodifw =  .Seriemodificacionfw			lxEnvmensBdaltafw =  .Basededatosaltafw			lxEnvmensVmodifw =  .Versionmodificacionfw			lxEnvmensZadsfw =  .Zadsfw			lxEnvmensUmodifw =  .Usuariomodificacionfw			lxEnvmensValtafw =  .Versionaltafw			lxEnvmensHaltafw =  .Horaaltafw			lxEnvmensUaltafw =  .Usuarioaltafw			lxEnvmensCodigo =  .Codigo			lxEnvmensMlenvuno =  .Mlenviouno			lxEnvmensEcommerce =  upper( .Ecommerce_PK ) 			lxEnvmensNumero =  .Numero			lxEnvmensMlenvdos =  .Mlenviodos			lxEnvmensEntidad =  .Entidad			lxEnvmensMlacordar =  .Mlacordar			lxEnvmensDis =  upper( .Diseno_PK ) 			lxEnvmensMotivomens =  .Motivoparacomunicarse			lxEnvmensTemplate =  .Template			lxEnvmensMensaje =  .Mensaje			lxEnvmensImagen =  .Imagen
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxEnvmensCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ENVMENS ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Saltafw","Esttrans","Horaimpo","Hmodifw","Bdmodifw","Horaexpo","Smodifw","Bdaltafw","Vmodifw","Zadsfw","Umodifw","Valtafw","Haltafw","Ualtafw","Codigo","Mlenvuno","Ecommerce","Numero","Mlenvdos","Entidad","Mlacordar","Dis","Motivomens","Template","Mensaje","Imagen" ) values ( <<"'" + this.ConvertirDateSql( lxEnvmensFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvmensFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvmensFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvmensFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvmensFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensCodigo ) + "'" >>, <<iif( lxEnvmensMlenvuno, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEnvmensEcommerce ) + "'" >>, <<lxEnvmensNumero >>, <<iif( lxEnvmensMlenvdos, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEnvmensEntidad ) + "'" >>, <<iif( lxEnvmensMlacordar, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEnvmensDis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensMotivomens ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensTemplate ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensMensaje ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensImagen ) + "'" >> )
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
			If this.ConsultarPorClaveCandidata()
				lcError  = 'El número a grabar ya existe. Cambie el último número del talonario correspondiente'
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
			local  lxEnvmensFecimpo, lxEnvmensFectrans, lxEnvmensFmodifw, lxEnvmensFecexpo, lxEnvmensFaltafw, lxEnvmensSaltafw, lxEnvmensEsttrans, lxEnvmensHoraimpo, lxEnvmensHmodifw, lxEnvmensBdmodifw, lxEnvmensHoraexpo, lxEnvmensSmodifw, lxEnvmensBdaltafw, lxEnvmensVmodifw, lxEnvmensZadsfw, lxEnvmensUmodifw, lxEnvmensValtafw, lxEnvmensHaltafw, lxEnvmensUaltafw, lxEnvmensCodigo, lxEnvmensMlenvuno, lxEnvmensEcommerce, lxEnvmensNumero, lxEnvmensMlenvdos, lxEnvmensEntidad, lxEnvmensMlacordar, lxEnvmensDis, lxEnvmensMotivomens, lxEnvmensTemplate, lxEnvmensMensaje, lxEnvmensImagen
				lxEnvmensFecimpo =  .Fechaimpo			lxEnvmensFectrans =  .Fechatransferencia			lxEnvmensFmodifw =  .Fechamodificacionfw			lxEnvmensFecexpo =  .Fechaexpo			lxEnvmensFaltafw =  .Fechaaltafw			lxEnvmensSaltafw =  .Seriealtafw			lxEnvmensEsttrans =  .Estadotransferencia			lxEnvmensHoraimpo =  .Horaimpo			lxEnvmensHmodifw =  .Horamodificacionfw			lxEnvmensBdmodifw =  .Basededatosmodificacionfw			lxEnvmensHoraexpo =  .Horaexpo			lxEnvmensSmodifw =  .Seriemodificacionfw			lxEnvmensBdaltafw =  .Basededatosaltafw			lxEnvmensVmodifw =  .Versionmodificacionfw			lxEnvmensZadsfw =  .Zadsfw			lxEnvmensUmodifw =  .Usuariomodificacionfw			lxEnvmensValtafw =  .Versionaltafw			lxEnvmensHaltafw =  .Horaaltafw			lxEnvmensUaltafw =  .Usuarioaltafw			lxEnvmensCodigo =  .Codigo			lxEnvmensMlenvuno =  .Mlenviouno			lxEnvmensEcommerce =  upper( .Ecommerce_PK ) 			lxEnvmensNumero =  .Numero			lxEnvmensMlenvdos =  .Mlenviodos			lxEnvmensEntidad =  .Entidad			lxEnvmensMlacordar =  .Mlacordar			lxEnvmensDis =  upper( .Diseno_PK ) 			lxEnvmensMotivomens =  .Motivoparacomunicarse			lxEnvmensTemplate =  .Template			lxEnvmensMensaje =  .Mensaje			lxEnvmensImagen =  .Imagen
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ENVMENS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxEnvmensFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxEnvmensFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxEnvmensFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxEnvmensFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxEnvmensFaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxEnvmensSaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxEnvmensEsttrans ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxEnvmensHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensHmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxEnvmensHoraexpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensSmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEnvmensBdaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxEnvmensZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxEnvmensValtafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxEnvmensHaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxEnvmensUaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxEnvmensCodigo ) + "'">>,"Mlenvuno" = <<iif( lxEnvmensMlenvuno, 1, 0 )>>,"Ecommerce" = <<"'" + this.FormatearTextoSql( lxEnvmensEcommerce ) + "'">>,"Numero" = <<lxEnvmensNumero>>,"Mlenvdos" = <<iif( lxEnvmensMlenvdos, 1, 0 )>>,"Entidad" = <<"'" + this.FormatearTextoSql( lxEnvmensEntidad ) + "'">>,"Mlacordar" = <<iif( lxEnvmensMlacordar, 1, 0 )>>,"Dis" = <<"'" + this.FormatearTextoSql( lxEnvmensDis ) + "'">>,"Motivomens" = <<"'" + this.FormatearTextoSql( lxEnvmensMotivomens ) + "'">>,"Template" = <<"'" + this.FormatearTextoSql( lxEnvmensTemplate ) + "'">>,"Mensaje" = <<"'" + this.FormatearTextoSql( lxEnvmensMensaje ) + "'">>,"Imagen" = <<"'" + this.FormatearTextoSql( lxEnvmensImagen ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxEnvmensCodigo ) + "'">> and  ENVMENS.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.ENVMENS where " + this.ConvertirFuncionesSql( " ENVMENS.CODIGO != ''" ) )
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
			Local lxEnvmensCodigo
			lxEnvmensCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Codigo" as "Codigo", "Mlenvuno" as "Mlenviouno", "Ecommerce" as "Ecommerce", "Numero" as "Numero", "Mlenvdos" as "Mlenviodos", "Entidad" as "Entidad", "Mlacordar" as "Mlacordar", "Dis" as "Diseno", "Motivomens" as "Motivoparacomunicarse", "Template" as "Template", "Mensaje" as "Mensaje", "Imagen" as "Imagen" from ZooLogic.ENVMENS where "Codigo" = <<"'" + this.FormatearTextoSql( lxEnvmensCodigo ) + "'">> and  ENVMENS.CODIGO != ''
			endtext
			use in select('c_ENVIODEMENSAJERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODEMENSAJERIA', set( 'Datasession' ) )

			if reccount( 'c_ENVIODEMENSAJERIA' ) = 0
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
			Local lxENVMENSNUMERO As Variant
			lxENVMENSNUMERO = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Codigo" as "Codigo", "Mlenvuno" as "Mlenviouno", "Ecommerce" as "Ecommerce", "Numero" as "Numero", "Mlenvdos" as "Mlenviodos", "Entidad" as "Entidad", "Mlacordar" as "Mlacordar", "Dis" as "Diseno", "Motivomens" as "Motivoparacomunicarse", "Template" as "Template", "Mensaje" as "Mensaje", "Imagen" as "Imagen" from ZooLogic.ENVMENS where  ENVMENS.CODIGO != '' And NUMERO = <<lxENVMENSNUMERO>>
			endtext
			use in select('c_ENVIODEMENSAJERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODEMENSAJERIA', set( 'Datasession' ) )
			if reccount( 'c_ENVIODEMENSAJERIA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxEnvmensCodigo as Variant
		llRetorno = .t.
		lxEnvmensCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ENVMENS where "Codigo" = <<"'" + this.FormatearTextoSql( lxEnvmensCodigo ) + "'">> and  ENVMENS.CODIGO != ''
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
				lcOrden =  str( .Numero, 4, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Codigo" as "Codigo", "Mlenvuno" as "Mlenviouno", "Ecommerce" as "Ecommerce", "Numero" as "Numero", "Mlenvdos" as "Mlenviodos", "Entidad" as "Entidad", "Mlacordar" as "Mlacordar", "Dis" as "Diseno", "Motivomens" as "Motivoparacomunicarse", "Template" as "Template", "Mensaje" as "Mensaje", "Imagen" as "Imagen" from ZooLogic.ENVMENS where  ENVMENS.CODIGO != '' order by NUMERO,CODIGO
			endtext
			use in select('c_ENVIODEMENSAJERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODEMENSAJERIA', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 4, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Codigo" as "Codigo", "Mlenvuno" as "Mlenviouno", "Ecommerce" as "Ecommerce", "Numero" as "Numero", "Mlenvdos" as "Mlenviodos", "Entidad" as "Entidad", "Mlacordar" as "Mlacordar", "Dis" as "Diseno", "Motivomens" as "Motivoparacomunicarse", "Template" as "Template", "Mensaje" as "Mensaje", "Imagen" as "Imagen" from ZooLogic.ENVMENS where  str( NUMERO, 4, 0) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ENVMENS.CODIGO != '' order by NUMERO,CODIGO
			endtext
			use in select('c_ENVIODEMENSAJERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODEMENSAJERIA', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 4, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Codigo" as "Codigo", "Mlenvuno" as "Mlenviouno", "Ecommerce" as "Ecommerce", "Numero" as "Numero", "Mlenvdos" as "Mlenviodos", "Entidad" as "Entidad", "Mlacordar" as "Mlacordar", "Dis" as "Diseno", "Motivomens" as "Motivoparacomunicarse", "Template" as "Template", "Mensaje" as "Mensaje", "Imagen" as "Imagen" from ZooLogic.ENVMENS where  str( NUMERO, 4, 0) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ENVMENS.CODIGO != '' order by NUMERO desc,CODIGO desc
			endtext
			use in select('c_ENVIODEMENSAJERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODEMENSAJERIA', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 4, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Codigo" as "Codigo", "Mlenvuno" as "Mlenviouno", "Ecommerce" as "Ecommerce", "Numero" as "Numero", "Mlenvdos" as "Mlenviodos", "Entidad" as "Entidad", "Mlacordar" as "Mlacordar", "Dis" as "Diseno", "Motivomens" as "Motivoparacomunicarse", "Template" as "Template", "Mensaje" as "Mensaje", "Imagen" as "Imagen" from ZooLogic.ENVMENS where  ENVMENS.CODIGO != '' order by NUMERO desc,CODIGO desc
			endtext
			use in select('c_ENVIODEMENSAJERIA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ENVIODEMENSAJERIA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Saltafw,Esttrans,Horaimpo,Hmodifw,Bdmodifw,Horaexpo" + ;
",Smodifw,Bdaltafw,Vmodifw,Zadsfw,Umodifw,Valtafw,Haltafw,Ualtafw,Codigo,Mlenvuno,Ecommerce,Numero,Ml" + ;
"envdos,Entidad,Mlacordar,Dis,Motivomens,Template,Mensaje,Imagen" + ;
" from ZooLogic.ENVMENS where  ENVMENS.CODIGO != '' and " + lcFiltro )
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
			local  lxEnvmensFecimpo, lxEnvmensFectrans, lxEnvmensFmodifw, lxEnvmensFecexpo, lxEnvmensFaltafw, lxEnvmensSaltafw, lxEnvmensEsttrans, lxEnvmensHoraimpo, lxEnvmensHmodifw, lxEnvmensBdmodifw, lxEnvmensHoraexpo, lxEnvmensSmodifw, lxEnvmensBdaltafw, lxEnvmensVmodifw, lxEnvmensZadsfw, lxEnvmensUmodifw, lxEnvmensValtafw, lxEnvmensHaltafw, lxEnvmensUaltafw, lxEnvmensCodigo, lxEnvmensMlenvuno, lxEnvmensEcommerce, lxEnvmensNumero, lxEnvmensMlenvdos, lxEnvmensEntidad, lxEnvmensMlacordar, lxEnvmensDis, lxEnvmensMotivomens, lxEnvmensTemplate, lxEnvmensMensaje, lxEnvmensImagen
				lxEnvmensFecimpo = ctod( '  /  /    ' )			lxEnvmensFectrans = ctod( '  /  /    ' )			lxEnvmensFmodifw = ctod( '  /  /    ' )			lxEnvmensFecexpo = ctod( '  /  /    ' )			lxEnvmensFaltafw = ctod( '  /  /    ' )			lxEnvmensSaltafw = []			lxEnvmensEsttrans = []			lxEnvmensHoraimpo = []			lxEnvmensHmodifw = []			lxEnvmensBdmodifw = []			lxEnvmensHoraexpo = []			lxEnvmensSmodifw = []			lxEnvmensBdaltafw = []			lxEnvmensVmodifw = []			lxEnvmensZadsfw = []			lxEnvmensUmodifw = []			lxEnvmensValtafw = []			lxEnvmensHaltafw = []			lxEnvmensUaltafw = []			lxEnvmensCodigo = []			lxEnvmensMlenvuno = .F.			lxEnvmensEcommerce = []			lxEnvmensNumero = 0			lxEnvmensMlenvdos = .F.			lxEnvmensEntidad = []			lxEnvmensMlacordar = .F.			lxEnvmensDis = []			lxEnvmensMotivomens = []			lxEnvmensTemplate = []			lxEnvmensMensaje = []			lxEnvmensImagen = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ENVMENS where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ENVMENS' + '_' + tcCampo
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
		lcWhere = " Where  ENVMENS.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Codigo" as "Codigo", "Mlenvuno" as "Mlenviouno", "Ecommerce" as "Ecommerce", "Numero" as "Numero", "Mlenvdos" as "Mlenviodos", "Entidad" as "Entidad", "Mlacordar" as "Mlacordar", "Dis" as "Diseno", "Motivomens" as "Motivoparacomunicarse", "Template" as "Template", "Mensaje" as "Mensaje", "Imagen" as "Imagen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ENVMENS', '', tnTope )
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
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MLENVIOUNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MLENVUNO AS MLENVIOUNO'
				Case lcAtributo == 'ECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ECOMMERCE AS ECOMMERCE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'MLENVIODOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MLENVDOS AS MLENVIODOS'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTIDAD AS ENTIDAD'
				Case lcAtributo == 'MLACORDAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MLACORDAR AS MLACORDAR'
				Case lcAtributo == 'DISENO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIS AS DISENO'
				Case lcAtributo == 'MOTIVOPARACOMUNICARSE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVOMENS AS MOTIVOPARACOMUNICARSE'
				Case lcAtributo == 'TEMPLATE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEMPLATE AS TEMPLATE'
				Case lcAtributo == 'MENSAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MENSAJE AS MENSAJE'
				Case lcAtributo == 'IMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMAGEN AS IMAGEN'
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
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MLENVIOUNO'
				lcCampo = 'MLENVUNO'
			Case upper( alltrim( tcAtributo ) ) == 'ECOMMERCE'
				lcCampo = 'ECOMMERCE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'MLENVIODOS'
				lcCampo = 'MLENVDOS'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'ENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'MLACORDAR'
				lcCampo = 'MLACORDAR'
			Case upper( alltrim( tcAtributo ) ) == 'DISENO'
				lcCampo = 'DIS'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVOPARACOMUNICARSE'
				lcCampo = 'MOTIVOMENS'
			Case upper( alltrim( tcAtributo ) ) == 'TEMPLATE'
				lcCampo = 'TEMPLATE'
			Case upper( alltrim( tcAtributo ) ) == 'MENSAJE'
				lcCampo = 'MENSAJE'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGEN'
				lcCampo = 'IMAGEN'
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
			local  lxEnvmensFecimpo, lxEnvmensFectrans, lxEnvmensFmodifw, lxEnvmensFecexpo, lxEnvmensFaltafw, lxEnvmensSaltafw, lxEnvmensEsttrans, lxEnvmensHoraimpo, lxEnvmensHmodifw, lxEnvmensBdmodifw, lxEnvmensHoraexpo, lxEnvmensSmodifw, lxEnvmensBdaltafw, lxEnvmensVmodifw, lxEnvmensZadsfw, lxEnvmensUmodifw, lxEnvmensValtafw, lxEnvmensHaltafw, lxEnvmensUaltafw, lxEnvmensCodigo, lxEnvmensMlenvuno, lxEnvmensEcommerce, lxEnvmensNumero, lxEnvmensMlenvdos, lxEnvmensEntidad, lxEnvmensMlacordar, lxEnvmensDis, lxEnvmensMotivomens, lxEnvmensTemplate, lxEnvmensMensaje, lxEnvmensImagen
				lxEnvmensFecimpo =  .Fechaimpo			lxEnvmensFectrans =  .Fechatransferencia			lxEnvmensFmodifw =  .Fechamodificacionfw			lxEnvmensFecexpo =  .Fechaexpo			lxEnvmensFaltafw =  .Fechaaltafw			lxEnvmensSaltafw =  .Seriealtafw			lxEnvmensEsttrans =  .Estadotransferencia			lxEnvmensHoraimpo =  .Horaimpo			lxEnvmensHmodifw =  .Horamodificacionfw			lxEnvmensBdmodifw =  .Basededatosmodificacionfw			lxEnvmensHoraexpo =  .Horaexpo			lxEnvmensSmodifw =  .Seriemodificacionfw			lxEnvmensBdaltafw =  .Basededatosaltafw			lxEnvmensVmodifw =  .Versionmodificacionfw			lxEnvmensZadsfw =  .Zadsfw			lxEnvmensUmodifw =  .Usuariomodificacionfw			lxEnvmensValtafw =  .Versionaltafw			lxEnvmensHaltafw =  .Horaaltafw			lxEnvmensUaltafw =  .Usuarioaltafw			lxEnvmensCodigo =  .Codigo			lxEnvmensMlenvuno =  .Mlenviouno			lxEnvmensEcommerce =  upper( .Ecommerce_PK ) 			lxEnvmensNumero =  .Numero			lxEnvmensMlenvdos =  .Mlenviodos			lxEnvmensEntidad =  .Entidad			lxEnvmensMlacordar =  .Mlacordar			lxEnvmensDis =  upper( .Diseno_PK ) 			lxEnvmensMotivomens =  .Motivoparacomunicarse			lxEnvmensTemplate =  .Template			lxEnvmensMensaje =  .Mensaje			lxEnvmensImagen =  .Imagen
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ENVMENS ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Saltafw","Esttrans","Horaimpo","Hmodifw","Bdmodifw","Horaexpo","Smodifw","Bdaltafw","Vmodifw","Zadsfw","Umodifw","Valtafw","Haltafw","Ualtafw","Codigo","Mlenvuno","Ecommerce","Numero","Mlenvdos","Entidad","Mlacordar","Dis","Motivomens","Template","Mensaje","Imagen" ) values ( <<"'" + this.ConvertirDateSql( lxEnvmensFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvmensFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvmensFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvmensFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxEnvmensFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensCodigo ) + "'" >>, <<iif( lxEnvmensMlenvuno, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEnvmensEcommerce ) + "'" >>, <<lxEnvmensNumero >>, <<iif( lxEnvmensMlenvdos, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEnvmensEntidad ) + "'" >>, <<iif( lxEnvmensMlacordar, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxEnvmensDis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensMotivomens ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensTemplate ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensMensaje ) + "'" >>, <<"'" + this.FormatearTextoSql( lxEnvmensImagen ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ENVMENS' 
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
			local  lxEnvmensFecimpo, lxEnvmensFectrans, lxEnvmensFmodifw, lxEnvmensFecexpo, lxEnvmensFaltafw, lxEnvmensSaltafw, lxEnvmensEsttrans, lxEnvmensHoraimpo, lxEnvmensHmodifw, lxEnvmensBdmodifw, lxEnvmensHoraexpo, lxEnvmensSmodifw, lxEnvmensBdaltafw, lxEnvmensVmodifw, lxEnvmensZadsfw, lxEnvmensUmodifw, lxEnvmensValtafw, lxEnvmensHaltafw, lxEnvmensUaltafw, lxEnvmensCodigo, lxEnvmensMlenvuno, lxEnvmensEcommerce, lxEnvmensNumero, lxEnvmensMlenvdos, lxEnvmensEntidad, lxEnvmensMlacordar, lxEnvmensDis, lxEnvmensMotivomens, lxEnvmensTemplate, lxEnvmensMensaje, lxEnvmensImagen
				lxEnvmensFecimpo =  .Fechaimpo			lxEnvmensFectrans =  .Fechatransferencia			lxEnvmensFmodifw =  .Fechamodificacionfw			lxEnvmensFecexpo =  .Fechaexpo			lxEnvmensFaltafw =  .Fechaaltafw			lxEnvmensSaltafw =  .Seriealtafw			lxEnvmensEsttrans =  .Estadotransferencia			lxEnvmensHoraimpo =  .Horaimpo			lxEnvmensHmodifw =  .Horamodificacionfw			lxEnvmensBdmodifw =  .Basededatosmodificacionfw			lxEnvmensHoraexpo =  .Horaexpo			lxEnvmensSmodifw =  .Seriemodificacionfw			lxEnvmensBdaltafw =  .Basededatosaltafw			lxEnvmensVmodifw =  .Versionmodificacionfw			lxEnvmensZadsfw =  .Zadsfw			lxEnvmensUmodifw =  .Usuariomodificacionfw			lxEnvmensValtafw =  .Versionaltafw			lxEnvmensHaltafw =  .Horaaltafw			lxEnvmensUaltafw =  .Usuarioaltafw			lxEnvmensCodigo =  .Codigo			lxEnvmensMlenvuno =  .Mlenviouno			lxEnvmensEcommerce =  upper( .Ecommerce_PK ) 			lxEnvmensNumero =  .Numero			lxEnvmensMlenvdos =  .Mlenviodos			lxEnvmensEntidad =  .Entidad			lxEnvmensMlacordar =  .Mlacordar			lxEnvmensDis =  upper( .Diseno_PK ) 			lxEnvmensMotivomens =  .Motivoparacomunicarse			lxEnvmensTemplate =  .Template			lxEnvmensMensaje =  .Mensaje			lxEnvmensImagen =  .Imagen
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ENVMENS.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ENVMENS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxEnvmensFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxEnvmensFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxEnvmensFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxEnvmensFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxEnvmensFaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxEnvmensSaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxEnvmensEsttrans ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxEnvmensHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensHmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxEnvmensHoraexpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensSmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxEnvmensBdaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxEnvmensZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxEnvmensUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxEnvmensValtafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxEnvmensHaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxEnvmensUaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxEnvmensCodigo ) + "'">>, "Mlenvuno" = <<iif( lxEnvmensMlenvuno, 1, 0 )>>, "Ecommerce" = <<"'" + this.FormatearTextoSql( lxEnvmensEcommerce ) + "'">>, "Numero" = <<lxEnvmensNumero>>, "Mlenvdos" = <<iif( lxEnvmensMlenvdos, 1, 0 )>>, "Entidad" = <<"'" + this.FormatearTextoSql( lxEnvmensEntidad ) + "'">>, "Mlacordar" = <<iif( lxEnvmensMlacordar, 1, 0 )>>, "Dis" = <<"'" + this.FormatearTextoSql( lxEnvmensDis ) + "'">>, "Motivomens" = <<"'" + this.FormatearTextoSql( lxEnvmensMotivomens ) + "'">>, "Template" = <<"'" + this.FormatearTextoSql( lxEnvmensTemplate ) + "'">>, "Mensaje" = <<"'" + this.FormatearTextoSql( lxEnvmensMensaje ) + "'">>, "Imagen" = <<"'" + this.FormatearTextoSql( lxEnvmensImagen ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ENVMENS' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ENVMENS.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.ENVMENS where ' + lcFiltro )
			loColeccion.cTabla = 'ENVMENS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ENVMENS where  ENVMENS.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ENVMENS where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ENVMENS.CODIGO != ''" )
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
					if empty( .oNumeraciones.ObtenerServicio('NUMERO') ) and iif( type( '.NUMERO' ) = 'C', int( val( .NUMERO ) ),.NUMERO ) = .oNumeraciones.UltimoNumero( 'NUMERO' )
						.oNumeraciones.Actualizar( 'NUMERO' )
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
					.NUMERO = .oNumeraciones.grabar( 'NUMERO' )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxENVMENSNUMERO as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODEMENSAJERIA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ENVMENS Where  NUMERO = ] + transform( &lcCursor..NUMERO     ), 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.ENVMENS set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, MLENVUNO = ] + Transform( iif( &lcCursor..MLENVUNO, 1, 0 ))+ [, Ecommerce = ] + "'" + this.FormatearTextoSql( &lcCursor..Ecommerce ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, MLENVDOS = ] + Transform( iif( &lcCursor..MLENVDOS, 1, 0 ))+ [, ENTIDAD = ] + "'" + this.FormatearTextoSql( &lcCursor..ENTIDAD ) + "'"+ [, MLACORDAR = ] + Transform( iif( &lcCursor..MLACORDAR, 1, 0 ))+ [, DIS = ] + "'" + this.FormatearTextoSql( &lcCursor..DIS ) + "'"+ [, MotivoMens = ] + "'" + this.FormatearTextoSql( &lcCursor..MotivoMens ) + "'"+ [, Template = ] + "'" + this.FormatearTextoSql( &lcCursor..Template ) + "'"+ [, MENSAJE = ] + "'" + this.FormatearTextoSql( &lcCursor..MENSAJE ) + "'"+ [, IMAGEN = ] + "'" + this.FormatearTextoSql( &lcCursor..IMAGEN ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.ENVMENS Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, SALTAFW, ESTTRANS, HORAIMPO, HMODIFW, BDMODIFW, HORAEXPO, SMODIFW, BDALTAFW, VMODIFW, ZADSFW, UMODIFW, VALTAFW, HALTAFW, UALTAFW, CODIGO, MLENVUNO, Ecommerce, NUMERO, MLENVDOS, ENTIDAD, MLACORDAR, DIS, MotivoMens, Template, MENSAJE, IMAGEN
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + Transform( iif( &lcCursor..MLENVUNO, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Ecommerce ) + "'" + ',' + transform( &lcCursor..NUMERO ) + ',' + Transform( iif( &lcCursor..MLENVDOS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ENTIDAD ) + "'" + ',' + Transform( iif( &lcCursor..MLACORDAR, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DIS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MotivoMens ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Template ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MENSAJE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IMAGEN ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.ENVMENS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODEMENSAJERIA'
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
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..NUMERO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ENVIODEMENSAJERIA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ENVIODEMENSAJERIA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ENVIODEMENSAJERIA_MENSAJE'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ENVMENS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ENVIODEMENSAJERIA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..NUMERO )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ENVIODEMENSAJERIA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODEMENSAJERIA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( NUMERO, 4, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( NUMERO, 4, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODEMENSAJERIA'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ENVMENS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ENVMENS
Create Table ZooLogic.TablaTrabajo_ENVMENS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"saltafw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"bdaltafw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"codigo" char( 38 )  null, 
"mlenvuno" bit  null, 
"ecommerce" char( 10 )  null, 
"numero" numeric( 4, 0 )  null, 
"mlenvdos" bit  null, 
"entidad" char( 40 )  null, 
"mlacordar" bit  null, 
"dis" char( 40 )  null, 
"motivomens" char( 180 )  null, 
"template" char( 180 )  null, 
"mensaje" varchar(max)  null, 
"imagen" char( 180 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ENVMENS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ENVMENS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ENVIODEMENSAJERIA'
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
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('mlenvuno','mlenvuno')
			.AgregarMapeo('ecommerce','ecommerce')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('mlenvdos','mlenvdos')
			.AgregarMapeo('entidad','entidad')
			.AgregarMapeo('mlacordar','mlacordar')
			.AgregarMapeo('dis','dis')
			.AgregarMapeo('motivomens','motivomens')
			.AgregarMapeo('template','template')
			.AgregarMapeo('mensaje','mensaje')
			.AgregarMapeo('imagen','imagen')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ENVMENS'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MLENVUNO = isnull( d.MLENVUNO, t.MLENVUNO ),t.ECOMMERCE = isnull( d.ECOMMERCE, t.ECOMMERCE ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.MLENVDOS = isnull( d.MLENVDOS, t.MLENVDOS ),t.ENTIDAD = isnull( d.ENTIDAD, t.ENTIDAD ),t.MLACORDAR = isnull( d.MLACORDAR, t.MLACORDAR ),t.DIS = isnull( d.DIS, t.DIS ),t.MOTIVOMENS = isnull( d.MOTIVOMENS, t.MOTIVOMENS ),t.TEMPLATE = isnull( d.TEMPLATE, t.TEMPLATE ),t.MENSAJE = isnull( d.MENSAJE, t.MENSAJE ),t.IMAGEN = isnull( d.IMAGEN, t.IMAGEN )
					from ZooLogic.ENVMENS t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.ENVMENS(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Saltafw,Esttrans,Horaimpo,Hmodifw,Bdmodifw,Horaexpo,Smodifw,Bdaltafw,Vmodifw,Zadsfw,Umodifw,Valtafw,Haltafw,Ualtafw,Codigo,Mlenvuno,Ecommerce,Numero,Mlenvdos,Entidad,Mlacordar,Dis,Motivomens,Template,Mensaje,Imagen)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.SMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.UALTAFW,''),isnull( d.CODIGO,''),isnull( d.MLENVUNO,0),isnull( d.ECOMMERCE,''),isnull( d.NUMERO,0),isnull( d.MLENVDOS,0),isnull( d.ENTIDAD,''),isnull( d.MLACORDAR,0),isnull( d.DIS,''),isnull( d.MOTIVOMENS,''),isnull( d.TEMPLATE,''),isnull( d.MENSAJE,''),isnull( d.IMAGEN,'')
						From deleted d left join ZooLogic.ENVMENS pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.ENVMENS cc 
							 on  d.NUMERO = cc.NUMERO
						Where pk.CODIGO Is Null 
							 and cc.NUMERO Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(4) ) + '','La clave principal no es la esperada'
					from ZooLogic.ENVMENS t inner join deleted d 
							on   t.NUMERO = d.NUMERO
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(4) ) + '','La clave principal a importar ya existe'
					from ZooLogic.ENVMENS t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.NUMERO = h.NUMERO
							where   h.NUMERO is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ENVMENS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ENVMENS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ENVIODEMENSAJERIA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODEMENSAJERIA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODEMENSAJERIA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODEMENSAJERIA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODEMENSAJERIA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ENVIODEMENSAJERIA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_ENVIODEMENSAJERIA.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_ENVIODEMENSAJERIA.Estadotransferencia, [] )
					.Horaimpo = nvl( c_ENVIODEMENSAJERIA.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_ENVIODEMENSAJERIA.Horamodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_ENVIODEMENSAJERIA.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_ENVIODEMENSAJERIA.Horaexpo, [] )
					.Seriemodificacionfw = nvl( c_ENVIODEMENSAJERIA.Seriemodificacionfw, [] )
					.Basededatosaltafw = nvl( c_ENVIODEMENSAJERIA.Basededatosaltafw, [] )
					.Versionmodificacionfw = nvl( c_ENVIODEMENSAJERIA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_ENVIODEMENSAJERIA.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_ENVIODEMENSAJERIA.Versionaltafw, [] )
					.Horaaltafw = nvl( c_ENVIODEMENSAJERIA.Horaaltafw, [] )
					.Usuarioaltafw = nvl( c_ENVIODEMENSAJERIA.Usuarioaltafw, [] )
					.Codigo = nvl( c_ENVIODEMENSAJERIA.Codigo, [] )
					.Mlenviouno = nvl( c_ENVIODEMENSAJERIA.Mlenviouno, .F. )
					.Ecommerce_PK =  nvl( c_ENVIODEMENSAJERIA.Ecommerce, [] )
					.Numero = nvl( c_ENVIODEMENSAJERIA.Numero, 0 )
					.Mlenviodos = nvl( c_ENVIODEMENSAJERIA.Mlenviodos, .F. )
					.Entidad = nvl( c_ENVIODEMENSAJERIA.Entidad, [] )
					.Mlacordar = nvl( c_ENVIODEMENSAJERIA.Mlacordar, .F. )
					.Diseno_PK =  nvl( c_ENVIODEMENSAJERIA.Diseno, [] )
					.Motivoparacomunicarse = nvl( c_ENVIODEMENSAJERIA.Motivoparacomunicarse, [] )
					.Template = nvl( c_ENVIODEMENSAJERIA.Template, [] )
					lcValor = This.ObtenerMemo( 'c_Mensaje')
					.Mensaje = lcValor 
					.Imagen = nvl( c_ENVIODEMENSAJERIA.Imagen, [] )
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
			lxRetorno = c_ENVIODEMENSAJERIA.CODIGO
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
		return c_ENVIODEMENSAJERIA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ENVMENS' )
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
								from ZooLogic.ENVMENS 
								Where   ENVMENS.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ENVMENS", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Ualtafw" as "Usuarioaltafw", "Codigo" as "Codigo", "Mlenvuno" as "Mlenviouno", "Ecommerce" as "Ecommerce", "Numero" as "Numero", "Mlenvdos" as "Mlenviodos", "Entidad" as "Entidad", "Mlacordar" as "Mlacordar", "Dis" as "Diseno", "Motivomens" as "Motivoparacomunicarse", "Template" as "Template", "Mensaje" as "Mensaje", "Imagen" as "Imagen"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ENVMENS 
								Where   ENVMENS.CODIGO != ''
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
	Tabla = 'ENVMENS'
	Filtro = " ENVMENS.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ENVMENS.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "ENVMENS.Numero"
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
	<row entidad="ENVIODEMENSAJERIA                       " atributo="FECHAIMPO                               " tabla="ENVMENS        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="FECHATRANSFERENCIA                      " tabla="ENVMENS        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="FECHAMODIFICACIONFW                     " tabla="ENVMENS        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="FECHAEXPO                               " tabla="ENVMENS        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="FECHAALTAFW                             " tabla="ENVMENS        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="SERIEALTAFW                             " tabla="ENVMENS        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="ESTADOTRANSFERENCIA                     " tabla="ENVMENS        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="HORAIMPO                                " tabla="ENVMENS        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="HORAMODIFICACIONFW                      " tabla="ENVMENS        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ENVMENS        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="HORAEXPO                                " tabla="ENVMENS        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="SERIEMODIFICACIONFW                     " tabla="ENVMENS        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="BASEDEDATOSALTAFW                       " tabla="ENVMENS        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="VERSIONMODIFICACIONFW                   " tabla="ENVMENS        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="ZADSFW                                  " tabla="ENVMENS        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="USUARIOMODIFICACIONFW                   " tabla="ENVMENS        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="VERSIONALTAFW                           " tabla="ENVMENS        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="HORAALTAFW                              " tabla="ENVMENS        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="USUARIOALTAFW                           " tabla="ENVMENS        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="CODIGO                                  " tabla="ENVMENS        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Codigo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="MLENVIOUNO                              " tabla="ENVMENS        " campo="MLENVUNO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Mercado envíos tipo 1                                                                                                                                           " dominio="TIPOSDEENTREGAML              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="ECOMMERCE                               " tabla="ENVMENS        " campo="ECOMMERCE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ECOMMERCE                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Plataforma                                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="NUMERO                                  " tabla="ENVMENS        " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CLAVEDEBUSQUEDA               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="MLENVIODOS                              " tabla="ENVMENS        " campo="MLENVDOS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Mercado envíos tipo 2                                                                                                                                           " dominio="TIPOSDEENTREGAML              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="ENTIDAD                                 " tabla="ENVMENS        " campo="ENTIDAD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Entidad                                                                                                                                                         " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="MLACORDAR                               " tabla="ENVMENS        " campo="MLACORDAR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Entrega a acordar                                                                                                                                               " dominio="TIPOSDEENTREGAML              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="DISENO                                  " tabla="ENVMENS        " campo="DIS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DISENOIMPRESION                         " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Adjuntar diseño de salida                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="MOTIVOPARACOMUNICARSE                   " tabla="ENVMENS        " campo="MOTIVOMENS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Motivo para comunicarse                                                                                                                                         " dominio="COMBOMOTIVOMENSAJERIA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="TEMPLATE                                " tabla="ENVMENS        " campo="TEMPLATE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Template                                                                                                                                                        " dominio="COMBOTEMPLATEMENSAJERIA       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="MENSAJE                                 " tabla="ENVMENS        " campo="MENSAJE   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Mensaje                                                                                                                                                         " dominio="OBSERVACION10R                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENVIODEMENSAJERIA                       " atributo="IMAGEN                                  " tabla="ENVMENS        " campo="IMAGEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="180" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Adjuntar imagen (ruta)                                                                                                                                          " dominio="IMAGENCONRUTADINAMICA         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ECOMMERCE                               " atributo="DESCRIPCION                             " tabla="ECOM           " campo="CUENTA    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="5" etiqueta="Detalle Pla.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ECOM On ENVMENS.ECOMMERCE = ECOM.CODIGO And  ECOM.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="DESCRIPCION                             " tabla="DISIMP         " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="7" etiqueta="Detalle Adj.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DISIMP On ENVMENS.DIS = DISIMP.cCod And  DISIMP.CCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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